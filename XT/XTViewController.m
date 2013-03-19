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
        [self.view addSubview: button];
    }
}

- (void)createCalculateButtons
{
    

}

- (void)createOpButtons
{

}

- (void)createDisplayArea
{
    float x = 300;
    float y = 200;
    float width = 100;
    float height = 100;
    m_label = [UILabel alloc] initWithFrame:CGRectMake(x, y, width, height);
    
    [self.view addSubview m_label];
}

- (void)clicked:(UIButton*)button
{

}
@end
