//
//  ViewController.m
//  TempCalculator
//
//  Created by Gabriel Betancourt on 8/25/20.
//  Copyright © 2020 mau5atron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	fahrenheit = 0.0;
	celsius = 0.0;
	self.errorDisplay.layer.shadowOpacity = 0.5;
	self.errorDisplay.layer.shadowOffset = CGSizeMake(3.0, 3.0);
	[self.errorDisplay setAlpha:0.0];
	self.errorDisplay.frame = CGRectMake(20, -50, 374, 50); // set initial y position out of sight
	self.errorDisplayLabel.frame = CGRectMake(15, 0, 374, 50); // set left padding on label
}


- (IBAction)segControlTempConversion:(id)sender {
//	self.temperatureLabelOutlet.text = self.conversionTextFieldOutlet.text;
//	switch ( self.convertSegControlOutlet.selectedSegmentIndex ) {
//		case 0:
//
//			break;
//
//		default:
//			break;
//	}
}

- (BOOL)checkConversionTextFieldIsNumeric:(NSString *)textFieldText {
	validNumericInput = FALSE;
	// need to check if input is integer / float or blank
	
	if ( textFieldText.length == 0 ){
		NSLog(@"Text field is blank");
		errorTimerWindow = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(displayErrorWindow:) userInfo:@"Field can\'t be blank" repeats:FALSE];
	} else {
		validNumericInput = [self textFieldValIsInteger:textFieldText] || [self textFieldValIsDouble:textFieldText];
	}
	
	if ( !validNumericInput && textFieldText.length > 0 ){
		errorTimerWindow = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(displayErrorWindow:) userInfo:@"Input must be an integer or float" repeats:FALSE];
	}
	
	NSLog(@"is valid number input: %d", validNumericInput);
	return validNumericInput;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ( [self checkConversionTextFieldIsNumeric:self.conversionTextFieldOutlet.text] ){
		
	}
	[textField resignFirstResponder];
	return TRUE;
}

// validations

- (BOOL)textFieldValIsInteger:(NSString *)textFieldString {
	NSScanner *scan = [NSScanner scannerWithString:textFieldString];
	int val;
	return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)textFieldValIsDouble:(NSString *)textFieldString {
	NSScanner *scan = [NSScanner scannerWithString:textFieldString];
	double val;
	return [scan scanDouble:&val] && [scan isAtEnd];
}

// error message slide in from above ***

- (void)displayErrorWindow:(NSTimer *)errorTimer {
	[UIView animateWithDuration:0.5 delay:0.5 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn animations:^{
		self.errorDisplayLabel.text = (NSString *)[errorTimer userInfo];
		[self.errorDisplay setAlpha:1.0];
		self.errorDisplay.frame = CGRectMake(20, 50, 374, 50);
	} completion:^(BOOL finished){
		// NSLog(@"Displaying error message");
		errorTimerWindow = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(fadeDisplayErrorWindow) userInfo:NULL repeats:FALSE];
	}];
}

- (void)fadeDisplayErrorWindow {
	[UIView animateWithDuration:0.5 delay:0.5 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn animations:^{
		[self.errorDisplay setAlpha:0.0];
		self.errorDisplay.frame = CGRectMake(20, -50, 374, 50);
	} completion:^(BOOL finished){
		self.errorDisplayLabel.text = @"";
		// NSLog(@"No longer displaying error message.");
	}];
}

@end
