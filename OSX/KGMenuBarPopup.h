//
//  ISStatusMenu.h
//  InScopeApps Status Menu
//
//  Created by David Keegan on 11/7/10.
//  Copyright 2010-2012 David Keegan. All rights reserved.
//
//  Made possible by:
//    http://mattgemmell.com/2008/03/04/using-maattachedwindow-with-an-nsstatusitem
//    http://blog.shpakovski.com/2011/07/cocoa-popup-window-in-status-bar.html
//

#import <Cocoa/Cocoa.h>

@interface KGMenuBarPopup : NSObject <NSWindowDelegate>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *alternateImage;
@property (nonatomic) CGFloat width;

- (id)initWithWidth:(CGFloat)width view:(NSView *)view;
- (id)initWithWidth:(CGFloat)width view:(NSView *)view offset:(CGFloat)offset;

- (void)hideView;
- (void)centerView;

@end
