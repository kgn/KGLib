//
//  ISLogin.m
//  InScopeLib
//
//  Created by David Keegan on 1/6/11.
//

#import "ISLogin.h"

@implementation ISLogin

+ (NSURL *)appURL{
    return [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
}

+ (BOOL)willStartAtLogin{
    NSURL *appURL = [ISLogin appURL];
    return [ISLogin willStartAtLogin:appURL];
}

+ (BOOL)willStartAtLogin:(NSURL *)itemURL{
    Boolean foundIt = false;
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if(loginItems){
        UInt32 seed = 0U;
        NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
        for(id itemObject in currentLoginItems){
            LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;

            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, /*outRef*/ NULL);
            if(err == noErr){
                foundIt = CFEqual(URL, itemURL);
                CFRelease(URL);

                if(foundIt){
                    break;
                }
            }
        }
        CFRelease(loginItems);
    }
    return (BOOL)foundIt;
}

+ (void)setStartAtLogin:(BOOL)enabled{
    NSURL *appURL = [ISLogin appURL];
    return [ISLogin setStartAtLogin:appURL enabled:enabled];
}

+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled{
    LSSharedFileListItemRef existingItem = NULL;
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if(loginItems){
        UInt32 seed = 0U;
        NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
        for(id itemObject in currentLoginItems){
            LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;

            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, /*outRef*/ NULL);
            if (err == noErr) {
                Boolean foundIt = CFEqual(URL, itemURL);
                CFRelease(URL);

                if (foundIt) {
                    existingItem = item;
                    break;
                }
            }
        }

        if(enabled && (existingItem == NULL)){
            LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemBeforeFirst,
                                          NULL, NULL, (CFURLRef)itemURL, NULL, NULL);
        }else if(!enabled && (existingItem != NULL)){
            LSSharedFileListItemRemove(loginItems, existingItem);
        }

        CFRelease(loginItems);
    }
}

@end
