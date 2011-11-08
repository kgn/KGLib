//
//  ISXPath.h
//  InScopeLib
//
//  Created by David Keegan on 9/30/11.
//

#import "ISXPath.h"

xmlDocPtr htmlDocFromData(NSData *data){
    return htmlReadMemory([data bytes], (int)[data length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);
}

NSString *xmlCharToNSString(xmlChar *value){
    if(value == NULL){
        return nil;
    }
    NSString *string =
    [NSString stringWithCString:(const char *)value
                       encoding:NSUTF8StringEncoding];
    xmlFree(value);
    return string;
}

NSString *attrValue(xmlNodePtr node, const char *name){
    if(node == NULL || name == NULL){
        return nil;
    }
    if(xmlHasProp(node, (xmlChar *)name)){
        return xmlCharToNSString(xmlGetProp(node, (xmlChar *)name));
    }
    return nil;
}

NSString *innerHtml(xmlNodePtr node){
    if(node == NULL){
        return nil;
    }
    //FIXME: xmlNodeGetContent does not preserve the node structure
    NSString *innerHtml = xmlCharToNSString(xmlNodeGetContent(node));
    return [innerHtml stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

xmlXPathObjectPtr xpath(xmlNodePtr node, const char *query){
	if(node == NULL || query == NULL){
		return NULL;
    }

	xmlXPathContextPtr xpContext = xmlXPathNewContext((xmlDocPtr)node);
	if(xpContext == NULL){
		return NULL;
    }

	xmlXPathObjectPtr xpResult = xmlXPathEvalExpression((xmlChar *)query, xpContext);
	xmlXPathFreeContext(xpContext);
	return xpResult;
}

xmlNodePtr nodeAtXPath(xmlNodePtr node, const char *query){
    xmlXPathObjectPtr xpathObj = xpath(node, query);
    if(xpathObj == NULL){
        return NULL;
    }

    xmlNodePtr result = NULL;
    xmlNodeSetPtr nodes = xpathObj->nodesetval;
    if (nodes && nodes->nodeTab){
        result = nodes->nodeTab[0];
    }
    xmlXPathFreeObject(xpathObj);
    return result;
}
