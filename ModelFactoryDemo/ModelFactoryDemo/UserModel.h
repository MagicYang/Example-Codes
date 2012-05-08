//
//  UserModel.h
//  ModelFactoryDemo
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, retain) UserModel *lover;
@property(nonatomic, retain) NSArray *parents;
@end
