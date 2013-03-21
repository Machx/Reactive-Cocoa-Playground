//
//  RCPMenuViewModel.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPMenuViewModel.h"

@implementation RCPMenuViewModel

- (id)init
{
    self = [super init];
    if (!self) return nil;
	
	_activities = @[ @"Load Network",
				 @"Load Task",
				  @"Load Login Example",
				  @"Load Observables"
				 ];
	
    return self;
}

@end
