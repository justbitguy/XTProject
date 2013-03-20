//
//  XTViewController.m
//  XT
//
//  Created by kyle on 13-3-16.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "XTViewController.h"

#define ButtonWidth 50
#define ButtonXOffset 50
#define ButtonYOffset 50

@implementation XTViewController

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
        
        float x = i%3*(ButtonWidth+5) + ButtonXOffset;
        float y = i/3*(ButtonWidth+5) + ButtonYOffset;
        button.frame = CGRectMake(x, y, ButtonWidth, ButtonWidth);
        [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_numberButtons[i] = [button retain];
        [m_numberButtons[i] setTag:i];
        
        [self.view addSubview: button];
    }
}

- (void)createOpButtons
{
    m_addButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 50, ButtonWidth, ButtonWidth)];
    [m_addButton setTitle:@"+" forState:UIControlStateNormal];
    [m_addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_addButton setBackgroundColor:[UIColor yellowColor]];
    [m_addButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_addButton setTag:11];
    
    m_minusButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 105, ButtonWidth, ButtonWidth)];
    [m_minusButton setTitle:@"-" forState:UIControlStateNormal];
    [m_minusButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_minusButton setBackgroundColor:[UIColor yellowColor]];
    [m_minusButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_minusButton setTag:12];
    
    m_multiButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 160, ButtonWidth, ButtonWidth)];
    [m_multiButton setTitle:@"x" forState:UIControlStateNormal];
    [m_multiButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_multiButton setBackgroundColor:[UIColor yellowColor]];
    [m_multiButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_multiButton setTag:13];
    
    m_divButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 215, ButtonWidth, ButtonWidth)];
    [m_divButton setTitle:@"/" forState:UIControlStateNormal];
    [m_divButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [m_divButton setBackgroundColor:[UIColor yellowColor]];
    [m_divButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_divButton setTag:14];
    
    [self.view addSubview:m_addButton];
    [self.view addSubview:m_minusButton];
    [self.view addSubview:m_multiButton];
    [self.view addSubview:m_divButton]; 
}

- (void)createOtherButtons
{
    m_dotButton = [[UIButton alloc] initWithFrame:CGRectMake(105, 215, ButtonWidth, ButtonWidth)];
    [m_dotButton setTitle:@"." forState:UIControlStateNormal];
    [m_dotButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [m_dotButton setBackgroundColor:[UIColor greenColor]];
    
    [self.view addSubview:m_dotButton];
}

- (void)createDisplayArea
{
    float x = 400;
    float y = 50;
    float width = 300;
    float height = 200;
    m_label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    m_label.backgroundColor = [UIColor redColor];
    m_label.textColor = [UIColor blackColor]; 
    [self.view addSubview:m_label];
}

- (void)clicked:(UIButton*)button
{
    if (m_label.text == nil && button.tag < 10)
    {
        m_label.text = button.titleLabel.text;
    }
    else
    {
        m_label.text = [m_label.text stringByAppendingString:button.titleLabel.text];
    }
}
@end
