//
//  ISTerminal.m
//  ShellTo
//
//  Created by David Keegan on 1/31/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//
//  Made possible by John Daniel's "ShellHere" http://www.etresoft.org/shellhere.html
//

#import "ISTerminal.h"

@implementation ISTerminal

+ (NSString *)appId{
    return @"com.apple.Terminal";
}

+ (TerminalApplication *)terminal{
    static TerminalApplication *terminalApp = nil;
    if(!terminalApp){
        terminalApp = [SBApplication applicationWithBundleIdentifier:[ISTerminal appId]];
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
    [ISTerminal shellTo:path clear:YES];
}

+ (void)shellTo:(NSString *)path clear:(BOOL)clear{
    NSString *clearCmd = clear ? @";clear;" : @"";
    NSString *command = [NSString stringWithFormat: @"cd %@%@", 
                         [self escapePath:path], clearCmd];
    [ISTerminal runCommand:command];
}

+ (void)runCommand:(NSString *)command{
    TerminalTab *currentTab = nil;
    if(![[ISTerminal terminal] isRunning]){
        SBElementArray *terminalWindows = [[ISTerminal terminal] windows];
        TerminalWindow *lastTerminalWindow = [terminalWindows lastObject];
        currentTab = [[lastTerminalWindow tabs] lastObject];
    }
    
    [[ISTerminal terminal] doScript:command in:currentTab];
    [[ISTerminal terminal] activate];
}

@end
