//
//  ViewController.h
//  DownloadingURLdata
//
//  Created by Rajesh on 17/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)downloadImage:(id)sender;

-(void)download;

- (IBAction)loadFlag:(id)sender;

@end

