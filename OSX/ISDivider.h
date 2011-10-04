//
//  ISDivider.h
//  InScopeLib
//
//  Created by David Keegan on 8/5/09.
//

#import <Foundation/Foundation.h>

// Sets the line color to darkGrayColor.
@interface ISDivider : NSSplitView
@end

// Sets the minimum and maximum size of the left panel, defaults to 36-300px
@interface ISDividerDelegate : NSObject <NSSplitViewDelegate>
@end
