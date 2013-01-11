//
//  NSDate+Additions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSDate *)dateWithNumberSince1970:(NSNumber *)number;
- (NSString *)timeIntervalInWordsSinceDate:(NSDate *)aDate;
- (NSString *)timeIntervalInWordsSinceNow;
- (NSComparisonResult)compareDayMonthAndYear:(NSDate *)date;
- (NSDate *)dateByAddingDays:(NSInteger)days;

@end