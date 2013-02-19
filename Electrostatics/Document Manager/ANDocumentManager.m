//
//  ANDocumentManager.m
//  Electrostatics
//
//  Created by Alex Nichol on 2/18/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDocumentManager.h"

@interface ANDocumentManager (Private)

- (void)saveFileDatabase;

@end

@implementation ANDocumentManager

+ (ANDocumentManager *)sharedDocumentManager {
    static ANDocumentManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ANDocumentManager alloc] init];
    });
    return manager;
}

- (id)init {
    if ((self = [super init])) {
        fileReferencePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileList.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:fileReferencePath]) {
            fileReference = [[NSMutableDictionary alloc] init];
            [fileReference setObject:[NSMutableDictionary dictionary] forKey:@"nameTable"];
            [fileReference setObject:[NSMutableArray array] forKey:@"fileList"];
            [fileReference writeToFile:fileReferencePath atomically:YES];
        } else {
            fileReference = [[NSMutableDictionary alloc] initWithContentsOfFile:fileReferencePath];
            if (!fileReference) {
                fileReference = [[NSMutableDictionary alloc] init];
                [fileReference setObject:[NSMutableDictionary dictionary] forKey:@"nameTable"];
                [fileReference setObject:[NSMutableArray array] forKey:@"fileList"];
                [fileReference writeToFile:fileReferencePath atomically:YES];
            }
        }
        documents = [[NSMutableArray alloc] init];
        NSArray * fileIds = [fileReference objectForKey:@"fileList"];
        for (NSString * fileId in fileIds) {
            NSString * title = [[fileReference objectForKey:@"nameTable"] objectForKey:fileId];
            ANDocumentInfo * info = [[ANDocumentInfo alloc] initWithFile:fileId title:title];
            [documents addObject:info];
        }
    }
    return self;
}

#pragma mark - Access -

- (NSArray *)documents {
    return [documents copy];
}

- (ANDocumentInfo *)createDocumentWithTitle:(NSString *)title {
    NSString * fileId = [NSString stringWithFormat:@"%d%d", arc4random(), arc4random()];
    ANDocumentInfo * info = [[ANDocumentInfo alloc] initWithFile:fileId title:title];
    [[fileReference objectForKey:@"nameTable"] setObject:title forKey:fileId];
    [[fileReference objectForKey:@"fileList"] addObject:fileId];
    [documents addObject:info];
    [self saveFileDatabase];
    return info;
}

- (void)deleteDocument:(ANDocumentInfo *)info {
    [[NSFileManager defaultManager] removeItemAtPath:[info filePath]
                                               error:nil];
    [[fileReference objectForKey:@"nameTable"] removeObjectForKey:info.documentFile];
    [[fileReference objectForKey:@"fileList"] removeObject:info.documentFile];
    [documents removeObject:info];
    NSString * path = [info filePath];
    [self saveFileDatabase];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (void)renameDocument:(ANDocumentInfo *)info title:(NSString *)title {
    [[fileReference objectForKey:@"nameTable"] setObject:title forKey:info.documentFile];
    info.documentTitle = title;
    [self saveFileDatabase];
}

- (void)moveDocumentAtIndex:(NSUInteger)index1 toIndex:(NSUInteger)index2 {
    ANDocumentInfo * info = [documents objectAtIndex:index1];
    [documents removeObjectAtIndex:index1];
    [documents insertObject:info atIndex:index2];
    [[fileReference objectForKey:@"fileList"] removeObjectAtIndex:index1];
    [[fileReference objectForKey:@"fileList"] insertObject:info.documentFile atIndex:index2];
    [self saveFileDatabase];
}

#pragma mark - Private -

- (void)saveFileDatabase {
    [fileReference writeToFile:fileReferencePath atomically:YES];
}

@end
