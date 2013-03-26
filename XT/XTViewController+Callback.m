//
//  XTViewController+Callback.m
//  XT
//
//  Created by kyle on 13-3-25.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "XTViewController+Callback.h"
#import "Stack.h"

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
    TextState state = [self currentState];
    
    if (state != TextStateDotLast
        && state != TextStateOperatorLast
        && state != TextStateEmpty
        && state != TextStateWrong)
    {
        [self calculate];
    }
}

- (int)priority:(char)first with:(char)last
{
    int firstPri, lastPri;
    if (first == '+'|| first == '-')
    {
        firstPri = 0;
    }
    else {
        firstPri = 1;
    }
    
    if (last == '+' || last == '-')
    {
        lastPri = 0;
    }
    else {
        lastPri = 1;
    }
    
    return firstPri - lastPri;
}


- (void)calculate
{
    NSString* exprText = m_label.text;
    const char * c = exprText.UTF8String;
    
    NSInteger length = exprText.length;
    NSInteger loc = 0, i;
    Stack* numStack = [[[Stack alloc] init] autorelease];
    Stack* opStack = [[[Stack alloc] init] autorelease];
    
    for(i = loc + 1; i < length; ++i)
    {
        if (c[i] == '+' || c[i] == '-' || c[i] =='x' || c[i] == '/')
        {
            NSRange range = NSMakeRange(loc, i - loc);
            NSString* ns = [exprText substringWithRange:range];
            float value = ns.floatValue;
            loc = i+1;
            
            NSNumber* number = [NSNumber numberWithFloat:value];
            [numStack push:number];
            
            char curOp = c[i];
            NSNumber* op = [NSNumber numberWithChar:curOp];
            if (opStack.isEmpty)
            {
                [opStack push:op];
            }
            else
            {
                NSNumber* top = opStack.top;
                char firstOp = top.charValue;
                if ([self priority:firstOp with:curOp] < 0)
                {
                    [opStack push:op];
                }
                else
                {
                    // pop operator.
                    // pop last two numbers.
                    // then: first op last.
                    NSLog(@"need to calculate.\n");
                }
            }
            
            NSLog(@"value = %f\n", value);
        }

    }
    
    // the last number.
    if (i == length)
    {
        NSRange range = NSMakeRange(loc, i-loc);
        NSString* ns = [exprText substringWithRange:range];
        float value = ns.floatValue;
        NSLog(@"value = %f\n", value);
    }
    
}

@end
