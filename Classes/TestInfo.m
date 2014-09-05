//
//  TestInfo.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "TestInfo.h"
#import "TestValues.h"

@implementation TestInfo
@synthesize number, rounds;
@synthesize startTime, stopTime;
@synthesize incorrectCount, problemTimes;




-(void) setTestType:(int) value {
    testType = value;
}

-(int) testType {
    return testType;
}


-(void)dealloc {
    [problemTimes release];
	[startTime release];
	[stopTime release];
	[super dealloc];
}

BOOL isNextToSameNumber(NSMutableArray *array, int oldPos, int newPos) {
	int count = [array count];
	int iVal = [[array objectAtIndex:oldPos] intValue];
	int newVal = [[array objectAtIndex:newPos] intValue];
	
	
	if (newPos < count-1){
		int otherValue = [[array objectAtIndex:newPos+1] intValue];
		if (iVal == otherValue) {
			return YES;
		}
	} 
	if (newPos > 0) {
		int otherValue = [[array objectAtIndex:newPos-1] intValue];
		if (iVal == otherValue)
			return YES;
	} 
	
	
	if (oldPos < count-1){
		int otherValue = [[array objectAtIndex:oldPos+1] intValue];
		if (newVal == otherValue) {
			return YES;
		}
	} 
	if (oldPos > 0) {
		int otherValue = [[array objectAtIndex:oldPos-1] intValue];
		if (newVal == otherValue)
			return YES;
	} 
		
	return NO;
}


-(NSArray *) randomizeValueArray: (NSMutableArray *) array{
	int count = [array count];
	for (int i = count-1; i>0; i--) {
		int newPos = -1;
		do {
			newPos = arc4random() % count;
		} while (isNextToSameNumber(array, i, newPos));
		
		[array exchangeObjectAtIndex:i withObjectAtIndex:newPos];
	}		
	return array;
}

-(NSArray *) createValueArray {
	int capacity = 9 * rounds;
	NSMutableArray *v1Array = [NSMutableArray arrayWithCapacity:capacity];
	
	// setup values to test against
	for (int r = 0; r < rounds; r++) {
		for (int v = 1; v < 10; v++) {
			[v1Array addObject: [NSNumber numberWithInt:v]];
		}
	}
	
	if (testType >= 2) {
		[self randomizeValueArray:v1Array];
	}
	return v1Array;
}

-(NSArray *) setupTest {

	NSArray *valueArray = [self createValueArray];

	int capacity = 9 * rounds;
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:capacity];

	for (int i = 0; i < capacity; i++) {
		TestValues *value = [[TestValues alloc] init];
		value.value1 = [[valueArray objectAtIndex:i] intValue];
		value.value2 = number;
		value.answer = value.value1 * value.value2;
		
		[array addObject: value];
		[value release];
	}
	return array;
}


@end
