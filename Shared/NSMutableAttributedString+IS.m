//
//  NSMutableAttributedString+IS.m
//  InScopeLib
//
//  Created by David Keegan on 10/23/11.
//

#import "NSMutableAttributedString+IS.h"

@implementation NSMutableAttributedString(IS)

- (NSRange)replaceString:(NSString *)src withString:(NSString *)dst{
    NSRange range = [[self string] rangeOfString:src];
    if(range.length > 0){
        [self replaceCharactersInRange:range withString:(dst ?: @"")];
        range.length = dst.length;
    }
    return range;
}

- (void)replaceString:(NSString *)src withString:(NSString *)dst andLink:(NSURL *)url withTooltip:(NSString *)tooltip{
    NSRange range = [self replaceString:src withString:dst];
    if (range.length > 0) {
        if(url != nil){
            [self addAttribute:NSLinkAttributeName value:url range:range];
        }
        if(tooltip != nil){
            [self addAttribute:NSToolTipAttributeName value:tooltip range:range];
        }
    }
}

- (void)addTextShadow:(NSShadow *)shadow{
    [self addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, [[self string] length])];
}

@end
