//
//  TestValues.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TestValues : NSObject {
	int value1;
	int value2;
	int answer;
}

@property int value1;
@property int value2;
@property int answer;

-(NSString *) toString;

@end
