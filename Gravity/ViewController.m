//
//  ViewController.m
//  Gravity
//
//  Created by 高源 on 15/8/13.
//  Copyright (c) 2015年 高源. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Ext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self test];

    /**
     
     //注册监听设备朝向通知
     [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"object:nil];
     */
    
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0f/100.0f; //1秒100次
    
    _arrow.layer.anchorPoint = CGPointMake(0.5, 0);
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test {

    //CMAltimeter 获取设备的海拔高度
     CMAltimeter *ltimeter = [[CMAltimeter alloc] init];
    
    if ([CMAltimeter isRelativeAltitudeAvailable]) {
        NSLog(@"获取设备海拔高度可用");
        
         NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [ltimeter startRelativeAltitudeUpdatesToQueue:queue withHandler:^(CMAltitudeData *altitudeData, NSError *error) {
            
            NSLog(@"%@",altitudeData.relativeAltitude);
            
        }];
        
    }else {
    
        NSLog(@"获取设备海拔高度不可用");
    
    }
//---------------------------------------------------------
    //某个时间点，设备的状态
    CMAttitude *ttitude = [[CMAttitude alloc]init];
    
//    NSLog(@"roll = %f",ttitude.quaternion.x);

//--------------------------------------------------------
    self.motionManager = [[CMMotionManager alloc] init];
    
    // 加速度器的检测
    if ([self.motionManager isAccelerometerAvailable]){//检测加速器是否可用
        NSLog(@"Accelerometer is available.");
        
       /*
        //线程队列实时获取加速器的数据
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [self.motionManager startAccelerometerUpdatesToQueue: queue
                                                 withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                     
                                                     NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
                                                     
                                                 }];
        */
        
        self.motionManager.accelerometerUpdateInterval = 0.001; // 告诉manager，更新频率是100Hz
        [self.motionManager startAccelerometerUpdates]; // 开始更新，后台线程开始运行。
        
        NSLog(@"x = %f,y = %f,z = %f",self.motionManager.accelerometerData.acceleration.x,self.motionManager.accelerometerData.acceleration.y,self.motionManager.accelerometerData.acceleration.z);
        
        
        
    } else{
        NSLog(@"Accelerometer is not available.");
    }
    
    if ([self.motionManager isAccelerometerActive]){//检测加速器是否启动
        NSLog(@"加速器启动");
    } else {
        NSLog(@"加速器未启动");
    }
    

    // 陀螺仪的检测
    if([self.motionManager isGyroAvailable]){//检测陀螺仪是否可用
        NSLog(@"陀螺仪可用");
        
        
        if ([self.motionManager  isGyroActive] == NO){
            [self.motionManager  setGyroUpdateInterval:1.0f / 1.0f];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [self.motionManager startGyroUpdatesToQueue:queue
                                            withHandler:^(CMGyroData *gyroData, NSError *error) {
            
            CGFloat x = gyroData.rotationRate.x;
            CGFloat y = gyroData.rotationRate.y;
            CGFloat z = gyroData.rotationRate.z;
            
            
            NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
      //   NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
        // NSLog(@"Gyro Rotation z = %.04f\n", gyroData.rotationRate.z);
        }];
            
            
        }
        
        
    } else {
        NSLog(@"Gyro is not available.");
    }
    
    if ([self.motionManager isGyroActive]){//检测陀螺仪是否开启
        NSLog(@"陀螺仪开启");
        
    } else {
        NSLog(@"陀螺仪未开启");
    }
}

- (void)orientationChanged:(NSNotification *)notification
{
    　　UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    　　NSLog(@"当前朝向枚举数字值：%ld",(long)orientation);
    
    /**
     
     　　switch (orientation) {
     　　　　case UIDeviceOrientationPortrait:
     　　　　　　self.lblOriention.text = @"Portrait";
     　　　　　　break;
     　　　　case UIDeviceOrientationPortraitUpsideDown:
     　　　　　　self.lblOriention.text = @"Portrait Upside Down";
     　　　　　　break;
     　　　　case UIDeviceOrientationLandscapeLeft:
     　　　　　　self.lblOriention.text = @"Landscape Left";
     　　　　　　break;
     　　　　case UIDeviceOrientationLandscapeRight:
     　　　　　　self.lblOriention.text = @"Landscape Right";
     　　　　　　break;
     　　　　case UIDeviceOrientationFaceUp:
     　　　　　　self.lblOriention.text = @"Face Up";
     　　　　　　break;
     　　　　case UIDeviceOrientationFaceDown:
     　　　　　　self.lblOriention.text = @"Face Down";
     　　　　　　break;
     　　　　default:
     　　　　　　self.lblOriention.text = @"Unknown";
     　　　　　　break;
     }
     */
}

- (void)controlHardware
{
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
       
        //yaw,pitch,roll
        self.yaw.text = [NSString stringWithFormat:@"%.2f",motion.attitude.yaw];
        self.pitch.text = [NSString stringWithFormat:@"%.2f",motion.attitude.pitch];
        self.roll.text = [NSString stringWithFormat:@"%.2f",motion.attitude.roll];
        
        
        //Acceleration
        self.userAccelerationX.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.x];
        self.userAccelerationY.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.y];
        self.userAccelerationZ.text = [NSString stringWithFormat:@"%.2f",motion.userAcceleration.z];
        
        
        //Gravity
        self.gravityX.text = [NSString stringWithFormat:@"%.2f",motion.gravity.x];
        self.gravityY.text = [NSString stringWithFormat:@"%.2f",motion.gravity.y];
        self.gravityZ.text = [NSString stringWithFormat:@"%.2f",motion.gravity.z];
      
    
        //Gyroscope's rotationRate(CMRotationRate)
        self.rotationRateX.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.x];
        self.rotationRateY.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.y];
        self.rotationRateZ.text = [NSString stringWithFormat:@"%.2f",motion.rotationRate.z];
        
        if(fabs(motion.attitude.roll)<1.0f){
            [UIView animateWithDuration:0.6 animations:^{
                _arrow.layer.transform = CATransform3DMakeRotation(-(motion.attitude.roll), 0, 0, 1);
            }];
        }else if (fabs(motion.attitude.roll)<1.5f) {
            [UIView animateWithDuration:0.6 animations:^{
                
                int s;
                if (motion.attitude.roll>0) {
                    s=-1;
                }else {
                    s = 1;
                }
                _arrow.layer.transform = CATransform3DMakeRotation(s*M_PI_2, 0, 0, 1);
            }];
        
        }
        

        if ((motion.attitude.pitch)<0) {
            [UIView animateWithDuration:0.6 animations:^{
                _arrow.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            }];
        }
        
    }];
}

- (IBAction)switchAction:(UISwitch *)sender {
    
    if(sender.on)
    {
        [self controlHardware];
    }
    else
    {
        [self.motionManager stopDeviceMotionUpdates];
    }
    
}
@end
