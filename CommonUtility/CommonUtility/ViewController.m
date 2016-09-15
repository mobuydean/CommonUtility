//
//  ViewController.m
//  CommonUtility
//
//  Created by jianghao on 16/9/13.
//  Copyright © 2016年 Dean. All rights reserved.
//

#import "ViewController.h"
#import "CommonUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([CommonUtility isCheckUserIdCard:@"xxxxxxxxx"]) {
        NSLog(@"是身份证号码");
    }
    if ([CommonUtility isValidBankCardNumber:@"xxxxxxxxx"]) {
        NSLog(@"是银行卡号码");
    }
    if ([CommonUtility isValidEmailAddress:@"xxxxxxxxx"]) {
        NSLog(@"是邮件地址");
    }
    [self testColorForImage];
    
    
    CGFloat r = [CommonUtility getFloatRandom];
    NSLog(@"r = %f",r);
    
    CGFloat r_m = [CommonUtility getIntegerRandomWithInMax:10];
    NSLog(@"r_m = %.f",r_m);
    
    
    /*
    NSMutableDictionary *dic = [CommonUtility urlParser:@"CommonTest://show?arr=1&kv=2" appScheme:@"CommonTest://"];
    
    NSLog(@"dic = %@",dic);
    
    
    NSArray *array = @[@"hhh",@"jjj",@"mmmm",@"yyyytt",@"poeoeo"];
    
    [array componentsJoinedByString:@"-"];
   */
    

    /*
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 100, 64)];
    textView.backgroundColor = [CommonUtility colorWithHexString:@"#333333"];
    [self.view addSubview:textView];
    
    UIImage *testImage = [UIImage imageWithContentsOfFile:@"http://pic32.nipic.com/20130829/12906030_124355855000_2.png"];
    
    
    float m = [CommonUtility calculateCache];
    NSLog(@"m = %f",m);
    
    [CommonUtility clearCache];
    
    float n = [CommonUtility calculateCache];
    NSLog(@"n = %f",n);
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *tomatter = [[NSDateFormatter alloc] init];
    [tomatter setDateFormat:@"MM月dd日"];
    NSString *str = [CommonUtility ToFormatStrFromDateStr:@"2016-08-30 18:22:28" fromFormatter:formatter toFormatter:tomatter];
    NSLog(@"str = %@",str);
    
    
    NSString *weekStr = [CommonUtility weekdayForDate:[NSDate date]];
    NSLog(@"weekStr = %@",weekStr);
     */
}


-(void)testColorForImage
{
//    UIImage *image = [CommonUtility imageWithColor:[UIColor orangeColor]];
    
    UIImage *image = [CommonUtility imageWithColor:[UIColor orangeColor] andRect:CGSizeMake(100, 64) text:@"我是谁" font:[UIFont systemFontOfSize:16]];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(17, 64, 100, 64);
    
    [self.view addSubview:imageView];
    
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
