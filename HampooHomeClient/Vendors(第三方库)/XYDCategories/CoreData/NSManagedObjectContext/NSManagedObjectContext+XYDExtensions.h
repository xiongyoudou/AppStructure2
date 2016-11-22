//
//  NSManagedObjectContext+Extensions.h
//
//  Created by Wess Cope on 9/23/11.
//  Copyright 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSFetchRequest+XYDExtensions.h"

typedef void (^ContextCallback)(NSManagedObjectContext *context);
typedef void (^ContextObjectCallback)(NSManagedObjectContext *context, id object);
typedef void (^ContextObjectsCallback)(NSManagedObjectContext *context, NSArray *objects);


@interface NSManagedObjectContext(XYDExtensions)

#pragma mark - Conveince Property
@property (nonatomic, readonly) NSManagedObjectModel *xyd_objectModel;

#pragma mark - Sync methods
- (NSArray *)xyd_fetchObjectsForEntity:(NSString *)entity;
- (NSArray *)xyd_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (NSArray *)xyd_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)xyd_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
- (NSArray *)xyd_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors fetchLimit:(NSUInteger)limit;
- (id)xyd_fetchObjectForEntity:(NSString *)entity;
- (id)xyd_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate;
- (id)xyd_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;
- (id)xyd_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

#pragma mark - Async Methods
- (void)xyd_fetchObjectsForEntity:(NSString *)entity callback:(FetchObjectsCallback)callback;
- (void)xyd_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectsCallback)callback;
- (void)xyd_fetchObjectsForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;
- (void)xyd_fetchObjectsForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectsCallback)callback;

- (void)xyd_fetchObjectForEntity:(NSString *)entity callback:(FetchObjectCallback)callback;
- (void)xyd_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate callback:(FetchObjectCallback)callback;
- (void)xyd_fetchObjectForEntity:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;
- (void)xyd_fetchObjectForEntity:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors callback:(FetchObjectCallback)callback;

- (void)xyd_fetchRequest:(NSFetchRequest *)fetchRequest withCallback:(FetchObjectsCallback)callback;

#pragma mark - Insert New Entity
- (id)xyd_insertEntity:(NSString *)entity;
- (void)xyd_deleteEntity:(NSString *)entity withPredicate:(NSPredicate *)predicate;
@end
