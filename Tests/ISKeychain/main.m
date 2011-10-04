//
//  main.m
//  ISKeychain
//
//  Created by David Keegan on 10/3/11.
//

#import <Foundation/Foundation.h>
#import "ISKeychain.h"

int main (int argc, const char * argv[]){
    @autoreleasepool{
        BOOL status = [ISKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        status = [ISKeychain setPassword:@"password"
                               forService:@"keychain_test"
                               andAccount:@"incopeapps"];
        assert((status == YES));
        NSString *password = [ISKeychain passwordForService:@"keychain_test" andAccount:@"incopeapps"];
        assert([password isEqualToString:@"password"]);
        
        status = [ISKeychain setPassword:@"password_change"
                               forService:@"keychain_test"
                               andAccount:@"incopeapps"];
        assert((status == YES));
        password = [ISKeychain passwordForService:@"keychain_test" andAccount:@"incopeapps"];
        assert([password isEqualToString:@"password_change"]);
        
        status = [ISKeychain passwordExistsForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        
        status = [ISKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        status = [ISKeychain removeEntryForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == YES));
        
        status = [ISKeychain passwordExistsForService:@"keychain_test" andAccount:@"incopeapps"];
        assert((status == NO));
        
        NSLog(@"All tests passed!");
    }
    return 0;
}
