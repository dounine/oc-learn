//
//  ViewController.m
//  oc-learn
//
//  Created by lake on 2024/7/29.
//

#import "ViewController.h"
#import <oc_learn-Swift.h>
#import "View2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    FloatBtn* btn= [FloatBtnBuilder newWithFrame:CGRectMake(0,100,100,100)];
    [self.view addSubview:btn];
//    FloatBtn *btn = [FloatBtnBuilder new]
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    View2 *view2 = [[View2 alloc]init];
//    [self presentViewController:view2 animated:YES completion:nil];
}

@end
