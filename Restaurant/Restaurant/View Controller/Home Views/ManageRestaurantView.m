//
//  ManageRestaurantView.m
//  Restaurant
//
//  Created by IMAC05 on 24/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "ManageRestaurantView.h"
#import "Constants.h"


@interface ManageRestaurantView ()

@end

@implementation ManageRestaurantView

- (void)viewDidLoad
{
    [super viewDidLoad];

    labelTopHeader.text = LocalizedString(@"manage_rest");
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



-(IBAction)btnNewAddTapped:(id)sender
{
    
}


-(IBAction)btnUpdateAddTapped:(id)sender
{
    
}

-(IBAction)btnDeleteAddTapped:(id)sender
{
    
}

-(IBAction)btnViewAddTapped:(id)sender
{
    
}

@end
