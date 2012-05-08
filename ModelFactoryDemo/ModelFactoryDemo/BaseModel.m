//
//  BaseModel.m
//  ModelFactoryDemo
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel {
	NSMutableDictionary *_extdata;
}

- (id)init
{
	if (self = [super init]) {
		_extdata = [NSMutableDictionary new];
	}
	return self;
}
- (void)addExtValue:(id)value forKey:(NSString *)key
{
	[_extdata setObject:value forKey:key];
}

- (id)extValueForKey:(NSString *)key
{
	return [_extdata objectForKey:key];
}
- (NSDictionary*)extDict
{
    return _extdata;
	
}
- (void)dealloc
{
	[_extdata release];
	[super dealloc];
}

@end
