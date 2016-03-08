//
//  IntrinsicViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/7/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "IntrinsicViewController.h"

@interface IntrinsicViewController ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *doneButtonBottomSpaceConstraint;

@end

@implementation IntrinsicViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (IBAction)hideKeyboardButtonPressed:(id)sender {
    
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    CGRect keyboardFrameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    CGFloat constraintConstant = CGRectGetHeight(self.view.frame) - [self.bottomLayoutGuide length] - CGRectGetMinY(keyboardFrame);
    
    self.doneButtonBottomSpaceConstraint.constant = constraintConstant;
    [self.view layoutIfNeeded];
}

@end
