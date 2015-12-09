//
//  AddLocationViewController.h
//  SalamPlanet
//
//  Created by Globit on 23/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGooglePlacesAutocompleteQuery.h"

@protocol AddLocationViewControllerDelegate
-(void)locationNameisSelected:(NSString *)locationName;
@end

@interface AddLocationViewController : UIViewController<UITextFieldDelegate>
{
    SPGooglePlacesAutocompleteQuery *searchQuery;
}
@property (weak, nonatomic) id<AddLocationViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
@property (weak, nonatomic) IBOutlet UITextField *locationInputTF;
- (IBAction)cancelAction:(id)sender;

@property (strong, nonatomic) NSString * locationNameSelected;

@end
