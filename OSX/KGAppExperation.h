//
//  KGAppExperation.h
//  KGLib
//
//  Created by David Keegan on 6/22/10.
//

#import <Foundation/Foundation.h>

//Here's an example of how to block and quit an application that has expired
/*
- (void)applicationWillFinishLaunching:(NSNotification *)notification{
    NSInteger daysLeft = [KGAppExperation daysLeftUntilExpiration:14 withCompileTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    NSLog(@"days left: %lu", daysLeft);

    if(daysLeft == 0){
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

        NSLog(@"%@ %@ has expired", appName, appVersion);
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:[NSString stringWithFormat:@"%@ has expired", appName]];
        [alert setInformativeText:[NSString stringWithFormat:@"The beta period for version %@ has expired.", appVersion]];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert runModal];

        [NSApp terminate:self];
    }
}
*/

@interface KGAppExperation : NSObject

//Days left = compile day - current day <= expiration
//The time zone should be set to the time zone the code was compiled in
+ (NSUInteger)daysLeftUntilExpiration:(NSUInteger)days withCompileTimeZone:(NSTimeZone *)timeZone;

@end
