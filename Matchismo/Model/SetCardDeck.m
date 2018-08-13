//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for(NSUInteger i=1;i<=[SetCard maxNumber];i++){
            for(NSString* shape in [SetCard validShapes]){
                for(UIColor* color in [SetCard validColors]){
                    for(NSNumber* shading in [SetCard validShadings]){
                        SetCard* card = [[SetCard alloc]init];
                        card.number = i;
                        card.shape = shape;
                        card.color = color;
                        card.shading = [shading doubleValue];
                        [self addCard:card];
                    }
                    

                }
            }
        }
    }
    return self;
}
@end
