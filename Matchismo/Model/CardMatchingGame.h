//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Anass Alzurba on 06/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@protocol ViewControllerDelegate <NSObject>
@required
- (void)displayChanges:(NSArray*) chosenCards :(BOOL)didMatch :(NSInteger)pointsDifference;
@end

@interface CardMatchingGame : NSObject
// designated initializer
-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;

-(void)chooseCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;

@property (nonatomic) NSUInteger matchMode ;
@property (nonatomic,weak,nullable) NSObject <ViewControllerDelegate> *viewControllerDelegate;

@end


