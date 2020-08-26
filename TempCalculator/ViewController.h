//
//  ViewController.h
//  TempCalculator
//
//  Created by Gabriel Betancourt on 8/25/20.
//  Copyright © 2020 mau5atron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleOutlet;
@property (weak, nonatomic) IBOutlet UITextField *conversionTextFieldOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *assetTemperatureOutlet;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabelOutlet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *convertSegControlOutlet;

- (IBAction)segControlTempConversion:(id)sender;

@end

