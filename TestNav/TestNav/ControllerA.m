//
//  ControllerA.m
//  TestNav
//
//  Created by MagicYang on 7/8/11.
//  Copyright 2011 personal. All rights reserved.
//

#import "ControllerA.h"
#import "ControllerB.h"

@implementation ControllerA

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"A";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ControllerB" style:UIBarButtonItemStyleBordered target:self action:@selector(push)];
    }
    return self;
}

- (void)push
{
    ControllerB *c = [ControllerB new];
    [self.navigationController pushViewController:c animated:YES];
    [c release];
}

@end
