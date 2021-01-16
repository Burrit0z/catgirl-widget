#import "CATActionButton.h"

@implementation CATActionButton

- (instancetype)initWithText:(NSString *)text {
    self = [[super class] buttonWithType:UIButtonTypeCustom];

    if(self) {
        // corners
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10;

        // blur effect
        UIBlurEffect *chromeEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial];
        UIVisualEffectView *blur = [[UIVisualEffectView alloc] initWithEffect:chromeEffect];

        // blur effect layout
        blur.userInteractionEnabled = NO;
        [self addSubview:blur];
        blur.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [blur.widthAnchor constraintEqualToAnchor:self.widthAnchor],
            [blur.heightAnchor constraintEqualToAnchor:self.heightAnchor],
            [blur.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [blur.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
        ]];


        // label
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = text;

        // label layout
        label.userInteractionEnabled = NO;
        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [label.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:-5],
            [label.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-5],
            [label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
        ]];


        // self layout
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [self.widthAnchor constraintEqualToConstant:60],
        ]];
    }

    return self;
}

@end
