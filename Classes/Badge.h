//
//  Badge.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 5/11/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Badge : NSObject {
    NSString *name;
    NSString *image;
    NSString *desc;
    NSNumber *stars;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) NSNumber *stars;
@end
