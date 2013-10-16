//
//  NSManagedObjectContext+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (KRAdditions)

- (NSUInteger)countForFetchRequest:(NSFetchRequest *)fetchRequest error:(void (^)(NSError *))error something:(id)something;

@end