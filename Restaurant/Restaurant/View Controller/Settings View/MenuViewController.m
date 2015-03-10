//
//  MenuViewController.m
//  Restaurant
//
//  Created by IMAC05 on 18/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MenuViewController.h"
#import "Constants.h"
#import "LocalizeHelper.h"

#import "MyProfileView.h"
#import "CustomAlertView.h"
#import "AddRestaurantView.h"
#import "UserViewController.h"
#import "MyFavouriteView.h"
#import "LoginViewController.h"
#import "ManageRestaurantView.h"

#import "AboutUsView.h"
#import "FAQViewController.h"
#import "TermsConditionView.h"

@interface MenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation MenuViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;
    
    
    UIImageView *imageBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    imageBg.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:imageBg];
    
    UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-50, 20, 100, 100)];
    imageLogo.image = [UIImage imageNamed:@"logo"];
    imageLogo.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageLogo];
    
    arrayTitles = [[NSMutableArray alloc]init];
    arrayImages = [[NSMutableArray alloc]init];
    
    [arrayTitles addObject:LocalizedString(@"my_profile")];
    [arrayTitles addObject:LocalizedString(@"add_restaurant")];
    [arrayTitles addObject:LocalizedString(@"manage_restaurant")];
    
    //[arrayTitles addObject:LocalizedString(@"my_account")];
    [arrayTitles addObject:LocalizedString(@"my_favourite")];
    [arrayTitles addObject:LocalizedString(@"faq")];

    [arrayTitles addObject:LocalizedString(@"change_lang")];
    [arrayTitles addObject:LocalizedString(@"menu_login")];
    [arrayTitles addObject:LocalizedString(@"about_us")];
    
    [arrayTitles addObject:LocalizedString(@"contat_us")];
    [arrayTitles addObject:LocalizedString(@"terms_condition")];


    
    [arrayImages addObject:@"my_account"];
    [arrayImages addObject:@"add_restaurant"];
    [arrayImages addObject:@"manage_restaurant"];
    
    //[arrayImages addObject:@"my_account"];
    [arrayImages addObject:@"favs"];
    [arrayImages addObject:@"faq"];
    
    [arrayImages addObject:@"change_language"];
    [arrayImages addObject:@"contact_us"];
    [arrayImages addObject:@"about_us"];
    
    [arrayImages addObject:@"my_account"];
    [arrayImages addObject:@"terms_condition"];

    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,130, DEVICE_WIDTH, DEVICE_HEIGHT -135) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView.bounces = NO;
        tableView;
        
    });
    [self.view addSubview:self.tableView];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [AppMemory setLanguage:LANGUAGE_VALUE_ENG];
        LocalizationSetLanguage(@"en");
        isEnglish = YES;
    }
    else
    {
        [AppMemory setLanguage:LANGUAGE_VALUE_ARE];
        LocalizationSetLanguage(@"ar");
        isEnglish = NO;
    }
    
    [appDelegate setNavigationController];
    [self.sideMenuViewController hideMenuViewController];
    
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     switch (indexPath.row)
    {
    case 0:
        {
            //[self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MyProfileView alloc] init]] animated:YES];
            //[self.sideMenuViewController setContentViewController:profile animated:YES];

            //MyProfileView *profile = [[MyProfileView alloc] init];
            //[appDelegate.nvc pushViewController:profile animated:YES];

            UserViewController *account = [[UserViewController alloc]init];
            [appDelegate.nvc pushViewController:account animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
            
    case 1:
        {
            AddRestaurantView *add = [[AddRestaurantView alloc]init];
            [appDelegate.nvc pushViewController:add animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
            
    case 2:   //Manage Restaurant
        {
           // ManageRestaurantView *manage = [[ManageRestaurantView alloc]init];
            //[appDelegate.nvc pushViewController:manage animated:YES];
            
            NearbyViewController *nearby = [[NearbyViewController alloc]init];
            nearby.isManageRestaurant = YES;
            [appDelegate.nvc pushViewController:nearby animated:YES];

            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
    /*case 3:
        {
            UserViewController *account = [[UserViewController alloc]init];
            [appDelegate.nvc pushViewController:account animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];

        }
            break;
    */
    case 3:  //Favourite
        {
            MyFavouriteView *favourite = [[MyFavouriteView alloc]init];
            [appDelegate.nvc pushViewController:favourite animated:YES];

            [self.sideMenuViewController hideMenuViewController];
        }
        break;
    
    case 4:  //FAQ
        {
            FAQViewController *faq = [[FAQViewController alloc]init];
            [appDelegate.nvc pushViewController:faq animated:YES];
            
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        
    case 5:  //Change Language
        {

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:LocalizedString(@"change_lang") delegate:self cancelButtonTitle:LocalizedString(@"english") otherButtonTitles:LocalizedString(@"arabic"), nil];
            [alert show];
            
            /*
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:LocalizedString(@"change_lang") leftButtonTitle:LocalizedString(@"english") rightButtonTitle:LocalizedString(@"arabic") showsImage:NO];
            [alert show];
            
            
            alert.leftBlock = ^()
            {
                [AppMemory setLanguage:LANGUAGE_VALUE_ENG];
                LocalizationSetLanguage(@"en");
                isEnglish = YES;
                
                [self.sideMenuViewController hideMenuViewController];
                [appDelegate setNavigationController];

                
            };
            
            
            alert.rightBlock = ^()
            {
                [AppMemory setLanguage:LANGUAGE_VALUE_ARE];
                LocalizationSetLanguage(@"ar");
                isEnglish = NO;
              
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                } completion:^(BOOL finished) {
                    
                    [appDelegate setNavigationController];
                    [self.sideMenuViewController hideMenuViewController];

                }];

            };
            */
            
            break;
            
        }
        
    case 6:    // LOGIN
        {
            LoginViewController *login = [[LoginViewController alloc] init];
            [appDelegate.nvc pushViewController:login animated:NO];

            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        
    case 7:   //About Us
        {
            AboutUsView *about = [[AboutUsView alloc] init];
            [appDelegate.nvc pushViewController:about animated:NO];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
        
    case 8:   // Contact Us
        {
            [self sendMail];
            
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
    case 9:   // Terms & Condition
        {
            TermsConditionView *terms = [[TermsConditionView alloc] init];
            [appDelegate.nvc pushViewController:terms animated:NO];
            
            [self.sideMenuViewController hideMenuViewController];
            
        }
            break;
     default:
     break;
     
     }
    
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [arrayTitles count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    
    UIImageView *imageLogo = [[UIImageView alloc] init];
    imageLogo.frame = CGRectMake(isEnglish? 10 : DEVICE_WIDTH-40, 10, 30, 30);
    imageLogo.image = [UIImage imageNamed:arrayImages[indexPath.row]];
    imageLogo.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageLogo];

    
    UILabel *labelTitle = [[UILabel alloc]init];
    labelTitle.frame = CGRectMake(isEnglish? 50 : DEVICE_WIDTH - 225, 5, 175, 40);
    labelTitle.text = arrayTitles[indexPath.row];
    labelTitle.numberOfLines = 0;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.font = [UIFont fontWithName:_roboto_light size:16];
    labelTitle.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    [cell.contentView addSubview:labelTitle];
    
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)sendMail
{
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    // We must always check whether the current device is configured for sending emails
    if ([mailClass canSendMail])
    {
        NSString *mailSubject = @"Test Mail"; //[NSString stringWithFormat:@"Device: %@, OS: %@",[self platformString],[[UIDevice currentDevice] systemVersion]];
        NSString *messageBody = @"";
        NSArray *arrayTo = [[NSArray alloc]initWithObjects:@"test@mys.st", nil ];
        
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:mailSubject];
        [mailComposer setMessageBody:messageBody isHTML:NO];
        [mailComposer setToRecipients:arrayTo];
        
        [self presentViewController:mailComposer animated:YES completion:NULL];
        
    }
    else
    {
        NSString *toAddress = @"test@mys.st";
        NSString *subject = @"Test Mail"; //[NSString stringWithFormat:@"Device:%@, OS:%@",[self platformString],[[UIDevice currentDevice] systemVersion]];
        NSString *body=@"";
        
        NSString *siteLink = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",[toAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], [subject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:siteLink]];
        
    }
    
}


#pragma ----- Mail Compose Controller Delegate -----

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
