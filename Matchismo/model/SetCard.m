//
//  SetCard.m
//  Matchismo
//
//  Created by GoGoCav on 10/21/14.
//  Copyright (c) 2014 GoGoCav Games. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - initializations

@synthesize symbol = _symbol, color = _color, shading = _shading, number = _number;

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbol] containsObject:symbol]) _symbol = symbol;
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColor] containsObject:color]) _color = color;
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShading] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber] && number >= 1) _number = number;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (NSUInteger)number
{
    return _number ? _number : 0;
}

#pragma mark - class methods
+ (NSArray *)validSymbol
{
    return @[@"diamond", @"squigle", @"oval"];
}

+ (NSArray *)validColor
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShading
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSUInteger)maxNumber
{
    return 3; // the Set game rule is certain, no need to be generic.
}

#pragma mark - overwrite methods
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    BOOL match = TRUE;
    
    if ([otherCards count] > 0) {
        for (SetCard *otherCard in otherCards) {
            if ([self.symbol isEqualToString:otherCard.symbol] ||
                [self.color isEqualToString:otherCard.color] ||
                [self.shading isEqualToString:otherCard.shading] ||
                (self.number == otherCard.number)) {
                match = FALSE;
                break;
            } else if ([otherCards count] > 1){
                Card *firstCard = [otherCards firstObject];
                otherCards = [otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] -1)];
                score += [firstCard match:otherCards];
            }
        }
        
        if (match) {
            score += 4;
        } else {
            score -= 2;
        }
    }

    return score;
}

- (NSString *)contents
{ 
    return @"";
}

@end
