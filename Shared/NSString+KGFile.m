//
//  NSString+KGFile.m
//  KGLib
//
//  Created by David Keegan on 1/2/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "NSString+KGFile.h"

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

@end
