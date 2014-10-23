//
//  ViewController.m
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController ()

@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel; // save and show the match results
@property (strong, nonatomic, readwrite) NSMutableArray *matchHistory; // for NSAttributeString
@end

@implementation ViewController

#pragma mark - initial
- (Deck *)createDeck // abstract
{
    return nil;
}

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardsButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (NSMutableArray *)matchHistory {
    if (!_matchHistory) _matchHistory = [[NSMutableArray alloc] init];
    return _matchHistory;
}

#pragma mark - actions
/*
- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
*/
- (NSAttributedString *)titleForCard:(Card *)card
{
    NSAttributedString *title = [self titleForChosenCard:card];
    if (!card.isChosen) {
        title = [[NSAttributedString alloc] initWithString:@"" attributes:[title attributesAtIndex:0 effectiveRange:NULL]];
    }
    
    return title;
}

- (NSAttributedString *)titleForChosenCard:(Card *)card
{
    NSString *contents = card.contents;
    NSDictionary *attribute = @{ NSForegroundColorAttributeName: [UIColor blackColor] };
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:contents
                                                                attributes:attribute];
    
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen ? @"cardfront" : @"cardback")];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardsButtons) {
        NSUInteger index = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        
        //[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        
        cardButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    // score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%ld", self.game.score];
    // describe
    NSMutableAttributedString *chosenCardsContents = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *description = [[NSMutableAttributedString alloc] init];
    
    if ([self.game.chosenCards count] > 0) {
        for (Card *chosenCard in self.game.chosenCards) {
            //NSLog(@"new chosen card is %@", [[self titleForChosenCard:chosenCard] string]);
            [chosenCardsContents appendAttributedString:[self titleForChosenCard:chosenCard]];
        }
    }
    
    if (self.game.lastScore > 0) {
        NSAttributedString *appendingString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"matched! Get +%ld points!", self.game.lastScore]];
        [description appendAttributedString:chosenCardsContents];
        [description appendAttributedString:appendingString];
    } else if (self.game.lastScore < 0){
        NSAttributedString *appendingString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match. Get %ld points.", self.game.lastScore]];
        [description appendAttributedString:chosenCardsContents];
        [description appendAttributedString:appendingString];
    } else {
        if ([self.game.chosenCards count] > 0) {
            
            description = chosenCardsContents;
        }
    }
    
    // record match history
    if ([description string].length > 0) {
        [self.matchHistory addObject:description];
    }
    // show the latest match description
    
    [self.descriptionLabel setAttributedText:description];
}

- (IBAction)restartButton:(UIButton *)sender {
    [self restart];
}

- (void)restart
{
    self.game = nil;
    self.matchHistory = nil;
    [self updateUI];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
        HistoryViewController *historyVC = (HistoryViewController *)segue.destinationViewController;
        NSMutableAttributedString *historyString = [[NSMutableAttributedString alloc] init];
        
        int i = 1;
        for (NSAttributedString *string in self.matchHistory) {
            [historyString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d : ", i++]]];
            [historyString appendAttributedString:string];
            [historyString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
        }
        
        historyVC.historyString = historyString;
    }
}

@end
