//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, strong) NSMutableArray *cards;// for Card
@property (nonatomic, strong) NSMutableArray *chosenCards; //for Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (NSInteger)matchNumber
{
    return _matchNumber >= 2 && _matchNumber <= [self.cards count] ? _matchNumber : 2;
}

- (Card *)cardAtIndex:(NSUInteger) index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        if (count > 1) { // at least 2 cards to play the game
            for (int i = 0; i < count; i++) {
                Card *card = [deck drawRandomCard];
                if (card) { // prevent from lack of cards in the deck
                    [self.cards addObject:card];
                } else {
                    self = nil;
                    break;
                }
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// the main game rule defined here
- (void)chooseCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    self.lastScore = 0;
    self.chosenCards = nil;
    
    NSInteger matchScore = 0;
    
    if (!card.isMatched) {
        card.chosen = !card.chosen; // flip the chosen card
    }
    
    for (Card *chosenCard in self.cards) {
        if (chosenCard.isChosen && !chosenCard.isMatched) {
            [self.chosenCards addObject:chosenCard]; // record all the upside cards
        }
    }
    
    if ([self.chosenCards count] == self.matchNumber) {
        Card *firstCard = [self.chosenCards firstObject];
        NSRange range = NSMakeRange(1, [self.chosenCards count] - 1);
        NSArray *restCards = [self.chosenCards subarrayWithRange:range];
        // match the first card in the chosen cards array to the rest of them.
        matchScore = [firstCard match:restCards];
    
        if (matchScore > 0) {
            self.lastScore += matchScore * MATCH_BONUS;
            for (Card *card in self.chosenCards) {
                card.matched = YES;
            }
        } else {
            self.lastScore -= 2 * MISMATCH_PENALTY;
            // flip back the first and the second end cards
            for (Card *aCard in self.chosenCards) {
                if (aCard != card) {
                    aCard.chosen = NO;
                }
            }
        }
    }
    self.score += self.lastScore - COST_TO_CHOOSE;
}

@end
