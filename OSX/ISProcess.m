//
//  ISProcess.m
//  InScopeLib
//
//  Created by David Keegan on 8/12/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//

#import "ISProcess.h"

@implementation ISProcess

+ (void)transformToForegroundApplication{
    //change process into front process
    ProcessSerialNumber psn = {0, kCurrentProcess}; 
    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
}

+ (void)setApplicationFront{
    ProcessSerialNumber psn = {0, kCurrentProcess}; 
    SetFrontProcess(&psn);
}

@end
