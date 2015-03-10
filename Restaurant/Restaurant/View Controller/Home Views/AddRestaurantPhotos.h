//
//  AddRestaurantPhotos.h
//  Restaurant
//
//  Created by IMAC05 on 23/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AddRestaurantPhotos : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate >
{
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView, *scrollRestaurantPhotos, *scrollMenuPhotos;
    
    IBOutlet UILabel *labelTopHeader;

    IBOutlet UILabel *labelRestaurantPhotosPlaceholder, *labelMenuPhotosPlaceholder;
    IBOutlet UIButton *btnAddRestaurantPhotos, *btnAddMenuPhotos, *btnBack, *btnSubmit, *btnDeleteRestPhotos, *btnDeleteMenuPhotos;
    

    UIImagePickerController *imagePicker;

    BOOL isEnglish, isAddMorePhoto;
    
    int kRestaurantPhotosLimits, kMenuPhotosLimits;
    int restaurantPhotosCount;
    int menuPhotosCount;
    NSMutableArray *arrayDeleteRestaurantFlag, *arrayDeleteMenuFlag;
    
}

@property (nonatomic, readwrite) BOOL isEditable;


@end
