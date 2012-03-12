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

+ (NSString *)generalPasteBoardString;
+ (void)copyString:(NSString *)string;
+ (void)copyString:(NSString *)string andHTML:(NSString *)html;

@end
