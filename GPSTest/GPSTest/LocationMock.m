//
//  LocationMock.m
//  GPSTest
//
//  Created by MagicYang on 10/21/12.
//
//

#import "LocationMock.h"

#define INTERVAL 2
#define SPEED    1

@implementation LocationMock
{
    CLLocationManager *_manager;
    id<CLLocationManagerDelegate> _delegate;
    NSTimer *_timer;
    NSUInteger _step;
    NSUInteger _curIdx;
    BOOL _isLocationSucceed;
}

@synthesize locationList;
@synthesize interval = _interval;

- (id)initWithDelegate:(id<CLLocationManagerDelegate>)delegate
  andCLLocationManager:(CLLocationManager *)manager
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _manager  = [manager retain];
        _interval = INTERVAL;
        _step     = SPEED;
        _curIdx   = 0;
        _isLocationSucceed = YES;
    }
    return self;
}

- (void)dealloc
{
    self.locationList = nil;
    [_manager release];
    [self stop];
    [super dealloc];
}

- (void)startWithLocationList:(NSArray *)aLocationList
{
    if (_timer) [self stop];
    self.locationList = aLocationList;
    _timer = [[NSTimer scheduledTimerWithTimeInterval:_interval
                                               target:self
                                             selector:@selector(locationChanged)
                                             userInfo:nil
                                              repeats:YES] retain];
}

- (void)stop
{
    [_timer invalidate];
    [_timer release];
    _timer = nil;
    _step   = 1;
    _curIdx = 0;
    _isLocationSucceed = YES;
}

- (void)mockSpeedUp
{
    NSUInteger cnt = [self.locationList count];
    if (_step < MIN(3, cnt)) {
        ++_step;
    }
}

- (void)mockSpeedDown
{
    // Can not be 0
    if (_step > 2) {
        --_step;
    }
}

- (void)mockGPSFailed
{
    _isLocationSucceed = NO;
}

- (void)mockGPSSucceed
{
    _isLocationSucceed = YES;
}

- (NSUInteger)speed
{
    return _step;
}

- (void)locationChanged
{
    _curIdx += _step;
    if (_curIdx > [self.locationList count]) {
        _curIdx -= [self.locationList count];
    }
    
    CLLocation *newLocation = [self.locationList objectAtIndex:_curIdx];
    
    if (_isLocationSucceed) {
        if ([_delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)])
        {
            [_delegate locationManager:_manager didUpdateToLocation:newLocation fromLocation:nil];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(locationManager:didFailWithError:)])
        {
            [_delegate locationManager:_manager didFailWithError:nil];
        }
    }
    
}

@end
