//
//  NSString+KGFile.m
//  KGLib
//
//  Created by David Keegan on 1/2/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "NSString+KGFile.h"
#import <AppKit/AppKit.h>

@implementation NSString(KGFile)

- (NSString *)validFilename{
    return [self validFilenameAllowHidden:NO];
}

- (NSString *)validFilenameAllowHidden:(BOOL)allowHidden{
    // make sure no illegal characters are in the name
    static NSCharacterSet *illegalFileNameCharacters = nil;
    if(illegalFileNameCharacters == nil){
        illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/:"];
    }
    
    NSString *newString = 
    [[self componentsSeparatedByCharactersInSet:illegalFileNameCharacters] 
     componentsJoinedByString:@""];
    
    if(allowHidden){
        return newString;        
    }
    
    // strip leading dots, dots will make the file hidden
    NSUInteger i = 0;
    static NSCharacterSet *dotCharacterSet = nil;
    if(dotCharacterSet == nil){
        dotCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
    }    
    while([dotCharacterSet characterIsMember:[newString characterAtIndex:i]]){
        ++i;
    }
    return [newString substringFromIndex:i];
}

- (NSString *)volumeMountURLWithError:(NSError **)error{
    NSURL *testURL = [NSURL fileURLWithPath:self];
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
    if(floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6){
        if(![[NSURL fileURLWithPath:self] getResourceValue:&volURL forKey:NSURLVolumeURLForRemountingKey error:error]){
            return nil;
        }
    }else{
        FSRef pathRef;
        FSPathMakeRef((UInt8*)[self fileSystemRepresentation], &pathRef, NULL);
        FSCatalogInfo catalogInfo;
        OSErr osErr = FSGetCatalogInfo(&pathRef, kFSCatInfoVolume, &catalogInfo, NULL, NULL, NULL);
        FSVolumeRefNum volumeRefNum = 0;
        if(osErr == noErr){
            volumeRefNum = catalogInfo.volume;
        }
        CFURLRef serverLocation;
        OSStatus result = FSCopyURLForVolume(volumeRefNum, &serverLocation);
        if(result == noErr){
#if !__has_feature(objc_arc)            
            volURL = (NSURL *)serverLocation;
#else
            volURL = (__bridge NSURL *)serverLocation;
#endif            
        }else{
            return nil;
        }   
    }
    
    if(volURL == nil || [volURL isFileURL]){
        return nil;
    }
    
    // remove the username from the path if it's there
    NSURL *fullURL= [volURL URLByAppendingPathComponent:[NSString pathWithComponents:pathComponents]];
    NSURL *trimedUrl = [[NSURL alloc] initWithScheme:[fullURL scheme] host:[fullURL host] path:[fullURL path]];
#if !__has_feature(objc_arc)
    [trimedUrl autorelease];
#endif
    // ; or ? doesn't get escaped so do it manually
    return [[[trimedUrl absoluteString] 
            stringByReplacingOccurrencesOfString:@";" withString:@"%3B"] 
            stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
}

@end
