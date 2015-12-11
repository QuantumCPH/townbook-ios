//
//  LanguagesVC.m
//  SalamCenterApp
//
//  Created by Waseem Asif on 06/11/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "LanguagesVC.h"
#import "LanguageListCell.h"
#import "UtilsFunctions.h"
#import "Constants.h"
#import "LangaugeManager.h"

@interface LanguagesVC ()
{
    NSArray *languagesArray;
    NSInteger selectedIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LanguagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = NSLocalizedString(@"Change Language",nil);
    selectedIndex = -1;
    languagesArray = @[NSLocalizedString(@"Phone default", nil),NSLocalizedString(@"English", nil),NSLocalizedString(@"Danish", nil)];
    if (GetStringWithKey(kAppLangauge))
    {
        if ([GetStringWithKey(kAppLangauge)isEqualToString:kEnglish]) {
            selectedIndex = 1;
        }
        else if ([GetStringWithKey(kAppLangauge)isEqualToString:kDanish]) {
            selectedIndex = 2;
        }
        else{
            selectedIndex = 0;
        }
    }
    else
    {
        selectedIndex = 0;
    }
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}
- (void)changeLanguage
{
    ShowMessage(kAppName,NSLocalizedString(@"Please restart the application for applying the change.", nil));
    if (selectedIndex == 0 )
    {
        [NSBundle setLanguage:nil];
        SaveStringWithKey(nil, kAppLangauge);
    }
    else if (selectedIndex == 1)
    {
        [NSBundle setLanguage:kEnglish];
        SaveStringWithKey(kEnglish, kAppLangauge);
    }
    else
    {
        [NSBundle setLanguage:kDanish];
        SaveStringWithKey(kDanish, kAppLangauge);
    }
}
#pragma mark:IBActions
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languagesArray.count;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanguageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LanguageListCell"];
    cell.titleLabel.text = languagesArray[indexPath.row];
    
    if (selectedIndex == indexPath.row)
        cell.tickButton.hidden = NO;
    else
        cell.tickButton.hidden = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanguageListCell *cell = (LanguageListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.tickButton.hidden = NO;
    selectedIndex = indexPath.row;
   [self changeLanguage];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanguageListCell *cell = (LanguageListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.tickButton.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
