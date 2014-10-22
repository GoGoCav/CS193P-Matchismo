//
//  PlayingCard.m
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] > 0) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank == self.rank) {
                score += 4;
            }
            else if ([otherCard.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    
    if ([otherCards count] > 1) {
        Card *firstCard = [otherCards firstObject];
        otherCards = [otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] -1)];
        score += [firstCard match:otherCards];
    }
    
    return score;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠️", @"♥️", @"♣️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"1", @"2", @"3", @"4", @"5", @"6", @"7",
             @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@end
