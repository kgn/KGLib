//
//  ISImageCache.m
//  InScopeLib
//
//  Created by David Keegan on 10/5/11.
//

#import "ISImageCache.h"

@implementation ISImageCache{
    NSMutableDictionary *_retainCache;
    NSMutableDictionary *_imageCache;
    NSMutableSet *_didLoad;
}

- (id)init{
    if((self = [super init])){
        _retainCache = [[NSMutableDictionary alloc] init];
        _imageCache = [[NSMutableDictionary alloc] init];
        _didLoad = [[NSMutableSet alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity{
    if((self = [super init])){
        _retainCache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        _imageCache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
        _didLoad = [[NSMutableSet alloc] initWithCapacity:capacity];
    }
    return self;
}

- (BOOL)didLoad:(id)key{
    return [_didLoad containsObject:key];
}

- (void)setDidLoad:(id)key{
    [_didLoad addObject:key];
}

- (void)retainKey:(id)key{
    NSInteger newCount = [[_retainCache objectForKey:key] integerValue]+1;
    NSLog(@"retain: %@=%lu", key, newCount);
    [_retainCache setObject:[NSNumber numberWithInteger:newCount] forKey:key];
}

- (ISImageCacheImage *)imageForKey:(id)key{
    return [_imageCache objectForKey:key];
}

- (void)setImage:(ISImageCacheImage *)image forKey:(id)key{
    [_imageCache setObject:image forKey:key];
}

- (void)releaseKey:(id)key{
    NSInteger newCount = [[_retainCache objectForKey:key] integerValue]-1;
    if(newCount <= 0){
        NSLog(@"release: %@", key);
        [self removeKey:key];
    }else{
        NSLog(@"release: %@=%lu", key, newCount);
        [_retainCache setObject:[NSNumber numberWithInteger:newCount] forKey:key];
    }
}

- (void)removeKey:(id)key{
    [_imageCache removeObjectForKey:key];
    [_retainCache removeObjectForKey:key];
    [_didLoad removeObject:key];
}

@end
