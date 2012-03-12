//
//  KGPasteboard.m
//  KGLib
//
//  Created by David Keegan on 7/2/09.
//

#import "KGPasteboard.h"

@implementation KGPasteboard

+ (NSString *)generalPasteBoardString{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    return [pasteboard stringForType:NSPasteboardTypeString];
}

+ (void)copyString:(NSString *)string{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSPasteboardTypeString] owner:nil];
    [pasteboard setString:string forType:NSPasteboardTypeString];
}

+ (void)copyString:(NSString *)string andHTML:(NSString *)html{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:[NSArray arrayWithObjects:NSHTMLPboardType, NSPasteboardTypeString, nil] owner:nil];
    [pasteboard setString:html forType:NSHTMLPboardType];
    [pasteboard setString:string forType:NSPasteboardTypeString];
}

@end
