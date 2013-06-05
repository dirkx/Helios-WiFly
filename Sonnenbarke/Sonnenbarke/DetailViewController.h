//
//  DetailViewController.h
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 31/05/2013.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *colourShowArea;

-(IBAction)infoButtonTapped:(id)sender;
@end
