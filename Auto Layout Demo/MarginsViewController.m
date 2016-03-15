//
//  MarginsViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/10/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "MarginsViewController.h"

@interface MarginsViewController ()

@property (strong, nonatomic) IBOutlet UIView *contentContainerView;
@property (strong, nonatomic) IBOutlet UILabel *contentContainerViewTopMarginLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentContainerViewBottomMarginLabel;
@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet UILabel *blueViewLeftMarginLabel;
@property (strong, nonatomic) IBOutlet UILabel *blueViewRightMarginLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MarginsViewController

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets layoutMargins = self.contentContainerView.layoutMargins;

    if(roundf(self.slider.value) != layoutMargins.top) {
        
        [self updateLayoutMargins:layoutMargins];
        self.slider.value = layoutMargins.top;
    }
}

- (void)updateLayoutMargins:(UIEdgeInsets)layoutMargins {
    
    self.contentContainerView.layoutMargins = layoutMargins;
    
    [self updateLayoutMarginLabels];
}

- (void)updateLayoutMarginLabels {
    
    UIEdgeInsets contentContainerLayoutMargins = self.contentContainerView.layoutMargins;
    NSString *contentContainerMarginString = [NSString stringWithFormat:@"%lipt", (long)contentContainerLayoutMargins.top];

    self.valueLabel.text = [NSString stringWithFormat:@"Layout Margin: %@", contentContainerMarginString];
    
    self.contentContainerViewTopMarginLabel.text = contentContainerMarginString;
    self.contentContainerViewBottomMarginLabel.text = contentContainerMarginString;
    
    UIEdgeInsets blueViewLayoutMargins = self.blueView.layoutMargins;
    
    self.blueViewLeftMarginLabel.text = [NSString stringWithFormat:@"%lipt", (long)blueViewLayoutMargins.left];
    self.blueViewRightMarginLabel.text = [NSString stringWithFormat:@"%lipt", (long)blueViewLayoutMargins.right];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    CGFloat marginValue = roundf(sender.value);
    UIEdgeInsets layoutMargins = UIEdgeInsetsMake(marginValue, marginValue, marginValue, marginValue);
    [self updateLayoutMargins:layoutMargins];
}

- (IBAction)preservesSuperviewLayoutMarginsSwitchValueChanged:(UISwitch *)sender {
    
    self.blueView.preservesSuperviewLayoutMargins = sender.isOn;
    [self updateLayoutMarginLabels];
}

@end
