//
//  HeliosGadget.h
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 03-06-13.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeliosGadget : NSObject

-(id)initWithAddress:(NSData *)address;

@property (assign,nonatomic) double lux, cct;
@property (assign,nonatomic) double red,green,blue;
@property (assign,nonatomic) double temp;
@property (strong,nonatomic) NSDate * lastSeen;

-(UIColor *)color;
@end
