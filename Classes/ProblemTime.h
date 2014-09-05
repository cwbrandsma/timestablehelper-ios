//
//  ProblemTime.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 5/11/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestValues.h"


@interface ProblemTime : NSObject {
    NSNumber* interval;
    TestValues *problem;
}

@property (nonatomic, retain) NSNumber *interval;
@property (nonatomic, retain) TestValues *problem;


@end
