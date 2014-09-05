//
//  FinishViewController.h
//  DyslexicMath
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestInfo.h"
#import <AVFoundation/AVFoundation.h>


@interface FinishViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	TestInfo *testInfo;
	UILabel *paramsLabel;
    UILabel *titleLabel;
	AVAudioPlayer* theAudio;
    
    NSMutableArray *badgeData;
    NSMutableArray *workonData;
    UITableView *badgeTable;
}

@property (nonatomic, retain) TestInfo *testInfo;
@property (nonatomic, retain) NSMutableArray *badgeData;
@property (nonatomic, retain) NSMutableArray *workonData;

@property (nonatomic, retain) IBOutlet UILabel *paramsLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) AVAudioPlayer* theAudio;
@property (nonatomic, retain) IBOutlet UITableView *badgeTable;

-(IBAction) click;
@end
