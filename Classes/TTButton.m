//
//  TTButton.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 9/3/14.
//  Copyright (c) 2014 DiamondB Software. All rights reserved.
//

#import "TTButton.h"

@implementation TTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    layer.cornerRadius = 2.0f;
    layer.borderWidth = 5;
//    layer.borderColor = [UIColor colorWithRed:0.77f green:0.43f blue:0.43f alpha:1.00f].CGColor;
    layer.borderColor = [UIColor colorWithRed:0.87 green:0.75 blue:0.60 alpha:1.0].CGColor;
    layer.backgroundColor = [UIColor colorWithRed:0.97 green:0.94 blue:0.89 alpha:1.0].CGColor;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}


@end
