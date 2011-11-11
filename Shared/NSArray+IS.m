//
//  NSArray+IS.m
//  InScopeLib
//
//  Created by David Keegan on 11/10/11.
//

#import "NSArray+IS.h"

@implementation NSArray(IS)

- (id)firstObject{
    return [self objectAtIndex:0];
}

- (NSArray *)lastObjects:(NSUInteger)count{
    NSRange theRange;
    NSUInteger arrayCount = [self count];
    if(arrayCount > count){
        theRange.location = arrayCount-count;
        theRange.length = count;
    }else{
        theRange.location = 0;
        theRange.length = [self count];
    }
    return [self subarrayWithRange:theRange];
}

@end
