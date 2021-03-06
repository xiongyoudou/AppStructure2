//
//  GON_NSManagedObjectContext+XYDObjectClear.h
//
//  Created by Nicolas Goutaland on 04/04/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (XYDObjectClear)
/* Delete all given objects*/
- (void)xyd_deleteObjects:(id <NSFastEnumeration>)objects;
@end
