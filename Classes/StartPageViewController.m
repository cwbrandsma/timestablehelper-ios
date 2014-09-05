    //
//  StartPageViewController.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StartPageViewController.h"
#import "TestInfo.h"
#import "MultiplyViewController.h"
#import "TimesTableViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "FlurryAnalytics.h"

@implementation StartPageViewController
@synthesize number1, number2, number3, number4, number5, number6, number7, number8, number9;
@synthesize numbersView, roundsView, modeView;
@synthesize round1, round2, round3, round4;
@synthesize modeLearn, modePractice, modeTest, modeMissing;


-(void) unselectButton: (UIButton *) btn {
	[btn setAlpha:0.5F];
	btn.selected = NO;
}
-(void) selectButton: (UIButton *) btn {
	[btn setAlpha:1.0F];
	btn.selected = YES;
}


-(IBAction) startClick {
	TestInfo *info = [[[TestInfo alloc] init] autorelease];
	info.number = selectedNumber;
	info.testType = modeValue;
	info.rounds = roundValue;
    info.problemTimes = [NSMutableArray array];
    
//    [FlurryAnalytics logEvent:[NSString stringWithFormat:@"Started: Number %d, Type %d, Rounds %d",
//                               info.number, info.testType, info.rounds]];
	
	NSString * nibNameOrNil = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		nibNameOrNil = @"MultiplyViewController_IPhone";
	MultiplyViewController *view = [[MultiplyViewController alloc] initWithNibName:nibNameOrNil bundle:nil];
	view.testInfo = info;
	
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//	NSLog(nibNameOrNil);
	//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	//	nibNameOrNil = @"StartPageViewController_IPhone";
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// Custom initialization
	}
	
    return self;
}


-(void) makeViewPretty: (UIView *) aView {
	aView.layer.cornerRadius = 10;
	aView.layer.borderColor = [[UIColor brownColor] CGColor];
	aView.layer.borderWidth = 5;
	
}

- (void) loadView {
    [super loadView];
    self.view.frame = [UIScreen mainScreen].bounds;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	
	[self makeViewPretty: modeView];
	[self makeViewPretty: roundsView];
	[self makeViewPretty: numbersView];
	
	[self selectButton:modeLearn];
	[self selectButton:round4];
	[self selectButton:number1];
	modeValue = 0;
	roundValue = 4;
	selectedNumber = 1;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//	else {
//		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction) viewTimesTableClick{
	TimesTableViewController *videoView = [[TimesTableViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
	videoView.modalTransitionStyle=UIModalTransitionStylePartialCurl;	
	[self presentModalViewController:videoView animated:YES];
}

-(IBAction) numberClick: (id) sender {	
	[self unselectButton:number1];
	[self unselectButton:number2];
	[self unselectButton:number3];
	[self unselectButton:number4];
	[self unselectButton:number5];
	[self unselectButton:number6];
	[self unselectButton:number7];
	[self unselectButton:number8];
	[self unselectButton:number9];

	UIButton *btn = (UIButton*)sender;
	[self selectButton:btn];	
	selectedNumber = [btn.titleLabel.text intValue];
}
-(IBAction) modeClick: (id) sender {
	[self unselectButton:modeLearn];
	[self unselectButton:modePractice];
	[self unselectButton:modeTest];
    [self unselectButton:modeMissing];
	
	UIButton *btn = (UIButton*)sender;
	[self selectButton:btn];
	modeValue = btn.tag;
}

-(IBAction) roundClick: (id) sender{
	[self unselectButton:round1];
	[self unselectButton:round2];
	[self unselectButton:round3];
	[self unselectButton:round4];

	UIButton *btn = (UIButton*)sender;
	[self selectButton:btn];
	
	roundValue = [btn.titleLabel.text intValue];
}


@end
