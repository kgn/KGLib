//
//  KGPasteboard.h
//  KGLib
//
//  Created by David Keegan on 7/2/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//
//  Simplifies posting to the pasteboard.
//

#import <Cocoa/Cocoa.h>

@interface KGPasteboard : NSObject

/// The general use pasteboard
+ (NSString *)generalPasteBoardString;

/// Copy a strig to the general pasteboard
+ (void)copyString:(NSString *)string;

/// Copy a string to the general pasteboard and html to the general html pasteboard
+ (void)copyString:(NSString *)string andHTML:(NSString *)html;

@end
