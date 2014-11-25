//
//  ViewController.h
//  DrunkCalc
//
//  Created by Chris on 12/24/13.
//  Copyright (c) 2013 The Casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)editingDidBegin:(UITextField *)sender;

-(IBAction)backgroundTap:(id)sender;

- (IBAction)calculateButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *calculateButton;

- (IBAction)closeButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)disclaimerButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *disclaimerButton;

@property (strong, nonatomic) IBOutlet UIImageView *outputImageBackground;

@property (strong, nonatomic) IBOutlet UILabel *outputLabel;

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;

@property (strong, nonatomic) IBOutlet UIImageView *textFieldLabel;

@property (strong, nonatomic) IBOutlet UISegmentedControl *genderChoice;

@property (strong, nonatomic) IBOutlet UILabel *genderLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UITextField *drinkField;
@property (strong, nonatomic) IBOutlet UITextField *weightField;
@property (strong, nonatomic) IBOutlet UITextField *timeField;

@end
