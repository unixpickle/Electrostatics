//
//  ANDocumentInfo.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANDocumentInfo : NSObject {
    NSString * documentFile;
    NSString * documentTitle;
}

@property (readonly) NSString * documentFile;
@property (nonatomic, retain) NSString * documentTitle;

- (id)initWithFile:(NSString *)file title:(NSString *)title;
- (NSString *)filePath;

@end
