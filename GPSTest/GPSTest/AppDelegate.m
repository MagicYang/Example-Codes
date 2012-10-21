//
//  AppDelegate.m
//  GPSTest
//
//  Created by MagicYang on 10/21/12.
//
//

#import "AppDelegate.h"
#import "LocationMock.h"

@implementation AppDelegate
{
    CLLocationManager *_manager;
    LocationMock *_mock;
    NSMutableArray *_locationList;
}

- (void)dealloc
{
    [_manager release];
    [_mock release];
    [_locationList release];
    [_window release];
    [super dealloc];
}

- (void)initUI
{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setFrame:CGRectMake(40, 40, 100, 40)];
    [startBtn setTitle:@"Start" forState:UIControlStateNormal];
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopBtn addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    [stopBtn setFrame:CGRectMake(170, 40, 100, 40)];
    [stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    
    UIButton *speedUpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [speedUpBtn addTarget:self action:@selector(mockSpeedUp:) forControlEvents:UIControlEventTouchUpInside];
    [speedUpBtn setFrame:CGRectMake(40, 90, 100, 40)];
    [speedUpBtn setTitle:@"SpeedUp" forState:UIControlStateNormal];

    UIButton *speedDownBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [speedDownBtn addTarget:self action:@selector(mockSpeedDown:) forControlEvents:UIControlEventTouchUpInside];
    [speedDownBtn setFrame:CGRectMake(170, 90, 100, 40)];
    [speedDownBtn setTitle:@"SpeedDown" forState:UIControlStateNormal];
    
    UIButton *succeedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [succeedBtn addTarget:self action:@selector(mockSucceed:) forControlEvents:UIControlEventTouchUpInside];
    [succeedBtn setFrame:CGRectMake(40, 150, 100, 40)];
    [succeedBtn setTitle:@"Succeed" forState:UIControlStateNormal];
    
    UIButton *failedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [failedBtn addTarget:self action:@selector(mockFailed:) forControlEvents:UIControlEventTouchUpInside];
    [failedBtn setFrame:CGRectMake(170, 150, 100, 40)];
    [failedBtn setTitle:@"Failed" forState:UIControlStateNormal];
    
    [_window addSubview:startBtn];
    [_window addSubview:stopBtn];
    [_window addSubview:speedUpBtn];
    [_window addSubview:speedDownBtn];
    [_window addSubview:succeedBtn];
    [_window addSubview:failedBtn];
}

- (void)initData
{
    _locationList = [NSMutableArray new];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gpx" ofType:@"data"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    [str release];
    for (NSString *substr in array)
    {
        NSArray *coor = [substr componentsSeparatedByString:@", "];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[coor objectAtIndex:0] doubleValue]
                                                          longitude:[[coor objectAtIndex:1] doubleValue]];
        [_locationList addObject:location];
        [location release];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self initUI];
    [self initData];
    
    _manager = [CLLocationManager new];
    _manager.delegate        = self;
    _manager.distanceFilter  = kCLDistanceFilterNone;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;

    _mock = [[LocationMock alloc] initWithDelegate:self andCLLocationManager:_manager];
    
    return YES;
}


#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // Your logic here...
    // Such as reverse geocoder balabala...
    
    CLLocationDegrees lat = newLocation.coordinate.latitude;
    CLLocationDegrees lng = newLocation.coordinate.longitude;
    
    NSLog(@"lat = %lf, lng = %lf", lat, lng);
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // Your logic here...
    
    NSLog(@"Location Failed");
}


#pragma mark -
#pragma mark Actions
- (void)start:(id)sender
{
    [_mock startWithLocationList:_locationList];
}

- (void)stop:(id)sender
{
    [_mock stop];
}

- (void)mockSpeedUp:(id)sender
{
    [_mock mockSpeedUp];
}

- (void)mockSpeedDown:(id)sender
{
    [_mock mockSpeedDown];
}

- (void)mockSucceed:(id)sender
{
    [_mock mockGPSSucceed];
}

- (void)mockFailed:(id)sender
{
    [_mock mockGPSFailed];
}

@end
