//
//  Card.h
//  Matchismo
//
//  Created by GoGoCav on 14/10/15.
//  Copyright (c) 2014年 GoGoCav Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
