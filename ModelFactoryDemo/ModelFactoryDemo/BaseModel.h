//
//  BaseModel.h
//  ModelFactoryDemo
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (void)addExtValue:(id)value forKey:(NSString *)key;
- (id)extValueForKey:(NSString *)key;
- (NSDictionary*)extDict;

@end
