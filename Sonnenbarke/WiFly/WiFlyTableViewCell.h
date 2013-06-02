//
//  WiFlyTableViewCell.h
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 01/06/2013.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFly.h"

@interface WiFlyTableViewCell : UITableViewCell

@property (strong,nonatomic) WiFly * dev;

@property (strong,nonatomic) IBOutlet UIImageView * battView, * signalView;
@property (strong,nonatomic) IBOutlet UILabel * mainTextLabel;
@property (strong,nonatomic) IBOutlet UILabel * extraLabel;
+(CGFloat)height;
@end
