//
//  NSDictionary+KGJSON.h
//  KGLib
//
//  Created by David Keegan on 12/18/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(KGJSON)

- (NSUInteger)uintSafelyFromKey:(id)key;
- (NSString *)stringSafelyFromKey:(id)key;
- (NSURL *)URLSafelyFromKey:(id)key;
- (id)objectSafelyFromKey:(id)key;

@end
