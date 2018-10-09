//
//  DBHelper.m
//  Gopeer
//
//  Created by Samuel Huang on 11/17/15.
//  Copyright © 2015 xyxNav. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@implementation DBHelper

static FMDatabaseQueue *databaseQueue = nil;
static FMDatabase *dataBase=nil;

+(FMDatabaseQueue *) getDatabaseQueue
{
    if (!databaseQueue) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"CookBook.db"];
        databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    
    return databaseQueue;
}

+ (BOOL) isTableOK:(NSString *)tableName withDB:(FMDatabase *)db
{
    BOOL isOK = NO;
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 == count) {
            isOK =  NO;
        } else {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}

@end
