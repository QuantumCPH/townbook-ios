//
//  EventsHomeVC.m
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "EventsHomeVC.h"
#import "EventHomeCell.h"
#import "EventItem.h"

@interface EventsHomeVC ()
{
    NSMutableArray * mainArray;
}
@end

@implementation EventsHomeVC
-(id)init{
    self=[super initWithNibName:@"EventsHomeVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        EventItem * event1=[[EventItem alloc]init];
        event1.title=@"Get to gather for Dinner feed";
        event1.userName=@"Saad";
        event1.place=@"McDonalds Egerton Road Lahore";
        event1.dateEvent=@"31-12-2015 13:50";
        event1.dateCreated=@"24-12-2015 16:30";
        event1.imgName=@"event1";
        
        EventItem * event2=[[EventItem alloc]init];
        event2.title=@"Get to gather for Dinner feed";
        event2.userName=@"Saad";
        event2.place=@"McDonalds Egerton Road Lahore";
        event2.dateEvent=@"31-12-2015 13:50";
        event2.dateCreated=@"24-12-2015 16:30";
        event2.imgName=@"event2";
        
        EventItem * event3=[[EventItem alloc]init];
        event3.title=@"Get to gather for Dinner feed";
        event3.userName=@"Saad";
        event3.place=@"McDonalds Egerton Road Lahore";
        event3.dateEvent=@"31-12-2015 13:50";
        event3.dateCreated=@"24-12-2015 16:30";
        event3.imgName=@"event3";
        
        EventItem * event4=[[EventItem alloc]init];
        event4.title=@"Get to gather for Dinner feed";
        event4.userName=@"Saad";
        event4.place=@"McDonalds Egerton Road Lahore";
        event4.dateEvent=@"31-12-2015 13:50";
        event4.dateCreated=@"24-12-2015 16:30";
        event4.imgName=@"event1";
        
        [mainArray addObject:event1];
        [mainArray addObject:event2];
        [mainArray addObject:event3];
        [mainArray addObject:event4];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text=NSLocalizedString(@"Event", nil);
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateNormal];
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateHighlighted];
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateSelected];
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
    return 164;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventHomeCell"];
    if(cell == nil){
        NSArray * array= [[NSBundle mainBundle] loadNibNamed:@"EventHomeCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    EventItem * event=[mainArray objectAtIndex:indexPath.row];
    cell.lblTitle.text=event.title;
    cell.lblDate.text=event.dateEvent;
    cell.lblPlace.text=event.place;
    cell.lblUserName.text=event.userName;
    [cell.imgEvent setImage:[UIImage imageNamed:event.imgName]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
