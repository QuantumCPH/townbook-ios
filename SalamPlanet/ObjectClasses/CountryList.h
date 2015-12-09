//
//  CountryList.h
//  TabBasedSip
//
//  Created by Smonte Technologies on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CountryList : NSObject 
{

	NSMutableArray *arrayNames;
	NSMutableArray *arrayValue;
    NSMutableArray *arrayShortNames;
    NSMutableArray *arrayCode;
	NSDictionary *countryCodes;
}
@property (nonatomic, retain) NSMutableArray *arrayNames;
@property (nonatomic, retain) NSMutableArray *arrayShortNames;
@property (nonatomic, retain) NSMutableArray *arrayValue;
@property (nonatomic, retain) NSDictionary *countryCodes;

- (void)setupData;

@end
