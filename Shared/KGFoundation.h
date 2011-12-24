//
//  KGFoundation.h
//  KGLib
//
//  Created by David Keegan on 11/26/11.
//

#import <Foundation/Foundation.h>

NS_INLINE CGFloat KGMidWidth(NSRect aRect) {
    return (aRect.size.width * (CGFloat)0.5);
}

NS_INLINE CGFloat KGMidHeight(NSRect aRect) {
    return (aRect.size.height * (CGFloat)0.5);
}
