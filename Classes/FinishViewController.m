    //
//  FinishViewController.m
//  DyslexicMath
//
//  Created by Chris Brandsma on 8/7/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "FinishViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TestInfo.h"
#import "Badge.h"
#import "ProblemTime.h"
#import "StarsTableViewCell.h"
//#import "FlurryAnalytics.h"

@implementation FinishViewController
@synthesize testInfo;
@synthesize paramsLabel, titleLabel;
@synthesize theAudio;
@synthesize badgeTable, badgeData, workonData;

#define goldStar @"star64.png"
#define silverStar @"whitestar64.png"
#define badStar @"wrong.png"


#pragma mark - 
#pragma mark Work on Problems



-(void) loadWorkOn {
    self.workonData = [NSMutableArray array];
    
    for (ProblemTime *t in self.testInfo.problemTimes) {
        double d = [t.interval doubleValue];
        if (d > 8) {
            Badge *b = [[Badge alloc] init];
            b.name = [t.problem toString];
            b.image = badStar;
            [self.workonData addObject:b];
            [b release];
        }        
    }
}

#pragma mark -
#pragma mark Badges

-(Badge *) createBadge: (NSString *) name: (NSString *) image: (NSString *) desc: (int) stars {
    Badge *b = [[[Badge alloc] init] autorelease];
    b.name = name;
    b.image = image;
    b.desc = desc;
    b.stars = [NSNumber numberWithInt:stars];
    return b;
}

-(Badge *) createBadge: (NSString *) name: (NSString *) image: (NSString *) desc {
    Badge *b = [[[Badge alloc] init] autorelease];
    b.name = name;
    b.image = image;
    b.desc = desc;
    
    return b;
}

-(void) speedyBadge {
    NSTimeInterval interval = [self.testInfo.stopTime timeIntervalSinceDate: self.testInfo.startTime];
    int seconds = interval;
    int problems = self.testInfo.rounds*10;
    NSLog(@"%d - %d", seconds, problems);
    
    int average = seconds / problems;
    if (average < 2){
        [badgeData addObject:[self createBadge:@"Speed" :goldStar :@"Averaged under 2 seconds": 3]];
    }
    else if (average < 5){
        [badgeData addObject:[self createBadge:@"Speed" :silverStar :@"Averaged under 5 seconds": 2]];
    }
    else {
        [badgeData addObject:[self createBadge:@"Speed" :@"" :@"Averaged under 5 seconds": 1]];
        
    }
}

-(void) perfectionBadge {
    if (self.testInfo.incorrectCount == 0) {
        [badgeData addObject:[self createBadge:@"Mistakes" :goldStar :@"No Wrong answers": 3]];
    } else {
        if ((self.testInfo.rounds == 4 && self.testInfo.incorrectCount < 4)
            ||(self.testInfo.rounds == 3 && self.testInfo.incorrectCount < 3)
            || (self.testInfo.rounds == 2 && self.testInfo.incorrectCount < 2)
            || (self.testInfo.rounds == 1 && self.testInfo.incorrectCount < 1)
            ) {
            [badgeData addObject:[self createBadge:@"Mistakes" :silverStar :@"Less than one wrong answers per round": 2]];
            
        } else {
            [badgeData addObject:[self createBadge:@"Mistakes" :@"" :@"More than one wrong answers per round": 1]];
            
        }
    }
}

-(void) consistencyBadge {
    BOOL allUnder2 = YES;
    BOOL allUnder5 = YES;
    
    for (ProblemTime *n in self.testInfo.problemTimes) {
        double d = [n.interval doubleValue];
        if (d > 2)
            allUnder2 = NO;
        if (d > 5){
            allUnder5 = NO;
            break;
        }
    }
    
    if (allUnder2) {
        [badgeData addObject:[self createBadge:@"Pace" :goldStar :@"All answered in under 2 seconds":3]];
    } else if (allUnder5) {
        [badgeData addObject:[self createBadge:@"Pace" :silverStar :@"All answered in under 5 seconds": 2]];        
    } else {
        [badgeData addObject:[self createBadge:@"Pace" :@"" :@"All answered in over 5 seconds": 1]];                
    }
}


-(void) loadBadges {
    self.badgeData = [NSMutableArray array];
    [self speedyBadge];
    [self perfectionBadge];
    [self consistencyBadge];
}


#pragma mark -

-(NSString *) parseTime {
	NSTimeInterval interval = [self.testInfo.stopTime timeIntervalSinceDate: self.testInfo.startTime];
	
    int seconds = interval;
    int minutes = interval / 60;
    if (minutes > 0) {
        seconds = seconds - (minutes * 60);
        if (seconds < 10)
            return 	[NSString stringWithFormat: @"%d:0%d minutes", minutes, seconds];
        else
            return 	[NSString stringWithFormat: @"%d:%d minutes", minutes, seconds];
    } else {
        return 	[NSString stringWithFormat: @"%d seconds", seconds];        
    }
    
}

-(NSString *) parseMode {
    switch (self.testInfo.testType) {
        case 0: return @"Learn";
        case 1: return @"Practice";
        case 2: return @"Test";
        case 3: return @"Missing";
    
    }
    return @"";
}

-(void) loadParamsLabel {
	NSString *seconds = [self parseTime];
	NSString *testMode = [self parseMode];
	NSString *rounds = self.testInfo.rounds == 1?@"round":@"rounds";
	NSString *msg = [NSString stringWithFormat: @"You completed %d %@ for number %d in %@ mode in %@", 
					 self.testInfo.rounds,
					 rounds,
					 self.testInfo.number,
					 testMode,
					 seconds];
    

	paramsLabel.text = msg;
	
}

-(void) playSound: (NSString*) value {
	NSString * path = [[NSBundle mainBundle] pathForResource: value ofType: @"wav"];
	theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:path] error: nil];
	[theAudio prepareToPlay];
	[theAudio play];	
}

-(void) loadTitleLabel {
    NSTimeInterval interval = [self.testInfo.stopTime timeIntervalSinceDate: self.testInfo.startTime];
    int seconds = interval;
    int problems = self.testInfo.rounds*10;
    NSLog(@"%d - %d", seconds, problems);
    
    int average = seconds / problems;
    if (average < 5)
        titleLabel.text = @"Awesome Job!";
    else if (average < 10)
        titleLabel.text = @"Great Job!";
    else
        titleLabel.text = @"Good Job!";
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self loadTitleLabel];
	[self loadParamsLabel];
    [self loadBadges];
    [self loadWorkOn];
    [self.badgeTable reloadData];
	[self playSound:@"yay"];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
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
}


- (void)dealloc {
    [badgeData release];
    [badgeTable release];
	[theAudio release];
	[testInfo release];
    [titleLabel release];
    [paramsLabel release];
    
    [super dealloc];
}

-(IBAction) click {
	//[self.view removeFromSuperview];
	[self.navigationController popToRootViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([self.workonData count] > 0) {
        return 2;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) 
        return [badgeData count];
    else
        return [workonData count];
}

// Provide a title for the section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0)
        return @"Awards";
    return @"Trouble Spots";
}

-(UITableViewCellAccessoryType) cellAccessoryType: (NSIndexPath *) indexPath {
	return UITableViewCellAccessoryDisclosureIndicator;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BadgeCell";
    static NSString *StarsIdentifier = @"StarCell";
    
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    NSString *cellType = section==0?StarsIdentifier:CellIdentifier;
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
    if (cell == nil) {
        if (section == 0)
            cell = [[[StarsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StarsIdentifier] autorelease];
        else
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (section == 0) {
        StarsTableViewCell *starCell = (StarsTableViewCell *) cell;
        Badge *b = [badgeData objectAtIndex:row];
        
        cell.textLabel.text = b.name;
//        cell.imageView.image = [UIImage imageNamed:b.image];
        [starCell setStarCount: [b.stars intValue]];
    } else {
        Badge *b = [workonData objectAtIndex:row];
        
        cell.textLabel.text = b.name;
        cell.imageView.image = [UIImage imageNamed:b.image];
        
    }
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60.0)] autorelease];

    
    UIColor *backgroundColor = [UIColor colorWithRed:0.796078431372549 green:0.55859375 blue:0.298039215686275 alpha:1.0];
    
    [headerView setBackgroundColor:backgroundColor];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    //THE COLOR YOU WANT:
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    //THE FONT YOU WANT:
    headerLabel.font = [UIFont boldSystemFontOfSize:20];
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
//    headerLabel.backgroundColor = backgroundColor;
    
    // If you want to align the header text as centered
    
    headerLabel.frame = CGRectMake(tableView.bounds.size.width /2-22, 0.0, 300.0, 44.0);

    if (section==0){
        headerLabel.text = @"Awards";
    } else {
        headerLabel.text = @"Trouble Spots";
    }
    
    [headerView addSubview: headerLabel];
    [headerLabel release];

    return headerView;
}

#pragma mark -



@end
