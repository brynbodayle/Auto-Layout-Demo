//
//  GuidesViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/18/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "GuidesViewController.h"

@interface GuidesViewController ()

@property (strong, nonatomic) IBOutlet UILabel *northLabel;
@property (strong, nonatomic) IBOutlet UILabel *southLabel;
@property (strong, nonatomic) IBOutlet UILabel *eastLabel;
@property (strong, nonatomic) IBOutlet UILabel *westLabel;

@property (strong, nonatomic) IBOutlet UILabel *scaleLabel;
@property (strong, nonatomic) IBOutlet UISlider *scaleSlider;
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) NSLayoutConstraint *centerLayoutGuideWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *centerLayoutGuideHeightConstraint;

@end

@implementation GuidesViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [self setupConstraints];
}

- (void)setupConstraints {
    
    //Add center layout guide
    UILayoutGuide *centerLayoutGuide = [[UILayoutGuide alloc] init];
    [self.containerView addLayoutGuide:centerLayoutGuide];
    
    
    self.centerLayoutGuideWidthConstraint = [centerLayoutGuide.widthAnchor constraintEqualToConstant:50.0f];
    self.centerLayoutGuideWidthConstraint.active = YES;

    /* Equivalent code without using layout anchors.
    self.centerLayoutGuideWidthConstraint = [NSLayoutConstraint constraintWithItem:centerLayoutGuide attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50.0f];
    [self.containerView addConstraint:self.centerLayoutGuideWidthConstraint];
     */
    
    self.centerLayoutGuideHeightConstraint = [centerLayoutGuide.heightAnchor constraintEqualToConstant:50.0f];
    self.centerLayoutGuideHeightConstraint.active = YES;
    
    [centerLayoutGuide.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor].active = YES;
    [centerLayoutGuide.centerYAnchor constraintEqualToAnchor:self.containerView.centerYAnchor].active = YES;
    
    
    //Add labels to view
    self.northLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.northLabel];

    self.southLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.southLabel];

    self.eastLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.eastLabel];

    self.westLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.westLabel];
    
    
    //Add label positioning constraints
    
    CGFloat padding = 0.0f;
    
    [centerLayoutGuide.topAnchor constraintEqualToAnchor:self.northLabel.bottomAnchor constant:padding].active = YES;
    [self.northLabel.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor].active = YES;
    
    [self.southLabel.topAnchor constraintEqualToAnchor:centerLayoutGuide.bottomAnchor constant:padding].active = YES;
    [self.southLabel.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor].active = YES;
    
    [self.eastLabel.leftAnchor constraintEqualToAnchor:centerLayoutGuide.rightAnchor constant:padding].active = YES;
    [self.eastLabel.centerYAnchor constraintEqualToAnchor:self.containerView.centerYAnchor].active = YES;

    [centerLayoutGuide.leftAnchor constraintEqualToAnchor:self.westLabel.rightAnchor constant:padding].active = YES;
    [self.westLabel.centerYAnchor constraintEqualToAnchor:self.containerView.centerYAnchor].active = YES;

    
    //Make aspect ratio 1:1 constraint for north label
    [self.northLabel.widthAnchor constraintEqualToAnchor:self.northLabel.heightAnchor].active = YES;
    
    
    //Set equal width constraints for labels
    [self.northLabel.widthAnchor constraintEqualToAnchor:self.southLabel.widthAnchor].active = YES;
    [self.eastLabel.widthAnchor constraintEqualToAnchor:self.westLabel.widthAnchor].active = YES;
    [self.eastLabel.widthAnchor constraintEqualToAnchor:self.southLabel.widthAnchor].active = YES;
    
    
    //Set equal height constraints for labels
    [self.northLabel.heightAnchor constraintEqualToAnchor:self.southLabel.heightAnchor].active = YES;
    [self.eastLabel.heightAnchor constraintEqualToAnchor:self.westLabel.heightAnchor].active = YES;
    [self.eastLabel.heightAnchor constraintEqualToAnchor:self.southLabel.heightAnchor].active = YES;
}

- (IBAction)scaleSliderValuedChanged:(UISlider *)sender {
    
    CGFloat sliderValue = roundf(sender.value);
    
    self.centerLayoutGuideHeightConstraint.constant = sliderValue;
    self.centerLayoutGuideWidthConstraint.constant = sliderValue;
    
    [self updateLabelFontSize:self.northLabel pointSize:sliderValue];
    [self updateLabelFontSize:self.southLabel pointSize:sliderValue];
    [self updateLabelFontSize:self.westLabel pointSize:sliderValue];
    [self updateLabelFontSize:self.eastLabel pointSize:sliderValue];
    
    self.scaleLabel.text = [NSString stringWithFormat:@"Scale: %lipt", (long)sliderValue];
}

- (void)updateLabelFontSize:(UILabel *)label pointSize:(CGFloat)pointSize {
    
    label.font = [UIFont fontWithName:label.font.fontName size:pointSize];
}


@end
