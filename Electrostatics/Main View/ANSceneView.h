//
//  ANSceneView.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLiveParticle.h"

@class ANSceneView;

@protocol ANSceneViewDelegate<NSObject>

- (void)sceneView:(ANSceneView *)sceneView editingParticle:(ANParticle *)particle;

@end

@interface ANSceneView : UIView {
    __weak NSMutableArray * particlesReference;
    
    ANLiveParticle * selectedParticle;
    CGPoint selectionBeginning;
    CGPoint particleBeginning;
    
    NSDate * touchStart;
    BOOL isDraggingVector;
    
    
    __weak id<ANSceneViewDelegate> delegate;
}

@property (nonatomic, weak) NSMutableArray * particlesReference;
@property (nonatomic, weak) id<ANSceneViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles;

@end
