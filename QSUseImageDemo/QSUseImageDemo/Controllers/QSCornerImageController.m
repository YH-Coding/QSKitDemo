//
//  QSCornerImageController.m
//  QSUseImageDemo
//
//  Created by zhongpingjiang on 2017/8/8.
//  Copyright © 2017年 shaoqing. All rights reserved.
//

#import "QSCornerImageController.h"
#import "QSProcessImageManager.h"
#import "UIImageView+SDWebImageExtension.h"
#import "UIImageView+WebCache.h"
#import "QSImageProcess.h"

@interface QSCornerImageController ()

@property (nonatomic,strong)UIImageView *sdImageView;
@property (nonatomic,strong)UIImageView *qsImageView;
@property (nonatomic,strong)NSMutableArray *processImageViews;

@end

@implementation QSCornerImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.navigationItem.title = @"网络图片的处理";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.processImageViews = [NSMutableArray array];
    
    NSInteger imageCount = 3;
    CGFloat margin = 10;
    CGFloat cornerRadius = 30;
    
    CGFloat width = ceilf((SCREEN_WIDTH - margin * (imageCount + 1))/imageCount);
    
    QSImageProcessConfig *config = [[QSImageProcessConfig alloc]initWithOutputSize:CGSizeMake(width, width)];
    config.option = QSImageProcessOptionCircle;
    UIImage *placeholderImage = [[QSImageProcess sharedImageProcess]processImage:[UIImage imageNamed:@"icon_lena@3x.png"] config:config];
    [self.view addSubview:({
        _sdImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - width * 2 + 20)/2, 0, width, width)];
        _sdImageView;
    })];
    
    [_sdImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img6.faloo.com/Picture/0x0/0/183/183388.jpg"] placeholderImage:placeholderImage];
    
    [self.view addSubview:({
        _qsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sdImageView.frame) + 20, 0, width, width)];
        _qsImageView;
    })];
    
    [_qsImageView qs_setImageWithURL:[NSURL URLWithString:@"http://img6.faloo.com/Picture/0x0/0/183/183388.jpg"] placeholderImage:placeholderImage];
    
    NSArray *configs = [self p_processConfigArrayWithOutputSize:CGSizeMake(width, width) cornerRadius:cornerRadius];
    for (NSInteger i = 0; i < 9; i++) {
        
        CGFloat offsetX = margin + (width + margin) * (i%3);
        CGFloat offsetY = CGRectGetMaxY(_sdImageView.frame) + 15 + ((width + 15) * (i/3));
        
        UIImageView *pImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offsetX, offsetY, width, width)];
        [self.view addSubview:pImageView];
        [pImageView qs_setImageWithURL:nil
//         [NSURL URLWithString:@"http://img6.faloo.com/Picture/0x0/0/183/183388.jpg"]
                      placeholderImage:placeholderImage
                                config:configs[i]];
    }
}

- (NSArray *)p_processConfigArrayWithOutputSize:(CGSize)outputSize cornerRadius:(CGFloat)cornerRadius{

    QSProcessImageConfig *config1 = [QSProcessImageConfig defaultConfigWithOutputSize:outputSize];  //没有任何圆角
    
    
    QSProcessImageConfig *config2 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerTopLeft];
    QSProcessImageConfig *config3 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerBottomLeft];
    QSProcessImageConfig *config4 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerTopRight];
    QSProcessImageConfig *config5 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerBottomRight];
    
    QSProcessImageConfig *config6 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    QSProcessImageConfig *config7 = [QSProcessImageConfig configWithOutputSize:outputSize cornerRadius:cornerRadius corners:UIRectCornerTopRight | UIRectCornerBottomRight];
    
    QSProcessImageConfig *config8 = [QSProcessImageConfig configWithOutputSize:outputSize
                                                                  cornerRadius:cornerRadius
                                                                       corners:UIRectCornerTopRight | UIRectCornerAllCorners];
    QSProcessImageConfig *config9 = [QSProcessImageConfig circleCofigWithOutputSize:outputSize];
    
    return @[config1,config2,config3,config4,config5,config6,config7,config8,config9];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    NSLog(@"释放");
    
}

@end
