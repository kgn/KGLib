//
//  NSURL+KGFile.m
//  KGLib
//
//  Created by David Keegan on 3/11/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "NSURL+KGFile.h"

@implementation NSURL(KGFile)

// From: https://devforums.apple.com/message/630614#630614
- (NSURL *)volumeMountURLWithError:(NSError *__autoreleasing *)error{
    NSURL *testURL = self;
    NSMutableArray *pathComponents = [NSMutableArray array];
    
    while(testURL != nil){
        NSNumber *isVolume;
        if(![testURL getResourceValue:&isVolume forKey:NSURLIsVolumeKey error:error]){
            return nil;
        }
        
        if([isVolume boolValue]){
            break;
        }
        
        [pathComponents insertObject:[testURL lastPathComponent] atIndex:0];
        
        NSURL *parentURL = nil;        
        if(![testURL getResourceValue:&parentURL forKey:NSURLParentDirectoryURLKey error:error]){
            return nil;
        }
        
        testURL = parentURL;
    }
    
    NSURL *volURL = nil;
    if(![self getResourceValue:&volURL forKey:NSURLVolumeURLForRemountingKey error:error]){
        return nil;
    }
    
    if(volURL == nil){
        return [NSURL fileURLWithPath:[NSString pathWithComponents:pathComponents]];
    }
    return [volURL URLByAppendingPathComponent:[NSString pathWithComponents:pathComponents]];
}

@end
