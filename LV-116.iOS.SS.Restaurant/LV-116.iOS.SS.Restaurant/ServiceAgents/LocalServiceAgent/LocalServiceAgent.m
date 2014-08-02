//
//  LocalServiceAgent.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 8/2/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalServiceAgent.h"

@implementation LocalServiceAgent

+ (NSArray *) executeFetchRequestForEntity: (NSString *)entityName error: (NSError **)error;
{
    NSFetchRequest *request = [LocalServiceAgent fetchRequestWithEntity: entityName];
    
    return [[LocalServiceAgent managedObjectContext] executeFetchRequest: request
                                                                   error: error];
}

+ (NSUInteger) countForFetchRequestForEntity: (NSString *)entityName error: (NSError **)error;
{
    NSFetchRequest *request = [LocalServiceAgent fetchRequestWithEntity: entityName];
    
    return [[LocalServiceAgent managedObjectContext] countForFetchRequest: request
                                                                    error: error];
}

+ (id) insertNewObjectForEntityName: (NSString *)entityName
{
    NSManagedObjectContext *managedObjectContext = [LocalServiceAgent managedObjectContext];
    
    return [NSEntityDescription insertNewObjectForEntityForName: entityName
                                         inManagedObjectContext: managedObjectContext];
}

+ (BOOL) save: (NSError**)error
{
    return [[LocalServiceAgent managedObjectContext] save: error];
}

+ (void) deleteDataFromEntity: (NSString*)entityName;
{
    NSManagedObjectContext *managedObjectContext = [LocalServiceAgent managedObjectContext];
    
    NSArray *managedObjects = [LocalServiceAgent executeFetchRequestForEntity:entityName
                                                                        error: nil];
    
    for ( NSManagedObject *managedObject in managedObjects ) {
        [managedObjectContext deleteObject: managedObject];
    }
    
    [LocalServiceAgent save: nil];
}

+ (BOOL) isDataInEntity: (NSString*)entityName
{
    NSUInteger count = [LocalServiceAgent countForFetchRequestForEntity: entityName
                                                                  error: nil];
    
    return (count > 0);
}

+ (NSFetchRequest*) fetchRequestWithEntity: (NSString*)entityName
{
    return [[NSFetchRequest alloc] initWithEntityName: entityName];
}

+ (NSManagedObjectContext*) managedObjectContext
{
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
