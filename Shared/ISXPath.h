//
//  ISXPath.h
//  InScopeLib
//
//  Created by David Keegan on 9/30/11.
//
//  Read this post for instuction on adding libxml2 to your project
//  http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>

xmlDocPtr htmlDocFromData(NSData *data);

xmlXPathObjectPtr xpath(xmlNodePtr node, const char *query);
xmlNodePtr nodeAtXPath(xmlNodePtr node, const char *query);

NSString *attrValue(xmlNodePtr node, const char *name);
NSString *innerHtml(xmlNodePtr node);

NSString *xmlCharToNSString(xmlChar *value);
