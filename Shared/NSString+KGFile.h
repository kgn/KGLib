//
//  NSString+KGFile.h
//  KGLib
//
//  Created by David Keegan on 1/2/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(KGFile)

- (NSString *)validFilename;
- (NSString *)validFilenameAllowHidden:(BOOL)allowHidden;

- (NSURL *)volumeMountURLWithError:(NSError **)error;

@end
