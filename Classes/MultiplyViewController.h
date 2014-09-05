//
//  MultiplyViewController.h
//  DyslexicMath
//
//  Created by Chris Brandsma on 6/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestInfo.h"
#import <AVFoundation/AVFoundation.h>

@interface MultiplyViewController : UIViewController {
	TestInfo *testInfo;
	NSArray *testValues;
	int testIndex;
	
	UILabel *value1;
	UILabel *value2;
	UILabel *answer;
	UILabel *correctCount;
	AVAudioPlayer* theAudio;
	AVAudioPlayer *answerAudio;
	UIImageView *answerImage;
	UIButton *timesTableButton;
	UIView *starsView;
    UIButton *speakProblemButton;
    
    //metrics
    NSDate *problemStarted;
}

@property (nonatomic, retain) IBOutlet UILabel *value1;
@property (nonatomic, retain) IBOutlet UILabel *value2;
@property (nonatomic, retain) IBOutlet UILabel *answer;
@property (nonatomic, retain) IBOutlet UILabel *correctCount;
@property (nonatomic, retain) IBOutlet UIImageView *answerImage;
@property (nonatomic, retain) IBOutlet UIButton *timesTableButton;
@property (nonatomic, retain) IBOutlet UIButton *speakProblemButton;

@property (nonatomic, retain) IBOutlet UIView *starsView;

@property (nonatomic,retain) TestInfo *testInfo;
@property (nonatomic, retain) NSArray *testValues;

@property (nonatomic, retain) AVAudioPlayer* theAudio;
@property (nonatomic, retain) AVAudioPlayer* answerAudio;

@property (nonatomic, retain) NSDate *problemStarted;

-(IBAction) numberClick: (id) sender;
-(IBAction) enterClick;
-(IBAction) returnClick;
-(IBAction) viewTimesTableClick;
-(IBAction) speakProblemClick;
-(IBAction) answerClear:(id)sender;

@end
