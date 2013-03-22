//
//  RCPTaskViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPTaskViewController.h"
#import "NSTask+RACSupport.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPTaskViewController ()
@property(nonatomic, retain) NSTask *task;
@property(atomic, retain) NSMutableString *results;
@property(nonatomic, unsafe_unretained) IBOutlet NSTextView *resultsTextView;
@end

static NSString *const kResultFieldFont = @"Menlo";
static CGFloat const kResultFieldFontSize = 12.0;

@implementation RCPTaskViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
						   bundle:[NSBundle mainBundle]];
    if (!self) return nil;
	
	_results = [NSMutableString new];
	
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
	if (!self) return nil;
	
	_results = [NSMutableString new];
    
    return self;
}

-(void)awakeFromNib {
	//@unsafeify(self); uncomment if using 1st method...
	
	[self.resultsTextView setFont:[NSFont fontWithName:kResultFieldFont size:kResultFieldFontSize]];
	[self.resultsTextView setAutomaticSpellingCorrectionEnabled:NO];
	
	self.task = [[NSTask alloc] init];
	[self.task setLaunchPath:@"/bin/ls"];
	[self.task setStandardOutput:[NSPipe pipe]];
	[self.task setStandardError:[NSPipe pipe]];
	[self.task setCurrentDirectoryPath:NSHomeDirectory()];
	
	
	/**
	 You can launch a task and read its output this way. Here the task has a RACSignal
	 for its standard output and error
	 */
//	[self.task.rac_standardOutput subscribeNext:^(id x) {
//		@strongify(self);
//		NSString *result = [[NSString alloc] initWithData:x
//												 encoding:NSUTF8StringEncoding];
//		[self.results appendString:result];
//		[self.resultsTextView setString:self.results];
//	}];
//	
//	[self.task.rac_standardError subscribeNext:^(id x) {
//		@strongify(self);
//		NSString *result = [[NSString alloc] initWithData:x
//												 encoding:NSUTF8StringEncoding];
//		[self.results appendString:result];
//		[self.resultsTextView setString:self.results];
//	}];
//	
//	[self.task launch];
	//end first way to launch a task
	
	/**
	 or you can run it this way...
	 Here we are using rac_runWithScheduler and passing [RACScheduler scheduler] to
	 run it on a background thread. You could also just do rac_run which will run it
	 on whatever thread you are on, which here is the main thread...
	 */
	[[self.task rac_runWithScheduler:[RACScheduler scheduler]] subscribeNext:^(id x) {
		NSString *result = [[NSString alloc] initWithData:x
												 encoding:NSUTF8StringEncoding];
		[[RACScheduler mainThreadScheduler] schedule:^{
			[self.results appendString:result];
			[self.resultsTextView setString:self.results];
		}];
	} error:^(NSError *error) {
		[[RACScheduler mainThreadScheduler] schedule:^{
			[self.results appendString:[error description]];
			[self.resultsTextView setString:self.results];
		}];
	} completed:^{
		[[RACScheduler mainThreadScheduler] schedule:^{
			[self.results appendString:@"\n\n...Task Finished."];
			[self.resultsTextView setString:self.results];
		}];
	}];
}

@end
