//
//  XTViewController.m
//  XT
//
//  Created by kyle on 13-3-16.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "XTViewController.h"

@interface XTViewController ()

@end

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
    
    CGPoint point = CGPointMake(20, 30);

    NSDictionary *dict = [NSDictionary dictionaryWithObject:(__bridge id)(&point) forKey:@"point"];
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


@end
