//
//  LocalMapDataProvider.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 8/1/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocalMapDataProvider.h"
#import "MapModel.h"
#import "TableModel.h"

static NSString *const kEntityMapModel = @"MapModel";

static NSString *const kTableID          = @"id";
static NSString *const kTableCapacity    = @"capacity";
static NSString *const kTableHeight      = @"height";
static NSString *const kTableisActive    = @"isActive";
static NSString *const kTableIsFree      = @"isFree";
static NSString *const kTableIsRound     = @"isRound";
static NSString *const kTableName        = @"name";
static NSString *const kTableRotation    = @"rotation";
static NSString *const kTablewWidth      = @"width";
static NSString *const kTableX           = @"x";
static NSString *const kTableY           = @"y";


@implementation LocalMapDataProvider

// store data to local data base
+ (BOOL) storeMapData: (MapModel*) mapModel error: (NSError**)error
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    for ( TableModel *tableModel in mapModel.tables ) {
        // Create a new managed object and insert it to local data base
        [LocalMapDataProvider insertTable: tableModel
                                forEntity: kEntityMapModel
                   inManagedObjectContext: managedObjectContext];
    }
    
    // Save the object to persistent store
    return ([managedObjectContext save: error]);
}

+ (NSManagedObject*) insertTable:(TableModel*)tableModel forEntity:(NSString*)entity inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext
{
    NSManagedObject *newTable = [NSEntityDescription insertNewObjectForEntityForName: entity
                                                              inManagedObjectContext: managedObjectContext];
    
    [newTable setValue: [NSNumber numberWithInt: tableModel.Id]
                forKey: kTableID];
    [newTable setValue: [NSNumber numberWithInt: tableModel.capacity]
                forKey: kTableCapacity];
    [newTable setValue: [NSNumber numberWithInt: tableModel.height]
                forKey: kTableHeight];
    [newTable setValue: [NSNumber numberWithBool: tableModel.isActive]
                forKey: kTableisActive];
    [newTable setValue: [NSNumber numberWithBool: tableModel.isFree]
                forKey: kTableIsFree];
    [newTable setValue: [NSNumber numberWithBool: tableModel.isRound]
                forKey: kTableIsRound];
    [newTable setValue: tableModel.name
                forKey: kTableName];
    [newTable setValue: [NSNumber numberWithInt: tableModel.rotation]
                forKey: kTableRotation];
    [newTable setValue: [NSNumber numberWithInt: tableModel.width]
                forKey: kTablewWidth];
    [newTable setValue: [NSNumber numberWithInt: tableModel.X]
                forKey: kTableX];
    [newTable setValue: [NSNumber numberWithInt: tableModel.Y]
                forKey: kTableY];
    
    return newTable;
}

// load data from local data base
+ (void) loadMapDataWithBlock: (void (^)(MapModel*, NSError*))callback {
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName: kEntityMapModel];
    
    NSError *error;
    
    NSArray *managedTables = [managedObjectContext executeFetchRequest: fetchRequest
                                                                 error: &error];
    MapModel *mapModel;
    if ( error == nil ) {
        mapModel = [[MapModel alloc] init];
        
        for ( NSManagedObject *managedTable in managedTables ) {
            TableModel *tableModel = [LocalMapDataProvider createNewTable: managedTable];
            [mapModel addTableModel: tableModel];
        }
    }
    
    callback(mapModel, error);
}

+ (TableModel*) createNewTable: (NSManagedObject*)tableManagedObject
{
    return [[TableModel alloc] initWithId: [[tableManagedObject valueForKey: kTableID] intValue]
                                 Capacity: [[tableManagedObject valueForKey: kTableCapacity]intValue]
                                   height: [[tableManagedObject valueForKey: kTableHeight]intValue]
                                 isActive: [[tableManagedObject valueForKey: kTableisActive] boolValue]
                                   isFree: [[tableManagedObject valueForKey: kTableIsFree]boolValue]
                                  isRound: [[tableManagedObject valueForKey: kTableIsRound]intValue]
                                     name: [tableManagedObject  valueForKey: kTableName]
                                 rotation: [[tableManagedObject valueForKey: kTableRotation]intValue]
                                    width: [[tableManagedObject valueForKey: kTablewWidth]intValue]
                                   coordX: [[tableManagedObject valueForKey: kTableX]intValue]
                                   coordY: [[tableManagedObject valueForKey: kTableY]intValue]
            ];
}


+ (BOOL) isData
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName: kEntityMapModel];
    
    NSError *error;
    NSUInteger count = [managedObjectContext countForFetchRequest: fetchRequest
                                                            error: &error];
    
    return (count > 0);
}

+ (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
