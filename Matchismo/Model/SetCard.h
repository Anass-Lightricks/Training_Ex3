//
//  SetCard.h
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"
#import "UIKit/UIKit.h"
@interface SetCard : Card

@property (strong,nonatomic) NSString* shape;
@property (nonatomic) NSUInteger  number;
@property (strong, nonatomic) UIColor* color;
@property (nonatomic) CGFloat shading;

+ (NSArray*) validShapes;
+ (NSUInteger) maxNumber;
+ (NSArray*) validColors;
+ (NSArray*) validShadings;

@end

// NSForegroundColorAttributeName color;
// NSStrokeColorAttributeName shading;
// [color colorWithAlphaComponent:<#(CGFloat)#>]
