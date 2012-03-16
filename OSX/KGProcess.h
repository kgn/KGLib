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

/// Transform the process into a forground application
+ (void)transformToForegroundApplication;

/// Set the application as the front most one
+ (void)setApplicationFront;

@end
