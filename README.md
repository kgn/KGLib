##OSX/KGAppExperation.h

###@interface KGAppExperation : NSObject

Here's an example of how to block and quit an application that has expired:
``` obj-c
- (void)applicationWillFinishLaunching:(NSNotification *)notification{
    NSInteger daysLeft = [KGAppExperation daysLeftUntilExpiration:14 withCompileTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
    NSLog(@"days left: %lu", daysLeft);

    if(daysLeft == 0){
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

        NSLog(@"%@ %@ has expired", appName, appVersion);
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:[NSString stringWithFormat:@"%@ has expired", appName]];
        [alert setInformativeText:[NSString stringWithFormat:@"The beta period for version %@ has expired.", appVersion]];
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert runModal];

        [NSApp terminate:self];
    }
}
```

Days left = compile day - current day <= expiration

The time zone should be set to the time zone the code was compiled in

```obj-c
+ (NSUInteger)daysLeftUntilExpiration:(NSUInteger)days withCompileTimeZone:(NSTimeZone *)timeZone;
```

##OSX/KGDivider.h

###@interface KGDivider : NSSplitView

###@interface KGDividerDelegate : NSObject <NSSplitViewDelegate>

##OSX/KGGrowl.h

###@interface KGGrowl : NSObject <GrowlApplicationBridgeDelegate>

```obj-c
@property (strong, readonly) NSString *notification;
```

```obj-c
- (id)initWithNotification:(NSString *)newNotification;
```

```obj-c
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;
```

##OSX/KGLogin.h

###@interface KGLogin : NSObject

```obj-c
+ (NSURL *)appURL;
```

```obj-c
+ (BOOL)willStartAtLogin;
```

```obj-c
+ (BOOL)willStartAtLogin:(NSURL *)itemURL;
```

```obj-c
+ (void)setStartAtLogin:(BOOL)enabled;
```

```obj-c
+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;
```

##OSX/KGMenuBarPopup.h

###@interface KGMenuBarPopup : NSObject <NSWindowDelegate>

```obj-c
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *alternateImage;
@property (nonatomic) CGFloat width;
```

```obj-c
- (id)initWithWidth:(CGFloat)width view:(NSView *)view;
```

```obj-c
- (id)initWithWidth:(CGFloat)width view:(NSView *)view offset:(CGFloat)offset;
```

```obj-c
- (void)hideView;
```

```obj-c
- (void)centerView;
```

##OSX/KGPasteboard.h

###@interface KGPasteboard : NSObject

The general use pasteboard

```obj-c
+ (NSString *)generalPasteBoardString;
```

Copy a strig to the general pasteboard

```obj-c
+ (void)copyString:(NSString *)string;
```

Copy a string to the general pasteboard and html to the general html pasteboard

```obj-c
+ (void)copyString:(NSString *)string andHTML:(NSString *)html;
```

##OSX/KGPopUpButtonImageCell.h

###@interface KGPopUpButtonImageCell : NSPopUpButtonCell

##OSX/KGProcess.h

###@interface KGProcess : NSObject

Transform the process into a forground application

```obj-c
+ (void)transformToForegroundApplication;
```

Set the application as the front most one

```obj-c
+ (void)setApplicationFront;
```

##OSX/KGRatingView.h

###@interface KGRatingView : NSView

```obj-c
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic) BOOL allowHalfRating;
@property (nonatomic) NSUInteger rating;
@property (nonatomic) NSTimeInterval hoverDelay;
```

```obj-c
- (void)setRatingChangedCallback:(KGRatingViewCallback)block;
```

##OSX/KGURLHandler.h

###@interface KGURLHandler : NSObject

```obj-c
+ (id)handlerWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;
```

```obj-c
- (id)initWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;
```

```obj-c
- (void)registerDefaultAction:(KGURLHandlerAction)action;
```

```obj-c
- (void)registerCommandPath:(NSString *)path withAction:(KGURLHandlerAction)action;
```

##OSX/ScriptingBridge/KGFinder.h

###@interface KGFinder : NSObject {}

```obj-c
+ (FinderApplication *)finder;
```

```obj-c
+ (NSString *)activeFinderWindowURL;
```

```obj-c
+ (NSArray *)selectedFinderURLs;
```

##OSX/ScriptingBridge/KGTerminal.h

###@interface KGTerminal : NSObject

```obj-c
+ (NSString *)appId;
```

```obj-c
+ (TerminalApplication *)terminal;
```

```obj-c
+ (NSString *)escapePath:(NSString*)path;
```

```obj-c
+ (void)shellTo:(NSString *)path;
```

```obj-c
+ (void)shellTo:(NSString *)path clear:(BOOL)clear additionalCommand:(NSString *)additionalCommand;
```

```obj-c
+ (void)runCommand:(NSString *)command;
```

##Shared/KGFoundation.h

##Shared/KGImageCache.h

###@interface KGImageCache : NSObject

```obj-c
- (id)initWithCapacity:(NSUInteger)capacity;
```

```obj-c
- (void)retainKey:(id)key;
```

```obj-c
- (BOOL)didLoad:(id)key;
```

```obj-c
- (void)setDidLoad:(id)key;
```

```obj-c
- (KGImageCacheImage *)imageForKey:(id)key;
```

```obj-c
- (void)setImage:(KGImageCacheImage *)image forKey:(id)key;
```

```obj-c
- (void)releaseKey:(id)key;
```

```obj-c
- (void)removeKey:(id)key;
```

##Shared/KGKeychain.h

###@interface KGKeychain : NSObject

```obj-c
+ (BOOL)passwordExistsForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```

```obj-c
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName andAccount:(NSString *)accountName;
```

```obj-c
+ (NSString *)passwordForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```

```obj-c
+ (BOOL)removeEntryForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```

##Shared/KGXPath.h

##Shared/NSArray+KG.h

###@interface NSArray(KG)

Return the first object in the array

```obj-c
- (id)firstObject;
```

Return the first `n` objects in the array

```obj-c
- (NSArray *)firstObjects:(NSUInteger)count;
```

Return the last `n` objects in the array

```obj-c
- (NSArray *)lastObjects:(NSUInteger)count;
```

##Shared/NSDictionary+KGJSON.h

###@interface NSDictionary(KGJSON)

```obj-c
- (NSUInteger)uintSafelyFromKey:(id)key;
```

```obj-c
- (NSString *)stringSafelyFromKey:(id)key;
```

```obj-c
- (NSURL *)URLSafelyFromKey:(id)key;
```

```obj-c
- (id)objectSafelyFromKey:(id)key;
```

##Shared/NSMutableAttributedString+KG.h

###@interface NSMutableAttributedString(KG)

```obj-c
- (NSRange)replaceString:(NSString *)src withString:(NSString *)dst;
```

```obj-c
- (void)replaceString:(NSString *)src withString:(NSString *)dst andAttributes:(NSDictionary *)attributes;
```

```obj-c
- (void)replaceString:(NSString *)src withString:(NSString *)dst andLink:(NSURL *)url withTooltip:(NSString *)tooltip;
```

```obj-c
- (void)addTextShadow:(NSShadow *)shadow;
```

##Shared/NSString+KGFile.h

###@interface NSString(KGFile)

Return a valid filename

```obj-c
- (NSString *)validFilename;
```

Return a valid filename, if `allowHidden` is `YES` then periods will be allows as the first character

```obj-c
- (NSString *)validFilenameAllowHidden:(BOOL)allowHidden;
```

Transform a path into it's true mount path, or return nil

Example: `/Volumes/slave1` -> `afp://Slave%20One/slave1`

```obj-c
- (NSString *)volumeMountURLWithError:(NSError **)error;
```

##Shared/NSString+KGHTTP.h

###@interface NSString(KGHTTP)

Encode a dictionary into a url string.

Example: `{name:'David Keegan', age:26}` -> `name=David%20Keegan&age=26`

```obj-c
+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;
```

URL encode a string, this encodes more characters than `[NSString stringByAddingPercentEscapesUsingEncoding:]`

```obj-c
- (NSString *)stringWithURLEncoding;
```

