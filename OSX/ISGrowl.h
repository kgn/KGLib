//
//  ISGrowl.h
//  InScopeLib
//
//  Created by David Keegan on 7/2/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//
//  This class tries to simplify posting to growl. 
//  Growl has a lot of features, this class ignores all of them for simplicity :)
//

#import <Growl/Growl.h>

@interface ISGrowl : NSObject <GrowlApplicationBridgeDelegate>{
    NSString *notification;
}

@property (copy) NSString *notification;

- (id)initWithNotification:(NSString *)newNotification;
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;

@end
