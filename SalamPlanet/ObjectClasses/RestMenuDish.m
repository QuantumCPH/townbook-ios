//
//  RestMenuDish.m
//  SalamCenterApp
//
//  Created by Globit on 04/02/2015.
//  Copyright (c) 2015 Globit. All rights reserved.
//

#import "RestMenuDish.h"

@implementation RestMenuDish
@synthesize dishID;
@synthesize dishDetail;
@synthesize dishPrice;
@synthesize dishTitle;
@synthesize dishType;
-(RestMenuDish*) initWithID:(NSInteger)ID
{
    self = [super init];
    if(self)
    {
        switch (ID) {
            case 0:
                dishID=ID;
                dishTitle=@"Scrambled Cheese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Breakfast";
                dishPrice=@"200 Kr.";
                break;
            case 2:
                dishID=ID;
                dishTitle=@"Fried Eggs with Vegitables";
                dishDetail=@"with olive and mustards sauce Arne Jacobsen Lounge er der rig mulighed for at tage an velfortjient pause og nyde den verdensberomte danske arkitekts design.";
                dishType=@"Breakfast";
                dishPrice=@"3455 Kr.";
                break;
            case 1:
                dishID=ID;
                dishTitle=@"Cheese Eggs";
                dishDetail=@"with olive and sauce..";
                dishType=@"Breakfast";
                dishPrice=@"400 Kr.";
                break;
            case 4:
                dishID=ID;
                dishTitle=@"Scrameese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Breakfast";
                dishPrice=@"230 Kr.";
                break;
            case 3:
                dishID=ID;
                dishTitle=@"Scramblggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Breakfast";
                dishPrice=@"899 Kr.";
                break;
            case 5:
                dishID=ID;
                dishTitle=@"Chicken Cheese";
                dishDetail=@"with olive and cheese and mustard sauce..";
                dishType=@"Breakfast";
                dishPrice=@"1200 Kr.";
                break;
                
            case 6:
                dishID=ID;
                dishTitle=@"Scrambled Cheese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Lunch";
                dishPrice=@"200 Kr.";
                break;
            case 7:
                dishID=ID;
                dishTitle=@"Fried Eggs with Vegitables";
                dishDetail=@"with olive and mustards sauce Arne Jacobsen Lounge er der rig mulighed for at tage an velfortjient pause og nyde den verdensberomte danske arkitekts design.";
                dishType=@"Lunch";
                dishPrice=@"3455 Kr.";
                break;
            case 8:
                dishID=ID;
                dishTitle=@"Cheese Eggs";
                dishDetail=@"with olive and sauce..";
                dishType=@"Lunch";
                dishPrice=@"400 Kr.";
                break;
            case 9:
                dishID=ID;
                dishTitle=@"Scrameese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Lunch";
                dishPrice=@"230 Kr.";
                break;
            case 10:
                dishID=ID;
                dishTitle=@"Scramblggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Lunch";
                dishPrice=@"899 Kr.";
                break;
            case 11:
                dishID=ID;
                dishTitle=@"Chicken Cheese";
                dishDetail=@"with olive and cheese and mustard sauce..";
                dishType=@"Lunch";
                dishPrice=@"1200 Kr.";
                break;
                
            case 13:
                dishID=ID;
                dishTitle=@"Scrambled Cheese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Dinner";
                dishPrice=@"200 Kr.";
                break;
            case 12:
                dishID=ID;
                dishTitle=@"Fried Eggs with Vegitables";
                dishDetail=@"with olive and mustards sauce Arne Jacobsen Lounge er der rig mulighed for at tage an velfortjient pause og nyde den verdensberomte danske arkitekts design.";
                dishType=@"Dinner";
                dishPrice=@"3455 Kr.";
                break;
            case 16:
                dishID=ID;
                dishTitle=@"Cheese Eggs";
                dishDetail=@"with olive and sauce..";
                dishType=@"Dinner";
                dishPrice=@"400 Kr.";
                break;
            case 15:
                dishID=ID;
                dishTitle=@"Scrameese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Dinner";
                dishPrice=@"230 Kr.";
                break;
            case 14:
                dishID=ID;
                dishTitle=@"Scramblggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Dinner";
                dishPrice=@"899 Kr.";
                break;
            case 17:
                dishID=ID;
                dishTitle=@"Chicken Cheese";
                dishDetail=@"with olive and cheese and mustard sauce..";
                dishType=@"Dinner";
                dishPrice=@"1200 Kr.";
                break;
                
            case 18:
                dishID=ID;
                dishTitle=@"Scrambled Cheese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Italina";
                dishPrice=@"200 Kr.";
                break;
            case 19:
                dishID=ID;
                dishTitle=@"Fried Eggs with Vegitables";
                dishDetail=@"with olive and mustards sauce Arne Jacobsen Lounge er der rig mulighed for at tage an velfortjient pause og nyde den verdensberomte danske arkitekts design.";
                dishType=@"Italina";
                dishPrice=@"3455 Kr.";
                break;
            case 20:
                dishID=ID;
                dishTitle=@"Cheese Eggs";
                dishDetail=@"with olive and sauce..";
                dishType=@"Italina";
                dishPrice=@"400 Kr.";
                break;
            case 21:
                dishID=ID;
                dishTitle=@"Scrameese Eggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Italina";
                dishPrice=@"230 Kr.";
                break;
            case 22:
                dishID=ID;
                dishTitle=@"Scramblggs";
                dishDetail=@"with olive and mustards sauce..";
                dishType=@"Italina";
                dishPrice=@"899 Kr.";
                break;
            case 23:
                dishID=ID;
                dishTitle=@"Chicken Cheese";
                dishDetail=@"with olive and cheese and mustard sauce..";
                dishType=@"Italina";
                dishPrice=@"1200 Kr.";
                break;
            default:
                break;
        }
    }
    return self;
}
@end
