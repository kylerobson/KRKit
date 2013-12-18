//
//  NSDate+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSDate+KRAdditions.h"
#import "KRKit.h"

@implementation NSDate (KRAdditions)

+ (NSDate *)dateWithNumberSince1970:(NSNumber *)number
{
    if (number == nil) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
}

- (NSString *)timeIntervalInWordsSinceNow
{
    return [[NSDate date] timeIntervalInWordsSinceDate:self];
}

- (NSString *)timeIntervalInWordsSinceDate:(NSDate *)aDate
{
    double interval = [self timeIntervalSinceDate:aDate];
    
    NSString *timeUnit;
    int timeValue;
    
    if (interval < 0.0) {
        interval = interval * -1.0;
    }
    
    if (interval < 60.0) {
        return @"seconds";
        
    }
    else if (interval < 3600.0) { // minutes
        
        timeValue = (int)round(interval / 60.0);
        
        if (timeValue == 1) {
            timeUnit = @"minute";
            
        }
        else {
            timeUnit = @"minutes";
            
        }
        
        
    }
    else if (interval < 86400.0) {
        timeValue = (int)round(interval / 60.0 / 60.0);
        
        if (timeValue == 1) {
            timeUnit = @"hour";
            
        }
        else {
            timeUnit = @"hours";
        }
        
        
    }
    else {
        int days = (int)round(interval / 60.0 / 60.0 / 24.0);
        
        if (days < 7) {
            
            timeValue = days;
            
            if (timeValue == 1) {
                timeUnit = @"day";
            }
            else {
                timeUnit = @"days";
            }
            
        }
        else if (days < 30) {
            int weeks = days / 7;
            
            timeValue = weeks;
            
            if (timeValue == 1) {
                timeUnit = @"week";
            }
            else {
                timeUnit = @"weeks";
            }
            
            
        }
        else if (days < 365) {
            int months = days / 30;
            timeValue = months;
            
            if (timeValue == 1) {
                timeUnit = @"month";
            }
            else {
                timeUnit = @"months";
            }
            
        }
        else if (days < 30000) { // this is roughly 82 years. After that, we'll say 'forever'
            int years = days / 365;
            timeValue = years;
            
            if (timeValue == 1) {
                timeUnit = @"year";
            }
            else {
                timeUnit = @"years";
            }
            
        }
        else {
            return @"forever";
        }
    }
    
    return [NSString stringWithFormat:@"%d %@", timeValue, timeUnit];
    
}

- (NSComparisonResult)compareDayMonthAndYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *selfComponents = [calendar components:unitFlags fromDate:self];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    BOOL dayIsEqual = (selfComponents.day == dateComponents.day && selfComponents.month == dateComponents.month && selfComponents.year == dateComponents.year);
    if (dayIsEqual) {
        return NSOrderedSame;
    }
    return [self compare:date];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = days;
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorianCalendar dateByAddingComponents:components toDate:[NSDate date] options:0];
}

@end