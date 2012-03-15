//
//  RunLoopSource.m
//  RL
//
//  Created by Magic Yang on 3/13/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "RunLoopSourceWrapper.h"

@implementation RunLoopSourceWrapper
@synthesize runLoop;

- (id)initWithContext:(CFRunLoopSourceContext)context
{
    if (self = [super init]) {
		runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
	}
    return self;
}

- (CFRunLoopSourceRef)runLoopSource
{
	return runLoopSource;
}

@end