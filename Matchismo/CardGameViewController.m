//
//  ViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 02/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@end


@implementation CardGameViewController

-(CardMatchingGame *) game
{
    if (!_game) _game = [self createGame];
    return _game;
}

-(CardMatchingGame *) createGame
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    game.viewControllerDelegate =self;
    return game;
}


- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)touchCardButton:(UIButton *)sender {
    [self.matchModeSwitch setEnabled:NO];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    if(self.game.matchMode==2)
    {
        [self.matchModeSwitch setSelectedSegmentIndex:0];
    }else{
        [self.matchModeSwitch setSelectedSegmentIndex:1];
    }
}

-(NSString *) titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}
- (IBAction)touchRedealButton:(UIButton *)sender {
    [self.matchModeSwitch setEnabled:YES];
    self.game = [self createGame];
    [self updateUI];
    self.lastMoveLabel.text = @"";
}
- (IBAction)TouchMatchModeControl:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex ==0)
    {
        [self.game setMatchMode:2];
    }else{
        [self.game setMatchMode:3];
    }
}
- (void)displayChanges:(NSArray*) chosenCards :(BOOL)didMatch :(NSInteger)pointsDifference
{
    NSString *chosenText = @"";
    for(Card *card in chosenCards){
        chosenText = [chosenText stringByAppendingString: [card contents]];
    }
    if(chosenCards.count < self.game.matchMode)
    {
        self.lastMoveLabel.text = chosenText;
    }else if(didMatch){
        self.lastMoveLabel.text = [NSString stringWithFormat:@"Matched %@ for %ld points.",chosenText,(long) pointsDifference];
    }
    else{
        self.lastMoveLabel.text = [NSString stringWithFormat:@"%@ don't match! %ld points penalty!",chosenText,(long) -pointsDifference];
    }
}

@end
