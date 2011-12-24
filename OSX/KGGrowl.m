//
//  KGGrowl.h
//  KGLib
//
//  Created by David Keegan on 7/2/09.
//

#import "KGGrowl.h"

@implementation KGGrowl

@synthesize notification = _notification;

- (id)init{
		return [self initWithNotification:nil];
}

- (id)initWithNotification:(NSString *)newNotification{
		if((self = [super init])){
				_notification = newNotification;
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
