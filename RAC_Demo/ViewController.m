//
//  ViewController.m
//  RAC_Demo
//
//  Created by 亚飞 on 2018/6/21.
//  Copyright © 2018年 yafei. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>
@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"Hello");
        [subscriber sendNext:@"This is RAC"];
        return nil;
    }];

    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

    @weakify(self);
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
        @strongify(self);
        if (x.length > 10) {
            self.textField.text = [x substringToIndex:10];
        }
    }];

    [[self.button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        NSLog(@"%@",self.textField.text);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
