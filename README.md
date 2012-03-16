###OSX/KGAppExperation.h

```
- (void)applicationWillFinishLaunching:(NSNotification *)notification{
```
Days left = compile day - current day <= expiration

The time zone should be set to the time zone the code was compiled in

```
+ (NSUInteger)daysLeftUntilExpiration:(NSUInteger)days withCompileTimeZone:(NSTimeZone *)timeZone;
```
###OSX/KGGrowl.h

```
- (id)initWithNotification:(NSString *)newNotification;
```
```
- (void)displayMessage:(NSString *)message withTitle:(NSString *)title;
```
###OSX/KGLogin.h

```
+ (NSURL *)appURL;
```
```
+ (BOOL)willStartAtLogin;
```
```
+ (BOOL)willStartAtLogin:(NSURL *)itemURL;
```
```
+ (void)setStartAtLogin:(BOOL)enabled;
```
```
+ (void)setStartAtLogin:(NSURL *)itemURL enabled:(BOOL)enabled;
```
###OSX/KGPasteboard.h

The general use pasteboard

```
+ (NSString *)generalPasteBoardString;
```
Copy a strig to the general pasteboard

```
+ (void)copyString:(NSString *)string;
```
Copy a string to the general pasteboard and html to the general html pasteboard

```
+ (void)copyString:(NSString *)string andHTML:(NSString *)html;
```
###OSX/KGProcess.h

Transform the process into a forground application

```
+ (void)transformToForegroundApplication;
```
Set the application as the front most one

```
+ (void)setApplicationFront;
```
###OSX/KGURLHandler.h

```
+ (id)handlerWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;
```
```
- (id)initWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;
```
```
- (void)registerDefaultAction:(KGURLHandlerAction)action;
```
```
- (void)registerCommandPath:(NSString *)path withAction:(KGURLHandlerAction)action;
```
###OSX/ScriptingBridge/KGFinder.h

```
+ (FinderApplication *)finder;
```
```
+ (NSString *)activeFinderWindowURL;
```
```
+ (NSArray *)selectedFinderURLs;
```
###OSX/ScriptingBridge/KGTerminal.h

```
+ (NSString *)appId;
```
```
+ (TerminalApplication *)terminal;
```
```
+ (NSString *)escapePath:(NSString*)path;
```
```
+ (void)shellTo:(NSString *)path;
```
```
+ (void)shellTo:(NSString *)path clear:(BOOL)clear additionalCommand:(NSString *)additionalCommand;
```
```
+ (void)runCommand:(NSString *)command;
```
###Shared/KGImageCache.h

```
- (id)initWithCapacity:(NSUInteger)capacity;
```
```
- (void)retainKey:(id)key;
```
```
- (BOOL)didLoad:(id)key;
```
```
- (void)setDidLoad:(id)key;
```
```
- (KGImageCacheImage *)imageForKey:(id)key;
```
```
- (void)setImage:(KGImageCacheImage *)image forKey:(id)key;
```
```
- (void)releaseKey:(id)key;
```
```
- (void)removeKey:(id)key;
```
###Shared/KGKeychain.h

```
+ (BOOL)passwordExistsForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```
```
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName andAccount:(NSString *)accountName;
```
```
+ (NSString *)passwordForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```
```
+ (BOOL)removeEntryForService:(NSString *)serviceName andAccount:(NSString *)accountName;
```
###Shared/NSArray+KG.h

Return the first object in the array

```
- (id)firstObject;
```
Return the first `n` objects in the array

```
- (NSArray *)firstObjects:(NSUInteger)count;
```
Return the last `n` objects in the array

```
- (NSArray *)lastObjects:(NSUInteger)count;
```
###Shared/NSDictionary+KGJSON.h

```
- (NSUInteger)uintSafelyFromKey:(id)key;
```
```
- (NSString *)stringSafelyFromKey:(id)key;
```
```
- (NSURL *)URLSafelyFromKey:(id)key;
```
```
- (id)objectSafelyFromKey:(id)key;
```
###Shared/NSMutableAttributedString+KG.h

```
- (NSRange)replaceString:(NSString *)src withString:(NSString *)dst;
```
```
- (void)replaceString:(NSString *)src withString:(NSString *)dst andAttributes:(NSDictionary *)attributes;
```
```
- (void)replaceString:(NSString *)src withString:(NSString *)dst andLink:(NSURL *)url withTooltip:(NSString *)tooltip;
```
```
- (void)addTextShadow:(NSShadow *)shadow;
```
###Shared/NSString+KGFile.h

Return a valid filename

```
- (NSString *)validFilename;
```
Return a valid filename, if `allowHidden` is `YES` then periods will be allows as the first character

```
- (NSString *)validFilenameAllowHidden:(BOOL)allowHidden;
```
Transform a path into it's true mount path, or return nil

Example: `/Volumes/slave1` -> `afp://Slave%20One/slave1`

```
- (NSString *)volumeMountURLWithError:(NSError **)error;
```
###Shared/NSString+KGHTTP.h

Encode a dictionary into a url string.

Example: `{name:'David Keegan', age:26}` -> `name=David%20Keegan&age=26`

```
+ (NSString *)urlEncodedStringForArgs:(NSDictionary *)args;
```
URL encode a string, this encodes more characters than `[NSString stringByAddingPercentEscapesUsingEncoding:]`

```
- (NSString *)stringWithURLEncoding;
```
