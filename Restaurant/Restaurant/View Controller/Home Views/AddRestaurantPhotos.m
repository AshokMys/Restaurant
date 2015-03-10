//
//  AddRestaurantPhotos.m
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "AddRestaurantPhotos.h"
#import "Constants.h"

#import "CustomAlertView.h"

@interface AddRestaurantPhotos ()

@end

@implementation AddRestaurantPhotos


@synthesize isEditable;


-(void)setTabBarView
{
    
    TabBarView *detailsView = [[TabBarView alloc]init];
    detailsView.frame=CGRectMake(0, DEVICE_HEIGHT-kTabbarHeight, DEVICE_WIDTH, kTabbarHeight);
    [self.view addSubview:detailsView];
    
    //[detailsView.btnTabThird setImage:[UIImage imageNamed:@"tab_selected"] forState:UIControlStateNormal];
    
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

    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;
    
    [self setTabBarView];

    kRestaurantPhotosLimits = 7;
    kMenuPhotosLimits = 7;
    
    labelTopHeader.text = LocalizedString(@"photos");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    labelMenuPhotosPlaceholder.font = [UIFont fontWithName:_roboto size:16];
    labelRestaurantPhotosPlaceholder.font = [UIFont fontWithName:_roboto size:16];

    [btnSubmit setTitle:LocalizedString(@"submit") forState:UIControlStateNormal];
    btnSubmit.titleLabel.font = [UIFont fontWithName:_roboto size:18];
    
    
    if(isEditable)
    {
        btnDeleteMenuPhotos.hidden = NO;
        btnDeleteRestPhotos.hidden = NO;
        
        btnDeleteMenuPhotos.enabled = NO;
        btnDeleteRestPhotos.enabled = NO;
        
        
        restaurantPhotosCount = 3;
        arrayDeleteRestaurantFlag = [[NSMutableArray alloc]init];
        for(int i=0; i<restaurantPhotosCount; i++)
        {
            [arrayDeleteRestaurantFlag addObject:@"0"];
        }
        
        menuPhotosCount = 7;
        arrayDeleteMenuFlag = [[NSMutableArray alloc]init];
        for(int i=0; i<menuPhotosCount; i++)
        {
            [arrayDeleteMenuFlag addObject:@"0"];
        }
        
    }
    else
    {
        btnDeleteMenuPhotos.hidden = YES;
        btnDeleteRestPhotos.hidden = YES;

    }
    
        
    
    [self setUIAsPerLanguage];
    [self setMenuPhotoView];

}


-(void)setUIAsPerLanguage
{
    labelMenuPhotosPlaceholder.text = LocalizedString(@"menu_photos");
    labelRestaurantPhotosPlaceholder.text = LocalizedString(@"rest_photos");

    labelMenuPhotosPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelRestaurantPhotosPlaceholder.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;

    //btnAddRestaurantPhotos.frame = CGRectMake(isEnglish ? 20 : DEVICE_WIDTH-90, 45, 70, 35);
   //btnAddMenuPhotos.frame = CGRectMake(isEnglish ? 20 : DEVICE_WIDTH-90, 125, 70, 35);

    
    [self setRestaurantPhotoView];
    
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

-(void)setRestaurantPhotoView
{
    int kButtonWidth = 70;
    int xPos = 10;
    int yPos = 5;
    int space = 10;
    
    int arrayLimit;
    
    if(restaurantPhotosCount < kRestaurantPhotosLimits)
    {
        arrayLimit = restaurantPhotosCount + 1;
        isAddMorePhoto = YES;
        
    }
    else
    {
        arrayLimit = restaurantPhotosCount;
        isAddMorePhoto = NO;
    }
    
    
    for(id subview in scrollRestaurantPhotos.subviews)
        [subview removeFromSuperview];
    
    
    for(int i =0; i<arrayLimit; i++)
    {
        btnAddRestaurantPhotos = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAddRestaurantPhotos.frame = CGRectMake(xPos, yPos, kButtonWidth, kButtonWidth);
        btnAddRestaurantPhotos.tag = i;
        //[btnCategory setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnAddRestaurantPhotos.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnAddRestaurantPhotos.titleLabel.textAlignment = NSTextAlignmentRight;
        btnAddRestaurantPhotos.backgroundColor = [UIColor clearColor];
        [scrollRestaurantPhotos addSubview:btnAddRestaurantPhotos];
        
        [btnAddRestaurantPhotos.layer setBorderColor: [kGrayTextColor CGColor]];
        [btnAddRestaurantPhotos.layer setBorderWidth: 0.3f];
        //[btnAddRestaurantPhotos.layer setShadowOffset:CGSizeMake(0.4, 0.4)];
        //[btnAddRestaurantPhotos.layer setShadowRadius: 1.3];
        //[btnAddRestaurantPhotos.layer setShadowOpacity: 0.4];

        
        if(isAddMorePhoto && ((i+1) == arrayLimit))
        {
            [btnAddRestaurantPhotos setImage:[UIImage imageNamed:@"camera-icon"] forState:UIControlStateNormal];
            [btnAddRestaurantPhotos addTarget:self action:@selector(btnAddRestaurantPhotosTapped:) forControlEvents:UIControlEventTouchUpInside];

        }
        else
        {
            [btnAddRestaurantPhotos setImage:[UIImage imageNamed:@"dummy"] forState:UIControlStateNormal];
            [btnAddRestaurantPhotos addTarget:self action:@selector(viewRestaurantPhotosTapped:) forControlEvents:UIControlEventTouchUpInside];

            
            UIButton *btnDeleteRest = [UIButton buttonWithType:UIButtonTypeCustom];
            btnDeleteRest.frame = CGRectMake(kButtonWidth-15, 0, 15, 15);
            btnDeleteRest.tag = i;
            btnDeleteRest.titleLabel.textAlignment = NSTextAlignmentRight;
            btnDeleteRest.backgroundColor = [UIColor clearColor];
            [btnDeleteRest addTarget:self action:@selector(btnDeleteRestTapped:) forControlEvents:UIControlEventTouchUpInside];
                [btnAddRestaurantPhotos addSubview:btnDeleteRest];
            
            if([[arrayDeleteRestaurantFlag objectAtIndex:i] isEqualToString:@"0"])
                [btnDeleteRest setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
            else
                [btnDeleteRest setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];
            
        }
        
        xPos+= kButtonWidth+space;
        
    }
    
    scrollRestaurantPhotos.backgroundColor = [UIColor clearColor];
    scrollRestaurantPhotos.contentSize = CGSizeMake(xPos, scrollRestaurantPhotos.frame.size.height);
    
}


-(void)setMenuPhotoView
{
    int kButtonWidth = 70;
    int xPos = 10;
    int yPos = 5;
    int space = 10;
    
    
    int arrayLimit;
    
    if(menuPhotosCount < kMenuPhotosLimits)
    {
        arrayLimit = menuPhotosCount + 1;
        isAddMorePhoto = YES;
        
    }
    else
    {
        arrayLimit = menuPhotosCount;
        isAddMorePhoto = NO;
    }

    
    for(id subview in scrollMenuPhotos.subviews)
        [subview removeFromSuperview];

    
    for(int i =0; i<arrayLimit; i++)
    {
        btnAddMenuPhotos = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAddMenuPhotos.frame = CGRectMake(xPos, yPos, kButtonWidth, kButtonWidth);
        //[btnAddMenuPhotos setTitle:@"Forgot Password?" forState:UIControlStateNormal];
        btnAddMenuPhotos.titleLabel.font = [UIFont fontWithName:_roboto_light size:18];
        btnAddMenuPhotos.titleLabel.textAlignment = NSTextAlignmentRight;
        btnAddMenuPhotos.backgroundColor = [UIColor clearColor];
        [scrollMenuPhotos addSubview:btnAddMenuPhotos];
        
        [btnAddMenuPhotos.layer setBorderColor: [kGrayTextColor CGColor]];
        [btnAddMenuPhotos.layer setBorderWidth: 0.3f];
        //[btnAddRestaurantPhotos.layer setShadowOffset:CGSizeMake(0.4, 0.4)];
        //[btnAddRestaurantPhotos.layer setShadowRadius: 1.3];
        //[btnAddRestaurantPhotos.layer setShadowOpacity: 0.4];
        
        
        if(isAddMorePhoto && ((i+1) == arrayLimit))
        {
            [btnAddMenuPhotos setImage:[UIImage imageNamed:@"camera-icon"] forState:UIControlStateNormal];
            [btnAddMenuPhotos addTarget:self action:@selector(btnAddMenuPhotosTapped:) forControlEvents:UIControlEventTouchUpInside];

        }
        else
        {
            [btnAddMenuPhotos setImage:[UIImage imageNamed:@"dummy"] forState:UIControlStateNormal];
            [btnAddMenuPhotos addTarget:self action:@selector(viewMenuPhotosTapped:) forControlEvents:UIControlEventTouchUpInside];

            
            
            UIButton *btnDeleteMenu = [UIButton buttonWithType:UIButtonTypeCustom];
            btnDeleteMenu.frame = CGRectMake(kButtonWidth-15, 0, 15, 15);
            btnDeleteMenu.tag = i;
            btnDeleteMenu.titleLabel.textAlignment = NSTextAlignmentRight;
            btnDeleteMenu.backgroundColor = [UIColor clearColor];
            [btnDeleteMenu addTarget:self action:@selector(btnDeleteMenuTapped:) forControlEvents:UIControlEventTouchUpInside];
            [btnAddMenuPhotos addSubview:btnDeleteMenu];
            
            if([[arrayDeleteMenuFlag objectAtIndex:i] isEqualToString:@"0"])
                [btnDeleteMenu setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
            else
                [btnDeleteMenu setImage:[UIImage imageNamed:@"checkbox-selected"] forState:UIControlStateNormal];

            
        }
        
        
        xPos+= kButtonWidth+space;
        
    }
    
    scrollMenuPhotos.backgroundColor = [UIColor clearColor];
    scrollMenuPhotos.contentSize = CGSizeMake(xPos, scrollRestaurantPhotos.frame.size.height);
    
}

-(void)btnDeleteRestTapped:(id)sender
{
    
    if([[arrayDeleteRestaurantFlag objectAtIndex:[sender tag]] isEqualToString:@"0"])
        [arrayDeleteRestaurantFlag replaceObjectAtIndex:[sender tag] withObject:@"1"];
    else
        [arrayDeleteRestaurantFlag replaceObjectAtIndex:[sender tag] withObject:@"0"];

    
    if([arrayDeleteRestaurantFlag containsObject:@"1"])
        btnDeleteRestPhotos.enabled = YES;
    else
        btnDeleteRestPhotos.enabled = NO;

    
    [self setRestaurantPhotoView];
    
}

-(void)btnDeleteMenuTapped:(id)sender
{
    
    if([[arrayDeleteMenuFlag objectAtIndex:[sender tag]] isEqualToString:@"0"])
        [arrayDeleteMenuFlag replaceObjectAtIndex:[sender tag] withObject:@"1"];
    else
        [arrayDeleteMenuFlag replaceObjectAtIndex:[sender tag] withObject:@"0"];
    
    
    if([arrayDeleteMenuFlag containsObject:@"1"])
        btnDeleteMenuPhotos.enabled = YES;
    else
        btnDeleteMenuPhotos.enabled = NO;

    
    [self setMenuPhotoView];
    
}

-(void)viewRestaurantPhotosTapped:(id)sender
{
    
}


-(void)viewMenuPhotosTapped:(id)sender
{
    
}

-(IBAction)deteteRestaurantPhotos:(id)sender
{
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"delete_restaurant_photos") leftButtonTitle:LocalizedString(@"yes") rightButtonTitle:LocalizedString(@"no") showsImage:NO];
    [alert show];
    
    alert.leftBlock = ^()
    {
        //for(int i =0; i<)
    };
    
}

-(IBAction)deteteMenuPhotos:(id)sender
{
    
}


-(IBAction)btnAddRestaurantPhotosTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:LocalizedString(@"add_rest_pic")
                                  delegate:self
                                  cancelButtonTitle:LocalizedString(@"cancel")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:LocalizedString(@"take_pic"), LocalizedString(@"select_gallary_pic"),
                                  nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    

}


-(IBAction)btnAddMenuPhotosTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:LocalizedString(@"add_menu_pic")
                                  delegate:self
                                  cancelButtonTitle:LocalizedString(@"cancel")
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:LocalizedString(@"take_pic"), LocalizedString(@"select_gallary_pic"),
                                  nil];

    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}


#pragma mark ---- ----- ----  -----
#pragma mark ---- ----- ACTION SHEET DELEGATE ----  -----

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    switch (buttonIndex) {
            
        case 0:
            [self takePhotoFromCamera];
            break;
            
        case 1:
            [self choosePhotoFromGallery];
            break;
    }
    
}
/*
- (void)changeTextColorForUIActionSheet:(UIActionSheet*)actionSheet
{
    UIColor *tintColor = [UIColor redColor];
    
    NSArray *actionSheetButtons = actionSheet.subviews;
    for (int i = 0; [actionSheetButtons count] > i; i++)
    {
        UIView *view = (UIView*)[actionSheetButtons objectAtIndex:i];
        
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton*)view;
            [btn setTitleColor:tintColor forState:UIControlStateNormal];
            
        }
    }
}


- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subview in actionSheet.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor greenColor]];
        }
    }
}
*/
-(void)takePhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
}
-(void)choosePhotoFromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark ---- ----- ----  -----
#pragma mark ---- ----- IMAGE PICKER DELEGATE ----  -----


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark ---- ----- ----  -----



@end
