//
//  PrioritiesViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/16/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "PrioritiesViewController.h"

@interface PrioritiesViewController()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UISlider *containerViewWidthSlider;
@property (strong, nonatomic) IBOutlet UILabel *containerViewWidthLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *huggingViews;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *compressionViews;

@end

@implementation PrioritiesViewController

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    if(self.containerViewWidthConstraint.constant > viewWidth) {
        
        self.containerViewWidthConstraint.constant = viewWidth;
    }
    
    if(roundf(self.containerViewWidthSlider.value) != self.containerViewWidthConstraint.constant) {
        
        self.containerViewWidthSlider.value = self.containerViewWidthConstraint.constant;
    }
    
    self.containerViewWidthSlider.maximumValue = viewWidth;
    
    [self updateContainerViewWidthLabel];
}

- (void)updateContainerViewWidthLabel {
    
    self.containerViewWidthLabel.text = [NSString stringWithFormat:@"Container View Width: %lipt", (long)roundf(self.containerViewWidthConstraint.constant)];
}

- (IBAction)containerViewWidthValueChanged:(UISlider *)sender {
    
    self.containerViewWidthConstraint.constant = roundf(sender.value);
    [self.view updateConstraintsIfNeeded];
}

/*Toggling views for demonstration purposes*/
- (IBAction)tapGestureRecognized:(UITapGestureRecognizer *)sender {
    
    UIView *compressionView = self.compressionViews.firstObject;

    [self toggleViews:self.huggingViews hidden:compressionView.hidden];
    [self toggleViews:self.compressionViews hidden:!compressionView.hidden];
}

- (void)toggleViews:(NSArray *)views hidden:(BOOL)hidden {
    
    for(UIView *view in views) {
        
        view.hidden = hidden;
    }
}

@end
