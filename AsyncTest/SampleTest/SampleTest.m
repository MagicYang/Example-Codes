//
//  SampleTest.m
//  SampleTest
//
//  Created by Magic Yang on 5/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "SampleTest.h"

@implementation SampleTest
{
	int statusCode;
}
- (void)setUp
{
    [super setUp];
    
    statusCode = -1;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NetworkHelper *helper = [[NetworkHelper alloc] initWithDelegate:self];
	[helper getStatusCodeForSite:@"http://www.baidu.com"];
	NSLog(@"------------------ Waiting ------------------");	
	CFRunLoopRun();
	STAssertTrue(statusCode == 200, @"Can not access this site");
	NSLog(@"------------------ Finished ------------------");
}

- (void)succeedGotStatusCode:(int)code
{
	statusCode = code;
	CFRunLoopRef runLoopRef = CFRunLoopGetCurrent();
	CFRunLoopStop(runLoopRef);
}

- (void)failedGotStatusCodeWithError:(NSError *)error
{
	// ...
}

@end
