//
//  main.m
//  KGKeychain
//
//  Created by David Keegan on 10/3/11.
//

#import <Foundation/Foundation.h>
#import "KGKeychain.h"

int main (int argc, const char * argv[]){
    @autoreleasepool{
        BOOL status = [KGKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        status = [KGKeychain setPassword:@"password"
                               forService:@"keychain_test"
                               andAccount:@"incopeapps"];
        assert((status == YES));
        NSString *password = [KGKeychain passwordForService:@"keychain_test" andAccount:@"incopeapps"];
        assert([password isEqualToString:@"password"]);

        status = [KGKeychain setPassword:@"password_change"
                               forService:@"keychain_test"
                               andAccount:@"incopeapps"];
        assert((status == YES));
        password = [KGKeychain passwordForService:@"keychain_test" andAccount:@"incopeapps"];
        assert([password isEqualToString:@"password_change"]);

        status = [KGKeychain passwordExistsForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));

        status = [KGKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        status = [KGKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));

        status = [KGKeychain passwordExistsForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == NO));

        NSLog(@"All tests passed!");
    }
    return 0;
}
