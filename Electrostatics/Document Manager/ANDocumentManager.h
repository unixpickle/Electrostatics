//
//  ANDocumentManager.h
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANDocumentInfo.h"

@interface ANDocumentManager : NSObject {
    NSMutableDictionary * fileReference;
    NSMutableArray * documents;
    NSString * fileReferencePath;
}

+ (ANDocumentManager *)sharedDocumentManager;
- (NSArray *)documents;

- (ANDocumentInfo *)createDocumentWithTitle:(NSString *)title;
- (void)deleteDocument:(ANDocumentInfo *)info;
- (void)renameDocument:(ANDocumentInfo *)info title:(NSString *)title;
- (void)moveDocumentAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2;

@end
