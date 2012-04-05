//
//  KGPopUpButtonImageCell.m
//  KGLib
//
//  Created by David Keegan on 1/17/11.
//  Copyright 2011 David Keegan. All rights reserved.
//

#import "KGPopUpButtonImageCell.h"
#import "KGFoundation.h"

@implementation KGPopUpButtonImageCell

- (void)drawImageWithFrame:(NSRect)cellRect inView:(NSView *)controlView{
    NSImage *image = self.image;
    if([self isHighlighted] && self.alternateImage){
        image = self.alternateImage;
    }
    
    //TODO: respect -(NSCellImagePosition)imagePosition
    NSRect imageRect = NSZeroRect;
    imageRect.origin.y = round(KGMidHeight(cellRect)-image.size.height*0.5f);
    imageRect.origin.x = round(KGMidWidth(cellRect)-image.size.width*0.5f);
    imageRect.size = image.size;
    
    [image drawInRect:imageRect
             fromRect:NSZeroRect
            operation:NSCompositeSourceOver 
             fraction:1.0f 
       respectFlipped:YES 
                hints:nil];
}

@end
