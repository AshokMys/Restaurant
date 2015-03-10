//
//  FAQViewController.m
//  Restaurant
//
//  Created by IMAC05 on 24/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "FAQViewController.h"
#import "Constants.h"


@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    labelTopHeader.text = LocalizedString(@"faq");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[appDelegate setNavigationController];
    
}


@end
