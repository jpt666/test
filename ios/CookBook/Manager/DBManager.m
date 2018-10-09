//
//  DBManager.m
//  CookBook
//
//  Created by zhangxi on 16/4/11.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "DBManager.h"
#import "DBHelper.h"


static NSString * const T_COOKDATA_DRAFT  =  @"T_COOKDATA_DRAFT";
static NSString * const T_CACHE          =  @"T_CACHE";

@implementation DBManager

+(DBManager *)shareInstance
{
    static DBManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class]alloc] init];
        [instance CreateTable];
        
    });
    return instance;
}

-(void)CreateTable
{
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return;
    }
    [queue inDatabase:^(FMDatabase *db) {
        if (![DBHelper isTableOK: T_COOKDATA_DRAFT withDB:db]) {
            NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ TEXT PRIMARY KEY, %@ TEXT, %@ INTEGER, %@ BLOB, %@ BLOB, %@ BLOB, %@ INTEGER);", T_COOKDATA_DRAFT, kDBKeyCookDataId, kDBKeyCookerId, kDBKeyCookType, kDBKeyBaseData,kDBKeyImagesData,kDBKeyExtendData, kDBKeyStatus];
            if(![db executeUpdate:createTableSQL]) {
                NSError * err = [db lastError];
                int c = 0;
                return ;
            }
        }
    }];
}


-(NSMutableArray *)queryCookDataWithCookerId:(NSString *)cookerId
{
    __block NSMutableArray * arr = nil;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return nil;
    }
    [queue inDatabase:^(FMDatabase *db) {
        NSString *strSql=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE CookerId='%@';",T_COOKDATA_DRAFT, cookerId];
        FMResultSet *rs = [db executeQuery:strSql];
        while ([rs next]) {
            if (!arr) {
                arr = [NSMutableArray array];
            }
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[kDBKeyCookDataId] = [rs stringForColumn:kDBKeyCookDataId];
            dict[kDBKeyCookerId] = [rs stringForColumn:kDBKeyCookerId];
            dict[kDBKeyCookType] = @([rs intForColumn:kDBKeyCookType]);
            dict[kDBKeyBaseData] = [rs dataForColumn:kDBKeyBaseData];
            dict[kDBKeyImagesData] = [rs dataForColumn:kDBKeyImagesData];
            dict[kDBKeyExtendData] = [rs dataForColumn:kDBKeyExtendData];
            dict[kDBKeyStatus] = @([rs intForColumn:kDBKeyStatus]);
            
            [arr addObject:dict];
        }
        [rs close];
    }];
    
    return arr;
}

-(NSMutableDictionary *)queryCookDataDraft:(NSString *)cookDataId
{
    __block NSMutableDictionary *dict = nil;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    if (queue==nil) {
        return nil;
    }
    [queue inDatabase:^(FMDatabase *db) {
        NSString *strSql=[NSString stringWithFormat:@"SELECT * FROM %@ WHERE CookDataId='%@';",T_COOKDATA_DRAFT, cookDataId];
        FMResultSet *rs = [db executeQuery:strSql];
        
        if ([rs next]) {
            dict = [NSMutableDictionary dictionary];
            dict[kDBKeyCookDataId] = [rs stringForColumn:kDBKeyCookDataId];
            dict[kDBKeyCookerId] = [rs stringForColumn:kDBKeyCookerId];
            dict[kDBKeyCookType] = @([rs intForColumn:kDBKeyCookType]);
            dict[kDBKeyBaseData] = [rs dataForColumn:kDBKeyBaseData];
            dict[kDBKeyImagesData] = [rs dataForColumn:kDBKeyImagesData];
            dict[kDBKeyExtendData] = [rs dataForColumn:kDBKeyExtendData];
            dict[kDBKeyStatus] = @([rs intForColumn:kDBKeyStatus]);
        }
        [rs close];
    }];
    
    return dict;
}


- (BOOL)saveCookDataDraft:(NSMutableDictionary *)dict
{
//    dict[kDBkeyFrontImage] = UIImagePNGRepresentation([UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]);
    __block BOOL flag;
    
    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *strSql=[NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (CookDataId, CookerId, CookType, BaseData, ImagesData,ExtendData, Status) VALUES (?, ?, ?, ?, ?, ?, ?);",T_COOKDATA_DRAFT];
        NSError *error=nil;
        flag=[db executeUpdate:strSql,dict[kDBKeyCookDataId],dict[kDBKeyCookerId], dict[kDBKeyCookType], dict[kDBKeyBaseData],dict[kDBKeyImagesData], dict[kDBKeyExtendData],dict[kDBKeyStatus]];
        error = [db lastError];
        NSLog(@"%@",error);
    }];
    return flag;
}

//- (BOOL)saveCookDataDraft:(NSMutableDictionary *)dict withStatus:(NSInteger)status
//{
//    //    dict[kDBkeyFrontImage] = UIImagePNGRepresentation([UIImage imageNamed:PLACE_HOLDER_COOK_IMAGE]);
//    __block BOOL flag;
//    
//    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
//    [queue inDatabase:^(FMDatabase *db) {
//        
//        NSString *strSql=[NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (CookDataId, CookerId, CookType, BaseData, ImagesData,ExtendData, Status) VALUES (?, ?, ?, ?, ?, ?, ?);",T_COOKDATA_DRAFT];
//        NSError *error=nil;
//        flag=[db executeUpdate:strSql,dict[kDBKeyCookDataId],dict[kDBKeyCookerId], dict[kDBKeyCookType], dict[kDBKeyBaseData],dict[kDBKeyImagesData], dict[kDBKeyExtendData],[NSNumber numberWithInteger:status]];
//        error = [db lastError];
//        NSLog(@"%@",error);
//    }];
//    return flag;
//}

- (BOOL)clearAllCookDataDraft
{
    __block BOOL flag;
    
    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *strSql=[NSString stringWithFormat:@"DELETE FROM %@;",T_COOKDATA_DRAFT];
        NSError *error=nil;
        flag=[db executeUpdate:strSql withErrorAndBindings:&error];
        NSLog(@"%@",error);
    }];
    return flag;
}

- (BOOL)deleteCookDataDraft:(NSString *)cookDataId
{
    __block BOOL flag;
    
    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *strSql=[NSString stringWithFormat:@"DELETE FROM %@ where CookDataId='%@';",T_COOKDATA_DRAFT,cookDataId];
        NSError *error=nil;
        flag=[db executeUpdate:strSql withErrorAndBindings:&error];
        NSLog(@"%@",error);
    }];
    return flag;
}

- (BOOL)updateCookDataDraft:(NSString *)cookDataId withStatus:(NSInteger)status
{
    __block BOOL flag;
    
    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *strSql=[NSString stringWithFormat:@"UPDATE %@ SET Status=%ld where CookDataId='%@';",T_COOKDATA_DRAFT,status, cookDataId];
        NSError *error=nil;
        flag=[db executeUpdate:strSql withErrorAndBindings:&error];
        NSLog(@"%@",error);
    }];
    return flag;
}

-(BOOL)updateUnCookerData:(NSString *)cookerId
{
    __block BOOL flag;
    FMDatabaseQueue *queue=[DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        NSString *strSql = [NSString stringWithFormat:@"UPDATE %@ SET CookerId='%@' where CookerId is NULL or CookerId='';", T_COOKDATA_DRAFT, cookerId];
        NSError *error=nil;
        flag=[db executeUpdate:strSql withErrorAndBindings:&error];
        NSLog(@"%@",error);
        
    }];
    return flag;
}

@end
