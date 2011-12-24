//
//  NSMutableAttributedString+KG.h
//  KGLib
//
//  Created by David Keegan on 10/23/11.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString(KG)

- (NSRange)replaceString:(NSString *)src withString:(NSString *)dst;
- (void)replaceString:(NSString *)src withString:(NSString *)dst andLink:(NSURL *)url withTooltip:(NSString *)tooltip;
- (void)addTextShadow:(NSShadow *)shadow;

@end
