//
//  DetailViewController.m
//  Sonnenbarke
//
//  Created by Dirk-Willem van Gulik on 31/05/2013.
//  Copyright (c) 2013 Dirk-Willem van Gulik. All rights reserved.
//

#import "DetailViewController.h"
#import "LicenseViewController.h"
#import "HeliosListener.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIPopoverController *infoPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:nil
                                                        name:kHeliosDeviceUpdated
                                                      object:_detailItem];

        _detailItem = newDetailItem;

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceUpdated:)
                                                     name:kHeliosDeviceUpdated
                                                   object:_detailItem];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceLost:)
                                                     name:kHeliosDeviceLost
                                                   object:_detailItem];

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }

}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:kHeliosDeviceUpdated object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:nil name:kHeliosDeviceLost object:nil];
}

-(void)deviceLost:(NSNotification *)notif {
    self.detailDescriptionLabel.text = @"Lost";
}

-(void)deviceUpdated:(NSNotification *)notif {
    HeliosGadget * dev  = (HeliosGadget *)notif.object;
    
    self.colourShowArea.backgroundColor = [dev color];
    
    NSLog(@"updated %@ %f,%f,%f", dev, dev.red, dev.green, dev.blue);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma  UI interaction

-(IBAction)infoButtonTapped:(id)sender {
    // currently only shown on the iPad - so safe to do the
    // popup without much ado.
    //
    LicenseViewController * vc = [[LicenseViewController alloc] initWithDelegate:self];
    CGRect screen = CGRectInset([[UIScreen mainScreen] bounds], 32,32);
    
    self.infoPopoverController = [[UIPopoverController alloc] initWithContentViewController:vc];
    [self.infoPopoverController setPopoverContentSize:screen.size];
    
    [self.infoPopoverController presentPopoverFromRect:((UIButton *)sender).frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionDown
                                              animated:YES];
}

-(void)thanksButtonPressed:(id)sender {
    [self.infoPopoverController dismissPopoverAnimated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}
@end
