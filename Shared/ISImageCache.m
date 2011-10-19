//
//  ISImageCache.m
//  InScopeLib
//
//  Created by David Keegan on 10/5/11.
//

#import "ISImageCache.h"

@implementation ISImageCache{
    NSMutableDictionary *retainCache;
    NSMutableDictionary *imageCache;
}

- (id)init{
    if((self = [super init])){
        retainCache = [[NSMutableDictionary alloc] init];
        imageCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity{
    if((self = [super init])){
        retainCache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        imageCache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    }
    return self;
}

- (BOOL)containsKey:(id)key{
    return ([retainCache objectForKey:key] != nil);
}

- (void)retainKey:(id)key{
    NSNumber *count = [retainCache objectForKey:key];
    if(count == nil){
        count = [NSNumber numberWithInteger:0];
    }else{ 
        NSInteger iCount = [count integerValue]+1;
        count = [NSNumber numberWithInteger:iCount];
    }
    NSLog(@"retain: %@=%@", key, count);
    [retainCache setObject:count forKey:key];
}

- (ISImageCacheImage *)imageForKey:(id)key{
    return [imageCache objectForKey:key];
}

- (void)setImage:(ISImageCacheImage *)image forKey:(id)key{
    [imageCache setObject:image forKey:key];
}

- (void)releaseKey:(id)key{
    NSInteger newCount = [[retainCache objectForKey:key] integerValue]-1;
    if(newCount <= 0){
        NSLog(@"release: %@", key);
        [self removeKey:key];
    }else{
        NSLog(@"release: %@=%lu", key, newCount);
        [retainCache setObject:[NSNumber numberWithInteger:newCount] forKey:key];
    }
}

- (void)removeKey:(id)key{
    [imageCache removeObjectForKey:key];
    [retainCache removeObjectForKey:key];
}

@end
