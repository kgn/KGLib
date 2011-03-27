//
//  ISGrowl.h
//  InScopeLib
//
//  Created by David Keegan on 7/2/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//

#import "ISGrowl.h"

@implementation ISGrowl

@synthesize notification;

- (id)init{
    return [self initWithNotification:nil];
}

- (id)initWithNotification:(NSString *)newNotification{
    if((self = [super init])){
        self.notification = newNotification;
        [GrowlApplicationBridge setGrowlDelegate:self];
    }
    return self;
}

- (void)displayMessage:(NSString *)message withTitle:(NSString *)title{
    if(message && title){
        [GrowlApplicationBridge notifyWithTitle:title
                                    description:message 
                               notificationName:self.notification
                                       iconData:nil 
                                       priority:0 
                                       isSticky:NO 
                                   clickContext:nil];
    }
}

- (NSDictionary *)registrationDictionaryForGrowl{
    NSArray *notificationArray = [NSArray arrayWithObject:self.notification];
    NSDictionary *notificationDict = [NSDictionary dictionaryWithObjectsAndKeys:
                          notificationArray, GROWL_NOTIFICATIONS_ALL,
                          notificationArray, GROWL_NOTIFICATIONS_DEFAULT,
                          nil];
    return notificationDict;
}

@end
