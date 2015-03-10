//
//  WriteReviewController.m
//  Restaurant
//
//  Created by IMAC05 on 09/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "WriteReviewController.h"
#import "Constants.h"
#import "LocalizeHelper.h"

@interface WriteReviewController ()

@end

@implementation WriteReviewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    textReview.layer.borderColor = [kGrayTextColor CGColor];
    textReview.layer.borderWidth = 0.5;
    textReview.placeholder = LocalizedString(@"Write Review");
    
    textReview.layer.cornerRadius = 5;

    
    labelRating.layer.cornerRadius = labelRating.frame.size.height/2;
    labelRating.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnRatingTapped:(id)sender
{
    NSLog(@"-- Selected Tag :%d", (int)[sender tag]);
        
    labelRating.text = [NSString stringWithFormat:@"%.1f",0.5 * ([sender tag]+1)];
    
}


-(IBAction)btnFBSelectedTapped:(id)sender
{
    if(btnFBSelected.selected == NO)
    {
        btnFBSelected.selected = YES;
        [btnFBSelected setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];
        
    }
    else
    {
        btnFBSelected.selected = NO;
        [btnFBSelected setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];

    }
}


-(IBAction)btnTwitterSelectedTapped:(id)sender
{
    if(btnTwitterSelected.selected == NO)
    {
        btnTwitterSelected.selected = YES;
        [btnTwitterSelected setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];
        
    }
    else
    {
        btnTwitterSelected.selected = NO;
        [btnTwitterSelected setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        
    }
}


-(IBAction)btnPublishTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- FB :%d", btnFBSelected.isSelected);
    NSLog(@"-- FB :%d", btnTwitterSelected.isSelected);
#endif
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textReview resignFirstResponder];
}


@end
