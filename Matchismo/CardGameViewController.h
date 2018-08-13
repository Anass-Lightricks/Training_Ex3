//
//  ViewController.h
//  Matchismo
//
//  Created by Anass Alzurba on 02/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController <ViewControllerDelegate>

//abstract
- (Deck *)createDeck;
-(NSAttributedString *) titleForCard:(Card *)card;
-(UIImage *)backgroundImageForCard:(Card *)card;

-(void)updateUI;

//protected

@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong,nonatomic,readonly) NSString* historySegueIdentifier;



-(CardMatchingGame *) createGame;

@end

