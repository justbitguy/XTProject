//
//  XTViewController+Callback.m
//  XT
//
//  Created by kyle on 13-3-25.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "XTViewController+Callback.h"

@implementation XTViewController (Callback)

- (void)dotButtonClicked:(UIButton*)button
{
    TextState state = [self currentState];
    if ((state == TextStateNumberLast || state == TextStateZeroFirst)
        && state != TextStateDotMiddle
        && state != TextStateDotLast)
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }
}

- (void)backButtonClicked:(UIButton*)button
{
    m_label.text = [m_label.text substringWithRange:NSMakeRange(0, m_label.text.length-1)];
}


- (void)opButtonClicked:(UIButton*)button
{
    TextState state = [self currentState];
    if (state == TextStateZeroFirst || state == TextStateNumberLast || state == TextStateDotMiddle)
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }
}

- (void)clearButtonClicked:(UIButton*)button
{
   m_label.text = @"";
}

- (void)numberButtonClicked:(UIButton*)button
{
     TextState currentState = [self currentState];
    
     if (currentState == TextStateEmpty)
     {
         if ([self stringIsNumber:button.titleLabel.text])
         {
             m_label.text = button.titleLabel.text;
         }
     }
     else if (currentState == TextStateZeroFirst)
    {
        NSString* text = [m_label.text substringWithRange:NSMakeRange(0, m_label.text.length -1)];
        text = [text stringByAppendingString:button.titleLabel.text];
        m_label.text = text;
    }
     else
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }

    
}

- (void)resultButtonClicked:(UIButton*)button
{
   
}
@end
