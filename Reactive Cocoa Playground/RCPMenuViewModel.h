//
//  RCPMenuViewModel.h
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/15/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

enum RCPMenuSelection : NSUInteger {
	kNetworkMenuItem = 0,
	kTaskMenuItem,
	kLoginMenuItem,
	kSequenceMenuItem,
	kTimerMenuItem
};

@interface RCPMenuViewModel : NSObject

@property(nonatomic,retain) NSArray *activities;

@property(nonatomic,assign) NSString *selectedItem;

@end
