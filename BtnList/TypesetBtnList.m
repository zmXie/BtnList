//
//  TypesetBtnList.m
//  BtnList
//
//  Created by ypwl on 15/8/7.
//  Copyright (c) 2015年 YPWL. All rights reserved.
//

#import "TypesetBtnList.h"
#import <QuartzCore/QuartzCore.h>

@interface BtnListModel ()

/**标题数组*/
@property(nonatomic,strong)NSMutableArray *btnFrames;

@end

@implementation BtnListModel

#define BORDER_WIDTH 1.0f
#define CORNER_RADIUS 12.0f //圆角
#define LABEL_MARGIN 10.0f  //btn的横向间距
#define BOTTOM_MARGIN 10.0f  //btn的纵向间距
#define FONT_SIZE 14.0f
#define HORIZONTAL_PADDING 10.0f //btn中标题的左右边界距离
#define VERTICAL_PADDING 5.0f  //btn中标题的上下边界距离
#define MIN_WIDTH 60 //最小宽度

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.titleColor= [UIColor blackColor];
        self.borderColor= [UIColor blackColor];
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        self.selectBGColor = [UIColor orangeColor];
        self.selectTitleColor = [UIColor whiteColor];
        self.isSettingRadius = NO;
        self.btnListwidth = [UIScreen mainScreen].bounds.size.width;
        self.isAllowMutable = YES;
        self.isAllowSelect = YES;
        _selectBtnTitles = [NSMutableArray array];
    }
    
    return self;
}

- (NSMutableArray *)btnFrames{
    
    if (!_btnFrames) {
        
        _btnFrames = [NSMutableArray array];
        
    }
    
    return _btnFrames;
}

- (void)configData{
    
    float totalHeight = 0;
    CGRect previousFrame = CGRectZero;
    BOOL gotPreviousFrame = NO;
    [self.btnFrames removeAllObjects];
    
    for (NSString *text in _textArray) {
        
        CGSize textSize = [self widthOfString:text font:[UIFont systemFontOfSize:FONT_SIZE] height:CGFLOAT_MAX];
        textSize.width += HORIZONTAL_PADDING*2;
        if (textSize.width < MIN_WIDTH) {
            textSize.width = MIN_WIDTH;
        }
        textSize.height += VERTICAL_PADDING*2;
        
        CGRect newRect =  CGRectMake(0, 0, textSize.width, textSize.height);
        
        if (!gotPreviousFrame) {
            totalHeight = newRect.size.height;
            gotPreviousFrame = YES;
            
        }else{
            if (previousFrame.origin.x + previousFrame.size.width + textSize.width + LABEL_MARGIN> self.btnListwidth) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.height + BOTTOM_MARGIN);
                totalHeight += textSize.height + BOTTOM_MARGIN;
            } else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
            }
            
        }
        
        previousFrame = newRect;

        [self.btnFrames addObject:NSStringFromCGRect(newRect)];
    }
    
    _totalHeight = totalHeight;
}

- (CGSize)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

@end

@interface TypesetBtnList (){
    
    UIButton *_lastBtn;
}

@end

@implementation TypesetBtnList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)setModel:(BtnListModel *)model{
    
    _model = model;
    
    while (self.subviews.count < _model.textArray.count) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
        [self addSubview:button];
        
    }
    
    for (int i = 0; i < self.subviews.count; i ++) {
        
        UIButton *button = self.subviews[i];
        if (i < _model.textArray.count) {
            
            button.hidden = NO;
            button.frame = CGRectFromString(_model.btnFrames[i]);
            NSString *title = _model.textArray[i];
            
            [self configButton:button
                         Title:title
                       bgColor:[_model.selectBtnTitles containsObject:title]?_model.selectBGColor:_model.backgroundColor
                    titleColor:[_model.selectBtnTitles containsObject:title]?_model.selectTitleColor:_model.titleColor
                   borderColor:_model.borderColor];
        }else{
            button.hidden = YES;
        }
    }
    
    CGSize sizeFit = CGSizeMake(self.frame.size.width, _model.totalHeight + 1.0f);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeFit.width, sizeFit.height);
    
}

- (void)configButton:(UIButton *)button
               Title:(NSString *)title
             bgColor:(UIColor *)bgColor
          titleColor:(UIColor *)titleColor
         borderColor:(UIColor *)borderColor{
    
    button.userInteractionEnabled = _model.isAllowSelect;
    [button setBackgroundColor:bgColor];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    //使视图渲染内容被缓存起来
    if(_model.isSettingRadius){
        [button.layer setCornerRadius:CORNER_RADIUS];
        button.layer.shouldRasterize = YES;
        button.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    [button.layer setBorderColor:borderColor.CGColor];
    [button.layer setBorderWidth: BORDER_WIDTH];
    [button.layer setMasksToBounds:YES];
    button.selected = [_model.selectBtnTitles containsObject:title];
    if (!_model.isAllowMutable && [_model.selectBtnTitles containsObject:title])
        _lastBtn = button;
}

-(void)clickAction:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (self.model.isAllowMutable) {
        
        [btn setTitleColor:btn.selected?_model.selectTitleColor:_model.titleColor forState:0];
        
        if (btn.selected) {
            [btn setBackgroundColor:self.model.selectBGColor];
            if(![_model.selectBtnTitles containsObject:btn.titleLabel.text]) [_model.selectBtnTitles addObject:btn.titleLabel.text];
            
        }else{
            [btn setBackgroundColor:self.model.backgroundColor];
            if([_model.selectBtnTitles containsObject:btn.titleLabel.text]) [_model.selectBtnTitles removeObject:btn.titleLabel.text];
        }
        
    }else{
        if(![_model.selectBtnTitles containsObject:btn.titleLabel.text]) [_model.selectBtnTitles addObject:btn.titleLabel.text];
        if([_model.selectBtnTitles containsObject:_lastBtn.titleLabel.text]) [_model.selectBtnTitles removeObject:_lastBtn.titleLabel.text];
        
        if (btn != _lastBtn) {
            [_lastBtn setBackgroundColor:self.model.backgroundColor];
            [_lastBtn setTitleColor:_model.titleColor forState:0];
            [btn setBackgroundColor:self.model.selectBGColor];
            [btn setTitleColor:_model.selectTitleColor forState:0];
        }else{
           
            [btn setBackgroundColor:btn.selected?self.model.selectBGColor:self.model.backgroundColor];
            [btn setTitleColor:btn.selected?_model.selectTitleColor:_model.titleColor forState:0];
        }

        _lastBtn = btn;
    }

    if (self.btnClickBlock) {
        
        _btnClickBlock(btn.titleLabel.text,btn);
    }
}

@end
