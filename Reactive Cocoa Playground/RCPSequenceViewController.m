//
//  RCPSequenceViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/21/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPSequenceViewController.h"

@interface RCPSequenceViewController ()

@end

@implementation RCPSequenceViewController

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
	NSArray *array = @[ @42, @54, @64, @93, @100, @102, @50 ];
	
	[[[array rac_sequence] signal] subscribeNext:^(id x) {
		NSLog(@"Next Number: %@",x);
	} completed:^{
		NSLog(@"Completed Enumeration");
	}];
}

@end
