//
//  ISFinder.h
//  InScopeLib
//
//  Created by David Keegan on 5/23/09.
//  Copyright 2009-2011 InScopeApps{+}. All rights reserved.
//
//  Requires the ScriptingBrige framework
//  This class tries to simplify dealing with the finder over scripting bridge.
//

#import "Finder.h"

@interface ISFinder : NSObject {}

+ (FinderApplication *)finder;
+ (NSString *)activeFinderWindowURL;
+ (NSArray *)selectedFinderURLs;

@end
