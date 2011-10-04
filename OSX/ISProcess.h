//
//  ISProcess.h
//  InScopeLib
//
//  Created by David Keegan on 8/12/09.
//
//  Class methods for transforming the process.
//

#import <Foundation/Foundation.h>

@interface ISProcess : NSObject

+ (void)transformToForegroundApplication;
+ (void)setApplicationFront;

@end
