//
//  ConsulationViewController.h
//  PlamExam
//
//  Created by 郭凯 on 16/10/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BaseViewController.h"
#import "ChatData.h"
@interface ConsultDetailViewController : BaseViewController

//@property (nonatomic, assign) BOOL isReloadNetData;
@property (nonatomic, strong) NSMutableArray<ChatData*> *dataArr;
@property (nonatomic, strong) NSMutableArray<ChatData*> *fromReportArr;
//-(void)setConsultDataFromReport:(NSMutableArray<ChatData>)
@end
