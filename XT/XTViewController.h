//
//  XTViewController.h
//  XT
//
//  Created by kyle on 13-3-16.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTViewController : UIViewController
{
    UIView* m_view;
    NSMutableArray* m_numberButtons;
    
    UIButton* m_addButton;
    UIButton* m_minusButton;
    UIButton* m_multiButton;
    UIButton* m_divButton;
    
    UIButton* m_clearButton;
    UIButton* m_resultButton;
    
    UILabel* m_label; 
}

- (void) createUI; 
- (void) createNumberButtons;
- (void) createCalculateButtons; 
- (void) createOpButtons;
- (void) createDisplayArea;

@end
