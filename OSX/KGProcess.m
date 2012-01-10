//
//  KGProcess.m
//  KGLib
//
//  Created by David Keegan on 8/12/09.
//

#import "KGProcess.h"
#import <Carbon/Carbon.h>

@implementation KGProcess

// inspired by http://www.cocoadev.com/index.pl?TransformProcessType

+ (void)transformToForegroundApplication{
    ProcessSerialNumber psn = {0, kCurrentProcess};
    OSStatus returnCode = TransformProcessType(&psn, kProcessTransformToForegroundApplication);
    if(returnCode == 0){
        SetSystemUIMode(kUIModeNormal, 0);
        ProcessSerialNumber psnx = {0, kNoProcess};
        GetNextProcess(&psnx);
        SetFrontProcess(&psnx);
        [self performSelector:@selector(setApplicationFront) 
                   withObject:nil afterDelay:0.5f];
    }
}

+ (void)setApplicationFront{
    ProcessSerialNumber psn = {0, kCurrentProcess};
    SetFrontProcess(&psn);
}

@end
