//
//  ISImageCache.m
//  InScopeLib
//
//  Created by David Keegan on 10/5/11.
//

#import "ISImageCache.h"

@implementation ISImageCache{
    NSMutableSet *imageRetrievedCache;
    NSMutableDictionary *imageCache;
}

- (id)init{
    if((self = [super init])){
        imageRetrievedCache = [[NSMutableSet alloc] init];
        imageCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity{
    if((self = [super init])){
        imageRetrievedCache = [[NSMutableSet alloc] initWithCapacity:capacity];
        imageCache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    }
    return self;
}

- (BOOL)containsKey:(id)key{
    return [imageRetrievedCache containsObject:key];
}

- (void)registerKey:(id)key{
    [imageRetrievedCache addObject:key];
}

- (ISImageCacheImage *)imageForKey:(id)key{
    return [imageCache objectForKey:key];
}

- (void)setImage:(ISImageCacheImage *)image forKey:(id)key{
    [imageCache setObject:image forKey:key];
}

- (void)removeKey:(id)key{
    [imageCache removeObjectForKey:key];
    [imageRetrievedCache removeObject:key];
}

- (void)removeKeysNotInSet:(NSSet *)keys{
    NSMutableSet *removeKeys = [NSSet set];
    [imageRetrievedCache enumerateObjectsUsingBlock:^(id key, BOOL *stop){
        if(![keys containsObject:key]){
            [removeKeys addObject:key];
        }
    }];
    [removeKeys enumerateObjectsUsingBlock:^(id key, BOOL *stop){
        [self removeKey:key];
    }];    
}

@end
