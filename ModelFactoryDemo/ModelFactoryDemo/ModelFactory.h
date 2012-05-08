//
//  ModelFactory.h
//  LogicController
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ModelFactoryInstance [ModelFactory sharedInstance]

@interface ModelFactory : NSObject
@property(nonatomic, copy) NSString *modelKey;
+ (id)sharedInstance;
- (id)createModelWithDictionary:(NSDictionary *)dict;
@end
