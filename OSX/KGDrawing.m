//
//  KGDrawing.m
//  KGLib
//
//  Created by David Keegan on 4/28/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KGDrawing.h"

@implementation KGDrawing

+ (void)drawMenuBarIconWithPath:(NSBezierPath *)path isAlternate:(BOOL)isAlternate{
    NSColor *mainColor = [NSColor colorWithCalibratedRed:0.11 green:0.11 blue:0.11 alpha:1];
    NSColor *dropColor = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:0.8];
    if(isAlternate){
        mainColor = [NSColor whiteColor];
        dropColor = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.5];
    }
    
    NSShadow *outer = [[NSShadow alloc] init];
    [outer setShadowColor:dropColor];
    [outer setShadowOffset:NSMakeSize(0, -1)];
    [outer setShadowBlurRadius:1];
    
    [NSGraphicsContext saveGraphicsState];
    [outer set];
#if !__has_feature(objc_arc)
    [outer release];
#endif
    [mainColor setFill];
    [path fill];   
    
    if(!isAlternate){
        NSColor *innerColor = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.75];        
        NSShadow *inner = [[NSShadow alloc] init];
        [inner setShadowColor:innerColor];
        [inner setShadowOffset:NSMakeSize(0, -2)];
        [inner setShadowBlurRadius:2];
        
        NSRect borderRect = NSInsetRect([path bounds], -inner.shadowBlurRadius, -inner.shadowBlurRadius);
        borderRect = NSOffsetRect(borderRect, -inner.shadowOffset.width, -inner.shadowOffset.height);
        borderRect = NSInsetRect(NSUnionRect(borderRect, [path bounds]), -1, -1);
        
        NSBezierPath *negativePath = [NSBezierPath bezierPathWithRect:borderRect];
        [negativePath appendBezierPath:path];
        [negativePath setWindingRule:NSEvenOddWindingRule];
        
        [NSGraphicsContext saveGraphicsState];       
        NSShadow *innerShadow = [inner copy];
#if !__has_feature(objc_arc)
        [inner release];
#endif         
        CGFloat xOffset = innerShadow.shadowOffset.width + round(borderRect.size.width);
        CGFloat yOffset = innerShadow.shadowOffset.height;
        innerShadow.shadowOffset = NSMakeSize(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset));
        [innerShadow set];
#if !__has_feature(objc_arc)
        [innerShadow release];
#endif         
        [[NSColor grayColor] setFill];
        [path addClip];
        NSAffineTransform *transform = [NSAffineTransform transform];
        [transform translateXBy:-round(borderRect.size.width) yBy:0];
        [[transform transformBezierPath:negativePath] fill];
        [NSGraphicsContext restoreGraphicsState];
    }
    [NSGraphicsContext restoreGraphicsState];
}

@end
