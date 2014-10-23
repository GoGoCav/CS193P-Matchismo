//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by GoGoCav on 10/21/14.
//  Copyright (c) 2014 GoGoCav Games. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super updateUI];
    self.game.matchNumber = 3;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *symbol = @"?";
    NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard*)card;
        NSDictionary *symbolDictionary  = @{ @"diamond" : @"▲" ,
                                             @"squigle" : @"●" ,
                                             @"oval"    : @"■" };
        symbol = [@"" stringByPaddingToLength:setCard.number
                                      withString:[symbolDictionary objectForKey:setCard.symbol]
                                 startingAtIndex:0];
        NSDictionary *colorDictionary   = @{ @"red"     : [UIColor redColor]    ,
                                             @"green"   : [UIColor greenColor]  ,
                                             @"purple"  : [UIColor purpleColor] };
        UIColor *color = [colorDictionary objectForKey:setCard.color];
        
        if ([setCard.shading isEqualToString:@"solid"]) {
            [attribute setObject:color forKey:NSForegroundColorAttributeName];
        } else if ([setCard.shading isEqualToString:@"striped"]) {
            [attribute setObject:color forKey:NSStrokeColorAttributeName];
            [attribute setObject:@-5 forKey:NSStrokeWidthAttributeName];
            [attribute setObject:[color colorWithAlphaComponent:0.2] forKey:NSForegroundColorAttributeName];
            
        } else if ([setCard.shading isEqualToString:@"open"]) {
            [attribute setObject:color forKey:NSStrokeColorAttributeName];
            [attribute setObject:@5 forKey:NSStrokeWidthAttributeName];
            
        }
        
    }
    
    return [[NSAttributedString alloc] initWithString:symbol attributes:attribute];
}

- (NSAttributedString *)titleForChosenCard:(Card *)card
{
    return [self titleForCard:card];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:(card.isChosen ? @"setcardchosen" : @"setcard")];
}

@end
