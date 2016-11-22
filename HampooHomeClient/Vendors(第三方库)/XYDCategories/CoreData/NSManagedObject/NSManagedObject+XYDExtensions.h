//
//  NSManagedObject+Extensions.h
//  kemmler
//
//  Created by Lars Kuhnt on 28.10.13.
//  Copyright (c) 2013 Coeus Solutions GmbH. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+XYDExtensions.h"

@interface NSManagedObject (XYDExtensions)

+ (id)xyd_create:(NSManagedObjectContext*)context;
+ (id)xyd_create:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;
+ (id)xyd_find:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (id)xyd_find:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSArray*)xyd_all:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSArray*)xyd_all:(NSPredicate *)predicate sortDescriptors:(NSArray*)sortDescriptors inContext:(NSManagedObjectContext *)context;
+ (NSUInteger)xyd_count:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)contex;
+ (NSString *)xyd_entityName;
+ (NSError*)xyd_deleteAll:(NSManagedObjectContext*)context;

@end
