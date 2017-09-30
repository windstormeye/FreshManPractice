//
//  ViewController.m
//  Rock-Paper-Scissors
//
//  Created by pjpjpj on 2017/9/30.
//  Copyright © 2017年 #incloud. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *MachineBtn;
@property (weak, nonatomic) IBOutlet UIButton *ManRockBtn;
@property (weak, nonatomic) IBOutlet UIButton *ManScissorsBtn;
@property (weak, nonatomic) IBOutlet UIButton *ManPaperBtn;
@property (weak, nonatomic) IBOutlet UIButton *GameBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *machineProgressView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController {
    bool isNew;
    bool isBegin;
    NSString *_kUserStr;
    NSString *_kMachineStr;
    NSMutableArray *_kBtnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initView {
    isNew = true;
    isBegin = false;
    _kUserStr = @"";
    _kMachineStr = @"";
    
    _kBtnArr = [@[] mutableCopy];
    [_kBtnArr addObject:_ManRockBtn];
    [_kBtnArr addObject:_ManPaperBtn];
    [_kBtnArr addObject:_ManScissorsBtn];
    
    [_GameBtn addTarget:self action:@selector(GameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_ManRockBtn addTarget:self action:@selector(ManBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ManPaperBtn addTarget:self action:@selector(ManBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ManScissorsBtn addTarget:self action:@selector(ManBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _ProgressView.progress = 0;
    _machineProgressView.progress = 0;
}

- (void)GameBtnClick {
    if (!isBegin) {
        _statusLabel.text = @"请选择你的出法";
    } else {
      
        
        [self judgeMethonWithUserAndMachine];
    }
}

- (void)machineMethon {
    switch (arc4random() % 3) {
        case 0:
            _kMachineStr = @"✊️";
            break;
        case 1:
            _kMachineStr = @"🖐";
            
            break;
        case 2:
            _kMachineStr = @"✌️";
            break;
    }
}

- (void)ManBtnClick:(UIButton *)sender {
    sender.layer.borderColor = [UIColor blueColor].CGColor;
    sender.layer.borderWidth = 2.f;
    if ([sender.titleLabel.text isEqualToString:@"✊️"]) {
        _kUserStr = @"✊️";
    } else if ([sender.titleLabel.text isEqualToString:@"🖐"]) {
        _kUserStr = @"🖐";
    } else {
        _kUserStr = @"✌️";
    }
    
    for (UIButton *btn in _kBtnArr) {
        if ([btn isEqual:sender]) {
            continue;
        } else {
            btn.layer.borderColor  = [UIColor whiteColor].CGColor;
        }
    }
    
    isBegin = true;
}

- (void)judgeMethonWithUserAndMachine {
    [self machineMethon];
    
    if ([_kUserStr isEqualToString:_kMachineStr]) {
        _statusLabel.text = @"平局";
    } else if ([_kUserStr isEqualToString:@"✊️"] && [_kMachineStr isEqualToString:@"✌️"]) {
        _statusLabel.text = @"你赢了";
        [self progressViewUpdate];
    } else if ([_kUserStr isEqualToString:@"✊️"] && [_kMachineStr isEqualToString:@"🖐"]) {
        _statusLabel.text = @"你输了";
        [self machineProgressUpdate];
    } else if ([_kUserStr isEqualToString:@"✌️"] && [_kMachineStr isEqualToString:@"🖐"]) {
        _statusLabel.text = @"你赢了";
        [self progressViewUpdate];
    } else if ([_kUserStr isEqualToString:@"✌️"] && [_kMachineStr isEqualToString:@"✊️"]) {
        _statusLabel.text = @"你输了";
        [self machineProgressUpdate];
    } else if ([_kUserStr isEqualToString:@"🖐"] && [_kMachineStr isEqualToString:@"✌️"]) {
        _statusLabel.text = @"你输了";
        [self machineProgressUpdate];
    } else if ([_kUserStr isEqualToString:@"🖐"] && [_kMachineStr isEqualToString:@"✊️"]) {
        _statusLabel.text = @"你赢了";
        [self progressViewUpdate];
    }
    
    [_MachineBtn setTitle:_kMachineStr forState:UIControlStateNormal];
    
    for (UIButton *btn in _kBtnArr) {
        btn.layer.borderColor  = [UIColor whiteColor].CGColor;
    }
    isBegin = false;
}

- (void)progressViewUpdate {
    _ProgressView.progress += 0.28;
    if (_ProgressView.progress >= 1) {
        _statusLabel.text = @"恭喜你赢得了比赛";
        _statusLabel.textColor = [UIColor redColor];
        [_GameBtn setTitle:@"重新开始" forState:UIControlStateNormal];
        [_GameBtn addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)machineProgressUpdate {
    _machineProgressView.progress += 0.28;

    if (_machineProgressView.progress >= 1) {
        _statusLabel.text = @"很遗憾你失去了比赛";
        _statusLabel.textColor = [UIColor grayColor];
        [_GameBtn setTitle:@"重新开始" forState:UIControlStateNormal];
        [_GameBtn addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)restartGame {
    _machineProgressView.progress = 0;
    _ProgressView.progress = 0;
    [_GameBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_GameBtn addTarget:self action:@selector(GameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _statusLabel.text = @"";
    _statusLabel.textColor = [UIColor blackColor];
}

@end
