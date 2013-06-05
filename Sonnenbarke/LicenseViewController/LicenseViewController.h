//
//  LicenseViewController.h
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 03-06-13.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicenseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView * rtfTextField;
@property (strong, nonatomic) IBOutlet UIImageView * logoImage;

-(IBAction)thanksButton:(id)sender;
@end
