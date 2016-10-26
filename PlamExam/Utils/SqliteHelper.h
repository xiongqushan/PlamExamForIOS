//
//  SqliteHelper.h
//  PlamExam
//
//  Created by 熊伟 on 2016/10/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface SqliteHelper : NSObject
+(FMDatabase*) getDBInstance:(NSString*)accountId;
@end
