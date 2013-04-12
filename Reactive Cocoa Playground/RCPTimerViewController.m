//
//  RCPTimerViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 4/12/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPTimerViewController.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPTimerViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *resultsField;
@property(retain) NSMutableString *results;
@property(assign) NSUInteger counter;
@end

@implementation RCPTimerViewController

-(id)init {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if(!self) return nil;
	
	_results = [NSMutableString new];
	_counter = 1;
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (!self) return nil;
    
	_results = [NSMutableString new];
	_counter = 1;
	
    return self;
}

-(void)awakeFromNib {
	@unsafeify(self);
	[[[RACSignal interval:1.0] take:15] subscribeNext:^(id x) {
		@strongify(self);
		[self.results appendFormat:@"Tick %lu...\n",self.counter++];
		[self.resultsField setString:self.results];
	}];
}

@end
