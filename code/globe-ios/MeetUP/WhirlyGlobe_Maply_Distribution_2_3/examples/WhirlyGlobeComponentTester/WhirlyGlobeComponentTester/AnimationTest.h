//
//  AnimationTest.h
//  WhirlyGlobeComponentTester
//
//  Created by Steve Gifford on 7/31/13.
//  Copyright (c) 2013 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhirlyGlobeComponent.h"

/** The animation test object runs a sphere around the globe
    over a defined time period.
  */
@interface AnimatedSphere : MaplyActiveObject

/// Initialize with period (amount of time for one orbit), radius and color of the sphere and a starting point
- (id)initWithPeriod:(float)period radius:(float)radius color:(UIColor *)color viewC:(MaplyBaseViewController *)viewC;

@end
