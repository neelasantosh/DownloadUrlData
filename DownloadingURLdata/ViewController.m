//
//  ViewController.m
//  DownloadingURLdata
//
//  Created by Rajesh on 17/12/15.
//  Copyright (c) 2015 CDAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize indicator,imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadImage:(id)sender {
    [indicator startAnimating];
    [NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
}

-(void)download{
    
    NSString *strUrl = @"http://www.thefamouspeople.com/profiles/thumbs/a-p-j-abdul-kalam-2.jpg";
    NSURL *imageUrl =[NSURL URLWithString:strUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *downloadedImage = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{imageView.image = downloadedImage;
     [indicator stopAnimating];});
}

- (IBAction)loadFlag:(id)sender {
    
    NSURL *flagUrl = [NSURL URLWithString:@"http://www.dailybackgrounds.com/wp-content/uploads/2014/12/3d-view-of-indian-flag.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:flagUrl];
    [indicator startAnimating];
    //[NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *response, NSData *data, NSError *connectionError)handler#>]
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        //code for response
        UIImage *flagImage = [UIImage imageWithData:data];
        imageView.image = flagImage;
        [indicator stopAnimating];
        
        //save image in document directory
        
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        NSString *docDirPath = [pathArray objectAtIndex:0];
        NSString *flagFilePath = [NSString stringWithFormat:@"%@/flag.jpg",docDirPath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:flagFilePath contents:data attributes:nil];
        
        NSLog(@"File:%@",docDirPath);
    }
     ];
}
@end
