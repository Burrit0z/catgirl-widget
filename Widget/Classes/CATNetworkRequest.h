@interface CATNetworkRequest : NSObject
@property (nonatomic, strong) NSURL *URL;
- (NSDictionary *)apiDictionary;
- (NSURL *)catgirlURL;
- (void)updateImage:(UIImageView *)imageView;
@end
