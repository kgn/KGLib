//
//  NSDictionary+KGJSON.m
//  KGLib
//
//  Created by David Keegan on 12/18/11.
//  Copyright (c) 2011 David Keegan. All rights reserved.
//

#import "NSDictionary+KGJSON.h"

@implementation NSDictionary(KGJSON)

- (NSUInteger)uintSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return NSNotFound;
    }
    return [[self objectForKey:key] integerValue];
}

- (NSString *)stringSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    return [NSString stringWithString:[self objectForKey:key]];
}

- (NSURL *)URLSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    NSString *urlString =
    [[self objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:urlString];
}

- (id)objectSafelyFromKey:(id)key{
    if([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil){
        return nil;
    }
    return [self objectForKey:key];
}

@end
