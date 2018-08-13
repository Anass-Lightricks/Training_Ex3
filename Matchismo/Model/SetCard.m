//
//  SetCard.m
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents{
    NSString* string = @"";
    for(int i=0;i<self.number;i++){
        string = [string stringByAppendingString:self.shape];
    }
    return string;
    
}

- (int) match: (NSArray *)otherCards
{
    int score =0;
    if ([otherCards count] !=2){
        return score;
    }
    SetCard *card2 = otherCards[0];
    SetCard *card3 = otherCards[1];
    
    if (![SetCard areSameOrDifferent:[NSNumber numberWithInteger:self.number]   :[NSNumber numberWithInteger:card2.number] :[NSNumber numberWithInteger:card3.number]]){
        return score;
    }
    if (![SetCard areSameOrDifferent:self.color :card2.color :card3.color]){
        return score;
    }
    if (![SetCard areSameOrDifferent:self.shape :card2.shape :card3.shape]){
        return score;
    }
    if (![SetCard areSameOrDifferent:[NSNumber numberWithDouble:self.shading] :[NSNumber numberWithDouble:card2.shading] :[NSNumber numberWithDouble:card3.shading]]){
        return score;
    }
    
    return 1;
}

+(BOOL) areSameOrDifferent: (NSObject*)o1 : (NSObject*)o2 : (NSObject*)o3
{
    return ([o1 isEqual:o2] && [o2 isEqual:o3]) || (![o1 isEqual:o2] && ![o2 isEqual:o3] && ![o1 isEqual:o3]);
}




+ (NSArray *)validShapes
{
    return @[@"▲", @"●",@"■"];
}
+ (NSUInteger)maxNumber{
    return 3;
}

+ (NSArray *)validColors
{
    return @[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]];
}
+ (NSArray *)validShadings
{
    return @[@0.0,@0.5,@1.0];
}


@end

