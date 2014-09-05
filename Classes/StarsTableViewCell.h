//
//  StarsTableViewCell.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 5/24/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StarsTableViewCell : UITableViewCell {
    UIImageView *star1;
    UIImageView *star2;
    UIImageView *star3;
}

-(void) setStarCount: (int) count;
@end
