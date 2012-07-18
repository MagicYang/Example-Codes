//
//  Reachability.m
//  Sample
//
//  Created by Magic Yang on 5/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper
{
	id<NetworkHelperDelegate> delegate;
	NSURLConnection *connection;
}

- (id)initWithDelegate:(id)del
{
	if (self = [super init]) {
		delegate = del;
	}
	return self;
}

- (void)getStatusCodeForSite:(NSString *)url
{
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
	if (connection) {
		[connection cancel];
		[connection release];
		connection = nil;
	}
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	int code = [(NSHTTPURLResponse *)response statusCode];
	[delegate succeedGotStatusCode:code];
}

- (void)dealloc
{
	[connection release];
	[super dealloc];
}

@end
