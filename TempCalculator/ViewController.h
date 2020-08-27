//
//  ViewController.h
//  TempCalculator
//
//  Created by Gabriel Betancourt on 8/25/20.
//  Copyright © 2020 mau5atron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
	double fahrenheit;
	double celsius;
	BOOL validNumericInput;
	NSTimer *errorTimerWindow;
	NSString *errorString;
}

@property (weak, nonatomic) IBOutlet UILabel *titleOutlet;
@property (strong, nonatomic) IBOutlet UITextField *conversionTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *assetTemperatureOutlet;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabelOutlet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *convertSegControlOutlet;
@property (weak, nonatomic) IBOutlet UIView *errorDisplay;
@property (weak, nonatomic) IBOutlet UILabel *errorDisplayLabel;

- (IBAction)segControlTempConversion:(id)sender;
- (BOOL)checkConversionTextFieldIsNumeric:(NSString *)textFieldText;

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (BOOL)textFieldValIsInteger:(NSString *)textFieldString;
- (BOOL)textFieldValIsDouble:(NSString *)textFieldString;

- (void)displayErrorWindow:(NSTimer *)errorTimer;
- (void)fadeDisplayErrorWindow;

@end

