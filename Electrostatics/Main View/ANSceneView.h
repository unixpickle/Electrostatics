//
//  ANSceneView.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANLiveParticle.h"
#import "ANLiveSpring.h"
#import "ANDraggableArrow.h"
#import "ANDraggableSpring.h"
#import "ANTouchContext.h"

@class ANSceneView;

@protocol ANSceneViewDelegate<NSObject>

- (void)sceneView:(ANSceneView *)sceneView editingParticle:(ANParticle *)particle;
- (void)sceneView:(ANSceneView *)sceneView editingSpring:(ANSpring *)spring;
- (void)sceneView:(ANSceneView *)sceneView springFrom:(ANLiveParticle *)source to:(ANLiveParticle *)dest;

@end

@interface ANSceneView : UIView {
    __weak NSMutableArray * particlesReference;
    __weak NSMutableArray * springsReference;
    
    BOOL isAnimating;
    ANTouchContext * touchContext;
    
    __weak id<ANSceneViewDelegate> delegate;
}

@property (nonatomic, weak) NSMutableArray * particlesReference;
@property (nonatomic, weak) NSMutableArray * springsReference;
@property (nonatomic, weak) id<ANSceneViewDelegate> delegate;
@property (readwrite) BOOL isAnimating;
@property (nonatomic, unsafe_unretained) Class draggableClass;

- (id)initWithFrame:(CGRect)frame particles:(NSMutableArray *)particles springs:(NSMutableArray *)springs;

@end
