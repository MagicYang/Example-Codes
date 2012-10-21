//
//  LocationMock.h
//  GPSTest
//
//  Created by MagicYang on 10/21/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationMock : NSObject

// CLLocation list
@property(nonatomic, retain) NSArray *locationList;
@property(nonatomic, assign) NSTimeInterval interval;
@property(nonatomic, readonly, getter = speed) NSUInteger speed;

- (id)initWithDelegate:(id<CLLocationManagerDelegate>)delegate
  andCLLocationManager:(CLLocationManager *)manager;

- (void)startWithLocationList:(NSArray *)locationList;
- (void)stop;

- (void)mockSpeedUp;
- (void)mockSpeedDown;
- (void)mockGPSFailed;
- (void)mockGPSSucceed;

@end