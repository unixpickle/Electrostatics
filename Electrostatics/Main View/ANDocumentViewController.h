//
//  ANDocumentViewController.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/15/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANDocumentManager.h"
#import "ANLiveParticle.h"
#import "ANLiveSpring.h"
#import "ANSceneView.h"
#import "ANParticleViewController.h"

@interface ANDocumentViewController : UIViewController <ANSceneViewDelegate, ANParticleViewControllerDelegate> {
    ANDocumentInfo * info;
    UIBarButtonItem * doneButton;
    NSMutableArray * liveParticles;
    NSMutableArray * liveSprings;
    ANSceneView * sceneView;
    
    UIToolbar * toolbar;
    UIBarButtonItem * spaceItem;
    UIBarButtonItem * addButton;
    UIBarButtonItem * playButton;
    UIBarButtonItem * stopButton;
    
    NSDate * lastTick;
    NSTimer * animationTimer;
}

- (id)initWithDocumentInfo:(ANDocumentInfo *)theInfo;
- (void)doneButtonPressed:(id)sender;
- (void)addButtonPressed:(id)sender;
- (void)playButtonPressed:(id)sender;
- (void)stopButtonPressed:(id)sender;

@end
