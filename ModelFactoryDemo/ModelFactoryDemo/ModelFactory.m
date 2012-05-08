		//
//  ModelFactory.m
//  LogicController
//
//  Created by Magic Yang on 4/12/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "ModelFactory.h"
#import <objc/message.h>
#import "BaseModel.h"

#define kDefaultModelKey @"T"

static ModelFactory *instance = nil;


@implementation ModelFactory
@synthesize modelKey;

+ (id)allocWithZone:(NSZone *)zone
{
	NSAssert(instance == nil, @"Attemp to alloc a single-ton instance");
	return [super allocWithZone:zone];
}

+ (id)sharedInstance
{
	@synchronized([ModelFactory class]) {
		if (!instance) {
			instance = [ModelFactory new];
			instance.modelKey = kDefaultModelKey;
		}
	}
	return instance;
}

- (void)dealloc
{
	self.modelKey = nil;
	[super dealloc];
}

- (NSString *)setterNameWithPropertyName:(NSString *)propName
{
	NSString *firstChar = [propName substringToIndex:1];
	firstChar = [firstChar capitalizedString];
	return [propName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
}

- (void)setProperty:(NSString *)propName withValue:(id)value forModel:(BaseModel *)model
{
	NSString *setterName = [NSString stringWithFormat:@"set%@:", [self setterNameWithPropertyName:propName]];
	SEL setter = NSSelectorFromString(setterName);
	if ([model respondsToSelector:setter]) {
		objc_property_t property = class_getProperty([model class], [propName cStringUsingEncoding:NSUTF8StringEncoding]);
		const char *attr = property_getAttributes(property);
		NSString *strAttr = [NSString stringWithCString:attr encoding:NSUTF8StringEncoding];
		NSString *varType = [[[strAttr componentsSeparatedByString:@","] objectAtIndex:0] substringFromIndex:1];
		if ([varType isEqualToString:@"d"]) {
			objc_msgSend(model, setter, [value doubleValue]);
		} else if ([varType isEqualToString:@"f"]) {
			objc_msgSend(model, setter, [value floatValue]);
		} else if ([varType isEqualToString:@"i"]) {
			objc_msgSend(model, setter, [value intValue]);
		} else if ([varType isEqualToString:@"q"]) {
			objc_msgSend(model, setter, [value longLongValue]);
		} else if ([varType isEqualToString:@"b"]) {
			objc_msgSend(model, setter, [value boolValue]);
		} else {
			objc_msgSend(model, setter, value);
		}
	} else {
		[model addExtValue:value forKey:propName];
	}
}

- (id)modelWithDictionary:(NSDictionary *)dict
{
	if (![dict objectForKey:self.modelKey]) return nil; // No Type, dismiss it
	NSString *className = [dict objectForKey:self.modelKey];
	Class clazz = NSClassFromString(className);
	if (![clazz isSubclassOfClass:[BaseModel class]]) return nil; // Invalid model

	BaseModel *model = [clazz new];
	for (NSString *key in [dict allKeys]) {
		id value = [dict objectForKey:key];
		if ([value isKindOfClass:[NSDictionary class]]) {
			BaseModel *modelValue = [self modelWithDictionary:value];
			[self setProperty:key withValue:modelValue forModel:model];
		} else if ([value isKindOfClass:[NSArray class]]) {
			NSMutableArray *arrValue = [NSMutableArray array];
			for (id item in value) {
				if (![item isKindOfClass:[NSDictionary class]]
					&& [item isKindOfClass:[NSArray class]]) {
					[arrValue addObject:item];
				} else {
					BaseModel *modelValue = [self modelWithDictionary:item];
					[arrValue addObject:modelValue];
				}
			}
			[self setProperty:key withValue:arrValue forModel:model];
		} else {
			[self setProperty:key withValue:value forModel:model];
		}
	}
	return [model autorelease];
}

- (id)createModelWithDictionary:(NSDictionary *)dict
{
	return [self modelWithDictionary:dict];
}

@end