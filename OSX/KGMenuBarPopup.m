//
//  ISStatusMenu.m
//  InScopeApps Status Menu
//
//  Created by David Keegan on 11/7/10.
//  Copyright 2010-2011 David Keegan. All rights reserved.
//

#import "KGMenuBarPopup.h"
#import "KGFoundation.h"

static CGFloat const KGMenuBarPopupFadeDuration = 0.15f;

@interface KGMenuBarPopupPanel : NSPanel
@end
@implementation KGMenuBarPopupPanel
- (BOOL)canBecomeKeyWindow{
    return YES;
}
@end

@interface KGMenuBarPopupView : NSView {
    BOOL _clicked;
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSImage *image;
@property (nonatomic, retain) NSImage *alternateImage;
@property (nonatomic, strong) KGMenuBarPopupPanel *menuBarPopupPanel;
@property (nonatomic) CGFloat offset;
- (void)hideView;
- (void)centerView;
@end

@implementation KGMenuBarPopup{
    NSStatusItem *_statusItem;
    KGMenuBarPopupView *_menuBarPopupView;
    KGMenuBarPopupPanel *_menuBarPopupPanel;
}

@synthesize title = _title;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize width = _width;

- (void)hideView{
    [_menuBarPopupView hideView];
}

- (void)centerView{
    [_menuBarPopupView centerView];
    [_menuBarPopupView setNeedsDisplay:YES];
}

- (void)windowDidResignKey:(NSNotification *)notification{
    if ([_menuBarPopupPanel isVisible]){    
        [_menuBarPopupView hideView];
    }
}

- (void)removeStatusItem:(NSNotification *)aNotification{
    [[NSStatusBar systemStatusBar] removeStatusItem:_statusItem];
}

- (id)initWithWidth:(CGFloat)width view:(NSView *)view{
    return [self initWithWidth:width view:view offset:0.0f];
}

- (id)initWithWidth:(CGFloat)width view:(NSView *)view offset:(CGFloat)offset{
    if((self = [super init])){
        _width = width;
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:self.width];
        
        //setup custom status menu view
        CGFloat height = [[NSStatusBar systemStatusBar] thickness];
        NSRect viewFrame = NSMakeRect(0.0f, 0.0f, self.width, height);
        _menuBarPopupView = [[KGMenuBarPopupView alloc] initWithFrame:viewFrame];
        _menuBarPopupView.offset = offset;
        _statusItem.view = _menuBarPopupView;
        
        //setup the window to show when clicked
        NSRect contentRect = NSZeroRect;
        contentRect.size = view.bounds.size;
        _menuBarPopupPanel = [[KGMenuBarPopupPanel alloc] initWithContentRect:contentRect
                                                                 styleMask:NSNonactivatingPanelMask
                                                                   backing:NSBackingStoreBuffered 
                                                                     defer:NO];
        [_menuBarPopupPanel setLevel:NSPopUpMenuWindowLevel];
        [_menuBarPopupPanel setBackgroundColor:[NSColor clearColor]];
        [_menuBarPopupPanel setMovableByWindowBackground:NO];
        [_menuBarPopupPanel setExcludedFromWindowsMenu:YES];
        [_menuBarPopupPanel setOpaque:NO];
        [_menuBarPopupPanel setHasShadow:NO];
        [_menuBarPopupPanel useOptimizedDrawing:YES];
        [_menuBarPopupPanel setAcceptsMouseMovedEvents:YES];
        [[_menuBarPopupPanel contentView] addSubview:view];
        [_menuBarPopupPanel setDelegate:self];
        
        _menuBarPopupView.menuBarPopupPanel = _menuBarPopupPanel;
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(removeStatusItem:) 
                                                     name:NSApplicationWillTerminateNotification 
                                                   object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setWidth:(CGFloat)width{
    if(self.width != width){
        _width = width;
        [_statusItem setLength:self.width];
    }
}

- (void)setTitle:(NSString *)title{
    if(self.title != title){
        _title = title;
        _menuBarPopupView.title = self.title;
        [_menuBarPopupView setNeedsDisplay:YES];
    }
}

- (void)setImage:(NSImage *)image{
    if(self.image != image){
        _image = image;
        _menuBarPopupView.image = self.image;
        [_menuBarPopupView setNeedsDisplay:YES];
    }
}

- (void)setAlternateImage:(NSImage *)alternateImage{
    if(self.alternateImage != alternateImage){
        _alternateImage = alternateImage;
        _menuBarPopupView.alternateImage = self.alternateImage;
        [_menuBarPopupView setNeedsDisplay:YES];
    }
}

@end

@implementation KGMenuBarPopupView

@synthesize title = _title;
@synthesize image = _image;
@synthesize alternateImage = _alternateImage;
@synthesize menuBarPopupPanel = _menuBarPopupPanel;
@synthesize offset = _offset;

- (void)hideViewPartTwo{
    [self.menuBarPopupPanel orderOut:self];
    [self.menuBarPopupPanel setAlphaValue:1.0f];
}

- (void)hideView{
    _clicked = NO;
    [self setNeedsDisplay:YES];
    
    //slow down the animation
    NSTimeInterval fadeOutDuration = KGMenuBarPopupFadeDuration;
    NSEvent *currentEvent = [NSApp currentEvent];
    if ([currentEvent type] == NSLeftMouseDown){
        NSUInteger modifierFlags = ([currentEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
        BOOL shiftPressed = (modifierFlags == NSShiftKeyMask);
        BOOL shiftOptionPressed = (modifierFlags == (NSShiftKeyMask | NSAlternateKeyMask));
        if (shiftPressed || shiftOptionPressed){
            fadeOutDuration *= 10;
        }
    }    
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:fadeOutDuration];
    [(KGMenuBarPopupPanel *)[self.menuBarPopupPanel animator] setAlphaValue:0.0f];
    [NSAnimationContext endGrouping];
    
    [self performSelector:@selector(hideViewPartTwo) withObject:nil afterDelay:fadeOutDuration];
}

- (void)dealloc{
    self.menuBarPopupPanel = nil;
}

- (void)drawImage:(NSImage *)aImage centeredInRect:(NSRect)aRect{
    NSRect imageRect = NSMakeRect((CGFloat)round(aRect.size.width*0.5f-aImage.size.width*0.5f),
                                  (CGFloat)round(aRect.size.height*0.5f-aImage.size.height*0.5f),
                                  aImage.size.width, 
                                  aImage.size.height);
    [aImage drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0f];
}

- (void)drawRect:(NSRect)rect{
    if(_clicked){
        [[NSColor selectedMenuItemColor] set];
        NSRectFill(rect);
    }
    
    if(self.title){
        //TODO: the font doesn't look as good as the other menus
        NSColor *textColor = [NSColor controlTextColor];
        NSShadow *textShadow = [[NSShadow alloc] init];
        textShadow.shadowOffset = NSMakeSize(0.0f, -1.0f);
        textShadow.shadowColor = [NSColor colorWithCalibratedWhite:1.0f alpha:0.4f];
        if(_clicked){
            textColor = [NSColor selectedMenuItemTextColor];
            textShadow.shadowColor = nil;
        }
        NSFont *msgFont = [NSFont menuBarFontOfSize:15.0f];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
        [paraStyle setAlignment:NSCenterTextAlignment];
        [paraStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        NSMutableDictionary *msgAttrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         msgFont, NSFontAttributeName,
                                         textColor, NSForegroundColorAttributeName,
                                         paraStyle, NSParagraphStyleAttributeName,
                                         textShadow, NSShadowAttributeName,
                                         nil];
        
        NSSize msgSize = [self.title sizeWithAttributes:msgAttrs];
        NSRect msgRect = NSMakeRect(0, 0, msgSize.width, msgSize.height);
        msgRect.origin.x = (self.frame.size.width-msgSize.width)*0.5f;
        msgRect.origin.y = (self.frame.size.height-msgSize.height)*0.5f;
        
        [self.title drawInRect:msgRect withAttributes:msgAttrs];
    }else if(_clicked){
        if(self.alternateImage){
            [self drawImage:self.alternateImage centeredInRect:rect];
        }else if(self.image){
            [self drawImage:self.image centeredInRect:rect];
        }
    }else if(self.image){
        [self drawImage:self.image centeredInRect:rect];
    }
}

- (void)centerView{
    NSRect menuFrame = self.window.frame;
    NSRect windowFrame = self.menuBarPopupPanel.frame;
    NSPoint menuPoint = NSMakePoint(NSMidX(menuFrame), NSMinY(menuFrame));
    menuPoint.x -= windowFrame.size.width*0.5f;
    menuPoint.y -= windowFrame.size.height+self.offset;
    [self.menuBarPopupPanel setFrameOrigin:menuPoint];
    [self.menuBarPopupPanel makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:NO];
}

- (void)mouseDown:(NSEvent *)event{
    _clicked = !_clicked;
    
    if(_clicked){
        [self centerView];
    }else{
        [self hideView];
    }
    
    [self setNeedsDisplay:YES];
}

@end
