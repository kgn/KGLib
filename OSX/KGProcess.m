//
//  KGProcess.m
//  KGLib
//
//  Created by David Keegan on 8/12/09.
//

#import "KGProcess.h"

@implementation KGProcess

//change process into front process
+ (void)transformToForegroundApplication{
    ProcessSerialNumber psn = {0, kCurrentProcess};
    TransformProcessType(&psn, kProcessTransformToForegroundApplication);
    SetFrontProcess(&psn);    
}

+ (void)setApplicationFront{
    ProcessSerialNumber psn = {0, kCurrentProcess};
    SetFrontProcess(&psn);
}

@end
