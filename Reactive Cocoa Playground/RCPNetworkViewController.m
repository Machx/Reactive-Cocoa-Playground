//
//  RCPNetworkViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPNetworkViewController.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPNetworkViewController ()
@property(nonatomic,unsafe_unretained) IBOutlet NSTextView *resultsField;
@property(nonatomic,retain) NSString *url;
@end

@implementation RCPNetworkViewController

-(id)initWithURLAddress:(NSString *)address {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if (!self) return nil;
	
	_url = address;
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
	[self.resultsField setFont:[NSFont fontWithName:@"Menlo" size:12.0]];
	[self.resultsField setAutomaticSpellingCorrectionEnabled:NO];
	
	__block RCPNetworkViewController *bself = self;
	[[[self networkLoad] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
		[bself.resultsField setString:x];
	}];
}

-(RACSignal *)networkLoad {
	@unsafeify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);
		NSError *error;
		NSString *results = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.url]
													 encoding:NSUTF8StringEncoding
														error:&error];
		if (results) {
			[subscriber sendNext:results];
			[subscriber sendCompleted];
		} else {
			[subscriber sendError:error];
		}
		
		return nil;
	}];
}

@end
