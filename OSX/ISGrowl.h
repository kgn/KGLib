//
//  ISGrowl.h
//  InScopeLib
//
//  Created by David Keegan on 7/2/09.
//
//  Growl has a lot of features, this class ignores all of them for simplicity :)
//

#import <Foundation/Foundation.h>
#import <Growl/Growl.h>

@interface ISGrowl : NSObject <GrowlApplicationBridgeDelegate>

@property (strong, readonly) NSString *notification;

- (id)initWithNotification:(NSString *)newNotification;
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;

@end
