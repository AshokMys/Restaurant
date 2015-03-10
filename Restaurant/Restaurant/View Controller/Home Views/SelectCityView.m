//
//  SelectCityView.m
//  Restaurant
//
//  Created by IMAC05 on 02/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "SelectCityView.h"
#import "Constants.h"

#import "CustomAlertView.h"

#define kRowHeight 44
#define kHeaderHeight 30


@interface SelectCityView ()

@end

@implementation SelectCityView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([[AppMemory getDataForKey:LANGUAGE_KEY] isEqualToString:LANGUAGE_VALUE_ENG])
        isEnglish = YES;
    else
        isEnglish = NO;
    
    
    [self setUIAsPerLanguage];

    locationManager = [[CLLocationManager alloc] init];
     geocoder = [[CLGeocoder alloc] init];
    
    
    arrayCity = [[NSMutableArray alloc]init];
    
    [arrayCity addObject:@"Pune"];
    [arrayCity addObject:@"Mumbai"];
    [arrayCity addObject:@"Ahmednagar"];
    [arrayCity addObject:@"Aurangabad"];

    arrayCountry = [[NSMutableArray alloc]init];
    [arrayCountry addObject:@"India"];
    [arrayCountry addObject:@"Austrelia"];
    [arrayCountry addObject:@"America"];
}


-(void)setUIAsPerLanguage
{
    labelTopHeader.text = LocalizedString(@"select_city");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
   
    btnBack.frame = CGRectMake(isEnglish ? 10 : DEVICE_WIDTH-45, 25, 35, 34);
    [btnBack setImage:[UIImage imageNamed:isEnglish ? @"back" : @"back_ar"] forState:UIControlStateNormal];
    
    btnAutoSearch.titleLabel.font  =  [UIFont fontWithName:_roboto size:16];
    [btnAutoSearch setTitle:LocalizedString(@"select_auto_city") forState:UIControlStateNormal];
   
    textSearch.font  =  [UIFont fontWithName:_roboto size:14];
    textSearch.placeholder = LocalizedString(@"select_manualy_city");
    textSearch.textAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    
    btnSearch.frame = CGRectMake(isEnglish ? DEVICE_WIDTH - 35 - 20 : 28, btnSearch.frame.origin.y+2, 26, 26);

    
    UIView *paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 32)];
    
    if(isEnglish)
    {
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = paddingUserName;
        
    }
    else
    {
        textSearch.leftViewMode = UITextFieldViewModeAlways;
        textSearch.leftView = paddingUserName;
        
        paddingUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 32)];
        textSearch.rightViewMode = UITextFieldViewModeAlways;
        textSearch.rightView = paddingUserName;
        
        
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(IBAction)btnAutoSearchTapped:(id)sender
{
    [appDelegate startSpinner];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
}


-(IBAction)btnManuallySearchCityTapped:(id)sender
{
    
    
}


-(IBAction)btnSkipTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];

}

#pragma mark -------- -----------
#pragma mark ---- TEXT FIELD DELEGATE -----


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark ----
#pragma mark ----  TABLE VIEW DELEGATE -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayCity count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrayCountry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderHeight;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableCity.frame.size.width, kHeaderHeight)];
    headerView.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    
//    UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnHeader.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
//    //[btnHeader addTarget:self action:@selector(btnHeaderTapped:) forControlEvents:UIControlEventTouchUpInside];
//    btnHeader.tag = section;
//    [headerView addSubview:btnHeader];
    
    
    UILabel *labelTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableCity.frame.size.width-20, kHeaderHeight)];
    labelTitle.TextAlignment = isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.font = [UIFont fontWithName:_roboto_light size:16];
    labelTitle.textColor = [UIColor darkGrayColor];
    [headerView addSubview:labelTitle];

        labelTitle.text = LocalizedString([arrayCountry objectAtIndex:section]);

    
//    UIImageView *headerSeperator = [[UIImageView alloc]initWithFrame:CGRectMake(isEnglish ? 10 : , kHeaderHeight-1, tableCity.frame.size.width-20, 1)];
//    headerSeperator.image = [UIImage imageNamed:@"Separator-white"];
//    [btnHeader addSubview:headerSeperator];
    
    return headerView;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
       
    UILabel *labelName =[[UILabel alloc] init];
    labelName.frame = CGRectMake(10, 0, tableView.frame.size.width-20, kRowHeight);
    labelName.TextAlignment =  isEnglish ? NSTextAlignmentLeft : NSTextAlignmentRight;
    labelName.numberOfLines = 0;
    labelName.text = [arrayCity objectAtIndex:indexPath.row];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.font = [UIFont fontWithName:_roboto size:15];
    labelName.textColor = kGrayTextColor;
    [cell.contentView addSubview:labelName];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textSearch.text = [arrayCity objectAtIndex:indexPath.row];
    
    [appDelegate saveToUserDefaultsForKey:@"CITY" saveValue:[arrayCity objectAtIndex:indexPath.row]];
    
    [btnSkip setTitle:LocalizedString(@"done") forState:UIControlStateNormal];
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [appDelegate stopSpinner];

    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:LocalizedString(@"app_name") contentText:error.description leftButtonTitle:nil rightButtonTitle:LocalizedString(@"ok") showsImage:NO];
    [alert show];
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        NSLog(@"-- Longitude :%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"-- Latitude :%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        

    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {

        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
       
        if (error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            
            NSString *address = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
            
#if DEBUG
            NSLog(@"-- Add : %@", address);
            NSLog(@"-- City : %@", placemark.locality);
#endif
            
            [appDelegate stopSpinner];
            [appDelegate saveToUserDefaultsForKey:@"CITY" saveValue:placemark.locality];
            [self.navigationController popViewControllerAnimated:NO];
            
            
        } else
        {
            NSLog(@"%@", error.debugDescription);
        }
        
    } ];
    
}

@end
