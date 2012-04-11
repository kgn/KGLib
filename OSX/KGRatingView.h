//
//  KGRatingView.h
//  KGLib
//
//  Created by David Keegan on 11/8/10.
//  Copyright 2010-2012 David Keegan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KGRatingView : NSView

@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic) BOOL allowHalfRating;
@property (nonatomic) NSUInteger rating;
@property (nonatomic) NSTimeInterval hoverDelay;

typedef void (^KGRatingViewCallback)(NSUInteger rating);
- (void)setRatingChangedCallback:(KGRatingViewCallback)block;

@end
