//
//  KGDivider.h
//  KGLib
//
//  Created by David Keegan on 8/5/09.
//

#import <Foundation/Foundation.h>

// Sets the line color to darkGrayColor.
@interface KGDivider : NSSplitView
@end

// Sets the minimum and maximum size of the left panel, defaults to 36-300px
@interface KGDividerDelegate : NSObject <NSSplitViewDelegate>
@end
