//
//  ISDivider.m
//  InScopeLib
//
//  Created by David Keegan on 8/5/09.
//  Copyright 2009 InScopeApps{+}. All rights reserved.
//

#import "ISDivider.h"

@implementation ISDivider

- (NSColor *)dividerColor{
    return [NSColor darkGrayColor];
}

@end

@implementation ISDividerDelegate

//Made posible by http://www.cocoadev.com/index.pl?SplitViewBasics

- (CGFloat)splitView:(NSSplitView *)sender constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)offset{
    return 36.0f;
}

- (CGFloat)splitView:(NSSplitView *)sender constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)offset{
    return 300.0f;
}

- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize{
    // how to resize a horizontal split view so that the left frame stays a constant size
    NSView *left = [[sender subviews] objectAtIndex:0];         // get the two sub views
    NSView *right = [[sender subviews] objectAtIndex:1];
    float dividerThickness = [sender dividerThickness];         // and the divider thickness
    NSRect newFrame = [sender frame];                           // get the new size of the whole splitView
    NSRect leftFrame = [left frame];                            // current size of the left subview
    NSRect rightFrame = [right frame];                          // ...and the right
    leftFrame.size.height = newFrame.size.height;               // resize the height of the left
    leftFrame.origin = NSMakePoint(0,0);                        // don't think this is needed
    // the rest of the width...
    rightFrame.size.width = newFrame.size.width - leftFrame.size.width - dividerThickness;
    rightFrame.size.height = newFrame.size.height;              // the whole height
    rightFrame.origin.x = leftFrame.size.width + dividerThickness;
    [left setFrame:leftFrame];
    [right setFrame:rightFrame];
}

@end
