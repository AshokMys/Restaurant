//
//  RestaurantDetailsView.m
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "RestaurantDetailsView.h"
#import "Constants.h"


#define kRowHeight 105

@interface RestaurantDetailsView ()

@end

@implementation RestaurantDetailsView


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    
    [self.view addSubview:detailsView];
    
    //[detailsView.btnTabSecond setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
    
    detailsView.tabFirstSelected =^()
    {
        SearchViewController *search = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:search animated:NO];
        
    };
    
    detailsView.tabSecondSelected =^()
    {
        NearbyViewController *nearby = [[NearbyViewController alloc]init];
        [self.navigationController pushViewController:nearby animated:NO];
        
    };
    
    detailsView.tabThirdSelected =^()
    {
        CategoryViewController *category = [[CategoryViewController alloc]init];
        [self.navigationController pushViewController:category animated:NO];
        
    };
    
    detailsView.tabFourthSelected =^()
    {
        UserViewController *user = [[UserViewController alloc]init];
        [self.navigationController pushViewController:user animated:NO];
        
    };
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;

    
    [self setTabBarView];

    scrollView.contentSize = CGSizeMake(DEVICE_WIDTH, 1300);
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [self setFoodMenuView];
    [self setBarMenuView];
    [self setPhotosView];

    arrayReviews = [[NSMutableArray alloc]init];
    
    [arrayReviews addObject:@"This is demo text....  This is demo text....  This is demo text....  This is demo text....  This is demo text....  "];
    [arrayReviews addObject:@"This is demo text....  This is demo text....  This is demo text....  This is demo text....  This is demo text....  "];
    [arrayReviews addObject:@"This is demo text....  This is demo text....  This is demo text....  This is demo text....  This is demo text....  "];
    [arrayReviews addObject:@"This is demo text....  This is demo text....  This is demo text....  This is demo text....  This is demo text....  "];
    [arrayReviews addObject:@"This is demo text....  This is demo text....  This is demo text....  This is demo text....  This is demo text....  "];

    UIImage *image = [UIImage imageNamed:@"dummy"];
    CGSize mySize = CGSizeMake(DEVICE_WIDTH, 250);
    UIImage *temp = [appDelegate imageByScalingAndCroppingForSize:mySize SourceImage:image];

    imageRestaurant.image = temp;
    
    
    labelTopHeader.text = LocalizedString(@"restaurant");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    
    labelRestaurantName.font = [UIFont fontWithName:_roboto_light size:16];
    labelAddress.font = [UIFont fontWithName:_roboto_light size:14];
    labelRatings.font = [UIFont fontWithName:_roboto size:16];
    
    labelFoodType.font = [UIFont fontWithName:_roboto_light size:14];
    labelReviews.font = [UIFont fontWithName:_roboto_light size:13];
    
    labelFullAddPlaceholder.font = [UIFont fontWithName:_roboto size:15];
    labelFullAd.font = [UIFont fontWithName:_roboto_light size:15];
    labelDistance.font = [UIFont fontWithName:_roboto_light size:15];
    
    labelFoodMenu.font = [UIFont fontWithName:_roboto size:16];
    labelBarMenu.font = [UIFont fontWithName:_roboto size:16];
    labelPhotos.font = [UIFont fontWithName:_roboto size:16];

    
    labelExpertReviewPlaceholder.font = [UIFont fontWithName:_roboto size:16];

    btnAllReviews.titleLabel.font = [UIFont fontWithName:_roboto_light size:14];
    btnWriteReview.titleLabel.font = [UIFont fontWithName:_roboto size:18];

    
    labelRestaurantName.text = @"Taj Hotel";
    labelAddress.text = @"Yerwada, Pune";
    
    labelRatings.text = @"4.5";
    
    labelFoodType.text = @"Sea Food";
    labelReviews.text = @"120 Reviews | 10 Photos";
    
    labelFullAd.text = @"104, Manchester, Park street, Yerwada road, Pune.";
    labelDistance.text = @"12 km";

    
    [scrollView addSubview:viewRestaurantName];
    [scrollView addSubview:labelFoodType];
    [scrollView addSubview:labelReviews];

    [scrollView addSubview:btnAddFavourite];
    [scrollView addSubview:btnShare];
    [scrollView addSubview:btnEdit];

        
    [self setUIAccordingLanguage];

    
}



-(void)setUIAccordingLanguage
{
    NSLog(@"-- DEVICE WIDTH : %f", DEVICE_WIDTH);
    
    btnBack.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 34);
    [btnBack setImage:[UIImage imageNamed:isEnglish ? @"back" : @"back_ar"] forState:UIControlStateNormal];
  
    
    labelRestaurantName.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-240, 2, 230, 21);
    labelAddress.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-240, 24, 230, 21);
    
    labelRatings.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-45 : 10, 7, 35, 35);
    labelRatings.layer.cornerRadius = labelRatings.frame.size.height/2;
    labelRatings.layer.masksToBounds = YES;

    
    
    btnEdit.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-115 : 85 , 214, 30, 30);
    btnShare.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-75 : 45 , 214, 30, 30);
    btnAddFavourite.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-35 : 5 , 214, 30, 30);

    
    labelFoodType.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-190 , 201, 180, 21);
    labelReviews.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-190 , 223 , 180, 21);
    
    
    labelFullAddPlaceholder.frame = CGRectMake(isEnglish ? 15 : DEVICE_WIDTH-160 , 268, 150, 21);
    labelFullAd.frame = CGRectMake(isEnglish ? 15 : DEVICE_WIDTH-270 , 297, 260, 40);

    
    labelDistance.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-60 : 10, 268, 50, 21);
    btnMakeCall.frame = CGRectMake(isEnglish ? DEVICE_WIDTH-40 : 10, 295, 30, 30);
    
    btnAllReviews.frame = CGRectMake(isEnglish ? 20 : DEVICE_WIDTH-165, 1188, 145, 30);
    
    
    labelRestaurantName.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelAddress.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;

    labelFoodType.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelReviews.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    labelFullAddPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelFullAd.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    labelDistance.textAlignment = isEnglish ? NSTextAlignmentRight : NSTextAlignmentLeft;
    
    
    labelFoodMenu.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelBarMenu.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelPhotos.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;

    labelExpertReviewPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;

    
}


-(void)setFoodMenuView
{
    int xPos =15;
    int kButtonWidth = 80;
    
    for(int i=0; i<6; i++)
    {
        UIButton *btnFoodMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        btnFoodMenu.frame = CGRectMake(xPos, 0, kButtonWidth, kButtonWidth);
        [btnFoodMenu setImage:[UIImage imageNamed:@"dummy"] forState:UIControlStateNormal];
        //[btnFoodMenu setTitle:@"LOGIN" forState:UIControlStateNormal];
        btnFoodMenu.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnFoodMenu.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnFoodMenu addTarget:self action:@selector(btnFoodMenuTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFoodMenu addSubview:btnFoodMenu];
        
        
        xPos+= kButtonWidth + 10;
        
    }
    
    scrollFoodMenu.backgroundColor = [UIColor clearColor];
    scrollFoodMenu.contentSize = CGSizeMake(xPos, 80);
    
}


-(void)setBarMenuView
{
    int xPos =15;
    int kButtonWidth = 80;
    
    for(int i=0; i<6; i++)
    {
        UIButton *btnBarMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBarMenu.frame = CGRectMake(xPos, 0, kButtonWidth, kButtonWidth);
        [btnBarMenu setImage:[UIImage imageNamed:@"dummy"] forState:UIControlStateNormal];
        //[btnBarMenu setTitle:@"LOGIN" forState:UIControlStateNormal];
        btnBarMenu.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnBarMenu.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnBarMenu addTarget:self action:@selector(btnBarMenuTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollBarMenu addSubview:btnBarMenu];
        
        
        xPos+= kButtonWidth + 10;
        
    }
    
    scrollBarMenu.backgroundColor = [UIColor clearColor];
    scrollBarMenu.contentSize = CGSizeMake(xPos, 80);

}

-(void)setPhotosView
{
    int xPos =15;
    int kButtonWidth = 80;
    
    for(int i=0; i<6; i++)
    {
        UIButton *btnPhotos = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPhotos.frame = CGRectMake(xPos, 0, kButtonWidth, kButtonWidth);
        [btnPhotos setImage:[UIImage imageNamed:@"dummy"] forState:UIControlStateNormal];
        //[btnPhotos setTitle:@"LOGIN" forState:UIControlStateNormal];
        btnPhotos.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnPhotos.titleLabel.textAlignment = NSTextAlignmentRight;
        [btnPhotos addTarget:self action:@selector(btnPhotosTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollPhotos addSubview:btnPhotos];
        
        
        xPos+= kButtonWidth + 10;
        
    }
    
    scrollPhotos.backgroundColor = [UIColor clearColor];
    scrollPhotos.contentSize = CGSizeMake(xPos, 80);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)btnEditTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Edit ---");
#endif
  
    
}

-(IBAction)btnShareTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Share ---");
#endif

    
    
}

-(IBAction)btnAddFavouriteTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Add Favourite ---");
#endif

    if(btnAddFavourite.selected == YES)
    {
        btnAddFavourite.selected = NO;
        
        [btnAddFavourite setImage:[UIImage imageNamed:@"fav_icon"] forState:UIControlStateNormal];
        
    }
    else
    {
        btnAddFavourite.selected = YES;
        
        [btnAddFavourite setImage:[UIImage imageNamed:@"fav_icon_selected"] forState:UIControlStateNormal];

    }
    
}

-(IBAction)btnMakeCallTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Make Call ---");
#endif
    
    
}


-(void)btnFoodMenuTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Food Menu  ---");
#endif

    
}

-(void)btnBarMenuTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Bar Menu  ---");
#endif
    
    
}

-(void)btnPhotosTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Photos  ---");
#endif
    
    
}


-(IBAction)btnAllReviews:(id)sender
{
#if DEBUG
    NSLog(@"-- All Reviews  ---");
#endif
    
    
}

-(IBAction)btnWriteReview:(id)sender
{
#if DEBUG
    NSLog(@"-- Write Reviews  ---");
#endif
    
    
}


#pragma mark ----
#pragma mark ----  TABLE VIEW DELEGATE -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayReviews count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    UIImageView *imageArrow = [[UIImageView alloc]init];
    imageArrow.frame = CGRectMake(isEnglish ? 15 : DEVICE_WIDTH-65, 5, 50, 50);
    imageArrow.image = [UIImage imageNamed:@"profile"];
    //imageArrow.backgroundColor  = [UIColor redColor];
    imageArrow.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageArrow];

    
    UILabel *labelName =[[UILabel alloc] init];
    labelName.frame = CGRectMake(isEnglish ? 75 : 15, 5, DEVICE_WIDTH-90, 50);
    labelName.TextAlignment =  isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelName.numberOfLines = 0;
    labelName.text = @"Jon Rao";
    labelName.backgroundColor = [UIColor clearColor];
    labelName.font = [UIFont fontWithName:_roboto size:15];
    labelName.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:labelName];

    
    UILabel *labelExpertReviews =[[UILabel alloc] init];
    labelExpertReviews.frame = CGRectMake(15, 60, DEVICE_WIDTH-30, 40);
    labelExpertReviews.TextAlignment =  isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelExpertReviews.numberOfLines = 0;
    labelExpertReviews.text = [arrayReviews objectAtIndex:indexPath.row];
    labelExpertReviews.backgroundColor = [UIColor clearColor];
    labelExpertReviews.font = [UIFont fontWithName:_roboto_light size:15];
    labelExpertReviews.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:labelExpertReviews];
    
    
    UIView *seperater = [[UIView alloc]init];
    seperater.frame = CGRectMake(15, kRowHeight-1, DEVICE_WIDTH-30, 1);
    seperater.backgroundColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:seperater];
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
