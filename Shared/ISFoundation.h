//
//  ISFoundation.h
//  InScopeLib
//
//  Created by David Keegan on 11/26/11.
//

#import <Foundation/Foundation.h>

NS_INLINE CGFloat ISMidWidth(NSRect aRect) {
    return (aRect.size.width * (CGFloat)0.5);
}

NS_INLINE CGFloat ISMidHeight(NSRect aRect) {
    return (aRect.size.height * (CGFloat)0.5);
}
