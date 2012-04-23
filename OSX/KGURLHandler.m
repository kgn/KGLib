//
//  KGURLHandler.m
//  KGLib
//
//  Created by David Keegan on 1/4/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "KGURLHandler.h"

@interface KGURLHandler()
- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent;
@end

@implementation KGURLHandler{
    NSString *_scheme;
    NSString *_identifier;   
    NSMutableDictionary *_actions;
    KGURLHandlerAction _defaultAction;
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent{
    NSURL *url= [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
    NSString *commandPath = [url host];
    NSMutableDictionary *urlArgs = [NSMutableDictionary dictionary];
    for(NSString *arg in [[url query] componentsSeparatedByString:@"&"]){
        NSArray *keyValue = [arg componentsSeparatedByString:@"="];
        [urlArgs setObject:[keyValue objectAtIndex:1] forKey:[keyValue objectAtIndex:0]];
    }
    NSDictionary *arguments = [NSDictionary dictionaryWithDictionary:urlArgs];
    KGURLHandlerAction action = [_actions objectForKey:commandPath];
    if(action){
        action(commandPath, arguments);
    }else if(_defaultAction){
        _defaultAction(commandPath, arguments);
    }
}

- (void)registerDefaultAction:(KGURLHandlerAction)action{
#if !__has_feature(objc_arc)    
    [_defaultAction release];
#endif
    _defaultAction = [action copy];
}

- (void)registerCommandPath:(NSString *)path withAction:(KGURLHandlerAction)action{
    [_actions setObject:action forKey:path];
}

+ (id)handlerWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier{
#if !__has_feature(objc_arc)    
    return [[[[self class] alloc] initWithScheme:scheme andIdentifier:identifier] autorelease];
#else
    return [[[self class] alloc] initWithScheme:scheme andIdentifier:identifier];
#endif
}

- (id)initWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier{
    if((self = [super init])){
        _scheme = [[NSString alloc] initWithString:scheme];
        _identifier = [[NSString alloc] initWithString:identifier];
        _actions = [[NSMutableDictionary alloc] init];
        
        // register scheme with callback
        [[NSAppleEventManager sharedAppleEventManager] 
         setEventHandler:self 
         andSelector:@selector(getUrl:withReplyEvent:) 
         forEventClass:kInternetEventClass 
         andEventID:kAEGetURL];
#if !__has_feature(objc_arc)          
        LSSetDefaultHandlerForURLScheme((CFStringRef)_scheme, (CFStringRef)_identifier);
#else        
        LSSetDefaultHandlerForURLScheme((__bridge CFStringRef)_scheme, (__bridge CFStringRef)_identifier);        
#endif        
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Scheme='%@' Identifier=%@>", 
            [self class], _scheme, _identifier];
}

#if !__has_feature(objc_arc)
- (void)dealloc{
    [_scheme release];
    [_identifier release];
    [_defaultAction release];
    [_actions release];
    [super dealloc];
}
#endif

@end
