//
//  ISTerminal.h
//  ShellTo
//
//  Created by David Keegan on 1/31/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "Terminal.h"

@interface ISTerminal : NSObject

+ (NSString *)appId;
+ (TerminalApplication *)terminal;
+ (NSString *)escapePath:(NSString*)path;
+ (void)shellTo:(NSString *)path;
+ (void)shellTo:(NSString *)path clear:(BOOL)clear additionalCommand:(NSString *)additionalCommand;
+ (void)runCommand:(NSString *)command;

@end
