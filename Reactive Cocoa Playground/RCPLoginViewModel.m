//
//  RCPLoginViewModel.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/18/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPLoginViewModel.h"

@implementation RCPLoginViewModel

- (id)init
{
    self = [super init];
    if (!self) return self;
	
	_login = @"";
	_password = @"";
	
    return self;
}

@end
