//
//  TestNavAppDelegate.h
//  TestNav
//
//  Created by MagicYang on 7/8/11.
//  Copyright 2011 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestNavAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
