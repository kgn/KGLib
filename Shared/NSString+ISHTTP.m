//
//  NSString+ISHTTP.m
//  InScopeLib
//
//  Created by David Keegan on 10/1/11.
//

#import "NSString+ISHTTP.h"

@implementation NSString(ISHTTP)

+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args{
    NSMutableArray *argsAndValues = [[NSMutableArray alloc] initWithCapacity:[args count]];
    @autoreleasepool{
        for(NSString *key in [args allKeys]){
            NSString *escapedKey = [key stringWithURLEncoding];
            NSString *value = [[args objectForKey:key] stringWithURLEncoding];
            [argsAndValues addObject:[NSString stringWithFormat:@"%@=%@", escapedKey, value]];
        }
    }
    return [argsAndValues componentsJoinedByString:@"&"];
}

- (NSString *)stringWithURLEncoding{
    CFStringRef escaped =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self, NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    return (__bridge NSString *)escaped;
}

@end
