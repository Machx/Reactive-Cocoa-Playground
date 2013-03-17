//
//  RCPTaskViewController.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPTaskViewController.h"

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
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
//	NSTask *task = [[NSTask alloc] init];
//	[task setLaunchPath:@"/bin/ls"];
//	[task setStandardOutput:[NSPipe pipe]];
//	
//	task.rac_
}

@end
