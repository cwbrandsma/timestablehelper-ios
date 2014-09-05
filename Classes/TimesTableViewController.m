    //
//  TimesTableViewController.m
//  TimeTableHelper
//
//  Created by Chris Brandsma on 8/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TimesTableViewController.h"
#import "CircleView.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
//#import "FlurryAnalytics.h"

@interface TimesTableViewController ()
-(void) visualizeNumber: (int) number;
@end

@implementation TimesTableViewController

@synthesize 
	visualizeView,
	multiplierLabel,
	visualizeParent,
	answerAudio;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	visualizeParent.hidden = YES;
	visualizeParent.layer.cornerRadius = 10;
	visualizeParent.layer.borderColor = [[UIColor blackColor] CGColor];
	visualizeParent.layer.borderWidth = 5;
	
	visualizeView.layer.cornerRadius = 8;
	visualizeView.layer.borderColor = [[UIColor blackColor] CGColor];
	visualizeView.layer.borderWidth = 2;
    
    [self visualizeNumber: 1];
}


-(void) clearViualizer {
	for (UIControl *ctrl in [self.visualizeView subviews]) {
		[ctrl removeFromSuperview];
	}
}

-(UIView *) createTemplate: (int) number {
	UIView *view = [[[UIView alloc] init] autorelease];
	const int gemSize = 12;
	const int gemSpace = 4;
	for (int i=0; i<number; i++) {
		UIView *gem = [[CircleView alloc] init];
		gem.frame = CGRectMake(0, gemSize*i + gemSpace*i, gemSize-4, gemSize);		
		[view addSubview:gem];
		[gem release];
	}
	
	return view;
}

-(void) visualizeNumber: (int) number {
	visualizeParent.hidden = NO;
	[self clearViualizer];
	self.multiplierLabel.text = [NSString stringWithFormat:@"%d", number];
	
	int xPos = 5;
	for (int i = 0; i < 9; i++) {
		for (int j = 0; j < i; j++) {
			UIView *mygem =[self createTemplate: number];
			mygem.backgroundColor = [UIColor clearColor];
			mygem.frame = CGRectMake(xPos, 4, 100, 100);
			
			[self.visualizeView addSubview:mygem];
			xPos = xPos + 14;
		}
		xPos=xPos+15;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return  UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	visualizeView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[visualizeView release];
	[answerAudio release];
    [super dealloc];
}

-(IBAction) hideClick {
	[self dismissModalViewControllerAnimated:YES];
}


-(IBAction) numberClick: (id) sender{
	UIButton *btn = (UIButton *) sender;
	int number = [btn.titleLabel.text intValue];
	
	[self visualizeNumber: number];
}

#pragma mark -
#pragma mark Answer Click stuff

-(IBAction) speakProblemAndAnswer: (NSString *) fileName {
	NSLog(@"Playing file: %@", fileName);
	NSString * path = [[NSBundle mainBundle] pathForResource: fileName ofType: @"mp3"];
	
	if (answerAudio != nil) {
		[answerAudio stop];
	}
	
	answerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil];
	[answerAudio prepareToPlay];
	[answerAudio play];	
}


-(IBAction) answerClick: (id) sender {
	UIButton *btn = (UIButton *) sender;
	int tag = btn.tag;
	
    @try {
        NSString *number = [NSString stringWithFormat:@"%d", tag];
        //	NSLog([number length]);
        NSString *p3 = [number substringWithRange:NSMakeRange(2, [number length]-2)];
        NSString *p2 = [number substringWithRange:NSMakeRange(1, 1)];
        NSString *p1 = [number substringToIndex:1];
        
        //	NSString *p3 = [number substringFromIndex:1];
        NSString *fileName = [NSString stringWithFormat: @"%@-%@-%@", p1, p2, p3];
        
        [self speakProblemAndAnswer:fileName];
    }
    @catch (NSException *exception) {
        //[FlurryAnalytics logError:@"Uncaught" message:@"Sound Error" exception:exception];

    }
    
}


@end
