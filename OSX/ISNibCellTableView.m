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


@implementation ISNibCell{
    BOOL _shouldClearSubviews;
}

@synthesize controller = _controller;

-(void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    [self.controller showViews:controlView frame:cellFrame highlight:self.isHighlighted];
}

@end


@implementation ISNibCellTableView
@synthesize cellControllers = _cellControllers;
- (void)reloadData{
    //TODO: this is working to hide the duplicate cells, but it isn't cleaning them up
    @autoreleasepool{
        for(NSView *subview in [self subviews]){
            [subview setHidden:YES];
//            [subview removeFromSuperviewWithoutNeedingDisplay];            
        }
    }
    [super reloadData];
}
@end
