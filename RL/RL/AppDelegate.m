//
//  AppDelegate.m
//  RL
//
//  Created by Magic Yang on 3/13/12.
//  Copyright (c) 2012 Personal. All rights reserved.
//

#import "AppDelegate.h"
#import "RunLoopSourceWrapper.h"

void RunLoopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine(void *info);
void RunLoopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
//    AppDelegate *obj = (AppDelegate *)info;
	NSLog(@"RunLoopSourceScheduleRoutine");
}

void RunLoopSourcePerformRoutine (void *info)
{
//    AppDelegate *obj = (AppDelegate *)info;
	NSLog(@"RunLoopSourcePerformRoutine");
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
//    AppDelegate *obj = (AppDelegate *)info;
	NSLog(@"RunLoopSourceCancelRoutine");
}

@implementation AppDelegate
{
	RunLoopSourceWrapper *source;
}

@synthesize window = _window;

- (void)dealloc
{
	[source release];
	[_window release];
    [super dealloc];
}

- (void)startNewThread
{
	// start a new thread to listen event
	[NSThread detachNewThreadSelector:@selector(subThread:) toTarget:self withObject:source];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.window.backgroundColor = [UIColor whiteColor];
	
	UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn1 setFrame:CGRectMake(60, 150, 200, 50)];
	[btn1 setTitle:@"WakeUp & Performan" forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(fireSource:) forControlEvents:UIControlEventTouchUpInside];
	[self.window addSubview:btn1];
	
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn2 setFrame:CGRectMake(20, 250, 120, 50)];
	[btn2 setTitle:@"Remove Source" forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(removeSource:) forControlEvents:UIControlEventTouchUpInside];
	[self.window addSubview:btn2];
	
	UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[btn3 setFrame:CGRectMake(180, 250, 120, 50)];
	[btn3 setTitle:@"Add Source" forState:UIControlStateNormal];
	[btn3 addTarget:self action:@selector(addSource:) forControlEvents:UIControlEventTouchUpInside];
	[self.window addSubview:btn3];
	
	[self.window makeKeyAndVisible];
	
	// create runloop with context in a Objective-C wapper
	CFRunLoopSourceContext context = {0, self, NULL, NULL, NULL, NULL, NULL,
										RunLoopSourceScheduleRoutine,
										RunLoopSourceCancelRoutine,
										RunLoopSourcePerformRoutine};
	source = [[RunLoopSourceWrapper alloc] initWithContext:context];
	
	[self startNewThread];
	
    return YES;
}

static bool isSubthreadExist = false;

- (void)subThread:(RunLoopSourceWrapper *)runloopSrc
{
	@synchronized(self) {
		isSubthreadExist = true;
	}
	
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	
	// add input source whitch is created in main-thread to sub-thread runloop 
	CFRunLoopRef runloop = CFRunLoopGetCurrent();
	runloopSrc.runLoop = runloop;
	CFRunLoopSourceRef src = [runloopSrc runLoopSource];
	CFRunLoopAddSource(runloop, src, kCFRunLoopDefaultMode);
	
	// start the runloop, thread will be blocked here
	CFRunLoopRun();
	
	NSLog(@"runloop is stoped, sub-thread will finish execute");
	
	[pool release];
	
	@synchronized(self) {
		isSubthreadExist = false;
	}
}

- (void)fireSource:(id)sender
{
	// wake up sub-thread and fire input source
	if (isSubthreadExist) {
		CFRunLoopSourceRef src = [source runLoopSource];
		CFRunLoopSourceSignal(src);
		CFRunLoopWakeUp(source.runLoop);
	}
}

- (void)removeSource:(id)sender
{
	// remove input source from a runloop
	if (isSubthreadExist) {
		CFRunLoopSourceRef src = [source runLoopSource];
		CFRunLoopRemoveSource(source.runLoop, src, kCFRunLoopDefaultMode);
		CFRunLoopWakeUp(source.runLoop);
	}
}

- (void)addSource:(id)sender
{
	if (!isSubthreadExist) {
		[self startNewThread];
	}
}

@end
