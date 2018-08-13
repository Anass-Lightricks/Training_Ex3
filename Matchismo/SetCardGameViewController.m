//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "PlayingCardDeck.h"
@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(NSString*) historySegueIdentifier{
    return @"setCardHistory";
}

-(Deck *)createDeck{
    return [[SetCardDeck alloc]init];
}

-(CardMatchingGame *)createGame{
    CardMatchingGame* game = [super createGame];
    game.matchMode =3;
    return game;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    for(NSUInteger i=0; i< self.cardButtons.count;i++){
//        UIButton* button = self.cardButtons[i];
//        SetCard* card = (SetCard *)[self.game cardAtIndex:i];
//        [[button titleLabel] setAttributedText:[self getAttributedStringforCard:card]];
//    }
    
    // Do any additional setup after loading the view.
}

-(void)updateUI
{
    [super updateUI];
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        if (card.isChosen && !card.isMatched){
            cardButton.layer.borderWidth = 1.5f;
            cardButton.layer.borderColor = [UIColor blackColor].CGColor;
            cardButton.layer.cornerRadius = 6.5f;
        }else
        {
            cardButton.layer.borderWidth = 0;
        }
    }
}


-(NSAttributedString*) getAttributedStringforCard: (SetCard*) card
{
        return [[NSAttributedString alloc] initWithString:card.contents
                attributes:@{NSForegroundColorAttributeName:
                [card.color colorWithAlphaComponent:card.shading],
                NSStrokeColorAttributeName:card.color,                                                                                                          NSStrokeWidthAttributeName: @-5,}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSAttributedString *) titleForCard:(Card *)card
{
    return [self getAttributedStringforCard:(SetCard*) card];
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed: @"cardfront"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
