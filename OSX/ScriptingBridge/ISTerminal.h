//
//  ISTerminal.h
//  ShellTo
//
//  Created by David Keegan on 1/31/11.
//  Copyright 2011 InScopeApps {+}. All rights reserved.
//

#import "Terminal.h"

@interface ISTerminal : NSObject {}

+ (TerminalApplication *)terminal;
+ (NSString *)escapePath:(NSString*)path;
+ (void)shellTo:(NSString *)path;

@end
