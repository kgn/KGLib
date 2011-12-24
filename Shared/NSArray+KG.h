//
//  NSArray+KG.h
//  KGLib
//
//  Created by David Keegan on 11/10/11.
//

#import <Foundation/Foundation.h>

@interface NSArray(KG)

- (id)firstObject;
- (NSArray *)firstObjects:(NSUInteger)count;
- (NSArray *)lastObjects:(NSUInteger)count;

@end
