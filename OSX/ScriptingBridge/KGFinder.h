//
//  KGFinder.h
//  KGLib
//
//  Created by David Keegan on 5/23/09.
//

#import <Foundation/Foundation.h>
#import "Finder.h"

@interface KGFinder : NSObject {}

+ (FinderApplication *)finder;
+ (NSString *)activeFinderWindowURL;
+ (NSArray *)selectedFinderURLs;

@end
