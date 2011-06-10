//
//  ISProcess.h
//  InScopeLib
//
//  Created by David Keegan on 8/12/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//
//  This class has methods for transforming the process.

@interface ISProcess : NSObject

+ (void)transformToForegroundApplication;
+ (void)setApplicationFront;

@end
