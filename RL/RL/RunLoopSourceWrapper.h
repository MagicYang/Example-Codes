//
//  RunLoopSource.h
//  RL
//
//  Created by Magic Yang on 3/13/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunLoopSourceWrapper : NSObject
{
    CFRunLoopSourceRef runLoopSource;
}
@property CFRunLoopRef runLoop;

- (id)initWithContext:(CFRunLoopSourceContext)context;
- (CFRunLoopSourceRef)runLoopSource;

@end
