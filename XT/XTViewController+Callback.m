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
    if (m_label.text.length > 0)
       m_label.text = [m_label.text substringWithRange:NSMakeRange(0, m_label.text.length-1)];
}


- (void)opButtonClicked:(UIButton*)button
{
    TextState state = [self currentState];
    if (state == TextStateResult)
        return;
    
    if (state == TextStateZeroFirst || state == TextStateNumberLast || state == TextStateDotMiddle)
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }
}

- (void) clear
{
    m_label.text = @"";
}

- (void)clearButtonClicked:(UIButton*)button
{
    [self clear];
}

- (void)numberButtonClicked:(UIButton*)button
{
     TextState currentState = [self currentState];
    
     if (currentState == TextStateResult)
     {
         return;
     }
    
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

- (int)priority:(char)left with:(char)right
{
    int leftWeight= 0, rightWeight = 0;
   
    //left value.
    if (left == '=')
    {
        leftWeight = 0;
    }
    else if (left == '+' || left == '-')
    {
        leftWeight = 1;
    }
    else
    {
        leftWeight = 2;
    }
  
    // right value.
    if (right == '=')
    {
        rightWeight = 0;
    }
    else if (right == '+' || right == '-')
    {
        rightWeight = 1;
    }
    else
    {
        rightWeight = 2;
    }
    
    return leftWeight - rightWeight;
}


- (void)calculate
{
    NSString* exprText = m_label.text;
    exprText = [exprText stringByAppendingString:@"="];
    const char * c = exprText.UTF8String;
    
    NSInteger length = exprText.length;
    NSInteger loc = 0, i;
    Stack* numStack = [[[Stack alloc] init] autorelease];
    Stack* opStack = [[[Stack alloc] init] autorelease];
    
    for(i = loc + 1; i < length; ++i)
    {
        if (c[i] == '+' || c[i] == '-' || c[i] =='x' || c[i] == '/' || c[i] == '=')
        {
            // convert string to a number and push into stack.
            NSRange range = NSMakeRange(loc, i - loc);
            NSString* ns = [exprText substringWithRange:range];
            float value = ns.floatValue;
            NSNumber* number = [NSNumber numberWithFloat:value];
            [numStack push:number];
            
            char curCharOpeator = c[i];
            NSNumber* curOperatorObject = [NSNumber numberWithChar:curCharOpeator];
            
            if (opStack.isEmpty)
            {
                
                [opStack push:curOperatorObject];
            }
            else
            {
                NSNumber* topOpObject = opStack.top;
                char topCharOperator = topOpObject.charValue;

                if ([self priority:topCharOperator with:curCharOpeator] < 0)
                {
                    [opStack push:curOperatorObject];
                }
                else
                {
                    // pop operator.
                    // pop last two numbers.
                    // then: first op last.
                    
                    NSNumber* tempTop = nil;
                    
                    // if current operator is a lower operator, we compute all the result before it,
                    // such as "5x2+3-", in this loop we will compute "5x2+3", and then push the result
                    // into the number stack, because '=' operator is lowest, so we will get the last result
                    // and push it into stack.
                    do
                    {
                        NSNumber* operatorObject = [opStack pop];
                        char operator = operatorObject.charValue;
                        
                        NSNumber* _2Num = [numStack pop];
                        NSNumber* _1Num = [numStack pop];
                        float _1st = _1Num.floatValue;
                        float _2nd = _2Num.floatValue;
                        float result = [self compute:operator left:_1st right:_2nd];
                        [numStack push:[NSNumber numberWithFloat:result]];
                        
                        tempTop = opStack.top;
                        
                    }while(tempTop && [self priority:tempTop.charValue with:curCharOpeator] >= 0);
                    
                    // after get the result in the loop, we will push the operator if need.
                    // unless current operator is '='.
                    if (curCharOpeator == '=')
                    {
                        NSNumber* resObject = [numStack pop];
                        NSString* resString = [NSString stringWithFormat:@"%f", resObject.floatValue];
                        m_label.text = [exprText stringByAppendingString:resString];
                        return;
                    }
                    else
                    {
                        [opStack push:curOperatorObject];
                    }
                }
            }
            
            // update the location for new substring.
            loc = i+1;
        }

    }
    
}

- (float)compute:(char)op left:(float)left right:(float)right
{
    float result = 0xffffffff;
    if ( op == '+')
    {
        result =  left+right;
    }
    else if (op == '-')
    {
        result =  left-right;
    }
    else if (op == 'x')
    {
        result = left*right;
    }
    else if (op == '/')
    {
        result = left/right;
    }
    else
    {
        assert(false);
    }
    
    return result;
}
@end
