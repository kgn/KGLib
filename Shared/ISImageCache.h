//
//  ISImageCache.h
//  InScopeLib
//
//  Created by David Keegan on 10/5/11.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define ISImageCacheImage UIImage
#else
#import <Cocoa/Cocoa.h>
#define ISImageCacheImage NSImage
#endif

@interface ISImageCache : NSObject

- (id)initWithCapacity:(NSUInteger)capacity;
- (void)retainKey:(id)key;
- (BOOL)didLoad:(id)key;
- (void)setDidLoad:(id)key;
- (ISImageCacheImage *)imageForKey:(id)key;
- (void)setImage:(ISImageCacheImage *)image forKey:(id)key;
- (void)releaseKey:(id)key;
- (void)removeKey:(id)key;

@end
