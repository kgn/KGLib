//
//  KGTerminal.h
//  KGLib
//
//  Created by David Keegan on 1/31/11.
//

#import <Foundation/Foundation.h>
#import "Terminal.h"

@interface KGTerminal : NSObject

+ (NSString *)appId;
+ (TerminalApplication *)terminal;
+ (NSString *)escapePath:(NSString*)path;
+ (void)shellTo:(NSString *)path;
+ (void)shellTo:(NSString *)path clear:(BOOL)clear additionalCommand:(NSString *)additionalCommand;
+ (void)runCommand:(NSString *)command;

@end
