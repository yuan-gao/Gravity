//
//  UIView+Ext.h
//
//
//  Created by mokai on 14-7-30.
//  Copyright (c) 2014years mokai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  视图坐标扩展
 */
@interface UIView (Position)

#pragma mark frame相关
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (void)setSize:(CGSize)size;

-(CGFloat)width;
-(CGFloat)height;
-(void)setWidth:(CGFloat)width;
-(void)setHeight:(CGFloat)height;

-(CGFloat)top;
-(CGFloat)left;
-(void)setTop:(CGFloat)x;
-(void)setLeft:(CGFloat)y;

-(CGFloat)bottom;
-(void)setBottom:(CGFloat)buttom;
-(CGFloat)right;
-(void)setRight:(CGFloat)right;

/**
 *  距离屏幕
 */
- (CGFloat)screenTop;
- (CGFloat)screenLeft;
- (CGRect)screenFrame;

#pragma mark 视图居中相关
/**
 * 根据传入的子视图计算出中心开始点
 **/
-(CGPoint)centerWithSubview:(UIView *)subview;
/**
 *  根据传入的子视图与当前视图计算出水平中心开始点
 */
-(CGFloat)centerHorizontalWithSubview:(UIView *)subview;
/**
 *  根据传入的子视图与当前视图计算出垂直中心开始点
 */
-(CGFloat)centerVerticalWithSubview:(UIView *)subview;
/**
 *  居中增加子视图
 */
-(void)addSubviewToCenter:(UIView *)subview;
-(void)addSubviewToHorizontalCenter:(UIView *)subview;
-(void)addSubviewToVerticalCenter:(UIView *)subview;

@end


#pragma mark 视图层次相关
@interface UIView (ZOrder)
/**
 *  当前视图在父视图中的位置
 */
-(int)getSubviewIndex;
/**
 *  将视图置于父视图最上面
 */
-(void)bringToFront;
/**
 *  将视图置于父视图最下面
 */
-(void)sendToBack;
/**
 *  视图层次上移一层
 */
-(void)bringOneLevelUp;
/**
 *  视图层次下移一层
 */
-(void)sendOneLevelDown;
/**
 *  是否在最上面
 */
-(BOOL)isInFront;
/**
 *  是否在最下面
 */
-(BOOL)isAtBack;
/**
 *  交换层次
 */
-(void)swapDepthsWithView:(UIView*)swapView;
/**
 *  清空所有子视图
 */
-(void)removeAllSubview;
@end

