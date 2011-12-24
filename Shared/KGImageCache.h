//
//  KGImageCache.h
//  KGLib
//
//  Created by David Keegan on 10/5/11.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define KGImageCacheImage UIImage
#else
#import <Cocoa/Cocoa.h>
#define KGImageCacheImage NSImage
#endif

@interface KGImageCache : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;
- (void)retainKey:(id)key;
- (BOOL)didLoad:(id)key;
- (void)setDidLoad:(id)key;
- (KGImageCacheImage *)imageForKey:(id)key;
- (void)setImage:(KGImageCacheImage *)image forKey:(id)key;
- (void)releaseKey:(id)key;
- (void)removeKey:(id)key;

@end
