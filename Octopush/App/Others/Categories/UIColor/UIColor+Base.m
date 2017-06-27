//
//  UIColor+Base.m
//  PartyFun
//
//  Created by Rafael Fernandez Alvarez on 01/05/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "UIColor+Base.h"

@implementation UIColor (Base)

- (UIColor *)darkerColor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

@end
