//
//  ScrollViewsViewController.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/22/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "ScrollViewsViewController.h"

static const CGFloat ScrollViewsViewControllerVerticalMargin = 16.0f;

static BOOL ScrollViewsViewControllerLandscapeLayoutTraitCollection(UITraitCollection *traitCollection){
    
    UITraitCollection *iPhoneTraitCollection = [UITraitCollection traitCollectionWithUserInterfaceIdiom:UIUserInterfaceIdiomPhone];
    BOOL iPhone = [traitCollection containsTraitsInCollection:iPhoneTraitCollection];
    
    UITraitCollection *verticalCompactTraitCollection = [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
    BOOL verticallyCompact = [traitCollection containsTraitsInCollection:verticalCompactTraitCollection];
    
    return iPhone && verticallyCompact;
}

@interface ScrollViewsViewController ()

//Views
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *logoLabel;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

//Constraints
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *registerButtonBottomSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoTopSpaceToScrollViewConstraint;

//State
@property (nonatomic, assign) BOOL transitioningToTraitCollection;
@property (nonatomic, assign) CGRect keyboardFrame;

@end

@implementation ScrollViewsViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.scrollView.alwaysBounceVertical = YES;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    if(ScrollViewsViewControllerLandscapeLayoutTraitCollection(self.traitCollection)){
        return; //No need to adjust scroll view contents when in landscape
    }
    
    if(self.transitioningToTraitCollection) {
        return; //Let the trait collection transition coordinator handle the animation
    }
    
    CGRect keyboardFrameEnd = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    self.keyboardFrame = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [self updateLayoutForKeyboardFrameIfNeeded];
    
    [UIView animateWithDuration:keyboardAnimationDuration delay:0.0f options:animationCurve << 16 animations:^{
        
        [self updateLayoutForKeyboardFrameIfNeeded];
        [self.view layoutIfNeeded];
        
    } completion:nil];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    self.transitioningToTraitCollection = YES;
    
    void (^viewUpdates)(id <UIViewControllerTransitionCoordinatorContext>context) = nil;
    
    if(ScrollViewsViewControllerLandscapeLayoutTraitCollection(newCollection)) {
        
        viewUpdates = ^(id <UIViewControllerTransitionCoordinatorContext>context){
            
            self.logoTopSpaceToScrollViewConstraint.active = NO;
            [self.view layoutIfNeeded];
        };
        
    }
    else {
        
        viewUpdates = ^(id <UIViewControllerTransitionCoordinatorContext>context){
            
            [self updateLayoutForKeyboardFrameIfNeeded];
            [self.view layoutIfNeeded];
        };
    }
    
    [coordinator animateAlongsideTransition:viewUpdates completion:^(id <UIViewControllerTransitionCoordinatorContext>context){
        
        self.transitioningToTraitCollection = NO;
    }];
}

- (void)updateLayoutForKeyboardFrameIfNeeded {
    
    BOOL keyboardFrameOnScreen = self.keyboardFrame.origin.y < CGRectGetHeight(self.view.frame);
    BOOL haveKeyboardFrame = self.keyboardFrame.size.height > 0;
    BOOL keyboardShowing = keyboardFrameOnScreen && haveKeyboardFrame;
    
    if(keyboardShowing) {
       
        CGFloat constraintConstant = CGRectGetHeight(self.view.frame) - [self.bottomLayoutGuide length] - CGRectGetMinY(self.keyboardFrame) + ScrollViewsViewControllerVerticalMargin;
        
        self.registerButtonBottomSpaceConstraint.constant = MAX(constraintConstant, 0.0f);
    }
    else {
        
        self.registerButtonBottomSpaceConstraint.constant = ScrollViewsViewControllerVerticalMargin;
    }
    
    self.logoTopSpaceToScrollViewConstraint.active = keyboardShowing;
}

@end
