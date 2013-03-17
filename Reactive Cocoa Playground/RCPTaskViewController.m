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
@end

@implementation RCPTaskViewController

- (id)init
{
    self = [super initWithNibName:NSStringFromClass([self class])
						   bundle:nil];
    if (!self) return nil;
	
	//
	
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
	self.task = [[NSTask alloc] init];
	[self.task setLaunchPath:@"/bin/ls"];
	[self.task setStandardOutput:[NSPipe pipe]];
	[self.task setStandardError:[NSPipe pipe]];
	[self.task setCurrentDirectoryPath:NSHomeDirectory()];
	
	[self.task.rac_standardOutput subscribeNext:^(id x) {
		NSString *result = [[NSString alloc] initWithData:x
												 encoding:NSUTF8StringEncoding];
		NSLog(@"Task Output: %@",result);
	}];
	
	[self.task.rac_standardError subscribeNext:^(id x) {
		NSString *result = [[NSString alloc] initWithData:x
												 encoding:NSUTF8StringEncoding];
		NSLog(@"Task Error: %@",result);
	}];
	
	[self.task launch];
}

@end
