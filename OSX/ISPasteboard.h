//
//  ISPasteboard.h
//  InScopeLib
//
//  Created by David Keegan on 7/2/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//
//  Simplifies posting to the pasteboard.
//

#import <Foundation/Foundation.h>

@interface ISPasteboard : NSObject

+ (NSString *)generalPasteBoardString;
+ (void)copyStringToGeneralPasteBoard:(NSString *)string;
+ (void)copyHTMLToGeneralPasteBoard:(NSString *)html;

@end
