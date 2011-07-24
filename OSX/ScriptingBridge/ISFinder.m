//
//  ISFinder.h
//  InScopeLib
//
//  Created by David Keegan on 5/23/09.
//  Copyright 2009-2011 InScopeApps{+}. All rights reserved.
//

#import "ISFinder.h"

@implementation ISFinder

+ (FinderApplication *)finder{
    static FinderApplication *finderApp = nil;
    if(!finderApp){
        finderApp = [[SBApplication applicationWithBundleIdentifier:@"com.apple.finder"] retain];
    }
    return finderApp;
}

+ (NSString *)activeFinderWindowURL{
    //the front window looks like it is always the first in the array
    //if this is not the case we will need to loop over the windows
    //and inspect their indices, the windows count from front to back
    FinderWindow *frontWindow = [[[ISFinder finder] windows] objectAtIndex:0];
    FinderFolder *folder = [[frontWindow properties] objectForKey:@"target"];
    if([folder respondsToSelector:@selector(URL)]){
        return [[NSURL URLWithString:[folder URL]] path];
    }
    return nil;
}

+ (NSArray *)selectedFinderURLs{
    NSMutableArray *selected = [[NSMutableArray alloc] init];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; 
    for(FinderItem *item in [[[ISFinder finder] selection] get]){
        if([item respondsToSelector:@selector(URL)]){
            [selected addObject:[[NSURL URLWithString:[item URL]] path]];
        }
    }
    [pool drain];
    return [selected autorelease];
}

@end
