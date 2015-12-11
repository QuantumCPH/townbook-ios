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
#import "EventDetailVC.h"

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
        event1.title=@"Julefrokost - medbring en ret";
        event1.briefText=@"Vi er et ungt par der lige er flyttet til Rønne, og synes at det kunne være hyggeligt at samles til en julefrokost, således at vi kunne lærer andre at kende.";
        event1.descText=@"Vi er har en nem adgang til et beboerlokale og synes at det kunne være hyggeligt at samles til en julefrokost og lærer vores andre familier i byen at kende. \nTanken er at I medbringer en kold/lun ret til julefrokostbuffeten samt drikkevarer til eget forbrug (der er glas til øl, vin og snaps). Der er køkken med mulighed for at varme mad og let anretning, men jeg vil anbefale at I så vidt muligt kommer med maden klar til servering.\nTil indkøb af brød m.m. + lokaleleje bedes alle overføre 35 kr. senest lørdag via Mobilepay til 30916169.\nFor at få en god blandet buffet vil jeg opfordre til at I skriver i kommentarfeltet, hvad I påtænker at tage med. En dessert er også velkommen :)\nMedbring to små pakker til pakkelegen. Andre festlige indslag må også gerne medbringes.\nDer står Fælleslokale på dørtelefonen, derefter er det tværs over gården.\nVi glæder os til at se jer alle sammen :)";
        event1.userName=@"Saad";
        event1.place=@"Industrivej 2, 3700 Rønne";
        event1.dateEvent=@"12-12-2016 18:00";
        event1.dateCreated=@"08-12-2015 16:30";
        event1.imgName=@"event1";
        event1.price=@"35 kr";
        
        EventItem * event2=[[EventItem alloc]init];
        event2.title=@"Fodbold";
        event2.briefText=@"Vi er 3 friske drenge der gerne vil spille indendørs fodbold men vi mangler 3 yderligere spillere ";
        event2.descText=@"Hvis du har lyst til at spille fodbold nu på søndag d. 13.12.2015 og har tid kl. 17.00, så kan du joine os til at spille fodbold i Søndermarkshallen. Vi har behov for 3 spillere i alt.\n I kan kontakte mig på: 30916169";
        event2.userName=@"Saad";
        event2.place=@"Industrivej 2, 3700 Rønne";
        event2.dateEvent=@"13-12-2016 13:50";
        event2.dateCreated=@"08-12-2015 17:00";
        event2.imgName=@"event2";
        event2.price=@"50 kr";
        
        EventItem * event3=[[EventItem alloc]init];
        event3.title=@"Skulptursamlingen – Bornholms Kunstmuseum";
        event3.briefText=@"Skulptursamlingen – Bornholms Kunstmuseum Bornholms Kunstmuseum rummer store samlinger af både malerier, grafik, kunsthåndværk og skulpturer. I år har vi valgt at sætte fokus på ...";
        event3.descText=@"Bornholms Kunstmuseum rummer store samlinger af både malerier, grafik, kunsthåndværk og skulpturer.\nI år har vi valgt at sætte fokus på skulptursamlingen i den årbog alle medlemmer af Museumsforeningen modtager hvert år. Vi har derfor også hentet en lang række skulpturer frem fra magasinerne. Tidsmæssigt spænder udstillingen over mere end 100 år og udtryksmæssigt lige fra realistiske portrætter til helt nonfigurative former og giver mulighed for at gå på opdagelse i forskellige tidsaldres særlige udtryk og ideer.";
            
        event3.userName=@"Saad";
        event3.place=@"Bornholms Kunstmuseum, Otto Bruuns Pl. 1, 3760 Gudhjem";
        event3.dateEvent=@"14.12.2016 10:00 - 17:00";
        event3.dateCreated=@"10-12-2015 16:30";
        event3.imgName=@"event3";
        event3.price=@"70 kr";
        
        
        [mainArray addObject:event1];
        [mainArray addObject:event2];
        [mainArray addObject:event3];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblTitle.text=NSLocalizedString(@"Event", nil);
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateNormal];
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateHighlighted];
    [self.btnCreate setTitle:NSLocalizedString(@"Create Event", nil) forState:UIControlStateSelected];
    [self.segmentBar setTitle:NSLocalizedString(@"All", nil) forSegmentAtIndex:0];
    [self.segmentBar setTitle:NSLocalizedString(@"Mine", nil) forSegmentAtIndex:1];

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
    cell.tvDescription.text=event.briefText;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EventItem * event=[mainArray objectAtIndex:indexPath.row];
    EventDetailVC * detailVC=[[EventDetailVC alloc]initWithEvent:event];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
