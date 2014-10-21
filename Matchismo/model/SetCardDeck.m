//
//  SetCardDeck.m
//  Matchismo
//
//  Created by GoGoCav on 10/21/14.
//  Copyright (c) 2014 GoGoCav Games. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        SetCard *card = [[SetCard alloc] init];
        
        for (NSString *symbol in [SetCard validSymbol]) {
            for (NSString *color in [SetCard validColor]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (int number = 1; number <= [SetCard maxNumber]; number ++){
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
