//
//  NSArray+KG.h
//  KGLib
//
//  Created by David Keegan on 11/10/11.
//

#import <Foundation/Foundation.h>

@interface NSArray(KG)

/// Return the first object in the array
- (id)firstObject;

/// Return the first `n` objects in the array
- (NSArray *)firstObjects:(NSUInteger)count;

/// Return the last `n` objects in the array
- (NSArray *)lastObjects:(NSUInteger)count;

@end
