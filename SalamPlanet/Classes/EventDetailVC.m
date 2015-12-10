//
//  EventDetailVC.m
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "EventDetailVC.h"

@interface EventDetailVC ()
{
    NSMutableArray * mainArray;
}
@property (nonatomic,strong)EventItem * event;
@end

@implementation EventDetailVC

-(id)initWithEvent:(EventItem*)item{
    self=[super initWithNibName:@"EventDetailVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        [mainArray addObject:@"TopCell"];
        [mainArray addObject:@"ActionCell"];
        [mainArray addObject:@"DetailCell"];
        [mainArray addObject:@"MapCell"];
        _event=item;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text=NSLocalizedString(@"Event Detail", nil);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: UITableView Delegates and Datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"TopCell"]) {
        return 253;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"ActionCell"]) {
        return 40;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"DetailCell"]) {
        return 196;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"MapCell"]) {
        return 204;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"TopCell"]) {
        self.lblUserName.text=_event.userName;
        self.imgEvent.image=[UIImage imageNamed:_event.imgName];
        self.lblDateCreated.text=_event.dateCreated;
        self.lblDateHappen.text=_event.dateEvent;
        self.lblPlace.text=_event.place;
        [UtilsFunctions makeUIImageViewRound:self.imgUser ANDRadius:self.imgUser.frame.size.width/2];
        self.cellTop.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellTop;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"ActionCell"]) {
        self.cellActionBar.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellActionBar;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"DetailCell"]) {
        self.lblEventTitle.text=_event.title;
        self.cellDetail.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellDetail;
    }
    else if ([[mainArray objectAtIndex:indexPath.row]isEqualToString:@"MapCell"]) {
        self.cellMap.selectionStyle=UITableViewCellSelectionStyleNone;
        return self.cellMap;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark-IBActions
- (IBAction)btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
