//
//  ANSceneView.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLiveParticle.h"
#import "ANDraggableArrow.h"
#import "ANDraggableSpring.h"

#define kANSceneViewTouchFingerOffset 0

@class ANSceneView;

@protocol ANSceneViewDelegate<NSObject>

- (void)sceneView:(ANSceneView *)sceneView editingParticle:(ANParticle *)particle;
- (void)sceneView:(ANSceneView *)sceneView springFrom:(ANParticle *)source to:(ANParticle *)dest;

@end

@interface ANSceneView : UIView {
    __weak NSMutableArray * particlesReference;
    
    ANLiveParticle * selectedParticle;
    CGPoint selectionBeginning;
    CGPoint particleBeginning;

    NSDate * touchStart;
    Class draggableClass;
    BOOL isDraggingLink;
    ANDraggableLink * draggingLink;
    
    BOOL isAnimating;
    
    __weak id<ANSceneViewDelegate> delegate;
}

@property (nonatomic, weak) NSMutableArray * particlesReference;
@property (nonatomic, weak) id<ANSceneViewDelegate> delegate;
@property (readwrite) BOOL isAnimating;
@property (nonatomic, unsafe_unretained) Class draggableClass;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles;

@end
