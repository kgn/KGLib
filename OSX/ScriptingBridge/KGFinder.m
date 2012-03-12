//
//  KGFinder.h
//  KGLib
//
//  Created by David Keegan on 5/23/09.
//  Copyright 2009-2011 InScopeApps{+}. All rights reserved.
//

#import "KGFinder.h"

@implementation KGFinder

+ (FinderApplication *)finder{
    static FinderApplication *finderApp = nil;
    if(finderApp == nil){
        finderApp = [[SBApplication applicationWithBundleIdentifier:@"com.apple.finder"] retain];
    }
    return finderApp;
}

+ (NSString *)activeFinderWindowURL{
    FinderWindow *frontWindow = [[[KGFinder finder] windows] objectAtIndex:0];
    FinderFolder *folder = [[frontWindow properties] objectForKey:@"target"];
    if([folder respondsToSelector:@selector(URL)] && [folder URL] != nil){
        return [[NSURL URLWithString:[folder URL]] path];
    }
    return nil;
}

+ (NSArray *)selectedFinderURLs{
    NSMutableArray *selected = [[NSMutableArray alloc] init];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for(FinderItem *item in [[[KGFinder finder] selection] get]){
        if([item respondsToSelector:@selector(URL)] && [item URL] != nil){
            [selected addObject:[[NSURL URLWithString:[item URL]] path]];
        }
    }
    [pool drain];
    return [selected autorelease];
}

@end
