//
//  ISAppExperation.m
//  InScopeLib
//
//  Created by David Keegan on 6/22/10.
//

#import "ISAppExperation.h"

@implementation ISAppExperation

+ (NSUInteger)daysLeftUntilExpiration:(NSUInteger)days withCompileTimeZone:(NSTimeZone *)timeZone{
    //early exit if the expiration is <= 0 days
    if(days <= 0){
        return 0;
    }

    //inspired by: http://www.red-sweater.com/blog/371/suicidal-code
    NSString* compileDateString = [NSString stringWithUTF8String:__DATE__];
    //compileDateString = @"Jun 10 2010";//TEST

    //split the compile date on spaces: Jun 22 2010
    NSArray *compileDateArray = [compileDateString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    //"If the day of the month is less than 10, it is padded with a space on the left."
    //http://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    compileDateArray = [compileDateArray filteredArrayUsingPredicate:noEmptyStrings];

    //convert the short month string into the month's number
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:NSGregorianCalendar]];
    NSArray *shortMonths = [dateFormatter shortMonthSymbols];
    NSInteger compileMonth = [shortMonths indexOfObject:[compileDateArray objectAtIndex:0]]+1;

    //convert the strings to integers
    NSInteger compileDay = [[compileDateArray objectAtIndex:1] intValue];
    NSInteger compileYear = [[compileDateArray objectAtIndex:2] intValue];

    //__DATE__ is calculated in the developer's time zone, so we ask for this
    //so we can correctly calculate the delta if the user is in a different time zone
    NSCalendarDate *compileDate = [NSCalendarDate dateWithYear:compileYear month:compileMonth day:compileDay
                                                          hour:0 minute:0 second:0
                                                      timeZone:timeZone];

    //days delta code from Jeff Lamarche's NSDate Category
    //http://iphonedevelopment.blogspot.com/2009/07/category-on-nsdate.html
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
                                                fromDate:compileDate
                                                  toDate:[NSDate date]//now
                                                 options:0];
    NSInteger daysDelta = [components day];

    //calculate how many days are left
    //add a day so it's <= days,
    NSInteger daysRemaining = days-daysDelta+1;
    return MIN(MAX(0, daysRemaining), days);
}

@end
