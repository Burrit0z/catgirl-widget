#import "CATCatgirlWidget.h"

#define API_URL @"https://nekos.life/api/v2/img/neko"

@implementation CATCatgirlWidget

- (instancetype)initWithFrame:(CGRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {

        // add a label
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:15]];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"Catgirl Widget"];

        [self addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.userInteractionEnabled = NO;

        UIImageView *catgirlImageView = [[UIImageView alloc] init];
        catgirlImageView.userInteractionEnabled = NO;
        catgirlImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:catgirlImageView];
        catgirlImageView.translatesAutoresizingMaskIntoConstraints = NO;

        // buttons creation
        CATActionButton *save = [[CATActionButton alloc] initWithText:@"Save"];
        [save addTarget:self action:@selector(saveToPhotos) forControlEvents:UIControlEventTouchUpInside];

        CATActionButton *new = [[CATActionButton alloc] initWithText:@"New"];
        [new addTarget:self action:@selector(getNew) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:save];
        [self addSubview:new];

        // layout buttons
        [NSLayoutConstraint activateConstraints:@[
            // right pos
            [save.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15],
            [new.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-15],

            // top and bottom anchors
            [save.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
            [new.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],

            // anchor to center
            [save.bottomAnchor constraintEqualToAnchor:self.centerYAnchor constant:-2.5],
            [new.topAnchor constraintEqualToAnchor:self.centerYAnchor constant:2.5],
        ]];

        // add layout constraints for image view
        [NSLayoutConstraint activateConstraints:@[
            [catgirlImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15],
            [catgirlImageView.rightAnchor constraintEqualToAnchor:save.leftAnchor constant:-15],
            [catgirlImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:-10],
            [catgirlImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
        ]];
        self.catgirl = catgirlImageView;

        // add layout constraints for label
        [NSLayoutConstraint activateConstraints:@[
            [label.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:15],
            [label.rightAnchor constraintEqualToAnchor:save.leftAnchor constant:-15],
            [label.heightAnchor constraintEqualToAnchor:self.heightAnchor],
            [label.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
        ]];
        self.label = label;

        // object to do our networking
        self.catgirlNetworking = [[CATNetworkRequest alloc] initWithURLString:API_URL];

    }
    return self;
}


- (void)updateWidget {
    // called when scrolling ends and the widget needs an update.
    // will be called even if your widget was the one that was
    // showing already. if the user cancels their scroll, your
    // widget will be called to update again.
}

- (void)widgetBecameFocused {
    // called when the widget is set as the currently displaying widget
    // and it wasn't before

    [self getNew];
}

- (void)widgetLostFocus {
    // widget is completely hidden and scrolling has stopped
    // feel free to reset your views here if you need to,
    // the user should not be able to see any changes you make,
    // so you don't even need animations.
    self.catgirl.image = nil;
    self.catgirl.alpha = 0;
    self.label.alpha = 1;
}

- (void)getNew {
    self.label.text = @"Loading catgirl...";

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.catgirlNetworking updateImage:self.catgirl];
        // nice animation
        // i add a delay so the user can see it and it doesn't happen too quick
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.catgirl.alpha = 1;
            self.label.alpha = 0;
        } completion:^(BOOL finished) {
            self.label.text = @"Catgirl Widget";
        }];
    });
}

- (void)saveToPhotos {
    // utilize the haptics from Multipla's runtime manager
    // please use this responsibly, if at all
    [UIView animateWithDuration:0.3 animations:^{
        self.catgirl.alpha = 0.5;
    } completion:^(BOOL finished) {
        UIImageWriteToSavedPhotosAlbum(self.catgirl.image, nil, nil, nil);
        [NSClassFromString(@"MPARuntimeManager") notiHaptic];
        [UIView animateWithDuration:0.3 animations:^{
            self.catgirl.alpha = 1.0;
        }];
    }];
}

@end
