//
//  CountryListViewController.m
//  SalamPlanet
//
//  Created by Saad Khan on 18/09/2014.
//  Copyright (c) 2014 Globit. All rights reserved.
//


#import "CountryListViewController.h"
#import "CountryList.h"
#import "AppDelegate.h"

@interface CountryListViewController ()
{
    NSArray * arrayAtoZ;
    NSMutableDictionary * mainDictionary;
    NSMutableArray * mainSectionArray;
    AppDelegate * appDelegate;
}
@end
@implementation CountryListViewController

- (id)init
{
    self = [super initWithNibName:@"CountryListViewController" bundle:nil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self dolocalizationText];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    tableView.backgroundColor =[UIColor clearColor];
    tableView.backgroundColor = nil;

	CountryList *obj = [[CountryList alloc] init];
	countries = [[NSMutableArray alloc] initWithArray:obj.arrayNames];
    countriesCode = [[NSMutableDictionary alloc] initWithDictionary:obj.countryCodes];
	[countries removeObjectAtIndex:0];
    
    //By Saad
    appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.bgImgV setImage:[UIImage imageNamed:[appDelegate getBackgroundImageName]]];
    mainDictionary=[[NSMutableDictionary alloc]init];
    mainSectionArray=[[NSMutableArray alloc]init];
    [self initializeArrayAtoZ];
    [self filterMainArray];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self initializeCustomIndexView];
}

- (void)viewDidAppear:(BOOL)animated
{
	[tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
-(void)dolocalizationText{
    self.lblPageTitle.text=NSLocalizedString(@"Select country", nil);
}

#pragma mark-Custom Methods
-(void)initializeCustomIndexView{
    // initialise MJNIndexView
    //CGRect frame=tableView.frame;
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y+=64;
    frame.size.height-=64;
//    if(IS_IPHONE_4){
//        frame.size.height-=160;
//        frame.origin.y+=40;
//    }
//    else{
        frame.size.height-=40;
        frame.origin.y+=10;

    self.indexView = [[MJNIndexView alloc]initWithFrame:frame];
    self.indexView.dataSource = self;
    [self firstAttributesForMJNIndexView];
    [self.view addSubview:self.indexView];
}
- (void)firstAttributesForMJNIndexView
{
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue" size:24.0];
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = NO;
    if(IS_IPHONE_4){
        self.indexView.upperMargin = 0.0;
    }
    else{
        self.indexView.upperMargin = 22.0;
    }
    self.indexView.lowerMargin = 22.0;
    self.indexView.rightMargin = 3.0;//10
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    self.indexView.maxItemDeflection = 100.0;
    self.indexView.rangeOfDeflection = 5;
    self.indexView.fontColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    self.indexView.selectedItemFontColor = [UIColor colorWithRed:102.0/255.0 green:51.0/255.0 blue:153.0/255.0 alpha:1];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
}
-(void)initializeArrayAtoZ{
    arrayAtoZ=[[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
}
-(void)filterMainArray{
    [mainDictionary removeAllObjects];
    [mainSectionArray removeAllObjects];
    //Sorting the array
    [countries sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (NSString * name in countries) {
        if(name && ![name isEqual:[NSNull null]] && name.length > 0)
        {
            NSString * firstChar = [[name substringToIndex:1]capitalizedString];//changed
            if (firstChar && ![firstChar isEqual:[NSNull null]] )
            {
                if ([mainDictionary valueForKey:firstChar]) {
                    NSMutableArray * array = [mainDictionary valueForKey:firstChar];
                    [array addObject:name];
                }
                else{
                    NSMutableArray * array = [[NSMutableArray alloc] init];
                    [array addObject:name];
                    [mainDictionary setObject:array forKey:firstChar];
                    [mainSectionArray addObject:firstChar];
                }
            }
        }
    }
    
}

- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-MJNIndexView Protocol
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    return arrayAtoZ;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    int i;
    for (i = 0; i< [mainSectionArray count]; i++) {
        // Here you return the name i.e. Honda,Mazda
        // and match the title for first letter of name
        // and move to that row corresponding to that indexpath as below
        NSString *letterString = [mainSectionArray objectAtIndex:i];
        if ([letterString isEqualToString:title]) {
            
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)atableView 
{
    return mainSectionArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (NSString*)[mainSectionArray objectAtIndex:section];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section {
//	return [countries count];
    NSArray * array=[mainDictionary objectForKey:[mainSectionArray objectAtIndex:section]];
    return [array count];

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [atableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor= [UIColor clearColor];
    }
	
    cell.textLabel.text = [[mainDictionary objectForKey:[mainSectionArray objectAtIndex:indexPath.section]]objectAtIndex:indexPath.row];//[countries objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger newRow = [indexPath row];
    NSInteger oldRow = (lastIndexPath != nil) ? [lastIndexPath row] : -1;
    
	if (newRow != oldRow) 
	{ 
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath]; 
		//newCell.textLabel.textColor = [UIColor blueColor];
		[[NSUserDefaults standardUserDefaults] setObject:newCell.textLabel.text forKey:kSelectedCountryName];
        NSDictionary *codeDict = [[NSDictionary alloc] initWithDictionary:[countriesCode objectForKey:newCell.textLabel.text]];
        NSLog(@"%@",codeDict);
        [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Code"]forKey:kSelectedCountryCode];
        
        [[NSUserDefaults standardUserDefaults] setObject:[codeDict objectForKey:@"Abbr"]forKey:kSelectedCountryShortName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"name %@ code %@ short name %@",[[NSUserDefaults standardUserDefaults] valueForKey:kSelectedCountryName],[[NSUserDefaults standardUserDefaults] valueForKey:kSelectedCountryCode],[[NSUserDefaults standardUserDefaults] valueForKey:kSelectedCountryShortName]);
        lastIndexPath = indexPath;

    } 
	
	[self.navigationController popViewControllerAnimated:YES];
//    [self dismissModalViewControllerAnimated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (IBAction)cancel:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
