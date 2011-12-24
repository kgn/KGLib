//
//  KGKeychain.h
//  KGLib
//
//  Created by David Keegan on 10/2/11.
//

#import "KGKeychain.h"
#import <Security/Security.h>

@implementation KGKeychain

static SecKeychainItemRef getKeychainItemRef(const char *serviceName, const char *accountName){
    SecKeychainItemRef item;
    OSStatus status =
    SecKeychainFindGenericPassword(NULL,
                                   (int)strlen(serviceName), serviceName,
                                   (int)strlen(accountName), accountName,
                                   NULL, NULL, &item);
    if(status != noErr){
        return NULL;
    }
    return item;
}

+ (BOOL)passwordExistsForService:(NSString *)serviceName andAccount:(NSString *)accountName{
    if(serviceName == nil || accountName == nil){
        return NO;
    }

    SecKeychainItemRef item = getKeychainItemRef([serviceName UTF8String], [accountName UTF8String]);
    if(item == NULL){
        return NO;
    }
    CFRelease(item);
    return YES;
}

+ (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName andAccount:(NSString *)accountName{
    if(password == nil || serviceName == nil || accountName == nil){
        return NO;
    }

    const char *cServiceName = [serviceName UTF8String];
    const char *cAccountName = [accountName UTF8String];
    const char *cPassword = [password UTF8String];

    OSStatus status = noErr;
    SecKeychainItemRef item = getKeychainItemRef(cServiceName, cAccountName);
    if(item != NULL){
		status =
        SecKeychainItemModifyAttributesAndData(item, NULL, (int)strlen(cPassword), cPassword);
        CFRelease(item);
    }else{
        status =
        SecKeychainAddGenericPassword(NULL,
                                      (int)strlen(cServiceName), cServiceName,
                                      (int)strlen(cAccountName), cAccountName,
                                      (int)strlen(cPassword), cPassword,
                                      NULL);
    }
    return (status == noErr);
}

+ (NSString *)passwordForService:(NSString *)serviceName andAccount:(NSString *)accountName{
    if(serviceName == nil || accountName == nil){
        return nil;
    }

    SecKeychainItemRef item = getKeychainItemRef([serviceName UTF8String], [accountName UTF8String]);
    if(item == NULL){
        return nil;
    }

    // From 'Advanced Mac OS X Programming'
    UInt32 length = 0;
    char *password = NULL;
    SecKeychainAttribute attributes[8];
    SecKeychainAttributeList list;

    attributes[0].tag = kSecAccountItemAttr;
    attributes[1].tag = kSecDescriptionItemAttr;
    attributes[2].tag = kSecLabelItemAttr;
    attributes[3].tag = kSecModDateItemAttr;

    list.count = 4;
    list.attr = attributes;

    OSStatus status = SecKeychainItemCopyContent(item, NULL, &list, &length, (void **)&password);
    CFRelease(item);

    if(status != noErr){
        return nil;
    }

    NSString *passwordString = nil;
	if(password != NULL){
		char *passwordBuffer = malloc(length+1);
		strncpy(passwordBuffer, password, length);
		passwordBuffer[length] = '\0';
		passwordString = [NSString stringWithCString:passwordBuffer encoding:NSUTF8StringEncoding];
        free(passwordBuffer);
	}

	SecKeychainItemFreeContent(&list, password);
    return passwordString;
}

+ (BOOL)removeEntryForService:(NSString *)serviceName andAccount:(NSString *)accountName{
    if(serviceName == nil || accountName == nil){
        return YES;
    }

    SecKeychainItemRef item = getKeychainItemRef([serviceName UTF8String], [accountName UTF8String]);
    if(item == NULL){
        return YES;
    }

    OSStatus status = SecKeychainItemDelete(item);
    CFRelease(item);
    return (status == noErr);
}

@end
