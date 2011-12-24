//
//  KGProcess.h
//  KGLib
//
//  Created by David Keegan on 8/12/09.
//
//  Class methods for transforming the process.
//

#import <Foundation/Foundation.h>

@interface KGProcess : NSObject

+ (void)transformToForegroundApplication;
+ (void)setApplicationFront;

@end
