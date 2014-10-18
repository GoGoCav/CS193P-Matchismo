//
//  PlayingCard.h
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
