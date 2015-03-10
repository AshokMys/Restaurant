//
//  MyProfileView.m
//  Restaurant
//
//  Created by IMAC05 on 18/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MyProfileView.h"

@interface MyProfileView ()

@end

@implementation MyProfileView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
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
