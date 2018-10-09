//
//  OrderNoteView.m
//  CookBook
//
//  Created by 你好 on 16/8/31.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "OrderNoteView.h"
#import "UITextView+Placeholder.h"
@implementation OrderNoteView
{
    CGFloat _defaultContentLabelH;
    CGFloat _defaultH;
    
    NSMutableParagraphStyle *_paragraphStyle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _defaultH = frame.size.height;
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    
    _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [_paragraphStyle setLineSpacing:5];//调整行间距
    
    self.backgroundColor=RGBACOLOR(230, 230, 230, 1);
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-10)];
    self.backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.backView];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 30)];
    self.titleLabel.text=@"订单备注";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.backView addSubview:self.titleLabel];
    
//    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 50, self.backView.bounds.size.width-20, self.backView.bounds.size.height-50-10)];
////    self.textView.layoutManager.allowsNonContiguousLayout = NO;
//    self.textView.delegate = self;
//    self.textView.autocorrectionType=UITextAutocorrectionTypeNo;
//    self.textView.autocapitalizationType=UITextAutocapitalizationTypeNone;
//    self.textView.font=[UIFont systemFontOfSize:16];
//    self.textView.scrollEnabled=NO;
//    self.textView.backgroundColor=[UIColor greenColor];
//    self.textView.placeholder=@"选填:对本次交易说明(希望何时送货)";
//    [self.backView addSubview:self.textView];
//    self.textView.hidden = YES;
    
    _defaultContentLabelH = self.backView.bounds.size.height-53-10;
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 53, self.backView.bounds.size.width-20, _defaultContentLabelH)];
    self.contentLabel.numberOfLines = 2;
    self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textColor =[UIColor colorWithHexString:@"#4e4e4e"];
    [self.backView addSubview:self.contentLabel];
    
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, self.backView.bounds.size.width-20, _defaultContentLabelH)];
    self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textfield.font = [UIFont systemFontOfSize:14];
    self.textfield.textColor = [UIColor colorWithHexString:@"#4e4e4e"];
    self.textfield.placeholder = @"选填:对本次交易说明(希望何时送货)";
    [self.backView addSubview:self.textfield];
}

-(CGFloat)makeViewHeightWithContent:(NSString *)string
{
    _paragraphStyle.lineBreakMode = _contentLabel.lineBreakMode;
    NSMutableAttributedString *attrString=[[NSMutableAttributedString alloc]initWithString:string];
    [attrString addAttributes:@{NSParagraphStyleAttributeName:_paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4e4e4e"]} range:NSMakeRange(0, string.length)];
    _contentLabel.attributedText = attrString;
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.contentLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:_paragraphStyle} context:nil].size;
    
    CGSize needSize = [self.contentLabel sizeThatFits:size];
    
    CGRect f= _contentLabel.frame;
    if (needSize.height <= _defaultContentLabelH+_paragraphStyle.lineSpacing) {
        f.size.height = _defaultContentLabelH;
        _contentLabel.frame = f;
        return _defaultH;
    } else {
        f.size.height = _defaultContentLabelH*2;
        _contentLabel.frame = f;
        return _defaultH+_defaultContentLabelH;
    }
}


@end
