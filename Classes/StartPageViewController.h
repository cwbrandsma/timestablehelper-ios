//
//  StartPageViewController.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartPageViewController : UIViewController {
	UIView *numbersView;
	UIView *roundsView;
	UIView *modeView;
	
	UIButton *modeLearn;
	UIButton *modePractice;
	UIButton *modeTest;
    UIButton *modeMissing;
	
	UIButton *round1;
	UIButton *round2;
	UIButton *round3;
	UIButton *round4;
	
	UIButton *number1;
	UIButton *number2;
	UIButton *number3;
	UIButton *number4;
	UIButton *number5;
	UIButton *number6;
	UIButton *number7;
	UIButton *number8;
	UIButton *number9;
	
	int selectedNumber;
	int modeValue;
	int roundValue;
	
}
@property (nonatomic, retain) IBOutlet UIView *numbersView;
@property (nonatomic, retain) IBOutlet UIView *roundsView;
@property (nonatomic, retain) IBOutlet UIView *modeView;

@property (nonatomic, retain) IBOutlet UIButton *modeLearn;
@property (nonatomic, retain) IBOutlet UIButton *modePractice;
@property (nonatomic, retain) IBOutlet UIButton *modeTest;
@property (nonatomic, retain) IBOutlet UIButton *modeMissing;


@property (nonatomic, retain) IBOutlet UIButton *round1;
@property (nonatomic, retain) IBOutlet UIButton *round2;
@property (nonatomic, retain) IBOutlet UIButton *round3;
@property (nonatomic, retain) IBOutlet UIButton *round4;

@property (nonatomic, retain) IBOutlet UIButton *number1;
@property (nonatomic, retain) IBOutlet UIButton *number2;
@property (nonatomic, retain) IBOutlet UIButton *number3;
@property (nonatomic, retain) IBOutlet UIButton *number4;
@property (nonatomic, retain) IBOutlet UIButton *number5;
@property (nonatomic, retain) IBOutlet UIButton *number6;
@property (nonatomic, retain) IBOutlet UIButton *number7;
@property (nonatomic, retain) IBOutlet UIButton *number8;
@property (nonatomic, retain) IBOutlet UIButton *number9;



-(IBAction) startClick;
-(IBAction) viewTimesTableClick;

-(IBAction) numberClick: (id) sender;
-(IBAction) modeClick: (id) sender;
-(IBAction) roundClick: (id) sender;
@end
