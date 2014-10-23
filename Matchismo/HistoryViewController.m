//
//  HistoryViewController.m
//  Matchismo
//
//  Created by GoGoCav on 10/23/14.
//  Copyright (c) 2014 GoGoCav Games. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

@synthesize historyString = _historyString;

#pragma mark - initial
- (NSMutableAttributedString *)historyString
{
    if (!_historyString) _historyString = [[NSMutableAttributedString alloc] init];
    return _historyString;
}

- (void)setHistoryString:(NSMutableAttributedString *)string
{
    _historyString = string;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
*/

#pragma mark - UI
- (void)updateUI
{
    if (self.historyString) {
        [self.historyTextView setAttributedText:self.historyString];
    }
}

@end
