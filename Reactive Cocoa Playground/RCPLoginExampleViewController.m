//
//  RCPLoginExample.m
//  Reactive Cocoa Playground
//
//  Created by Colin Wheeler on 3/18/13.
//  Copyright (c) 2013 Colin Wheeler. All rights reserved.
//

#import "RCPLoginExampleViewController.h"
#import "RCPLoginViewModel.h"
#import <ReactiveCocoa/EXTScope.h>

@interface RCPLoginExampleViewController ()
@property(nonatomic,weak) IBOutlet NSTextField *loginField;
@property(nonatomic,weak) IBOutlet NSSecureTextField *passwordField;
@property(nonatomic,weak) IBOutlet NSButton *loginButton;
@property(nonatomic,retain) RCPLoginViewModel *viewModel;
@end

@implementation RCPLoginExampleViewController

-(id)init {
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
	if(!self) return nil;
	
	_viewModel = [RCPLoginViewModel new];
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
    if (!self) return nil;
	
	_viewModel = [RCPLoginViewModel new];
    
    return self;
}

-(void)awakeFromNib {
	@unsafeify(self);
	
	self.loginField.stringValue = self.viewModel.login;
	self.passwordField.stringValue = self.viewModel.password;
	
	[self.loginField.rac_textSignal subscribeNext:^(NSString *newValue) {
		@strongify(self);
		self.viewModel.login = newValue;
	}];
	[self.passwordField.rac_textSignal subscribeNext:^(NSString *newValue) {
		@strongify(self);
		self.viewModel.password = newValue;
	}];
	
	RACSignal *valid = [RACSignal combineLatest:@[self.loginField.rac_textSignal, self.passwordField.rac_textSignal]
										 reduce:^id(NSString *login, NSString *password) {
											 return @(login.length > 0 && password.length > 0);
										 }];
	
	self.loginButton.rac_command = [RACCommand commandWithCanExecuteSignal:valid];
	[self.loginButton.rac_command subscribeNext:^(id x) {
		@strongify(self);
		NSAlert *alert = [NSAlert alertWithMessageText:@"Did login"
										 defaultButton:@"Okay"
									   alternateButton:nil
										   otherButton:nil
							 informativeTextWithFormat:@"Did login with %@ : %@",self.viewModel.login,
														self.viewModel.password];
		[alert runModal];
	}];
}

@end
