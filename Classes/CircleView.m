//
//  CircleView.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/14/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "CircleView.h"


@implementation CircleView


- (id)initWithFrame:(CGRect)frame {
//	self.opaque = YES;
  if ((self = [super initWithFrame:frame])) {
	  self.backgroundColor = [UIColor clearColor];
  }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


- (void)drawRect:(CGRect)rect {
	/*
	CGContextRef contextRef = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(contextRef, 250, 250, 255, 0.1);
	CGContextSetRGBStrokeColor(contextRef, 250, 250, 255, 0.5);
	
	// Draw a circle (filled)
	CGContextFillEllipseInRect(contextRef, rect);
	
	// Draw a circle (border only)
	//CGContextStrokeEllipseInRect(contextRef, rect);
	*/
	
	// Get the graphics context and clear it
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextClearRect(ctx, rect);
	
	// Draw a green solid circle
	CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
//	CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 12, 12));
	CGContextFillEllipseInRect(ctx, rect);
	 
	/*
	// Draw a yellow hollow rectangle
	CGContextSetRGBStrokeColor(ctx, 255, 255, 0, 1);
	CGContextStrokeRect(ctx, CGRectMake(195, 195, 60, 60));
	
	// Draw a purple triangle with using lines
	CGContextSetRGBStrokeColor(ctx, 255, 0, 255, 1);
	CGPoint points[6] = { CGPointMake(100, 200), CGPointMake(150, 250),
		CGPointMake(150, 250), CGPointMake(50, 250),
		CGPointMake(50, 250), CGPointMake(100, 200) };
	CGContextStrokeLineSegments(ctx, points, 6);
	*/
}

@end
