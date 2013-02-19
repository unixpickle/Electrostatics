//
//  ANDocumentInfo.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDocumentInfo.h"

@implementation ANDocumentInfo

@synthesize documentFile;
@synthesize documentTitle;

- (id)initWithFile:(NSString *)file title:(NSString *)title {
    if ((self = [super init])) {
        documentFile = file;
        documentTitle = title;
    }
    return self;
}

- (NSString *)filePath {
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:documentFile];
}

@end
