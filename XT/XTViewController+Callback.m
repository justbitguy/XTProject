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
    
}

- (void)backButtonClicked:(UIButton*)button
{
    
}


- (void)opButtonClicked:(UIButton*)button
{
    
    
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
        NSString* text = [m_label.text substringWithRange:NSMakeRange(1, m_label.text.length -1)];
        text = [text stringByAppendingString:button.titleLabel.text];
        m_label.text = text;
    }
     else
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }

    
}
@end
