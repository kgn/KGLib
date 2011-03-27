//
//  ISPasteboard.m
//  InScopeLib
//
//  Created by David Keegan on 7/2/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//

#import "ISPasteboard.h"

@implementation ISPasteboard

+ (NSString *)generalPasteBoardString{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    return [pasteboard stringForType:NSPasteboardTypeString];
}

+ (void)copyStringToGeneralPasteBoard:(NSString *)string{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];
    [pasteboard setString:string forType:NSPasteboardTypeString];
}

+ (void)copyHTMLToGeneralPasteBoard:(NSString *)html{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObjects:NSHTMLPboardType, NSPasteboardTypeString, nil] owner:nil];
    [pasteboard setString:html forType:NSHTMLPboardType];
    [pasteboard setString:html forType:NSPasteboardTypeString];
}

@end
