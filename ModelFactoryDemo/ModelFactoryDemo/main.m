//
//  main.m
//  ModelFactoryDemo
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelFactory.h"
#import "UserModel.h"

int main (int argc, const char * argv[])
{
	@autoreleasepool {
	    NSDictionary *father = [NSDictionary dictionaryWithObjectsAndKeys:
								@"UserModel",   @"T",
								@"Father",		@"name", 
								@"57",			@"age", nil];
		NSDictionary *mother = [NSDictionary dictionaryWithObjectsAndKeys:
								@"UserModel",   @"T",
								@"Mother",		@"name", 
								@"48",			@"age", nil];
		NSArray *parents = [NSArray arrayWithObjects:father, mother, nil];
		NSDictionary *lover = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"UserModel",	@"T",
							   @"Wife",			@"name", 
							   @"25",			@"age", nil];
		NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:
							  @"UserModel",		@"T",
							  @"Son",			@"name", 
							  @"27",			@"age",
							  lover,			@"lover", 
							  parents,			@"parents", nil];
		UserModel *userModel = [ModelFactoryInstance createModelWithDictionary:user];
		UserModel *loverModel = userModel.lover;
		UserModel *fatherModel = [userModel.parents objectAtIndex:0];
		UserModel *motherModel = [userModel.parents objectAtIndex:1];
		
		NSCAssert([userModel.name isEqualToString:@"Son"], @"error user name");
		NSCAssert(userModel.age == 27, @"error mother age");
		NSCAssert([loverModel.name isEqualToString:@"Wife"], @"error wife name");
		NSCAssert([userModel.parents count] == 2, @"error parents count");
		NSCAssert([fatherModel.name isEqualToString:@"Father"], @"error father name");
		NSCAssert(motherModel.age == 48, @"error mother age");
		
		NSLog(@"---- Test OK ----");
	}
    return 0;
}

