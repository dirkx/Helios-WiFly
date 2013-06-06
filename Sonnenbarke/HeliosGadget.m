//
//  HeliosGadget.m
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 03-06-13.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import "HeliosGadget.h"

@interface HeliosGadget () {
}
@property (strong,nonatomic) NSData * address;
@end
@implementation HeliosGadget

-(id)initWithAddress:(NSData *)anAddress {
    self = [super init];
    self.address = anAddress;
    return self;
}

-(BOOL)isEqual:(id)object {
    if (object == self)
        return YES;
    if (![object isKindOfClass:[self class]])
        return NO;
    
    return [self.address isEqual:((HeliosGadget *)object).address];
}

-(NSUInteger)hash {
    return [self.address hash];
}

-(UIColor *)color {
    return [UIColor colorWithRed:self.red green:self.green blue:self.red alpha:1];
}

@end
