//
//  KGProcess.m
//  KGLib
//
//  Created by David Keegan on 8/12/09.
//

#import "KGProcess.h"

@implementation KGProcess

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
