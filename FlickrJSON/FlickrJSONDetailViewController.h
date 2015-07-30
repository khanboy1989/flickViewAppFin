//
//  FlickrJSONDetailViewController.h
//  FlickrJSON
//
//  Created by Serhan Khan on 24/11/2013.
//  Copyright (c) 2013 Serhan Khan All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrJSONDetailViewController : UIViewController{
    NSMutableData *JSONData;
}

@property (strong, nonatomic) NSURL *detailItem;
@property (strong, nonatomic) NSString *photoID;
@property (strong, nonatomic) NSString *FlickrKey;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;

@end
