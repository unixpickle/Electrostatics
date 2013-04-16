//
//  ANSaveableScene.h
//  Electrostatics
//
//  Created by Alex Nichol on 4/16/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANSpring.h"

@interface ANSaveableScene : NSObject <NSCoding> {
	NSArray * particles;
	NSArray * springs;
}

@property (readonly) NSArray * particles;
@property (readonly) NSArray * springs;

- (id)initWithParticles:(NSArray *)particles springs:(NSArray *)springs;

@end
