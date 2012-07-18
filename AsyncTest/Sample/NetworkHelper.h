//
//  Reachability.h
//  Sample
//
//  Created by Magic Yang on 5/11/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkHelperDelegate <NSObject>
@optional
- (void)succeedGotStatusCode:(int)code;
- (void)failedGotStatusCodeWithError:(NSError *)error;
@end

@interface NetworkHelper : NSObject

- (id)initWithDelegate:(id<NetworkHelperDelegate>)del;
- (void)getStatusCodeForSite:(NSString *)url;

@end
