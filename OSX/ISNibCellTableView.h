//
//  ISNibCellTableView.h
//  InScopeLib
//
//  Created by David Keegan on 10/14/11.
//  Made possible by: http://www.stevestreeting.com/2010/08/08/cocoa-tip-using-custom-table-outline-cells-designed-in-ib/
//

#import <AppKit/AppKit.h>

@interface ISNibCellController : NSObject
@property (strong, nonatomic) IBOutlet NSView *detailView;
- (id)initWithNibName:(NSString *)nibName;
// This should only be implemented in a subclass.
// It should not be called directly, it will be
// called when the cell is highlighted
- (void)setIsHighlighted:(BOOL)highlight;
@end

@interface ISNibCell : NSCell
@property (strong) ISNibCellController *controller;
@end

@interface ISNibCellTableView : NSTableView
@property (strong) NSArray *cellControllers;
@end
