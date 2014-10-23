//
//  ViewController.h
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//
//  Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic, readonly) NSMutableArray *matchHistory; // for NSAttributeString

// protected
// for subclasses
- (Deck *)createDeck; // abstract

- (NSAttributedString *)titleForCard:(Card *)card;
- (NSAttributedString *)titleForChosenCard:(Card *)card;

- (void)updateUI;
@end

