//
//  RCPObservableViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/21/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPObservableViewController.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPObservableViewController ()
@property (nonatomic,retain) NSMutableString *result;
@property (unsafe_unretained) IBOutlet NSTextView *resultField;
@end

@implementation RCPObservableViewController

-(id)init {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if(!self) return nil;
	
	_result = [NSMutableString string];
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self) return nil;
	
	_result = [NSMutableString string];
    
    return self;
}

-(void)awakeFromNib {
	@unsafeify(self);
	
	//Array Sequence
	NSArray *numbers = @[ @42, @54, @64, @93, @100, @102, @50 ];
	
	[[[numbers rac_sequence] signal] subscribeNext:^(id x) {
		@strongify(self)
		@synchronized(self.result) {
			[self.result appendFormat:@"Next Number: %@\n", x];
			[self.resultField setString:self.result];
		}
	} completed:^{
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendString:@"Completed Sequence Enumeration\n"];
			[self.resultField setString:self.result];
		}
	}];
	
	/**
	 Demonstrate concatenated sequence
	 Create 2 arrays of objects and concatenate them together and 
	 subscribe to the result of that concatenation
	 */
	NSArray *numbers2 = @[ @5, @15, @30, @55, @92 ];
	NSArray *strings = @[ @"Zangetsu", @"Zabimaru", @"Tenken", @"Senbonzakura" ];
	
	RACSequence *numbersSequence = numbers2.rac_sequence;
	RACSequence *stringsSequence = strings.rac_sequence;
	RACSequence *concatenatedSequence = [numbersSequence concat:stringsSequence];
	
	RACSignal *concatenatedSignal = [[concatenatedSequence signal] deliverOn:[RACScheduler mainThreadScheduler]];
	
	[concatenatedSignal subscribeNext:^(id x) {
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendFormat:@"Concatenated Sequence: %@\n",x];
			[self.resultField setString:self.result];
		}
	}];
	
	//Observable that returns immediately
	[[RACSignal return:@4] subscribeNext:^(id x) {
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendFormat:@"Received Return Value: %@\n",x];
			[self.resultField setString:self.result];
		}
	} completed:^{
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendString:@"Return Value Completed\n"];
			[self.resultField setString:self.result];
		}
	}];
	
	//Empty Signal
	[[RACSignal empty] subscribeNext:^(id x) {
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendFormat:@"Empty Signal Received: %@\n",x];
			[self.resultField setString:self.result];
		}
	} completed:^{
		@strongify(self);
		@synchronized(self.result) {
			[self.result appendString:@"Empty Signal Completed\n"];
			[self.resultField setString:self.result];
		}
	}];
}

@end
