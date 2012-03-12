//
//  NSURL+KGFile.h
//  KGLib
//
//  Created by David Keegan on 3/11/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(KGFile)

- (NSURL *)volumeMountURLWithError:(NSError *__autoreleasing *)error;

@end
