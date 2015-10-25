//
//  UIView+Ext.m
//
//
//  Created by mokai on 14-7-30.
//  Copyright (c) 2014years mokai. All rights reserved.
//


#import "UIView+Ext.h"

/**
 *  视图坐标相关
 */
@implementation UIView (Position)

#pragma mark frame相关
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setLeft:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(void)setTop:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

-(CGFloat)left{
    return self.frame.origin.x;
}

-(CGFloat)top{
    return self.frame.origin.y;
}

- (CGFloat)right {
    return self.frame.origin.x + self.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

/**
 *  距离屏幕的left
 *
 */
- (CGFloat)screenLeft {
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview){
        x += view.left;
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    return x;
}

/**
 *  距离屏幕的top
 */
- (CGFloat)screenTop {
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview){
        y += view.top;
        if ([view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y - [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenLeft, self.screenTop, self.width, self.height);
}

#pragma mark 视图居中相关
/**
 *  根据传入的子视图与当前视图计算出水平中心开始点
 */
-(CGFloat)centerHorizontalWithSubview:(UIView *)subview{
    return self.width/2 - subview.width/2;
}
/**
 *  根据传入的子视图与当前视图计算出垂直中心开始点
 */
-(CGFloat)centerVerticalWithSubview:(UIView *)subview{
    return self.height/2 - subview.height/2;
}

/**
 * 根据传入的子视图计算出中心开始点
 **/
-(CGPoint)centerWithSubview:(UIView *)subview{
    return CGPointMake([self centerHorizontalWithSubview:subview],[self centerVerticalWithSubview:subview]);
}

/**
 *  居中增加子视图
 */
-(void)addSubviewToCenter:(UIView *)subview{
    CGRect rect = subview.frame;
    rect.origin = [self centerWithSubview:subview];
    subview.frame = rect;
    [self addSubview:subview];
}

-(void)addSubviewToHorizontalCenter:(UIView *)subview{
    CGRect rect = subview.frame;
    rect.origin.x = [self centerHorizontalWithSubview:subview];
    subview.frame = rect;
    [self addSubview:subview];
}

-(void)addSubviewToVerticalCenter:(UIView *)subview{
    CGRect rect = subview.frame;
    rect.origin.y = [self centerVerticalWithSubview:subview];
    subview.frame = rect;
    [self addSubview:subview];
}

@end

/**
 *  视图层次相关
 */
#pragma mark 视图层次相关
@implementation UIView (ZOrder)

/**
 *  当前视图在父视图中的位置
 */
-(int)getSubviewIndex
{
    return [self.superview.subviews indexOfObject:self];
}

/**
 *  将视图置于父视图最上面
 */
-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}
/**
 *  将视图置于父视图最下面
 */
-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

/**
 *  视图层次上移一层
 */
-(void)bringOneLevelUp
{
    int currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

/**
 *  视图层次下移一层
 */
-(void)sendOneLevelDown
{
    int currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

/**
 *  是否在最上面
 */
-(BOOL)isInFront
{
    return ([self.superview.subviews lastObject]==self);
}

/**
 *  是否在最下面
 */
-(BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0]==self);
}

/**
 *  交换层次
 */
-(void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

/**
 *  清空所有子视图
 */
-(void)removeAllSubview{
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
}
@end
