//
//  NSString+KGHTTP.m
//  KGLib
//
//  Created by David Keegan on 10/1/11.
//

#import "NSString+KGHTTP.h"

@implementation NSString(KGHTTP)

+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args{
    NSMutableArray *argsAndValues = [[NSMutableArray alloc] initWithCapacity:[args count]];
    @autoreleasepool{
        for(NSString *key in [args allKeys]){
            NSString *escapedKey = [key stringWithURLEncoding];
            NSString *value = [args[key] stringWithURLEncoding];
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
    NSString *string = [NSString stringWithString:(__bridge NSString *)escaped];
    CFRelease(escaped);
    return string;
}

@end
