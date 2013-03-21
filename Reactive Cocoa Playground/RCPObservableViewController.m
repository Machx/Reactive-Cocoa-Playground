//
//  RCPObservableViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/21/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPObservableViewController.h"

@interface RCPObservableViewController ()

@end

@implementation RCPObservableViewController

-(id)init {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if(!self) return nil;
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
	//Array Sequence
	NSArray *array = @[ @42, @54, @64, @93, @100, @102, @50 ];
	
	[[[array rac_sequence] signal] subscribeNext:^(id x) {
		NSLog(@"Next Number: %@",x);
	} completed:^{
		NSLog(@"Completed Enumeration");
	}];
	
	//Observable that returns immediately
	[[RACSignal return:@4] subscribeNext:^(id x) {
		NSLog(@"Return Obserable received: %@",x);
	} completed:^{
		NSLog(@"Return Observable completed");
	}];
	
	//Empty Signal
	[[RACSignal empty] subscribeNext:^(id x) {
		NSLog(@"Empty Signal Received: %@",x);
	} completed:^{
		NSLog(@"Empty Signal Completed");
	}];
}

@end
