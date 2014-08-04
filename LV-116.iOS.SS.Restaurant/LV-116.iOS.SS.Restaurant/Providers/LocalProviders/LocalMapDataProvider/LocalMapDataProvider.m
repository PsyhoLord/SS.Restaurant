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

#import "LocalServiceAgent.h"

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
+ (void) storeMapData: (MapModel*)mapModel
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync( concurrentQueue, ^{
        
        for ( TableModel *tableModel in mapModel.tables ) {
            
            NSManagedObject *managedTable = [LocalServiceAgent insertNewObjectForEntityName: kEntityMapModel];
            
            [LocalMapDataProvider setTableData: tableModel
                              forManagedObject: managedTable];
        }
        
        [LocalServiceAgent save: nil];
    });
}

//+ (NSManagedObject*) insertTable:(TableModel*)tableModel forEntity:(NSString*)entity
+ (void) setTableData: (TableModel*)tableModel forManagedObject: (NSManagedObject*)managedTable
{
    [managedTable setValue: [NSNumber numberWithInt: tableModel.Id]
                    forKey: kTableID];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.capacity]
                    forKey: kTableCapacity];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.height]
                    forKey: kTableHeight];
    [managedTable setValue: [NSNumber numberWithBool: tableModel.isActive]
                    forKey: kTableisActive];
    [managedTable setValue: [NSNumber numberWithBool: tableModel.isFree]
                    forKey: kTableIsFree];
    [managedTable setValue: [NSNumber numberWithBool: tableModel.isRound]
                    forKey: kTableIsRound];
    [managedTable setValue: tableModel.name
                    forKey: kTableName];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.rotation]
                    forKey: kTableRotation];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.width]
                    forKey: kTablewWidth];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.X]
                    forKey: kTableX];
    [managedTable setValue: [NSNumber numberWithInt: tableModel.Y]
                    forKey: kTableY];
}

+ (void) resetMapData
{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync( concurrentQueue, ^{
        [LocalServiceAgent deleteDataFromEntity: kEntityMapModel];
    });
}

// load data from local data base
+ (void) loadMapDataWithBlock: (void (^)(MapModel*, NSError*))callback
{
    NSError *error;
    NSArray *managedTables = [LocalServiceAgent executeFetchRequestForEntity: kEntityMapModel
                                                                       error: &error];
    MapModel *mapModel;
    if ( error == nil ) {
        mapModel = [MapModel new];
        
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
    return [LocalServiceAgent isDataInEntity: kEntityMapModel];
}




@end
