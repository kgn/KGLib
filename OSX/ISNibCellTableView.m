//
//  ISNibCellTableView.m
//  InScopeLib
//
//  Created by David Keegan on 10/14/11.
//

#import "ISNibCellTableView.h"

@interface ISNibCellController()
- (void)showViews:(NSView*)parent frame:(NSRect)cellFrame highlight:(BOOL)highlight;
@end


@implementation ISNibCellController

@synthesize detailView = _detailView;

- (id)initWithNibName:(NSString *)nibName{
	if((self = [super init])){
        if(![NSBundle loadNibNamed:nibName owner:self]){
            self = nil;
        }
    }
    return self;
}

-(void)showViews:(NSView*)parent frame:(NSRect)cellFrame highlight:(BOOL)highlight{
    [self.detailView setFrame:cellFrame];
    if([self.detailView superview] != parent){
		[parent addSubview:self.detailView];
    }
}

@end


@implementation ISNibCell

@synthesize controller = _controller;

-(void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    [self.controller showViews:controlView frame:cellFrame highlight:self.isHighlighted];
}

@end


@implementation ISNibCellTableView
@synthesize cellControllers = _cellControllers;
- (NSArray *)cellControllers{
    return _cellControllers;
}
- (void)setCellControllers:(NSArray *)cellControllers{
    @autoreleasepool{
        while([[self subviews] count] > 0){
            [[[self subviews] lastObject] removeFromSuperview];
        }
    }
    _cellControllers = cellControllers;
}
@end
