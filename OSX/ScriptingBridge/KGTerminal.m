//
//  KGTerminal.m
//  KGLib
//
//  Created by David Keegan on 1/31/11.
//  Copyright 2011-12 David Keegan. All rights reserved.
//
//  Made possible by John Daniel's "ShellHere" http://www.etresoft.org/shellhere.html
//

#import "KGTerminal.h"

@implementation KGTerminal

+ (NSString *)appId{
    return @"com.apple.Terminal";
}

+ (TerminalApplication *)terminal{
    static TerminalApplication *terminalApp = nil;
    if(!terminalApp){
        terminalApp = [[SBApplication applicationWithBundleIdentifier:[KGTerminal appId]] retain];
    }
    return terminalApp;
}

+ (NSString *)escapePath:(NSString*)path{
    NSScanner *scanner = [NSScanner scannerWithString:path];

    // Don't skip whitespace.
    [scanner setCharactersToBeSkipped:[NSCharacterSet illegalCharacterSet]];

    // Character set with path-unfriendly characters (punctuation, symbols, white space).
    NSMutableCharacterSet *punctuation = [NSMutableCharacterSet punctuationCharacterSet];
    [punctuation formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
    [punctuation formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];

    // Remove characters that should not (/) or need not (-_.,:+) be replaced.
    [punctuation removeCharactersInString:@"/-_.,:+"];

    NSMutableString *escapedPath = [NSMutableString string];
    NSString *good, *bad;

    while(![scanner isAtEnd]){
        // Scan all the good characters.
        if([scanner scanUpToCharactersFromSet:punctuation intoString:&good]){
            [escapedPath appendString:good];
        }

        // Scan all the bad characters that come next and escape them.
        if([scanner scanCharactersFromSet:punctuation intoString:&bad]){
            for(NSUInteger i=0; i<[bad length]; ++i){
                [escapedPath appendFormat:@"\\%C", [bad characterAtIndex:i]];
            }
        }
    }

    return escapedPath;
}

+ (void)shellTo:(NSString *)path{
    [KGTerminal shellTo:path clear:YES additionalCommand:nil];
}

+ (void)shellTo:(NSString *)path clear:(BOOL)clear additionalCommand:(NSString *)additionalCommand{
    NSString *clearCmd = clear ? @";clear" : @"";
    NSString *command = [NSString stringWithFormat: @"cd %@%@",
                         [self escapePath:path], clearCmd];
    if([additionalCommand length]){
        command = [NSString stringWithFormat:@"%@;%@", command, additionalCommand];
    }
    [KGTerminal runCommand:command];
}

+ (void)runCommand:(NSString *)command{
    TerminalTab *currentTab = nil;
    if(![[KGTerminal terminal] isRunning]){
        SBElementArray *terminalWindows = [[KGTerminal terminal] windows];
        TerminalWindow *lastTerminalWindow = [terminalWindows lastObject];
        currentTab = [[lastTerminalWindow tabs] lastObject];
    }

    [[KGTerminal terminal] doScript:command in:currentTab];
    [[KGTerminal terminal] activate];
}

@end
