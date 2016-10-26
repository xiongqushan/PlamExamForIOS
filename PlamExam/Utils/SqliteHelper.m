//
//  SqliteHelper.m
//  PlamExam
//
//  Created by 熊伟 on 2016/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SqliteHelper.h"
#define kDatabaseDir @"resource"

@implementation SqliteHelper
+(FMDatabase*) getDBInstance:(NSString*)accountId{
    NSString* path=[SqliteHelper getDbPath:accountId];
    FMDatabase* db=[FMDatabase databaseWithPath:path];
    [db open];
    return db;
}

+(NSString*)getDbPath:(NSString*)accountId{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ;
    NSString* path=[paths objectAtIndex:0];
    NSString* dbDir=[path stringByAppendingPathComponent:kDatabaseDir];
    BOOL isDir=NO;
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL isExist= [fileManager fileExistsAtPath:dbDir isDirectory:&isDir];
    if (!(isDir == YES && isExist == YES)) {
        [fileManager createDirectoryAtPath:dbDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString* fullPath= [NSString stringWithFormat:@"%@/%@.%@", dbDir, accountId,@"sqlite"];
    NSString* originalPath=[[NSBundle mainBundle] pathForResource:@"plamexam" ofType:@"sqlite"];
    if(![fileManager fileExistsAtPath:fullPath]){
        [fileManager copyItemAtPath:originalPath toPath:fullPath error:nil];
    }
    return fullPath;
}


@end
