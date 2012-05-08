//
//  UserModel.m
//  ModelFactoryDemo
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize name;
@synthesize age;
@synthesize lover;
@synthesize parents;
- (void)dealloc
{
	self.name = nil;
	self.lover = nil;
	self.parents = nil;
	[super dealloc];
}
@end
