//
//  DemoViewController.m
//  Runner
//
//  Created by gix on 2021/2/26.
//

#import "DemoViewController.h"

@import g_faraday;

@interface DemoViewController ()

@end

@implementation DemoViewController {
    UIViewController *lastVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
}

- (IBAction)onTapShowFlutter:(UIButton *)sender {
    FFViewController *fvc = [[FFViewController alloc] init:@"home" arguments:nil backgroundClear:YES engine:nil callback:^(id _Nullable result) {
        
    }];
    [fvc viewWillAppear:NO];
    [self presentViewController:fvc animated:NO completion:nil];
    [fvc viewDidAppear:NO];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"第二个页面---");
        FFViewController *fvc2 = [[FFViewController alloc] init:@"home22222" arguments:nil backgroundClear:YES engine:nil callback:nil];
        [fvc viewWillDisappear:NO];
        [fvc2 viewWillAppear:NO];
        [fvc presentViewController:fvc2 animated:NO completion:nil];
        [fvc2 viewDidAppear:NO];
        [fvc viewDidDisappear:NO];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"第三个页面---");
            UIViewController *vc = [[UIViewController alloc] init];
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            vc.view.backgroundColor = [UIColor.greenColor colorWithAlphaComponent:0.6];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn addTarget:self action:@selector(backVC) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"点击返回" forState:UIControlStateNormal];
            [vc.view addSubview:btn];
            btn.frame = CGRectMake(100, 200, 100, 50);
            btn.backgroundColor = UIColor.redColor;

            //MARK:点击空白处，底层flutterVC会响应点击，
            //viewWillDisappear｜:viewDidDisappear:试过多种调用方式都不能解决

            [fvc2 viewWillDisappear:NO];
            [fvc2 presentViewController:vc animated:NO completion:nil];
            [fvc2 viewDidDisappear:NO];

            self->lastVC = vc;
        });
    });
}

- (void)gestureAction:(id)ge {
    NSLog(@"手势点击");
}

- (void)backVC {
    [lastVC dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
