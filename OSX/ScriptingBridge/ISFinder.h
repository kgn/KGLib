//
//  ISFinder.h
//  InScopeLib
//
//  Created by David Keegan on 5/23/09.
//

#import <Foundation/Foundation.h>
#import "Finder.h"

@interface ISFinder : NSObject {}

+ (FinderApplication *)finder;
+ (NSString *)activeFinderWindowURL;
+ (NSArray *)selectedFinderURLs;

@end
