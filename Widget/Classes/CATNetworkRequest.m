#import "CATNetworkRequest.h"

@implementation CATNetworkRequest

- (instancetype)initWithURLString:(NSString *)string {
    self = [super init];

    if(self) {
        self.URL = [NSURL URLWithString:string];
    }

    return self;
}

- (NSDictionary *)apiDictionary {
    NSData *data = [NSData dataWithContentsOfURL:self.URL];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    return JSON;
}

- (NSURL *)catgirlURL {
    NSDictionary *response = [self apiDictionary];
    return [NSURL URLWithString:[response objectForKey:@"url"]];
}

- (void)updateImage:(UIImageView *)imageView {
    __block UIImageView *blockImageView = imageView;
    dispatch_async(dispatch_queue_create("com.burritoz.catgirlwidget.update", NULL), ^{
        __block UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self catgirlURL]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            blockImageView.image = image;
        });
    });
}

@end
