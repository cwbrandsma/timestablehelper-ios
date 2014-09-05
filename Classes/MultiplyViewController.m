    //
//  MultiplyViewController.m
//  DyslexicMath
//
//  Created by Chris Brandsma on 6/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MultiplyViewController.h"
#import "TestValues.h"
#import "FinishViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TimesTableViewController.h"
#import "ProblemTime.h"
//#import "FlurryAnalytics.h"


#define kTypeLearn 0
#define kTypePractice 1
#define kTypeTest 2
#define kTypeMissing 3


@implementation MultiplyViewController
@synthesize testInfo, testValues;
@synthesize value1, value2, answer;
@synthesize correctCount;
@synthesize theAudio;
@synthesize answerAudio;
@synthesize answerImage;
@synthesize timesTableButton;
@synthesize starsView,
    speakProblemButton,
    problemStarted;

#pragma mark Mode Helper
-(BOOL) isLearnMode {
    int tt = self.testInfo.testType; 
    return (tt == kTypeLearn);
}
-(BOOL) isPracticeMode {
    int tt = self.testInfo.testType; 
    return (tt == kTypePractice);
}
-(BOOL) isTestMode {
    int tt = self.testInfo.testType; 
    return (tt == kTypeTest);
}
-(BOOL) isMissingMode {
    int tt = self.testInfo.testType; 
    return (tt == kTypeMissing);
}


#pragma mark -
#pragma mark Sound helpers
-(void) playSound: (NSString*) value {
	if (theAudio != nil)
		[theAudio stop];
	
	NSString * path = [[NSBundle mainBundle] pathForResource: value ofType: @"wav"];
	theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil];
	[theAudio prepareToPlay];
	[theAudio play];	
}

#pragma mark -
#pragma mark Image Helpers

- (void)removeImage:(UIImageView *)imageView {
	[UIView beginAnimations:@"removeImage" context:nil];
	imageView.alpha = 0.0;
	[UIView commitAnimations];
}

-(void) flashImage: (NSString *) imageNamed {
	answerImage.image = [UIImage imageNamed:imageNamed];
	answerImage.alpha = 1.0;
	answerImage.hidden = NO;
	
	[self performSelector:@selector(removeImage:)
			   withObject:answerImage
			   afterDelay:1];
}
-(void) flashStar: (UIImageView *) image {
	[starsView bringSubviewToFront:image];
	float from = 1.2;
	float to = 0.9;
	//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		from = 3.0;
	//}
	
	CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	pulseAnimation.duration = 0.35;
	pulseAnimation.fromValue = [NSNumber numberWithFloat:from];
	pulseAnimation.toValue = [NSNumber numberWithFloat:to];
	pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	pulseAnimation.autoreverses = NO;
	pulseAnimation.repeatCount = 1;
	pulseAnimation.delegate = image;
	[image.layer addAnimation:pulseAnimation forKey:nil];
 	
}

-(void) visualizeCount {
	// clear out the view
	for (UIControl *ctrl in [starsView subviews]) {
		[ctrl removeFromSuperview];
	}
	int starH = 60;
	int starW = 60;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		starH = 30;
		starW = 30;
	}

	
	int mycorrectCount = [correctCount.text intValue];
	
	int i = 0;
	for (int round = 0; round < testInfo.rounds; round++) {
		for (int x = 0; x < 9; x++) {
			NSString *starName = (mycorrectCount-1 >= i)?@"star64.png":@"whitestar64.png";
			UIImage *image = [UIImage imageNamed:starName];
			UIImageView *iview = [[UIImageView alloc] initWithImage:image];
			
			CGFloat posX = x * (starW + 5);
			CGFloat posY = round * (starH-5);
			iview.frame = CGRectMake(posX, posY, starW, starH);
			
			if (mycorrectCount-1 == i) {
				[self flashStar:iview];
			}
			
			[starsView addSubview:iview];
			[iview release];
			
			i++;
		}
	}
	
}

#pragma mark -
#pragma mark Common Methods

-(UILabel *) getAnswerLabel {
    if ([self isMissingMode]) {
        return self.value2;
    }else {
        return self.answer;
    }
}

-(void) highlightAnswerLabel {
    UILabel *label = [self getAnswerLabel];
    
    CALayer *hlayer = [[CALayer alloc] init];
    [hlayer setFrame:CGRectMake(0, 0, label.frame.size.width, label.frame.size.height)];
    
    hlayer.cornerRadius = 5;
    hlayer.borderColor = [[UIColor blackColor] CGColor];
    hlayer.borderWidth = 1;
    hlayer.backgroundColor =[[UIColor whiteColor] CGColor];
    hlayer.opacity = 0.2;
    
    [label.layer insertSublayer:hlayer atIndex:[label.layer.sublayers count]]; 
    [hlayer release];
    
}


-(void) testComplete {
	self.testInfo.stopTime = [NSDate date];

	NSString *nibNameOrNil = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		nibNameOrNil = @"FinishViewController_IPhone";

	FinishViewController *view = [[FinishViewController alloc] initWithNibName:nibNameOrNil bundle:nil];
	view.testInfo = testInfo;
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}

-(IBAction) speakProblemAndAnswer {
	TestValues *test = [self.testValues objectAtIndex:testIndex];
	
	NSString *fileName = [NSString stringWithFormat: @"%d-%d-%d", test.value2, test.value1, test.answer]; 
	NSLog(@"Playing file: %@", fileName);
	NSString * path = [[NSBundle mainBundle] pathForResource: fileName ofType: @"mp3"];
	
	if (answerAudio != nil)
		[answerAudio stop];
	
	answerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil];
	[answerAudio prepareToPlay];
	[answerAudio play];	
	
}

-(void) loadTestValues:(TestValues *)test {
    if ([self isMissingMode]) {
        self.value1.text = [NSString stringWithFormat:@"%d", test.value2];
        self.value2.text = @""; 
        self.answer.text = [NSString stringWithFormat:@"%d", test.answer];
    } else {
        self.value1.text = [NSString stringWithFormat:@"%d", test.value2];
        self.value2.text = [NSString stringWithFormat:@"%d", test.value1];
        self.answer.text = @"";	
    }
}


-(void) loadTest {
	if (testIndex >= [self.testValues count]) {
		[self testComplete];
		return;
	}
    self.problemStarted = [NSDate date];
	correctCount.text = [NSString stringWithFormat:@"%d", testIndex];
	TestValues *test = [self.testValues objectAtIndex:testIndex];
	
	[self loadTestValues: test];
    
    if ([self isLearnMode]) {
		[self speakProblemAndAnswer];
	}
	[self visualizeCount];
}

-(void) checkAnswer {
    UILabel *currentLabel = [self getAnswerLabel];
    
    int maxNumbers = ([self isMissingMode])?1:2;
    
    if ([currentLabel.text length] > maxNumbers){
        currentLabel.text = @"";
        [self playSound:@"blip"];	
    }
}

-(BOOL) isAnswerCorrect {
	TestValues *test = [self.testValues objectAtIndex:testIndex];
    int mode = self.testInfo.testType;
    if (mode != kTypeMissing){
        int currentAnswer = [self.answer.text intValue];	
        return test.answer == currentAnswer;
    } else {
        int currentAnswer = [self.value2.text intValue];	
        NSLog(@"Missing Mode Answer: %d", currentAnswer);
        NSLog(@"Missing Mode Value: %d", test.value1);
        
        return test.value1 == currentAnswer;
    }
}


-(void) clearAnswer {
    if ([self isMissingMode]){
        self.value2.text = @"";
    } else {
        self.answer.text = @"";
    }
}

-(void) recordTime {
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate: self.problemStarted];
    NSNumber *num = [NSNumber numberWithDouble:interval];
    
    ProblemTime *time = [[ProblemTime alloc] init];
    time.interval = num;
    time.problem = [testValues objectAtIndex:testIndex];
    [self.testInfo.problemTimes addObject:time];
    [time release];
}

-(void) validateAnswer {
    if ([self isAnswerCorrect]) {
        [self recordTime];
		testIndex++;
		[self playSound:@"bell"];
		[self flashImage:@"star.png"];
		[self loadTest];
        
	} else {
        testInfo.incorrectCount++;
        [self clearAnswer];
		[self flashImage:@"wrong.png"];
		[self playSound:@"blip"];
	}
}

-(void) appendToAnswer: (int) value {
    if ([self isMissingMode]){
        NSString *answerText = [NSString stringWithFormat:@"%@%d", self.value2.text, value]; 
        self.value2.text = answerText;
    }else {
        NSString *answerText = [NSString stringWithFormat:@"%@%d", self.answer.text, value]; 
        self.answer.text = answerText;
    }
}

#pragma mark -
#pragma mark Gestures
-(IBAction) clear{
	[self clearAnswer];
}	

-(void)clearSwipe:(UIGestureRecognizer *)recognizer {
	[self clear];
}

-(void) setupGestures {
	UISwipeGestureRecognizer *swipeNext = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clearSwipe:)];
	if ([swipeNext respondsToSelector:@selector(setDirection:)]){
		[swipeNext setDirection:UISwipeGestureRecognizerDirectionLeft];
		[self.view addGestureRecognizer:swipeNext];
	}
	[swipeNext release];
	
	UISwipeGestureRecognizer *swipePrev = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clearSwipe:)];
	if ([swipePrev respondsToSelector:@selector(setDirection:)]){
		[swipePrev setDirection:UISwipeGestureRecognizerDirectionRight];
		[self.view addGestureRecognizer:swipePrev];
	}
	[swipePrev release];
    

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearSwipe:)];
    [self.answer addGestureRecognizer:tapGesture];
	[tapGesture release];
    
}

-(IBAction) answerClear:(id)sender {
    [self clear];
}


#pragma mark -
#pragma mark Memory Management


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	testIndex = 0;
	self.testValues = [self.testInfo setupTest];
	self.testInfo.startTime = [NSDate date];
    if ([self isTestMode] || [self isMissingMode]){
		self.timesTableButton.hidden = YES;
        self.speakProblemButton.hidden = YES;
	}
	[self loadTest];
	[self setupGestures];
    [self highlightAnswerLabel];
	
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//		return YES;
//	else {
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
//	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.starsView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [problemStarted release];
	[answerAudio release];
	[timesTableButton release];
	[theAudio release];
	[testInfo release];
	[testValues release];
	[value1 release];
	[value2 release];
	[answer release];
	[starsView release];
    [speakProblemButton release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Click Handlers

-(IBAction) numberClick: (id) sender {
	UIButton *btn = (UIButton*)sender;
	int newValue = btn.tag;
    
    [self appendToAnswer:newValue];
	[self checkAnswer];
}

-(IBAction) enterClick {
    [self validateAnswer];
}

-(IBAction) returnClick {
	[self.navigationController popViewControllerAnimated:YES];	
}

-(IBAction) viewTimesTableClick{
	TimesTableViewController *videoView = [[TimesTableViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
	videoView.modalTransitionStyle=UIModalTransitionStylePartialCurl;	
	[self presentModalViewController:videoView animated:YES];
	
}

-(IBAction) speakProblemClick {
    @try {
        
        NSString *fileName = [NSString stringWithFormat: @"%@-%@", self.value1.text, self.value2.text];
        
        if (answerAudio != nil) 
            [answerAudio stop];
        
        NSString * path = [[NSBundle mainBundle] pathForResource: fileName ofType: @"mp3"];
        answerAudio = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil];
        [answerAudio prepareToPlay];
        [answerAudio play];	
    }
    @catch (NSException *exception) {
//        [FlurryAnalytics logError:@"Uncaught" message:@"Sound Error" exception:exception];
        
    }

}

@end
