//
//  TestValues.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestValues.h"


@implementation TestValues
@synthesize value1, value2, answer;

-(NSString*) toString {
    return [NSString stringWithFormat:@"%d * %d = %d", value1, value2, answer];
}

@end
