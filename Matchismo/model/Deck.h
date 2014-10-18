//
//  Deck.h
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
