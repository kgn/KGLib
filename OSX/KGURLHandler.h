//
//  KGURLHandler.h
//  KGLib
//
//  Created by David Keegan on 1/4/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//
//  NOTE: This KGURLHandler.m cannot work under arc and must be compiled with the -fno-objc-arc flag
//

//  Example:
//    KGURLHandler *urlHandler = [KGURLHandler handlerWithScheme:@"exampleapp" 
//                                                 andIdentifier:[[NSBundle mainBundle] bundleIdentifier]];
//    [urlHandler registerDefaultAction:^(NSString *comandPath, NSDictionary *arguments){
//        NSLog(@"%@ %@", comandPath, arguments);
//    }];
//    [urlHandler registerCommandPath:@"success" withAction:^(NSString *comandPath, NSDictionary *arguments){
//        NSLog(@"%@", arguments);
//    }];

#import <Foundation/Foundation.h>

@interface KGURLHandler : NSObject

+ (id)handlerWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;
- (id)initWithScheme:(NSString *)scheme andIdentifier:(NSString *)identifier;

typedef void (^KGURLHandlerAction)(NSString *comandPath, NSDictionary *arguments);
- (void)registerDefaultAction:(KGURLHandlerAction)action;
- (void)registerCommandPath:(NSString *)path withAction:(KGURLHandlerAction)action;

@end
