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
	[self.conversionTextFieldOutlet setPlaceholder:@"Enter F temperature to convert to C"];
	self.temperatureLabelOutlet.text = @"Celsius";
}

- (IBAction)segControlTempConversion:(id)sender {
	//self.temperatureLabelOutlet.text = self.conversionTextFieldOutlet.text;
	switch ( self.convertSegControlOutlet.selectedSegmentIndex ) {
		case 0:
			[self.conversionTextFieldOutlet setPlaceholder:@"Enter F temperature to convert to C"];
			NSLog(@"Called some temp in C");
			self.temperatureLabelOutlet.text = @"Celsius";
			if ( [self checkConversionTextFieldIsNumeric:self.conversionTextFieldOutlet.text] ){
				
				// add logic here to change the image on the imageview depending on the temperature
				
				celsius = [self.conversionTextFieldOutlet.text doubleValue];
				celsius = [self convertToC:celsius];
				[self switchImageC:celsius];
				self.temperatureLabelOutlet.text = [NSString stringWithFormat:@"%.2f Celsius", celsius];
			}
			break;
		case 1:
			[self.conversionTextFieldOutlet setPlaceholder:@"Enter C temperature to convert to F"];
			NSLog(@"Called some temp in F");
			self.temperatureLabelOutlet.text = @"Fahrenheit";
			if ( [self checkConversionTextFieldIsNumeric:self.conversionTextFieldOutlet.text] ){
				fahrenheit = [self.conversionTextFieldOutlet.text doubleValue];
				fahrenheit = [self convertToF:fahrenheit];
				[self switchImageF:fahrenheit];
				self.temperatureLabelOutlet.text = [NSString stringWithFormat:@"%.2f Fahrenheit", fahrenheit];
			}
			break;
		default:
			break;
	}
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

// send when user presses done on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ( [self checkConversionTextFieldIsNumeric:self.conversionTextFieldOutlet.text] ){
		// actually call the conversion to take place
		// pass this into the conversion function
		[self segControlTempConversion:self];
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
		// fix implicit self
		self->errorTimerWindow = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(fadeDisplayErrorWindow) userInfo:NULL repeats:FALSE];
	}];
}

- (void)fadeDisplayErrorWindow {
	[UIView animateWithDuration:0.5 delay:0.5 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseIn animations:^{
		[self.errorDisplay setAlpha:0.0];
		self.errorDisplay.frame = CGRectMake(20, -50, 374, 50);
	} completion:^(BOOL finished){
		/*
		 do nothing here
		 
		 commented this, else, when window faded in
		 it would display a blank at depending on how
		 user pressed the segments
	  */
		// self.errorDisplayLabel.text = @"";
	}];
}


// conversions
- (double)convertToC:(double)dToConvert { // convert to celsius
	// subtract 32
	// multiply by 5
	// divide by 9
	return ( (dToConvert - 32) * 5 ) / 9;
}

- (double)convertToF:(double)dToConvert { // convert to fahrenheit
	// divide by 5
	// multiply by 9
	// add 32
	return ( (dToConvert / 5) * 9 ) + 32;
}

- (void)switchImageC:(double)tempInC {
	if ( celsius > 85 ){
		[self setTempImage:@"Temp9"];
	} else if ( celsius > 75 ){
		[self setTempImage:@"Temp8"];
	} else if ( celsius > 65 ){
		[self setTempImage:@"Temp7"];
	} else if ( celsius > 55 ){
		[self setTempImage:@"Temp6"];
	} else if ( celsius > 45 ){
		[self setTempImage:@"Temp5"];
	} else if ( celsius > 35 ){
		[self setTempImage:@"Temp4"];
	} else if ( celsius > 25 ){
		[self setTempImage:@"Temp3"];
	} else if ( celsius > 15 ){
		[self setTempImage:@"Temp2"];
	} else if ( celsius < 15 ){
		[self setTempImage:@"Temp1"];
	}
}

- (void)switchImageF:(double)tempInF {
	if ( fahrenheit > 180.00 ){
		[self setTempImage:@"Temp9"];
	} else if ( fahrenheit > 160.00 ){
		[self setTempImage:@"Temp8"];
	} else if ( fahrenheit > 140.00 ){
		[self setTempImage:@"Temp7"];
	} else if ( fahrenheit > 120.00 ){
		[self setTempImage:@"Temp6"];
	} else if ( fahrenheit > 100.00 ){
		[self setTempImage:@"Temp5"];
	} else if ( fahrenheit > 80.00 ){
		[self setTempImage:@"Temp4"];
	} else if ( fahrenheit > 60.00 ){
		[self setTempImage:@"Temp3"];
	} else if ( fahrenheit > 40.00 ){
		[self setTempImage:@"Temp2"];
	} else if ( fahrenheit < 40.00 ){
		[self setTempImage:@"Temp1"];
	}
}

- (void)setTempImage:(NSString *)tempImgString {
	self.assetTemperatureOutlet.image = [UIImage imageNamed:tempImgString];
}
@end
