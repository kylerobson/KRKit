//
//  NSManagedObjectContext+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSManagedObjectContext+Additions.h"

@implementation NSManagedObjectContext (Additions)

- (NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest error:(void (^)(NSError *))error
{
    fetchRequest.includesSubentities = NO;
    fetchRequest.includesPropertyValues = NO;
    fetchRequest.includesPendingChanges = NO;
    NSError *fetchError;
    NSUInteger count = [self countForFetchRequest:fetchRequest error:&fetchError];
    if (count == NSNotFound) {
        if (error != nil) {
            error(fetchError);
        }
    }
    else {
        return count;
    }
    return 0;
}

@end