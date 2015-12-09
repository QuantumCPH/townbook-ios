//
//  DemoViewController.h
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.
//

#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController
{
    UIImageView * imgView;
}
@property (strong, nonatomic) IBOutlet UIView *tableView;
@property (nonatomic) CGRect defaultimagePagerFrame;

@property (nonatomic) CGFloat defaultimagePagerHeight;
/**
 How fast is the table view scrolling with the image picker
 */
@property (nonatomic) CGFloat parallaxScrollFactor;
@end
