//
//  ANDocumentViewController.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDocumentViewController.h"
#import "ANAppDelegate.h"

@interface ANDocumentViewController (Private)

- (NSArray *)particleList;
- (NSArray *)springList;
- (void)saveParticles;
- (void)loadParticlesFromFile:(NSString *)path;

- (void)animationTimerRoutine;

@end

@implementation ANDocumentViewController

- (id)initWithDocumentInfo:(ANDocumentInfo *)theInfo {
    if ((self = [super init])) {
        self.title = theInfo.documentTitle;
        info = theInfo;
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self action:@selector(doneButtonPressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        self.view.backgroundColor = [UIColor whiteColor];
        
        NSString * filePath = [info filePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [self loadParticlesFromFile:filePath];
        } else {
            liveParticles = [[NSMutableArray alloc] init];
            liveSprings = [[NSMutableArray alloc] init];
            // TODO: create a default particle here for user friendliness
        }
        
        CGRect sceneViewBounds = self.view.bounds;
        sceneViewBounds.size.height -= 88;
        sceneView = [[ANSceneView alloc] initWithFrame:sceneViewBounds
                                             particles:liveParticles
                                               springs:liveSprings];
        sceneView.delegate = self;
        [self.view addSubview:sceneView];
        
        spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                  target:nil action:nil];
        playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                   target:self
                                                                   action:@selector(playButtonPressed:)];
        stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                   target:self
                                                                   action:@selector(stopButtonPressed:)];
        addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                  target:self
                                                                  action:@selector(addButtonPressed:)];
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 88,
                                                              self.view.frame.size.width, 44)];
        [toolbar setItems:[NSArray arrayWithObjects:playButton, spaceItem, addButton, nil]];
        [self.view addSubview:toolbar];
    }
    return self;
}

- (void)doneButtonPressed:(id)sender {
    [self saveParticles];
    ANAppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [delegate.homeview dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addButtonPressed:(id)sender {
    ANParticle * particle = [[ANParticle alloc] init];
    particle.positionX = 320 / 2;
    particle.positionY = sceneView.frame.size.height / 2;
    particle.velocityX = 0;
    particle.velocityY = 0;
    particle.constant = 100;
    ANLiveParticle * live = [[ANLiveParticle alloc] initWithParticle:particle];
    [liveParticles addObject:live];
    [sceneView setNeedsDisplay];
}

- (void)playButtonPressed:(id)sender {
    sceneView.isAnimating = YES;
    [toolbar setItems:[NSArray arrayWithObjects:stopButton, spaceItem, addButton, nil] animated:YES];
    lastTick = nil;
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0)
                                                      target:self
                                                    selector:@selector(animationTimerRoutine)
                                                    userInfo:nil repeats:YES];
    // set every particle to be active
    for (ANLiveParticle * particle in liveParticles) {
        [particle beginActivity];
    }
    [sceneView setNeedsDisplay];
}

- (void)stopButtonPressed:(id)sender {
    sceneView.isAnimating = NO;
    [toolbar setItems:[NSArray arrayWithObjects:playButton, spaceItem, addButton, nil] animated:YES];
    for (ANLiveParticle * particle in liveParticles) {
        [particle resignActivityAndReset];
    }
    [sceneView setNeedsDisplay];
    [animationTimer invalidate];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (!animationTimer) return;
    [self stopButtonPressed:nil];
}

#pragma mark - Scene View -

- (void)sceneView:(ANSceneView *)sceneView editingParticle:(ANParticle *)particle {
    ANParticleViewController * pvc = [[ANParticleViewController alloc] initWithParticle:particle];
    pvc.delegate = self;
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)sceneView:(ANSceneView *)_sceneView springFrom:(ANLiveParticle *)source to:(ANLiveParticle *)dest {
    ANLiveSpring * spring = [[ANLiveSpring alloc] init];
    ANSpring * baseSpring = [[ANSpring alloc] initWithParticle:source.baseParticle
                                                    toParticle:dest.baseParticle];
    spring.spring = baseSpring;
    spring.particle1 = source;
    spring.particle2 = dest;
    [liveSprings addObject:spring];
    [sceneView setNeedsDisplay];
}

#pragma mark - Particle Editing -

- (void)particleViewControllerDismissed:(ANParticleViewController *)pvc {
    //[self dismissViewControllerAnimated:YES completion:NULL];
    [sceneView setNeedsDisplay];
}

- (void)particleViewController:(ANParticleViewController *)pvc deleteParticle:(ANParticle *)particle {
    for (int i = 0; i < [liveParticles count]; i++) {
        if ([[liveParticles objectAtIndex:i] baseParticle] == particle) {
            [liveParticles removeObjectAtIndex:i];
            break;
        }
    }
    [sceneView setNeedsDisplay];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private -

- (NSArray *)particleList {
    NSMutableArray * particles = [[NSMutableArray alloc] init];
    for (int i = 0; i < [liveParticles count]; i++) {
        [particles addObject:[[liveParticles objectAtIndex:i] baseParticle]];
    }
    return particles;
}

- (NSArray *)springList {
    NSMutableArray * springs = [[NSMutableArray alloc] init];
    for (ANLiveSpring * liveSpring in liveSprings) {
        [springs addObject:[liveSpring spring]];
    }
    return springs;
}

- (void)saveParticles {
    NSArray * particles = [self particleList];
    NSArray * springs = [self springList];
    
    ANSaveableScene * scene = [[ANSaveableScene alloc] initWithParticles:particles
                                                                 springs:springs];
    
    NSString * path = [info filePath];
    [NSKeyedArchiver archiveRootObject:scene toFile:path];
}

- (void)loadParticlesFromFile:(NSString *)filePath {
    ANSaveableScene * scene = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSArray * particles = scene.particles;
    NSArray * springs = scene.springs;
    liveParticles = [[NSMutableArray alloc] init];
    for (ANParticle * particle in particles) {
        [liveParticles addObject:[[ANLiveParticle alloc] initWithParticle:particle]];
    }
    
    liveSprings = [[NSMutableArray alloc] init];
    for (ANSpring * spring in springs) {
        ANLiveSpring * liveSpring = [[ANLiveSpring alloc] init];
        liveSpring.spring = spring;
        // find the particles
        for (ANLiveParticle * particle in liveParticles) {
            if (particle.baseParticle == spring.p1) {
                liveSpring.particle1 = particle;
            } else if (particle.baseParticle == spring.p2) {
                liveSpring.particle2 = particle;
            }
        }
        
        [liveSprings addObject:liveSpring];
    }
}

- (void)animationTimerRoutine {
    NSDate * now = [NSDate date];
    if (!lastTick) {
        lastTick = now;
        return;
    }
    NSTimeInterval duration = [now timeIntervalSinceDate:lastTick];
    lastTick = now;
    
    for (ANLiveParticle * particle in liveParticles) {
        ANVector2D netForce = ANVector2DMake(0, 0);
        for (ANLiveParticle * anotherParticle in liveParticles) {
            if (anotherParticle == particle) continue;
            ANVector2D anotherForce = [anotherParticle forceOnParticle:particle];
            if (ANVector2DMagnitude(anotherForce) > pow(10, 20)) {
                continue;
            }
            netForce = ANVector2DAdd(netForce, anotherForce);
        }
		for (ANLiveSpring * spring in liveSprings) {
			if (spring.particle1 == particle || spring.particle2 == particle) {
				ANVector2D springForce = [spring forceOnParticle:particle];
				netForce = ANVector2DAdd(netForce, springForce);
			}
		}
        ANLiveParticleActive active = particle.activeState;
        if (!particle.baseParticle.fixedVelocity) {
            active.activeVelocity.x += netForce.x * duration / particle.baseParticle.constant;
            active.activeVelocity.y += netForce.y * duration / particle.baseParticle.constant;
        }
        active.activePosition.x += active.activeVelocity.x * duration;
        active.activePosition.y += active.activeVelocity.y * duration;
        particle.activeState = active;
    }
    
    [sceneView setNeedsDisplay];
}

@end
