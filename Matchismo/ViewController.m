//
//  ViewController.m
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel; // save and show the match results
@property (strong, nonatomic) NSMutableArray *matchHistory; // for NSString. save 4 recently match results
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardsButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (NSMutableArray *)matchHistory {
    if (!_matchHistory) _matchHistory = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];// only record last 5 history
    //if (!_matchHistory) _matchHistory = (NSMutableArray *)@[@"",@"",@"",@"",@""];
    return _matchHistory;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchModeControl.enabled = NO;
    
    NSUInteger index = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardsButtons) {
        NSUInteger index = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    // score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%ld", self.game.score];
    // describe
    NSMutableArray *chosenCardsContents = [NSMutableArray array];
    NSString *cardContents = @"";
    NSString *description = [NSString stringWithFormat:@""];
    
    if ([self.game.chosenCards count] > 0) {
        for (Card *chosenCard in self.game.chosenCards) {
            [chosenCardsContents addObject:chosenCard.contents];
        }
        cardContents = [chosenCardsContents componentsJoinedByString:@" "];
    }
    
    if (self.game.lastScore > 0) {
        description = [NSString stringWithFormat:@"%@ ✔️ +%ld", cardContents, self.game.lastScore];
    } else if (self.game.lastScore < 0){
        description = [NSString stringWithFormat:@"%@ ❌ %ld", cardContents, self.game.lastScore];
    } else {
        if ([self.game.chosenCards count] > 0) {
            description = [NSString stringWithFormat:@"%@", cardContents];
        }
    }
    
    // record match history
    [self.matchHistory addObject:description];
    [self.matchHistory removeObjectAtIndex:0];
    // show the latest match description
    [self.slider setValue: 4];
    
    [self updateDescription];
    
    //[self.descriptionLabel setText:description];
    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [self updateDescription];
}

-(void)updateDescription {
    NSUInteger index = ceil(self.slider.value);
    if (self.matchHistory) {
        NSString *string = [self.matchHistory objectAtIndex:index];
        [self.descriptionLabel setText:string];
        if (index == 4) {
            self.descriptionLabel.alpha = 1;
        } else {
            self.descriptionLabel.alpha = 0.5;
        }
    }
}

- (IBAction)restartButton:(UIButton *)sender {
    [self restart];
}

- (void)restart
{
    self.game = nil;
    self.matchHistory = nil;
    self.matchModeControl.enabled = YES;
    [self updateMatchNumber];
    [self updateUI];
}

- (IBAction)modeControl:(UISegmentedControl *)sender {
    [self updateMatchNumber];
}

- (void)updateMatchNumber {
    self.game.matchNumber = (self.matchModeControl.selectedSegmentIndex == 0 ? 2 : 3);
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen ? @"cardfront" : @"cardback")];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

@end
