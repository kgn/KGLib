##OSX/KGAppExperation.h

```obj-c
- (void)applicationWillFinishLaunching:(NSNotification *)notification{
```

Days left = compile day - current day <= expiration

The time zone should be set to the time zone the code was compiled in

```obj-c
+ (NSUInteger)daysLeftUntilExpiration:(NSUInteger)days withCompileTimeZone:(NSTimeZone *)timeZone;
```

##OSX/KGGrowl.h

```obj-c
- (id)initWithNotification:(NSString *)newNotification;
```

```obj-c
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;
```

##OSX/KGLogin.h

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

##OSX/KGProcess.h

Transform the process into a forground application

```obj-c
+ (void)transformToForegroundApplication;
```

Set the application as the front most one

```obj-c
+ (void)setApplicationFront;
```

##OSX/KGRatingView.h

```obj-c
- (void)setRatingChangedCallback:(KGRatingViewCallback)block;
```

##OSX/KGURLHandler.h

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

##Shared/KGImageCache.h

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

##Shared/NSArray+KG.h

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

Encode a dictionary into a url string.

Example: `{name:'David Keegan', age:26}` -> `name=David%20Keegan&age=26`

```obj-c
+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;
```

URL encode a string, this encodes more characters than `[NSString stringByAddingPercentEscapesUsingEncoding:]`

```obj-c
- (NSString *)stringWithURLEncoding;
```

