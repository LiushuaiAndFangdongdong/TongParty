//
//  LSSystemMessageEntity.h
//  TongParty
//
//  Created by 刘帅 on 2018/1/18.
//  Copyright © 2018年 桐聚. All rights reserved.
//

#import "DDModel.h"

@interface LSSystemMessageEntity : DDModel
@property (nonatomic, copy) NSString *msg_text;
@property (nonatomic, copy) NSString *uptime;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *image;
@end
