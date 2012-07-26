//
//  NSMutableAttributedString+KG.m
//  KGLib
//
//  Created by David Keegan on 10/23/11.
//

#import "NSMutableAttributedString+KG.h"

@implementation NSMutableAttributedString(KG)

- (NSRange)replaceString:(NSString *)src withString:(NSString *)dst{
    NSRange range = [[self string] rangeOfString:src];
    if(range.length > 0){
        [self replaceCharactersInRange:range withString:(dst ?: @"")];
        range.length = dst.length;
    }
    return range;
}

- (void)replaceString:(NSString *)src withString:(NSString *)dst andAttributes:(NSDictionary *)attributes{
    NSRange range = [self replaceString:src withString:dst];
    if(range.length > 0 && attributes){
        [self addAttributes:attributes range:range];
    }
}

- (void)replaceString:(NSString *)src withString:(NSString *)dst andLink:(NSURL *)url withTooltip:(NSString *)tooltip{
    NSDictionary *attrs = @{NSLinkAttributeName: url, 
                           NSToolTipAttributeName: tooltip};
    [self replaceString:src withString:dst andAttributes:attrs];
}

- (void)addTextShadow:(NSShadow *)shadow{
    [self addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, [[self string] length])];
}

@end
