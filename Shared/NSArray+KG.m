//
//  NSArray+KG.m
//  KGLib
//
//  Created by David Keegan on 11/10/11.
//

#import "NSArray+KG.h"

@implementation NSArray(KG)

- (id)firstObject{
    return self[0];
}

- (NSArray *)firstObjects:(NSUInteger)count{
    NSRange range = NSMakeRange(0, MIN(count, [self count]));
    return [self subarrayWithRange:range];
}

- (NSArray *)lastObjects:(NSUInteger)count{
    NSRange range;
    NSUInteger arrayCount = [self count];
    if(arrayCount > count){
        range.location = arrayCount-count;
        range.length = count;
    }else{
        range.location = 0;
        range.length = arrayCount;
    }
    return [self subarrayWithRange:range];
}

@end
