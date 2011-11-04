//
//  ISNibCellTableView.m
//  InScopeLib
//
//  Created by David Keegan on 10/14/11.
//

#import "ISNibCellTableView.h"

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
- (void)showInView:(NSView *)parent withFrame:(NSRect)cellFrame highlight:(BOOL)highlight{
    [self.detailView setFrame:cellFrame];
    if([self.detailView superview] != parent){
        [parent addSubview:self.detailView];
    }
}
@end


@implementation ISNibCell
@synthesize controller = _controller;
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView{
    [self.controller showInView:controlView withFrame:cellFrame highlight:self.isHighlighted];
}
@end


@implementation ISNibCellTableView
@synthesize cellControllers = _cellControllers;
- (void)awakeFromNib{
	ISNibCell* cell = [[ISNibCell alloc] init];
    [self setIntercellSpacing:NSZeroSize];    
    NSTableColumn *firstColumn = [[self tableColumns] objectAtIndex:0];
    // This doesn't seem to work under Snow Leopard,
    // Make sure the set the correct column width in IB
//    [firstColumn setWidth:self.bounds.size.width];
	[firstColumn setDataCell:cell];
}
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
