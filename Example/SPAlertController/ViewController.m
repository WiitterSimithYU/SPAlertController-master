//
//  ViewController.m
//  SPAlertController
//
//  Created by 乐升平 on 17/10/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ViewController.h"
#import "SPAlertController.h"
#import "MyView.h"
#import "MyTitleView.h"
#import "MyCenterView.h"
#import "ShoppingCartView.h"
#import "CommodityListView.h"

// RGB颜色
#define ZCColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define ZCRandomColor ZCColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) SPAlertAction *sureAction;
@end

@implementation ViewController

#pragma mark ---------------------------- 示例方法 -------------------------------

// 示例1:actionSheet的默认样式
- (void)actionSheetTest1 {
    // actionSheet中，SPAlertAnimationTypeDefault 等价于 SPAlertAnimationTypeRaiseUp
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDefault];
    alertController.needBlur = NO;
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第取消");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action4]; // 注意第4个按钮是第二次添加，但是最终会显示在最底部，因为第四个按钮是取消按钮，只要是取消按钮，一定会在最底端，其余按钮按照添加顺序依次排布
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例2:actionSheet从底部弹出，这也是默认样式
- (void)actionSheetTest2 {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:nil preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeRaiseUp];
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第取消");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action4]; // 注意第4个按钮是第二次添加，但是最终会显示在最底部，因为第四个按钮是取消按钮，只要是取消按钮，一定会在最底端，其余按钮按照添加顺序依次排布
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例3:actionSheet“从天而降”
- (void)actionSheetTest3 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:nil message:nil preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDropDown];
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [self presentViewController:alertController animated:YES completion:nil];
}


// 示例4:actionSheet设置字体和颜色
- (void)actionSheetTest4 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDefault];
    // 设置大标题颜色
    alertController.titleColor = [UIColor redColor];
    // 设置大标题字体
    alertController.titleFont = [UIFont systemFontOfSize:50];
    // 设置小标题颜色
    alertController.messageColor = [UIColor blueColor];
    // 设置小标题字体
    alertController.messageFont = [UIFont systemFontOfSize:13];
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的字体
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // 设置第2个action的字体
    action2.titleFont = [UIFont systemFontOfSize:11];
    // 设置第2个action的文字颜色
    action2.titleColor = [UIColor orangeColor];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    // 设置第3个action的字体
    action3.titleFont = [UIFont systemFontOfSize:16];
    
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    // 设置第4个action的字体
    action4.titleFont = [UIFont systemFontOfSize:40];
    // 设置第4个action的文字颜色
    action4.titleColor = [UIColor redColor];
    
    // 注:在addAction之后设置action的文字颜色和字体同样有效
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    
    action1.titleFont = [UIFont systemFontOfSize:11];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例5:alert默认样式
- (void)alertTest5 {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeDefault];

    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的颜色
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];

    // 设置第2个action的颜色
    action2.titleColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];

    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例6:alert的alpha渐变动画，这也是默认样式
- (void)alertTest6 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeAlpha];
    
    // 设置最大排列数为1，当actions的个数超过1时，就会垂直排列
    alertController.maxNumberOfActionHorizontalArrangementForAlert = 1;
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的字体
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // 设置第2个action的颜色
    action2.titleColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例7:alert从小变大动画
- (void)alertTest7 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeExpand];
    
    alertController.maxNumberOfActionHorizontalArrangementForAlert = 3;
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的颜色
    action1.titleColor = [UIColor redColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    action2.titleColor = [UIColor blueColor];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    // 设置第2个action的颜色
    action3.titleColor = [UIColor orangeColor];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例8:alert从小大变小动画
- (void)alertTest8 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeShrink];
    alertController.maxNumberOfActionHorizontalArrangementForAlert = 4;
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的字体
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    action2.titleColor = [UIColor magentaColor];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    action3.titleColor  = [UIColor greenColor];
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"第4个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第4个");
    }];
    action4.titleColor = [UIColor purpleColor];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例9:alert样式没有action
- (void)alertTest9 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeAlpha];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例10:alert样式无标题
- (void)alertTest10 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:nil message:nil preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeShrink];
    alertController.maxNumberOfActionHorizontalArrangementForAlert = 2;
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"OK" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了OK");
    }];
    action1.titleColor = [UIColor blueColor];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例11:alert样式下按钮垂直排布,如果想要3个按钮水平排列，可设置maxNumberOfActionHorizontalArrangementForAlert大于等于3即可
- (void)alertTest11 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeAlpha];
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的字体
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    action3.titleColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例12:alert样式含有文本输入框
- (void)alertTest12 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeShrink];
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    action1.titleColor = [UIColor redColor];
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"确定" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"确定");
    }];
    action2.titleColor = [UIColor blueColor];
    action2.enabled = NO;
    self.sureAction = action2;
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSLog(@"第1个本本输入框回调");
        // 这个block只会回调一次，因此可以在这里自由定制textFiled，如设置textField的相关属性，设置代理，添加addTarget，监听通知等
        textField.placeholder = @"请输入手机号码";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSLog(@"第2个文本输入框回调");
        textField.placeholder = @"请输入密码";
        [textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)textFieldDidChanged:(UITextField *)textField {
    
    if (textField.text.length) {
        self.sureAction.enabled = YES;
    } else {
        self.sureAction.enabled = NO;
    }
}

// 示例13:自定义视图(alert样式)
- (void)customTest13 {
    
    MyView *myView = [MyView shareMyView];
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeAlpha customView:myView];
    [self presentViewController:alertController animated:YES completion:nil];
}


// 示例14:自定义整个对话框(actionSheet样式从底部弹出)
- (void)customTest14 {
    
    ShoppingCartView *shoppingCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    shoppingCartView.backgroundColor = [UIColor whiteColor];
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeRaiseUp customView:shoppingCartView];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例15:自定义整个对话框(actionSheet样式从顶部弹出)
- (void)customTest15 {
    CommodityListView *commodityListView = [[CommodityListView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    commodityListView.backgroundColor = [UIColor whiteColor];
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDropDown customView:commodityListView];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例16:自定义titleView
- (void)customTest16 {
    MyTitleView *myTitleView = [[MyTitleView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    SPAlertController *alertController = [SPAlertController alertControllerWithPreferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeDefault customTitleView:myTitleView];
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的颜色
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // 设置第2个action的颜色
    action2.titleColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例17:自定义中间的view，这种自定义下:如果是SPAlertControllerStyleAlert样式，action个数不能大于maxNumberOfActionHorizontalArrangementForAlert,超过maxNumberOfActionHorizontalArrangementForAlert的action将不显示,如果是SPAlertControllerStyleActionSheet样式,action必须为取消样式才会显示
- (void)customTest17 {
    MyCenterView *centerView = [[MyCenterView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"这是大标题" message:@"这是小标题" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeDefault customCenterView:centerView];
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // 设置第1个action的颜色
    action1.titleColor = [UIColor blueColor];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // 设置第2个action的颜色
    action2.titleColor = [UIColor redColor];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例18:当按钮过多时
- (void)test18 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"请滑动查看更多内容" message:@"谢谢" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDefault];
    alertController.maxTopMarginForActionSheet = 100;
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"第4个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第4个");
    }];
    SPAlertAction *action5 = [SPAlertAction actionWithTitle:@"第5个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第5个");
    }];
    SPAlertAction *action6 = [SPAlertAction actionWithTitle:@"第6个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第6个");
    }];
    SPAlertAction *action7 = [SPAlertAction actionWithTitle:@"第7个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第8个");
    }];
    SPAlertAction *action8 = [SPAlertAction actionWithTitle:@"第8个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第8个");
    }];
    SPAlertAction *action9 = [SPAlertAction actionWithTitle:@"第9个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第9个");
    }];
    SPAlertAction *action10 = [SPAlertAction actionWithTitle:@"第10个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第10个");
    }];
    SPAlertAction *action11 = [SPAlertAction actionWithTitle:@"第11个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第11个");
    }];
    SPAlertAction *action12 = [SPAlertAction actionWithTitle:@"第12个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第12个");
    }];
    SPAlertAction *action13 = [SPAlertAction actionWithTitle:@"第13个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第13个");
    }];
    SPAlertAction *action14 = [SPAlertAction actionWithTitle:@"第14个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第14个");
    }];
    SPAlertAction *action15 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    [alertController addAction:action7];
    [alertController addAction:action8];
    [alertController addAction:action9];
    [alertController addAction:action10];
    [alertController addAction:action11];
    [alertController addAction:action12];
    [alertController addAction:action13];
    [alertController addAction:action14];
    [alertController addAction:action15];

    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例19:当文字和按钮同时过多时，文字占据更多位置
- (void)test19 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"请滑动查看更多内容" message:@"谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢" preferredStyle:SPAlertControllerStyleActionSheet animationType:SPAlertAnimationTypeDefault];
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"第3个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第3个");
    }];
    SPAlertAction *action4 = [SPAlertAction actionWithTitle:@"第4个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第4个");
    }];
    SPAlertAction *action5 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    SPAlertAction *action6 = [SPAlertAction actionWithTitle:@"第6个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第6个");
    }];
    
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 示例20:含有文本输入框，且文字过多
- (void)test20 {
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:@"请滑动查看更多内容" message:@"谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢谢" preferredStyle:SPAlertControllerStyleAlert animationType:SPAlertAnimationTypeDefault];
    
    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"第1个" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第1个");
    }];
    
    // SPAlertActionStyleDestructive默认文字为红色(可修改)
    SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"第2个" style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
        NSLog(@"点击了第2个");
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableView.sectionFooterHeight = CGFLOAT_MIN;
    
    self.titles = @[@"ActionSheet样式",@"Alert样式",@"自定义视图",@"特殊情况"];
    self.dataSource = @[@[@"actionSheet的默认动画",@"actionSheet从底部弹出(与默认样式一致)",@"actionSheet'从天而降'",@"actionSheet设置文字颜色和字体"],@[@"alert的默认动画",@"alert透明度渐变(与默认样式一致)",@"alert从小变大动画",@"alert从大变小动画",@"alert样式没有action",@"alert样式无标题",@"alert样式下垂直排布",@"alert样式含有文本输入框"],@[@"自定义整个对话框(alert样式)",@"自定义整个对话框(actionSheet样式(底)）",@"自定义整个对话框(actionSheet样式(顶))",@"自定义titleView",@"自定义centerView"],@[@"当按钮过多时，以scrollView滑动",@"当文字和按钮同时过多时,二者都可滑动",@"含有文本输入框，且文字过多"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.titles[section];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self actionSheetTest1];
                break;
            case 1:
                [self actionSheetTest2];
                break;
            case 2:
                [self actionSheetTest3];
                break;
            case 3:
                [self actionSheetTest4];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self alertTest5];
                break;
            case 1:
                [self alertTest6];
                break;
            case 2:
                [self alertTest7];
                break;
            case 3:
                [self alertTest8];
                break;
            case 4:
                [self alertTest9];
                break;
            case 5:
                [self alertTest10];
                break;
            case 6:
                [self alertTest11];
                break;
            case 7:
                [self alertTest12];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                [self customTest13];
                break;
            case 1:
                [self customTest14];
                break;
            case 2:
                [self customTest15];
                break;
            case 3:
                [self customTest16];
                break;
            case 4:
                [self customTest17];
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                [self test18];
                break;
            case 1:
                [self test19];
                break;
            case 2:
                [self test20];
                break;
            default:
                break;
        }
    }
    
}


@end
