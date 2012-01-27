//
//  KGURLHandler.m
//  KGLib
//
//  Created by David Keegan on 1/4/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//
//  NOTE: This file cannot work under arc and must be compiled with the -fno-objc-arc flag
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
    }else{
        NSLog(@"No action defined for command path: %@", commandPath);
    }
}

- (void)registerDefaultAction:(KGURLHandlerAction)action{
    Block_release(_defaultAction);
    _defaultAction = Block_copy(action);
}

- (void)registerCommandPath:(NSString *)path withAction:(KGURLHandlerAction)action{
    KGURLHandlerAction oldAction = [_actions objectForKey:path];
    Block_release(oldAction);
    
    [_actions setObject:Block_copy(action) forKey:path];
}

+ (id)handlerWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier{
    return [[[[self class] alloc] initWithScheme:scheme andIdentifier:identifier] autorelease];
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
        LSSetDefaultHandlerForURLScheme((CFStringRef)_scheme, (CFStringRef)_identifier);
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@ %lu Scheme='%@' Identifier=%@>", 
            [self class], _scheme, _identifier];
}

- (void)dealloc{
    [_scheme release];
    [_identifier release];
    Block_release(_defaultAction);
    for(KGURLHandlerAction action in [_actions allValues]){
        Block_release(action);
    }
    [_actions release];
    [super dealloc];
}

@end
