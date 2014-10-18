//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger) index;
- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic, readwrite) NSInteger matchNumber;// 2 or 3
@property (nonatomic, readonly, strong) NSMutableArray *chosenCards;// for Card

@end
