//
//  FormTextView.m
//  Auto Layout Demo
//
//  Created by Bryn Bodayle on March/7/2016.
//  Copyright © 2016 Bryn Bodayle. All rights reserved.
//

#import "FormTextView.h"

@interface FormTextView()

@property (nonatomic, assign) CGSize desiredIntrinsicContentSize;

@end

@implementation FormTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self applyStyling];
    [self updateIntrinsicSizing];
}

- (void)prepareForInterfaceBuilder {
    
    [super prepareForInterfaceBuilder];
    
    [self applyStyling];
}

- (void)applyStyling {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

#pragma mark - Setters & Getters

- (void)setText:(NSString *)text {
    
    [super setText:text];
    
    [self textDidChange];
}

- (CGSize)intrinsicContentSize {
    
    return self.desiredIntrinsicContentSize;
}

#pragma mark -

- (void)textDidChange {
    
    [self updateIntrinsicSizing];
}

- (void)updateIntrinsicSizing {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    CGFloat textViewHeight = [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)].height;
    CGSize textViewSize = CGSizeMake(UIViewNoIntrinsicMetric, textViewHeight);
    
    if(!CGSizeEqualToSize(textViewSize, self.desiredIntrinsicContentSize)) {
        
        self.desiredIntrinsicContentSize = textViewSize;
        
        BOOL shouldAnimate = self.intrinsicContentSize.width != 0 && self.intrinsicContentSize.height != 0;
        
        void (^layoutUpdates)() = ^{
            
            [self invalidateIntrinsicContentSize];
            [self.superview layoutIfNeeded];
        };
        
        if(shouldAnimate) {
            
            [UIView animateWithDuration:0.15f animations:layoutUpdates];
        }
        else {
            
            layoutUpdates();
        }
    }
}

@end
