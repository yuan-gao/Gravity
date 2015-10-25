//
//  ViewController.h
//  Gravity
//
//  Created by 高源 on 15/8/13.
//  Copyright (c) 2015年 高源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) CMMotionManager *motionManager;

@property (weak, nonatomic) IBOutlet UILabel *yaw;
@property (weak, nonatomic) IBOutlet UILabel *pitch;
@property (weak, nonatomic) IBOutlet UILabel *roll;


@property (weak, nonatomic) IBOutlet UILabel *userAccelerationX;
@property (weak, nonatomic) IBOutlet UILabel *userAccelerationY;
@property (weak, nonatomic) IBOutlet UILabel *userAccelerationZ;


@property (weak, nonatomic) IBOutlet UILabel *gravityX;
@property (weak, nonatomic) IBOutlet UILabel *gravityY;
@property (weak, nonatomic) IBOutlet UILabel *gravityZ;


@property (weak, nonatomic) IBOutlet UILabel *rotationRateX;
@property (weak, nonatomic) IBOutlet UILabel *rotationRateY;
@property (weak, nonatomic) IBOutlet UILabel *rotationRateZ;


@property (weak, nonatomic) IBOutlet UIImageView *arrow;


- (IBAction)switchAction:(UISwitch *)sender;




@end

