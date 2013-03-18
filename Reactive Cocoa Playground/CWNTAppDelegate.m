//
//  CWNTAppDelegate.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 2/24/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "CWNTAppDelegate.h"
#import "RCPMenuViewModel.h"
#import "RCPNetworkViewController.h"
#import "RCPTaskViewController.h"

@interface CWNTAppDelegate ()
@property(nonatomic,retain) RCPMenuViewModel *viewModel;
@property(nonatomic, weak) IBOutlet NSPopUpButton *menuButton;
@property(nonatomic, weak) IBOutlet NSBox *viewBox;
//View Controllers
@property(nonatomic, retain) RCPNetworkViewController *networkController;
@property(nonatomic, retain) RCPTaskViewController *taskController;
@end

@implementation CWNTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	__weak CWNTAppDelegate *bself = self;
	
	self.viewModel = [RCPMenuViewModel new];
	
	//Menu Button
	[RACAbleWithStart(self.viewModel.activities) subscribeNext:^(NSArray *x) {
		[bself.menuButton removeAllItems];
		[bself.menuButton addItemsWithTitles:x];
		[bself.menuButton selectItemAtIndex:0];
	}];
	self.menuButton.rac_command = [RACCommand command];
	[self.menuButton.rac_command subscribeNext:^(NSPopUpButton *button) {
		bself.viewModel.selectedItem = bself.viewModel.activities[button.indexOfSelectedItem];
	}];
	
	//Switch Views
	[self.menuButton.rac_command subscribeNext:^(NSPopUpButton *button) {
		NSUInteger selectedIndex = button.indexOfSelectedItem;
		if (selectedIndex == 0) {
			//Load Network
			if (!bself.networkController) {
				bself.networkController = [[RCPNetworkViewController alloc] initWithURLAddress:@"http://www.google.com"];
			}
			[bself.viewBox setContentView:bself.networkController.view];
			
		} else if (selectedIndex == 1) {
			//Load Task
			if (!bself.taskController) {
				bself.taskController = [[RCPTaskViewController alloc] init];
			}
			[bself.viewBox setContentView:bself.taskController.view];
		}
	}];
	
	self.networkController = [[RCPNetworkViewController alloc] initWithURLAddress:@"http://www.google.com"];
	[self.viewBox setContentView:self.networkController.view];
}

@end
