//
//  MenuEditTableViewCell.m
//  CookBook
//
//  Created by 你好 on 16/4/15.
//  Copyright © 2016年 coralhust. All rights reserved.
//

#import "MenuEditTableViewCell.h"
#import "UITextView+Placeholder.h"


#define MAX_LIMIT_NUMS 2000


@implementation MenuEditTableViewCell
{
    NSIndexPath *_indexPath;
    CGFloat * _height;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.contentImageView=[[AnimationImageView alloc]initWithFrame:CGRectMake(5, 10, ScreenWidth-10, 200)];
    self.contentImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:self.contentImageView];

    self.textView=[[TextView alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-40, ScreenWidth-20, 40)];
    self.textView.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textView.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.textView.font=[UIFont systemFontOfSize:16];
    self.textView.scrollEnabled=NO;
    self.textView.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"步骤描述" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.textView.delegate=self;

    [self.contentView addSubview:self.textView];
    
    self.rightPressView=[[UIImageView alloc]initWithFrame:CGRectZero];
    self.rightPressView.userInteractionEnabled=YES;
    [self.contentView addSubview:self.rightPressView];
}



-(void)configData:(CookBaseProxy*)cookData atRow:(NSInteger)row isEditing:(BOOL)isEditing
{
    CookPhoto * photo = [cookData.cookPhotoProxy.arrLoaclPhotos objectAtIndex:row];
    UIImage *image=[photo getImageWithCookDataId:cookData.cookBaseId];
    double height = 0;
    
    if (image) {
       height = ((ScreenWidth-20) *(image.size.height))/image.size.width;
    }
    
    self.contentImageView.frame=CGRectMake(10, 10, ScreenWidth-20, height);
    self.contentImageView.image=image;
    self.textView.text=photo.story;
    
    UIImage *cellItemImage=[UIImage imageNamed:@"cell_item"];

    double TextHeight=[self getStringRectInTextView:self.textView.text InTextView:self.textView].height;
    
    if (TextHeight<40)
    {
        TextHeight=40;
    }
    
    if (isEditing)
    {
        self.contentImageView.userInteractionEnabled=NO;
        self.rightPressView.hidden=NO;
        self.textView.frame=CGRectMake(10, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+10, ScreenWidth-cellItemImage.size.width-30,TextHeight);
        self.rightPressView.frame=CGRectMake(ScreenWidth-cellItemImage.size.width-20, self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+(self.textView.frame.size.height-cellItemImage.size.height)/2, cellItemImage.size.width, cellItemImage.size.height);
    }
    else
    {
        self.contentImageView.userInteractionEnabled=YES;
        self.rightPressView.hidden=YES;
        self.rightPressView.frame=CGRectZero;
        self.textView.frame=CGRectMake(10,self.contentImageView.frame.origin.y+self.contentImageView.frame.size.height+10, ScreenWidth-20, TextHeight);
    }
    
    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    self.textView.lineImageView.frame=CGRectMake(0, self.textView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
    self.textView.editable=!isEditing;
    self.rightPressView.image=cellItemImage;
}



-(void)textViewDidBeginEditing:(UITextView *)textView
{
    id view = [self superview];
    
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    
    UITableView *tableView = (UITableView *)view;
    
    _indexPath=[tableView indexPathForCell:self];
    self.contentImageView.userInteractionEnabled=NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didCellTextViewBeginEditing:)]) {
        [_delegate didCellTextViewBeginEditing:textView];
    }
}



-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.contentImageView.userInteractionEnabled=YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didTextViewEndEdit:andText:)])
    {
        [_delegate didTextViewEndEdit:_indexPath andText:textView.text];
    }
    
}

- (CGSize)getFitStringTextSize:(NSString *)string
{
    CGSize size = [self getStringRectInTextView:string InTextView:self.textView];
    if (size.height<40)
    {
        size.height=40;
    }
    
    return size;
}

- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;
{
    //
    //    NSLog(@"行高  ＝ %f container = %@,xxx = %f",self.textview.font.lineHeight,self.textview.textContainer,self.textview.textContainer.lineFragmentPadding);
    //
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
}


- (void)refreshTextViewSize:(TextView *)textView
{
    CGSize size = [self getStringRectInTextView:textView.text InTextView:textView];
    //[textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    
    CGFloat diff = 0;
    if (size.height<=40)
    {
        if (frame.size.height > 40) {
            diff = frame.size.height-40;
        }
        frame.size.height=40;
    }
    else
    {
        diff = size.height - frame.size.height;
        frame.size.height = size.height;
    }

    textView.frame = frame;

    UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
    textView.lineImageView.frame=CGRectMake(0, textView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeTextViewSize:diff:andCell:)])
    {
        [_delegate didChangeTextViewSize:textView.frame.size.height diff:diff andCell:self];
    }
}

- (BOOL)textView:(TextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //对于退格删除键开放限制
    if (text.length == 0) {
        return YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        //加入动态计算高度
//        CGSize size = [self getStringRectInTextView:comcatstr InTextView:textView];
//        
//        CGRect frame = textView.frame;
//        
//        if (size.height<40)
//        {
//            frame.size.height=40;
//        }
//        else
//        {
//            frame.size.height = size.height;
//        }
//        
//        textView.frame = frame;
//
//        UIImage *lineImage=[UIImage imageNamed:@"dotted_line"];
//        textView.lineImageView.frame=CGRectMake(0, textView.frame.size.height-lineImage.size.height, ScreenWidth-20, lineImage.size.height);
        
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx = idx + steplen;
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            
            //由于后面反回的是NO不触发didchange
            [self refreshTextViewSize:textView];
        }
        return NO;
    }
}


- (void)textViewDidChange:(TextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    [self refreshTextViewSize:textView];
}



@end
