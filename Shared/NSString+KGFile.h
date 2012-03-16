//
//  NSString+KGFile.h
//  KGLib
//
//  Created by David Keegan on 1/2/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(KGFile)

/// Return a valid filename
- (NSString *)validFilename;

/// Return a valid filename, if `allowHidden` is `YES` then periods will be allows as the first character
- (NSString *)validFilenameAllowHidden:(BOOL)allowHidden;

/// Transform a path into it's true mount path, or return nil
///Example: `/Volumes/slave1` -> `afp://Slave%20One/slave1`
- (NSString *)volumeMountURLWithError:(NSError **)error;

@end
