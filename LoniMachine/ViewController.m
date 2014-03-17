//
//  ViewController.m
//  LoniMachine
//
//  Created by Ilja Rozhko on 02.03.14.
//  Copyright (c) 2014 IR Works. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize getNewQuote, theQuote;

- (void)viewDidLoad
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadData];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)loadData {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://slndrmn.de/lonimachine/api/get/"]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
    httpResponse = [NSMutableData dataWithCapacity: 0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!theConnection) {
        httpResponse = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    httpResponse = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [httpResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Do something with the response
    NSString *responseQuote = [[[NSString alloc] initWithData:httpResponse encoding:NSUTF8StringEncoding] copy];
    NSLog(@"Got this: %@", responseQuote);
    [theQuote setText:responseQuote];
    [getNewQuote setEnabled:YES];
    [getNewQuote setTitle:@"Neues Zitat" forState:UIControlStateNormal];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Conn Err: %@", [error localizedDescription]);
    /*UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error."
     message:[error localizedDescription]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK",
     nil];
     [message show];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getTheQuote:(id)sender {
    [getNewQuote setEnabled:NO];
    [getNewQuote setTitle:@"Lade..." forState:UIControlStateNormal];
    [self loadData];
}

- (IBAction)tweeet:(id)sender {
    NSString *tweetStr = [theQuote text];
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tw = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *tweet = [tweetStr stringByAppendingString:@" (via #LMforiOS)"];
        [tw setInitialText:tweet];
        [self presentViewController:tw animated:YES completion:nil];
    }

}
@end
