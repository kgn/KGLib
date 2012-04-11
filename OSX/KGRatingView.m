//
//  KGRatingView.m
//  KGLib
//
//  Created by David Keegan on 11/8/10.
//  Copyright 2010-2012 David Keegan. All rights reserved.
//

#import "KGRatingView.h"
#import "KGFoundation.h"
#import "NSImage+BBlock.h"
#import "NSTimer+BBlocks.h"
#import "BBlock.h"

@interface KGRatingView()
- (NSUInteger)windowPointToPercentage:(NSPoint)aPoint;
- (void)updateViewForRating:(NSUInteger)rating;
- (NSImage *)deactiveImage;
- (NSImage *)activeImage;
- (NSImage *)halfImage;
@end

@implementation KGRatingView{
    NSImageView *_cell1, *_cell2, 
    *_cell3, *_cell4, *_cell5;
    KGRatingViewCallback _callback;
    BOOL _entered, _timerCleared;
}

@synthesize enabled = _enabled;
@synthesize allowHalfRating = _allowHalfRating;
@synthesize rating = _rating;
@synthesize hoverDelay = _hoverDelay;

- (NSUInteger)windowPointToPercentage:(NSPoint)aPoint{
    NSPoint viewPoint = [self convertPoint:aPoint fromView:nil];
    NSUInteger percentage = (NSUInteger)round(viewPoint.x/self.frame.size.width*10)*10;
    
    //if we are not allowing half ratings round up.
    if(!self.allowHalfRating && (BOOL)(percentage*0.1)&1){
        percentage += 10;
    }
    return percentage;
}

- (void)updateViewForRating:(NSUInteger)rating{
    NSImage *image1 = [self deactiveImage];
    NSImage *image2 = [self deactiveImage];
    NSImage *image3 = [self deactiveImage];
    NSImage *image4 = [self deactiveImage];
    NSImage *image5 = [self deactiveImage];
    
    if(rating > 0){
        if(rating >= 10){
            image1 = rating < 20 ? [self halfImage] : [self activeImage];
        }
        if(rating >= 30){
            image2 = rating < 40 ? [self halfImage] : [self activeImage];
        }
        if(rating >= 50){
            image3 = rating < 60 ? [self halfImage] : [self activeImage];
        }   
        if(rating >= 70){
            image4 = rating < 80 ? [self halfImage] : [self activeImage];
        }  
        if(rating >= 90){
            image5 = rating < 100 ? [self halfImage] : [self activeImage];
        }
    }
    
    _cell1.image = image1;
    _cell2.image = image2;
    _cell3.image = image3;
    _cell4.image = image4;
    _cell5.image = image5;
}

- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        self.hoverDelay = 0.1;
        
        NSRect cellRect = NSZeroRect;
        cellRect.size.width = round(NSWidth(self.bounds)/5);
        cellRect.size.height = NSHeight(self.bounds);
        
        _cell1 = [[NSImageView alloc] initWithFrame:cellRect];
        [self addSubview:_cell1];
        
        cellRect.origin.x += NSWidth(cellRect);
        _cell2 = [[NSImageView alloc] initWithFrame:cellRect];
        [self addSubview:_cell2];
        
        cellRect.origin.x += NSWidth(cellRect);
        _cell3 = [[NSImageView alloc] initWithFrame:cellRect];
        [self addSubview:_cell3];
        
        cellRect.origin.x += NSWidth(cellRect);
        _cell4 = [[NSImageView alloc] initWithFrame:cellRect];
        [self addSubview:_cell4];
        
        cellRect.origin.x += NSWidth(cellRect);
        _cell5 = [[NSImageView alloc] initWithFrame:cellRect];
        [self addSubview:_cell5];
        
        NSTrackingArea *trackingArea = 
        [[NSTrackingArea alloc] initWithRect:self.visibleRect 
                                     options:(NSTrackingMouseEnteredAndExited | 
                                              NSTrackingMouseMoved | 
                                              NSTrackingActiveAlways)
                                       owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
        
        [self updateViewForRating:0];
        _enabled = YES;
    }
    return self;
}

- (void)setRating:(NSUInteger)rating{
    if(self.rating != rating){
        [self updateViewForRating:rating];
        _rating = rating;
    }
}

- (void)setRatingChangedCallback:(KGRatingViewCallback)block{
    _callback = [block copy];
}

#pragma mark -
#pragma mark Mouse Events

- (void)mouseEntered:(NSEvent *)theEvent{
    if(self.isEnabled){
        _entered = YES;
        [NSTimer scheduledTimerWithTimeInterval:self.hoverDelay andBlock:^{
            [BBlock dispatchOnMainThread:^{
                if(_entered){                    
                    _timerCleared = YES;
                    [[self window] setAcceptsMouseMovedEvents:YES];
                    [[self window] makeFirstResponder:self];
                }                    
            }];
        }];
    }
}

- (void)mouseMoved:(NSEvent *)theEvent{
    if(self.isEnabled && _timerCleared){
        NSInteger rating = [self windowPointToPercentage:theEvent.locationInWindow];
        [self updateViewForRating:rating];
    }
}

- (void)mouseExited:(NSEvent *)theEvent{
    _entered = NO;
    _timerCleared = NO;
    [[self window] setAcceptsMouseMovedEvents:NO];
    [self updateViewForRating:self.rating];
}

- (void)mouseDown:(NSEvent *)theEvent{
    if(self.isEnabled){
        self.rating = [self windowPointToPercentage:theEvent.locationInWindow];        
        if(_callback){
            _callback(self.rating);
        }
    }
}

#pragma mark -
#pragma image drawing

- (NSImage *)deactiveImage{
    return [NSImage imageWithIdentifier:NSStringFromSelector(_cmd) forSize:NSMakeSize(7, 8) andDrawingBlock:^{
        //// Color Declarations
        NSColor* color = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0.5];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: color];
        [shadow setShadowOffset: NSMakeSize(0, -1)];
        [shadow setShadowBlurRadius: 0];
        
        //// Oval Drawing
        NSBezierPath* ovalPath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(0, 1, 7, 7)];
        [NSGraphicsContext saveGraphicsState];
        [shadow set];
        [[NSColor whiteColor] setFill];
        [ovalPath fill];
        [NSGraphicsContext restoreGraphicsState];
    }];    
}

- (NSImage *)activeImage{
    return [NSImage imageWithIdentifier:NSStringFromSelector(_cmd) forSize:NSMakeSize(27, 28) andDrawingBlock:^{
        //// Color Declarations
        NSColor* color = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0.5];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: color];
        [shadow setShadowOffset: NSMakeSize(0, -1)];
        [shadow setShadowBlurRadius: 0];
        
        //// Star Drawing
        NSBezierPath* starPath = [NSBezierPath bezierPath];
        [starPath moveToPoint: NSMakePoint(13.5, 28)];
        [starPath lineToPoint: NSMakePoint(10, 18)];
        [starPath lineToPoint: NSMakePoint(-0, 18)];
        [starPath lineToPoint: NSMakePoint(7.71, 11.29)];
        [starPath lineToPoint: NSMakePoint(5.14, 1)];
        [starPath lineToPoint: NSMakePoint(13.5, 7.39)];
        [starPath lineToPoint: NSMakePoint(21.86, 1)];
        [starPath lineToPoint: NSMakePoint(19.29, 11.29)];
        [starPath lineToPoint: NSMakePoint(27, 18)];
        [starPath lineToPoint: NSMakePoint(17, 18)];
        [starPath lineToPoint: NSMakePoint(13.5, 28)];
        [starPath closePath];
        [NSGraphicsContext saveGraphicsState];
        [shadow set];
        [[NSColor whiteColor] setFill];
        [starPath fill];
        [NSGraphicsContext restoreGraphicsState];
    }];
}

- (NSImage *)halfImage{
    return [NSImage imageWithIdentifier:NSStringFromSelector(_cmd) forSize:NSMakeSize(27, 28) andDrawingBlock:^{
        //// Color Declarations
        NSColor* color = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 0.5];
        
        //// Shadow Declarations
        NSShadow* shadow = [[NSShadow alloc] init];
        [shadow setShadowColor: color];
        [shadow setShadowOffset: NSMakeSize(0, -1)];
        [shadow setShadowBlurRadius: 0];
        
        //// Bezier Drawing
        NSBezierPath* halfStarPath = [NSBezierPath bezierPath];
        [halfStarPath moveToPoint: NSMakePoint(14, 26.57)];
        [halfStarPath lineToPoint: NSMakePoint(14, 7.01)];
        [halfStarPath lineToPoint: NSMakePoint(13.5, 7.39)];
        [halfStarPath lineToPoint: NSMakePoint(5.14, 1)];
        [halfStarPath lineToPoint: NSMakePoint(7.71, 11.29)];
        [halfStarPath lineToPoint: NSMakePoint(-0, 18)];
        [halfStarPath lineToPoint: NSMakePoint(10, 18)];
        [halfStarPath lineToPoint: NSMakePoint(13.5, 28)];
        [halfStarPath lineToPoint: NSMakePoint(14, 26.57)];
        [halfStarPath closePath];
        [NSGraphicsContext saveGraphicsState];
        [shadow set];
        [[NSColor whiteColor] setFill];
        [halfStarPath fill];
        [NSGraphicsContext restoreGraphicsState];
    }];    
}

@end
