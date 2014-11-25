//
//  ViewController.m
//  DrunkCalc
//
//  Created by Chris on 12/24/13.
//  Copyright (c) 2013 The Casual Programmer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.scroller.scrollEnabled = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scroller layoutIfNeeded];
    self.scroller.contentSize = self.contentView.bounds.size;
    
}

- (IBAction)editingDidBegin:(UITextField *)sender {
    _scroller.contentOffset = CGPointMake(0,145);
}

-(IBAction)backgroundTap:(id)sender {
    [self.drinkField resignFirstResponder];
    [self.weightField resignFirstResponder];
    [self.timeField resignFirstResponder];
    [self.view endEditing:YES];
    _scroller.contentOffset = CGPointMake(0, 0);
}

- (IBAction)calculateButton:(UIButton *)sender {//main calculations 
    [self.view endEditing:YES];//closes keyboard
    
    if (_weightField.text.length == 0 || _drinkField.text.length == 0 || _timeField.text.length == 0) {
        _scroller.contentOffset = CGPointMake(0, 0);//brings scroller back to top
        //do nothing
        //will calculate only if all fields have values entered
    }
    
    else {
        const double BODY_WATER_PERCENTAGE = .806;
        const double STANDARD_CONVERSION = 1.2;
        
        int drinkValue = [[_drinkField text] intValue];
        int weightValue = [[_weightField text] intValue];
        int timeValue = [[_timeField text] intValue];
        
        NSString *percent =@"%"; //for output
        NSInteger gender = _genderChoice.selectedSegmentIndex; //0 = male 1 = female
        
        float genderBodyWaterConstant;
        float genderMetabolismConstant;
        
        if (gender == 0) {
            //give genderConstant value for male (alcohol distribution ratio)
            genderMetabolismConstant = .015;
            genderBodyWaterConstant = .58;
        }
        else if (gender == 1) {
            //give genderConstant value for female (alcohol distribution ratio)
            genderMetabolismConstant = .017;
            genderBodyWaterConstant = .49;
        }
        else {
            genderMetabolismConstant = .015;
            genderBodyWaterConstant = .58; //assume male as default
        }//END IF, IF, ELSE
        
        float calculationNumerator = BODY_WATER_PERCENTAGE * STANDARD_CONVERSION * drinkValue;
        float calculationDenominator = genderBodyWaterConstant * (weightValue / 2.20462);
        float alcoholEliminationSubtraction = genderMetabolismConstant * timeValue;
        
        float bloodAlcoholConcentration = (calculationNumerator / calculationDenominator) - alcoholEliminationSubtraction;
        
        if (bloodAlcoholConcentration < 0) {
            bloodAlcoholConcentration = 0;
        }//cant have negative BAC
        
        //if any field == 0, change bac to 0
        if (weightValue == 0 || timeValue == 0 || drinkValue == 0) {
            bloodAlcoholConcentration = 0;
        }
        
        float metabolizationRateHour = .016; //average rate a person metabolizes alcohol (percent per hour)
        int timeCounterHour = 0;
        int timeCounterMinute = 0;
        float decrementBAC = bloodAlcoholConcentration;
        float metabolizationRateMinute = metabolizationRateHour / 60.0;
        
        while (decrementBAC != 0) {
            if (decrementBAC >= metabolizationRateHour) {
                timeCounterHour++;
                decrementBAC = decrementBAC - metabolizationRateHour;
            }
            else {
                timeCounterMinute = decrementBAC / metabolizationRateMinute;
                decrementBAC = 0;
            }
        }//finds total time to become sober
        
        NSString *outputText = [NSString stringWithFormat:@"Current BAC: %4.3f%@",bloodAlcoholConcentration,percent];
        
        NSString *timeHour;
        NSString *timeMinute;
        
        if (timeCounterHour == 1) {
            timeHour = @"hour";
        }
        else {
            timeHour = @"hours";
        }
        
        if (timeCounterMinute == 1) {
            timeMinute = @"minute";
        }
        else {
            timeMinute = @"minutes";
        }
        
        NSString *outputText2 = [NSString stringWithFormat:@"%i %@ and %i %@ until sober",timeCounterHour, timeHour,timeCounterMinute, timeMinute];
        
        NSString *finalOutput = [NSString stringWithFormat:@"\n %@ \n\n %@",outputText,outputText2];
        _outputLabel.text = finalOutput;
        
        //scroll to right position
        _scroller.contentOffset = CGPointMake(0, 0);
        
        //shows output label and background & close button
        [_outputImageBackground setHidden:NO];
        [_outputLabel setHidden:NO];
        [_closeButton setHidden:NO];
        _closeButton.enabled = YES;
        _disclaimerButton.enabled = NO;
        
        //hide everything else
        [_genderLabel setHidden:YES];
        [_genderChoice setHidden:YES];
        [_weightField setHidden:YES];
        [_drinkField setHidden:YES];
        [_timeField setHidden:YES];
        [_textFieldLabel setHidden:YES];
        [_logoImage setHidden:YES];
        [_calculateButton setHidden:YES];
        
    }//END MAIN CALCULATION ELSE
        
}//end caclulate button

- (IBAction)closeButton:(UIButton *)sender {
    //hides output label and background & close button
    [_outputImageBackground setHidden:YES];
    [_outputLabel setHidden:YES];
    [_closeButton setHidden:YES];
    _closeButton.enabled = NO;
    _disclaimerButton.enabled = YES;
    [_disclaimerButton setHidden:NO];
    
    //show everything else
    [_genderLabel setHidden:NO];
    [_genderChoice setHidden:NO];
    [_weightField setHidden:NO];
    [_drinkField setHidden:NO];
    [_timeField setHidden:NO];
    [_textFieldLabel setHidden:NO];
    [_logoImage setHidden:NO];
    [_calculateButton setHidden:NO];
}

- (IBAction)disclaimerButton:(UIButton *)sender {
    //shows output label and background & close button
    [_outputImageBackground setHidden:NO];
    [_outputLabel setHidden:NO];
    [_closeButton setHidden:NO];
    _closeButton.enabled = YES;
    _disclaimerButton.enabled = NO;
    [_disclaimerButton setHidden:YES];
    
    //hide everything else
    [_genderLabel setHidden:YES];
    [_genderChoice setHidden:YES];
    [_weightField setHidden:YES];
    [_drinkField setHidden:YES];
    [_timeField setHidden:YES];
    [_textFieldLabel setHidden:YES];
    [_logoImage setHidden:YES];
    [_calculateButton setHidden:YES];
    
    
    //maybe change font/fontsize
    NSString *disclaimerOutput = @"Disclaimer:\nThis is only a rough estimate based on population averages and does not take into account existing disease states, drug interactions, or age. Drunk Calc is a novelty application for entertainment purposes only. You should not use Drunk Calc as a guideline to see how much you can safely drink and drive. It is dangerous to drive a vehicle or operate machinery after drinking alcohol. If you do so, you assume full risk of injury and death to yourself and others.The best rule to follow is to not drink and drive at all.";
    _outputLabel.text = disclaimerOutput;
}


@end
