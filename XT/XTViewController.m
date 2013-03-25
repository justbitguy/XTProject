//
//  XTViewController.m
//  XT
//
//  Created by kyle on 13-3-16.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "XTViewController.h"

#define ButtonWidth 100
#define ButtonXOffset 200
#define ButtonYOffset 200
#define WidthAndInterval 110

#define DOT_TAG 10
#define BACK_TAG 21

@implementation XTViewController
@synthesize state = m_state;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    m_view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = m_view;
    [self createUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - new methods.
- (void)createUI
{
    [self createNumberButtons];
    [self createOpButtons];
    [self createOtherButtons];
    [self createDisplayArea];
}

- (void)createNumberButtons
{
    for (int i = 0; i < 10; ++i)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[NSString stringWithFormat:@"%d", i ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        
        float x = i%3*(WidthAndInterval) + ButtonXOffset;
        float y = i/3*(WidthAndInterval) + ButtonYOffset;
        button.frame = CGRectMake(x, y, ButtonWidth, ButtonWidth);
        [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_numberButtons[i] = [button retain];
        [m_numberButtons[i] setTag:i];
        
        [self.view addSubview: button];
    }
}

- (void)createOpButtons
{
    float x = ButtonXOffset + 3*(WidthAndInterval);
    float y = ButtonYOffset;
    
    m_addButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, ButtonWidth, ButtonWidth)];
    [m_addButton setTitle:@"+" forState:UIControlStateNormal];
    [m_addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_addButton setBackgroundColor:[UIColor yellowColor]];
    [m_addButton setTag:11];
    
    m_minusButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y+WidthAndInterval, ButtonWidth, ButtonWidth)];
    [m_minusButton setTitle:@"-" forState:UIControlStateNormal];
    [m_minusButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_minusButton setBackgroundColor:[UIColor yellowColor]];
    [m_minusButton setTag:12];
    
    m_multiButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y+2*WidthAndInterval, ButtonWidth, ButtonWidth)];
    [m_multiButton setTitle:@"x" forState:UIControlStateNormal];
    [m_multiButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_multiButton setBackgroundColor:[UIColor yellowColor]];
    [m_multiButton setTag:13];
    
    m_divButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y+3*WidthAndInterval, ButtonWidth, ButtonWidth)];
    [m_divButton setTitle:@"/" forState:UIControlStateNormal];
    [m_divButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_divButton setBackgroundColor:[UIColor yellowColor]];
    [m_divButton setTag:14];
    
    
    [m_addButton addTarget:self action:@selector(opButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_minusButton addTarget:self action:@selector(opButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_multiButton addTarget:self action:@selector(opButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_divButton addTarget:self action:@selector(opButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:m_addButton];
    [self.view addSubview:m_minusButton];
    [self.view addSubview:m_multiButton];
    [self.view addSubview:m_divButton]; 
}

- (void)createOtherButtons
{
    
    m_dotButton = [[UIButton alloc] initWithFrame:CGRectMake(ButtonXOffset+WidthAndInterval, ButtonYOffset+3*WidthAndInterval, ButtonWidth, ButtonWidth)];
    [m_dotButton setTitle:@"." forState:UIControlStateNormal];
    [m_dotButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_dotButton setBackgroundColor:[UIColor greenColor]];
    m_dotButton.tag = 10;
    
    m_backButton = [[UIButton alloc] initWithFrame:CGRectMake(ButtonXOffset+2*WidthAndInterval, ButtonYOffset+3*WidthAndInterval, ButtonWidth, ButtonWidth)];
    [m_backButton setTitle:@"<" forState:UIControlStateNormal];
    [m_backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_backButton setBackgroundColor:[UIColor greenColor]];
    m_backButton.tag = BACK_TAG;
    
    m_clearButton = [[UIButton alloc] initWithFrame:CGRectMake(ButtonXOffset, ButtonYOffset+4*WidthAndInterval, ButtonWidth+WidthAndInterval, ButtonWidth)];
    [m_clearButton setTitle:@"clear" forState:UIControlStateNormal];
    [m_clearButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_clearButton setBackgroundColor:[UIColor greenColor]];


    m_resultButton = [[UIButton alloc] initWithFrame:CGRectMake(ButtonXOffset+2*WidthAndInterval, ButtonYOffset+4*WidthAndInterval, ButtonWidth+WidthAndInterval, ButtonWidth)];
    [m_resultButton setTitle:@"=" forState:UIControlStateNormal];
    [m_resultButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_resultButton setBackgroundColor:[UIColor greenColor]];

    
    [m_dotButton addTarget:self action:@selector(dotButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_clearButton addTarget:self action:@selector(clearButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_resultButton addTarget:self action:@selector(resultButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:m_dotButton];
    [self.view addSubview:m_backButton];
    [self.view addSubview:m_clearButton];
    [self.view addSubview:m_resultButton];
}

- (void)createDisplayArea
{
    float height = ButtonWidth;
    float width = 3*WidthAndInterval+ButtonWidth;
    float x  = ButtonXOffset;
    float y = ButtonXOffset - WidthAndInterval;
    
    m_label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    m_label.backgroundColor = [UIColor redColor];
    m_label.textColor = [UIColor blackColor];
    m_label.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:m_label];
}

- (BOOL) stringIsOperator:(NSString*)text
{
    if ([text isEqualToString:@"+"]
        || [text isEqualToString:@"-"]
        || [text isEqualToString:@"x"]
        || [text isEqualToString:@"/"])
    {
        return YES;
    }
    else
        return NO;
}

- (BOOL) stringIsNumber:(NSString *)text
{
    if (text.length != 1)
        return NO;
    
    const char * c = text.UTF8String;
    if (*c >= '0' && *c <= '9')
    {
        return YES;
    }
    
    return NO;
}

- (BOOL) stringIsPositive:(NSString *)text
{
   if (text.length != 1)
       return NO;
    const char* c = text.UTF8String;
    if (*c > '0' && *c <= '9')
    {
        return YES;
    }

    return NO;
}

- (BOOL) stringisZero:(NSString *)text
{
   if (text.length !=1)
       return NO;
    
    const char* c = text.UTF8String;
    if (*c == '0')
        return YES;
    
    return NO;
}

- (BOOL) inMiddleDotState
{
    if (m_label.text.length <= 0)
        return  NO;
    
    const char * c = m_label.text.UTF8String;
//    const char * p = c + m_label.text.length - 1;
    
    NSInteger i = m_label.text.length - 1;
    while( i > 0)
    {
       if (c[i] >= '0' && c[i] <='9')
           --i;
        else if (c[i] == '.' && i != m_label.text.length -1)
            return YES;
        else
            return NO;
    };
    return NO;
}

- (void)updateTextState
{
    NSString* text = m_label.text;
    if (text.length == 0)
    {
        self.state = TextStateEmpty;
    }
    else if (text.length == 1)
    {
        if ([text isEqualToString:@"0"])
        {
            self.state = TextStateZeroFirst;
        }
        else
        {
            self.state = TextStateNumberLast;
        }
    }
    else
    {
        NSString* last = [text substringWithRange:NSMakeRange(text.length-1, 1)];
        NSString* secondLast = [text substringWithRange:NSMakeRange(text.length-2, 1)];
        
        if ([self stringIsOperator:last])
        {
            self.state = TextStateOperatorLast;
        }
        else if ([last isEqualToString:@"."])
        {
            self.state = TextStateDotLast;
        }
        else if ([last isEqualToString:@"0"] && [self stringIsOperator:secondLast])
        {
            self.state = TextStateZeroFirst;
        }
        else if ([self inMiddleDotState])
        {
            self.state = TextStateDotMiddle;
        }
        else
        {
            self.state = TextStateNumberLast;
        }
    
    }
    
}

- (TextState) currentState
{
    [self updateTextState];
    return self.state;
}
@end
