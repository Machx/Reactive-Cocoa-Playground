//
//  RCPAsyncViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 7/8/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPAsyncViewController.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPAsyncViewController ()
@property(copy,nonatomic) NSString *pilotName;
@property(copy,nonatomic) NSNumber *pilotUnitNumber;
@end

@implementation RCPAsyncViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
	@unsafeify(self);
	[[RACScheduler scheduler] schedule:^{
		[[RACSignal merge:@[ [self getNameString], [self getUnitNumber] ]]
		 subscribeCompleted:^{
			 [[RACScheduler mainThreadScheduler] schedule:^{
				 @strongify(self);
				 NSLog(@"Fetched Pilot: %@ of Unit %@",self.pilotName,self.pilotUnitNumber);
			 }];
		 }];
	}];
}

-(RACSignal *)getNameString {
	@unsafeify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);
		sleep(1);
		self.pilotName = @"Asuka";
		[subscriber sendNext:self.pilotName];
		[subscriber sendCompleted];
		
		return [RACDisposable disposableWithBlock:^{ }];
	}];
}

-(RACSignal *)getUnitNumber {
	@unsafeify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);
		sleep(2);
		self.pilotUnitNumber = @2;
		[subscriber sendNext:self.pilotUnitNumber];
		[subscriber sendCompleted];
		
		return [RACDisposable disposableWithBlock:^{ }];
	}];
}

@end
