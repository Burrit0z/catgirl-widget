@import UIKit;
#import "Classes/CATNetworkRequest.m"
#import "Classes/CATActionButton.m"

@interface MPARuntimeManager : NSObject
+ (void)notiHaptic;
@end

// please see README for explanation
@protocol MPAWidgetProtocol
@required
- (void)updateWidget;
@optional
- (void)widgetBecameFocused;
- (void)widgetLostFocus;
@end

@interface CATCatgirlWidget : UIView <MPAWidgetProtocol>
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *catgirl;
@property (nonatomic, strong) CATNetworkRequest *catgirlNetworking;
- (instancetype)initWithFrame:(CGRect)arg1;
- (void)saveToPhotos;
- (void)getNew;
@end
