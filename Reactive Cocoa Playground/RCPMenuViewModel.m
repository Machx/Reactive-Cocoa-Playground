//
//  RCPMenuViewModel.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPMenuViewModel.h"

static NSString * const kNetworkItem = @"Load Network";
static NSString * const kTaskItem = @"Load Task";
static NSString * const kLoginItem = @"Load Login Example";
static NSString * const kObservablesItem = @"Load Observables";
static NSString * const kTimerIntervalItem = @"Time Invterval";

@implementation RCPMenuViewModel

- (id)init
{
    self = [super init];
    if (!self) return nil;
	
	_activities = @[ kNetworkItem,
				 kTaskItem,
				  kLoginItem,
				  kObservablesItem,
				  kTimerIntervalItem
				 ];
	
    return self;
}

@end
