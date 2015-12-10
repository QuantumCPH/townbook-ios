//
//  MyTownHomeVC.m
//  SalamCenterApp
//
//  Created by Globit on 10/12/2015.
//  Copyright © 2015 Globit. All rights reserved.
//

#import "MyTownHomeVC.h"
#import "MyTownCollectionCell.h"
#import "MyTownItem.h"

@interface MyTownHomeVC ()
{
    NSMutableArray * mainArray;
}

@end

@implementation MyTownHomeVC
-(id)init{
    self=[super initWithNibName:@"MyTownHomeVC" bundle:nil];
    if (self) {
        mainArray=[[NSMutableArray alloc]init];
        MyTownItem *tourist=[[MyTownItem alloc]init];
        tourist.title=@"Turist";
        tourist.imgName=@"";
        tourist.url=@"http://bornholm.info/da";
        [mainArray addObject:tourist];
        
        MyTownItem *municiple=[[MyTownItem alloc]init];
        municiple.title=@"Kommunen";
        municiple.imgName=@"";
        municiple.url=@"http://www.brk.dk/Sider/Forside.aspx";
        [mainArray addObject:municiple];
        
        MyTownItem *brighGreenIsland=[[MyTownItem alloc]init];
        brighGreenIsland.title=@"Bright Green Island";
        brighGreenIsland.imgName=@"";
        brighGreenIsland.url=@"http://brightgreenisland.dk";
        [mainArray addObject:brighGreenIsland];
        
        MyTownItem *newComer=[[MyTownItem alloc]init];
        newComer.title=@"Tilflytter";
        newComer.imgName=@"";
        newComer.url=@"http://flyttilbornholm.dk";
        [mainArray addObject:newComer];
        
        MyTownItem *bussiness=[[MyTownItem alloc]init];
        bussiness.title=@"Erhverv";
        bussiness.imgName=@"";
        bussiness.url=@"http://bornholm.biz";
        [mainArray addObject:bussiness];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"MyTownCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"myTownCollectionCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Collection View
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return mainArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = (self.view.frame.size.width - 30) /2;
    return CGSizeMake(height, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);//(top, left, bottom, right);
}
- (MyTownCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyTownCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myTownCollectionCell" forIndexPath:indexPath];
    MyTownItem * item=[mainArray objectAtIndex:indexPath.row];
    cell.lblTitle.text=item.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyTownItem * item=[mainArray objectAtIndex:indexPath.row];
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.url]]) {
        NSLog(@"%@%@",@"Failed to open url:",item.url);
    }
}

@end
