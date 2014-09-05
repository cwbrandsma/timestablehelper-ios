//
//  StarsTableViewCell.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 5/24/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "StarsTableViewCell.h"


@implementation StarsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float height = self.frame.size.height;
        float pWidth = self.frame.size.width;
        
        star1 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whitestar64.png"]] retain];
        star1.frame = CGRectMake(pWidth - height*3, 0, height, height);
        star2 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whitestar64.png"]] retain];
        star2.frame = CGRectMake(pWidth - height*2, 0, height, height);
        star3 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whitestar64.png"]] retain];
        star3.frame = CGRectMake(pWidth - height*1, 0, height, height);
        
        [self addSubview:star1];
        [self addSubview:star2];
        [self addSubview:star3];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setStarCount: (int) count{
    [star1 setImage:[UIImage imageNamed:@"whitestar64.png"]];
    [star2 setImage:[UIImage imageNamed:@"whitestar64.png"]];
    [star3 setImage:[UIImage imageNamed:@"whitestar64.png"]];
    
    if (count >= 1) 
        [star1 setImage:[UIImage imageNamed:@"star64.png"]];
    if (count >= 2) 
        [star2 setImage:[UIImage imageNamed:@"star64.png"]];
    if (count >= 3) 
        [star3 setImage:[UIImage imageNamed:@"star64.png"]];
        
}


- (void)dealloc
{
    [super dealloc];
}

@end
