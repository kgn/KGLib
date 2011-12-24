//
//  KGLogin.m
//  KGLib
//
//  Created by David Keegan on 1/6/11.
//
//  Made possible by: http://stackoverflow.com/questions/815063/how-do-you-make-your-app-open-at-login/2318004#2318004
//

#import <Foundation/Foundation.h>

@interface KGLogin : NSObject

+ (NSURL *)appURL;

+ (BOOL)willStartAtLogin;
+ (BOOL)willStartAtLogin:(NSURL *)itemURL;

+ (void)setStartAtLogin:(BOOL)enabled;
+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;

@end
