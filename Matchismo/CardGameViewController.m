//
//  ViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 02/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()


//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (strong,nonatomic) NSMutableAttributedString* history;
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

- (NSMutableAttributedString *)history{
    if(!_history) _history = [[NSMutableAttributedString alloc] init];
    return _history;
}

- (Deck *)createDeck
{
    return nil;
}

-(NSAttributedString *) titleForCard:(Card *)card
{
    return nil;
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return nil;
}


- (IBAction)touchCardButton:(UIButton *)sender {
//    [self.matchModeSwitch setEnabled:NO];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
//        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
//        [[cardButton titleLabel] setAttributedText:[self titleForCard:card]];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self.view setNeedsLayout];
//    if(self.game.matchMode==2)
//    {
//        [self.matchModeSwitch setSelectedSegmentIndex:0];
//    }else{
//        [self.matchModeSwitch setSelectedSegmentIndex:1];
//    }
}



- (IBAction)touchRedealButton:(UIButton *)sender {
    [self.matchModeSwitch setEnabled:YES];
    self.game = [self createGame];
    [self updateUI];
    self.lastMoveLabel.text = @"";
}
//- (IBAction)TouchMatchModeControl:(UISegmentedControl *)sender {
//    if(sender.selectedSegmentIndex ==0)
//    {
//        [self.game setMatchMode:2];
//    }else{
//        [self.game setMatchMode:3];
//    }
//}
- (void)displayChanges:(NSArray*) chosenCards :(BOOL)didMatch :(NSInteger)pointsDifference
{
    NSMutableAttributedString *chosenText = [[NSMutableAttributedString alloc]initWithString:@"" attributes: @{}];
    
    for(Card *card in chosenCards){
        [chosenText appendAttributedString:[self titleForCard:card]];
    }
    if(chosenCards.count < self.game.matchMode)
    {
        self.lastMoveLabel.attributedText = chosenText;
    }else if(didMatch){
        NSMutableAttributedString* attributedText = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [attributedText appendAttributedString:chosenText];
        NSString *text = [NSString stringWithFormat:@" for %ld points.",(long) pointsDifference];
        [attributedText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:text]];
        self.lastMoveLabel.attributedText = attributedText;
        [self appendtoHistory:attributedText];
        
    }
    else{
        NSString *text = [NSString stringWithFormat:@" don't match! %ld points penalty!",(long) -pointsDifference];
        [chosenText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:text]];
        self.lastMoveLabel.attributedText = chosenText;
        [self appendtoHistory:chosenText];
        
    }
    self.lastMoveLabel.textAlignment = NSTextAlignmentCenter;
}

-(void) appendtoHistory:(NSMutableAttributedString*) string
{
    [self.history appendAttributedString:string];
    NSMutableAttributedString *enter = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [self.history appendAttributedString: enter];
}


// #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController]
     if([segue.identifier isEqualToString:self.historySegueIdentifier]){
         HistoryViewController* dest = (HistoryViewController*)[segue destinationViewController];
         dest.history = self.history;
     }
 // Pass the selected object to the new view controller.
 }



@end
