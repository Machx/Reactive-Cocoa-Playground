//
//  CWNTAppDelegate.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 2/24/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "CWNTAppDelegate.h"
#import <ReactiveCocoa/EXTScope.h>
#import "RCPMenuViewModel.h"
#import "RCPNetworkViewController.h"
#import "RCPTaskViewController.h"
#import "RCPLoginExampleViewController.h"
#import "RCPObservableViewController.h"
#import "RCPTimerViewController.h"

@interface CWNTAppDelegate ()
@property(nonatomic,retain) RCPMenuViewModel *viewModel;
@property(nonatomic, weak) IBOutlet NSPopUpButton *menuButton;
@property(nonatomic, weak) IBOutlet NSBox *viewBox;
//View Controllers
@property(nonatomic, retain) RCPNetworkViewController *networkController;
@property(nonatomic, retain) RCPTaskViewController *taskController;
@property(nonatomic, retain) RCPLoginExampleViewController *loginViewController;
@property(nonatomic, retain) RCPObservableViewController *sequenceController;
@property(nonatomic, retain) RCPTimerViewController *timerController;
@end

@implementation CWNTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	@weakify(self);
	
	self.viewModel = [RCPMenuViewModel new];
	
	//Menu Button
	[RACAbleWithStart(self.viewModel.activities) subscribeNext:^(NSArray *x) {
		@strongify(self);
		[self.menuButton removeAllItems];
		[self.menuButton addItemsWithTitles:x];
		[self.menuButton selectItemAtIndex:0];
	}];
	self.menuButton.rac_command = [RACCommand command];
	[self.menuButton.rac_command subscribeNext:^(NSPopUpButton *button) {
		@strongify(self);
		self.viewModel.selectedItem = self.viewModel.activities[button.indexOfSelectedItem];
	}];
	
	//Switch Views
	[self.menuButton.rac_command subscribeNext:^(NSPopUpButton *button) {
		@strongify(self);
		NSUInteger selectedIndex = button.indexOfSelectedItem;
		if (selectedIndex == 0) {
			//Load Network
			if (!self.networkController) {
				self.networkController = [[RCPNetworkViewController alloc] initWithURLAddress:@"http://www.google.com"];
			}
			[self.viewBox setContentView:self.networkController.view];
			
		} else if (selectedIndex == 1) {
			//Load Task
			if (!self.taskController) {
				self.taskController = [[RCPTaskViewController alloc] init];
			}
			[self.viewBox setContentView:self.taskController.view];
		} else if (selectedIndex == 2) {
			//Load Login Example
			if (!self.loginViewController) {
				self.loginViewController = [[RCPLoginExampleViewController alloc] init];
			}
			[self.viewBox setContentView:self.loginViewController.view];
		} else if (selectedIndex == 3) {
			//Load Array Sequence
			if (!self.sequenceController) {
				self.sequenceController = [[RCPObservableViewController alloc] init];
			}
			[self.viewBox setContentView:self.sequenceController.view];
		} else if (selectedIndex == 4) {
			//Load Timer
			if(!self.timerController) {
				self.timerController = [[RCPTimerViewController alloc] init];
			}
			[self.viewBox setContentView:self.timerController.view];
		}
	}];
	
	self.networkController = [[RCPNetworkViewController alloc] initWithURLAddress:@"http://www.google.com"];
	[self.viewBox setContentView:self.networkController.view];
}

@end
