//
//  TypesetBtnList.h
//  BtnList
//
//  Created by xzm on 16/9/2.
//  Copyright © 2016年 ypwl. All rights reserved.
//


/**
 *  多按钮排版
 */

#import <UIKit/UIKit.h>

@interface BtnListModel : NSObject

/**标题数组，必须设置*/
@property(nonatomic,strong)NSArray*textArray;
/**TypesetBtnList宽度，默认为屏幕宽度*/
@property(nonatomic,assign)CGFloat btnListwidth;
/**标题字体颜色，默认黑色*/
@property(nonatomic,strong)UIColor*titleColor;
/**背景颜色，默认白色*/
@property(nonatomic,strong)UIColor*backgroundColor;
/**选中字体颜色，默认为白色*/
@property(nonatomic,strong)UIColor*selectTitleColor;
/**选中背景颜色，默认为橙色*/
@property(nonatomic,strong)UIColor*selectBGColor;
/**边框颜色，默认黑色*/
@property(nonatomic,strong)UIColor*borderColor;
/**是否设置圆角，默认为NO*/
@property(nonatomic,assign)BOOL isSettingRadius;
/**是否可以多选，默认为YES*/
@property(nonatomic,assign)BOOL isAllowMutable;
/**是否可以选中，默认为YES*/
@property(nonatomic,assign)BOOL isAllowSelect;
/**总高度*/
@property(nonatomic,assign,readonly)CGFloat totalHeight;
/**选中按钮标题*/
@property(nonatomic,strong,readonly)NSMutableArray *selectBtnTitles;
/**
 *  处理数据
 */
- (void)configData;

@end

@interface TypesetBtnList : UIView;

/**资源模型*/
@property (nonatomic,strong)BtnListModel *model;

/**点击回调，返回标题跟按钮本身*/
@property(nonatomic,copy)void(^btnClickBlock)(NSString *title,UIButton *btn);

@end
