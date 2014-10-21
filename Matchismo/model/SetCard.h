//
//  SetCard.h
//  Matchismo
//
//  Created by GoGoCav on 10/21/14.
//  Copyright (c) 2014 GoGoCav Games. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic)NSString *symbol;
@property (strong, nonatomic)NSString *color; // red, green, purple
@property (strong, nonatomic)NSString *shading; // solid, striped, open
@property (nonatomic) NSUInteger number; // one, two, three

+ (NSArray *)validSymbol;// diamond, squiggle, oval
+ (NSArray *)validColor;
+ (NSArray *)validShading;
+ (NSUInteger)maxNumber;

@end
