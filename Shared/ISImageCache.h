//
//  ISImageCache.h
//  Play by Play
//
//  Created by David Keegan on 10/5/11.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#define ISImageCacheImage UIImage
#else
#define ISImageCacheImage NSImage
#endif

@interface ISImageCache : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;
- (void)registerKey:(id)key;
- (BOOL)containsKey:(id)key;
- (ISImageCacheImage *)imageForKey:(id)key;
- (void)setImage:(ISImageCacheImage *)image forKey:(id)key;

@end
