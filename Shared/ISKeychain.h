//
//  ISKeychain.h
//  InScopeLib
//
//  Created by David Keegan on 10/2/11.
//

#import <Foundation/Foundation.h>

@interface ISKeychain : NSObject

+ (BOOL)passwordExistsForService:(NSString *)serviceName andAccount:(NSString *)accountName;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName andAccount:(NSString *)accountName;
+ (NSString *)passwordForService:(NSString *)serviceName andAccount:(NSString *)accountName;
+ (BOOL)removeEntryForService:(NSString *)serviceName andAccount:(NSString *)accountName;

@end
