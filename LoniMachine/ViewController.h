//
//  ViewController.h
//  LoniMachine
//
//  Created by Ilja Rozhko on 02.03.14.
//  Copyright (c) 2014 IR Works. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableData *httpResponse;
}
@property (weak, nonatomic) IBOutlet UILabel *theQuote;
@property (weak, nonatomic) IBOutlet UIButton *getNewQuote;
- (IBAction)getTheQuote:(id)sender;
- (IBAction)tweeet:(id)sender;

@end
