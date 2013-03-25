//
//  XTViewController.h
//  XT
//
//  Created by kyle on 13-3-16.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    TextStateEmpty,
    TextStateZeroFirst,     // "0", "+0"
    TextStateNumberLast,    // "1", "+23"
    TextStateOperatorLast,  // "1+", "23/"
    TextStateDotLast,       // "0.", "23."
    TextStateDotMiddle,     // "0.22"
    TextStateWrong
}TextState;

@interface XTViewController : UIViewController
{
    UIView* m_view;
    NSMutableArray* m_numberButtons;
    
    UIButton* m_addButton;
    UIButton* m_minusButton;
    UIButton* m_multiButton;
    UIButton* m_divButton;
    
    UIButton* m_clearButton;
    UIButton* m_backButton;
    UIButton* m_resultButton;
    UIButton* m_dotButton;
    
    UILabel* m_label;
    TextState m_state;
}

@property (nonatomic, assign) TextState state;
- (void) createUI; 
- (void) createNumberButtons;
- (void) createOtherButtons;
- (void) createOpButtons;
- (void) createDisplayArea;

- (BOOL) stringIsNumber:(NSString*)text;
- (BOOL) stringIsOperator:(NSString *)text;
- (BOOL) stringIsPositive:(NSString *)text;
- (BOOL) stringisZero:(NSString*)text;
- (BOOL) inMiddleDotState;

- (TextState)currentState;

@end
