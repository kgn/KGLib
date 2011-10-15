//
//  ISNibCellTableView.h
//  InScopeLib
//
//  Created by David Keegan on 10/14/11.
//  Made possible by: http://www.stevestreeting.com/2010/08/08/cocoa-tip-using-custom-table-outline-cells-designed-in-ib/
//

#import <AppKit/AppKit.h>

@interface ISNibCellController : NSObject
@property (strong) IBOutlet NSView *detailView;
- (id)initWithNibName:(NSString *)nibName;
@end

@interface ISNibCell : NSCell
@property (strong) ISNibCellController *controller;
@end

@interface ISNibCellTableView : NSTableView
@property (strong) NSArray *cellControllers;
@end
