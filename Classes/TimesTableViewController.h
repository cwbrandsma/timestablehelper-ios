//
//  TimesTableViewController.h
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface TimesTableViewController : UIViewController {
	UIView *visualizeView;
	UIView *visualizeParent;
	UILabel *multiplierLabel;
	AVAudioPlayer *answerAudio;	
	
}
@property (nonatomic, retain) IBOutlet UIView *visualizeView;
@property (nonatomic, retain) IBOutlet UILabel *multiplierLabel;
@property (nonatomic, retain) IBOutlet UIView *visualizeParent;
@property (nonatomic, retain) AVAudioPlayer *answerAudio;

-(IBAction) hideClick;
-(IBAction) numberClick: (id) sender;
-(IBAction) answerClick: (id) sender;
@end
