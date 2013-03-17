//
//  RCPTaskViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPTaskViewController.h"
#import "NSTask+RACSupport.h"

@interface RCPTaskViewController ()
@property(nonatomic, retain) NSTask *task;
@property(nonatomic, retain) NSMutableString *results;
@property(nonatomic, unsafe_unretained) IBOutlet NSTextView *resultsTextView;
@end

@implementation RCPTaskViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
						   bundle:nil];
    if (!self) return nil;
	
	_results = [NSMutableString new];
	
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	if (!self) return nil;
	
	_results = [NSMutableString new];
    
    return self;
}

-(void)awakeFromNib {
	__block RCPTaskViewController *bself = self;
	
	bself.task = [[NSTask alloc] init];
	[self.task setLaunchPath:@"/bin/ls"];
	[self.task setStandardOutput:[NSPipe pipe]];
	[self.task setStandardError:[NSPipe pipe]];
	[self.task setCurrentDirectoryPath:NSHomeDirectory()];
	
	[self.task.rac_standardOutput subscribeNext:^(id x) {
		NSString *result = [[NSString alloc] initWithData:x
												 encoding:NSUTF8StringEncoding];
		[bself.results appendString:result];
		[bself.resultsTextView setString:bself.results];
	}];
	
	[self.task.rac_standardError subscribeNext:^(id x) {
		NSString *result = [[NSString alloc] initWithData:x
												 encoding:NSUTF8StringEncoding];
		[bself.results appendString:result];
		[bself.resultsTextView setString:bself.results];
	}];
	
	[self.task launch];
}

@end
