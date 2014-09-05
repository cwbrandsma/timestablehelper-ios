//
//  TestInfo.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TestInfo : NSObject {
	int testType;
	int number;
	int rounds;
	NSDate *startTime;
	NSDate *stopTime;
    
    // metrics
    int incorrectCount;
    NSMutableArray *problemTimes;
}

@property int testType;
@property int number;
@property int rounds;

@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *stopTime;

// metrics
@property int incorrectCount;
@property (nonatomic, retain) NSMutableArray *problemTimes;

-(NSArray *) setupTest;

@end
