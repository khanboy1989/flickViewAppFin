//
//  FlickrJSONDetailViewController.m
//  FlickrJSON
//
//  Created by Serhan Khan on 24/11/2013.
//  Copyright (c) 2013 Serhan Khan. All rights reserved.
//

#import "FlickrJSONDetailViewController.h"

@interface FlickrJSONDetailViewController ()

@end

@implementation FlickrJSONDetailViewController

#pragma mark - Managing the detail item

- (void)updatePhotoInfo
{
    NSString *urlExif = [ NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getExif&api_key=%@&photo_id=%@&secret=%@&format=json&nojsoncallback=1", _FlickrKey, _photoID, @"secret"];
    NSURL *JSONURL = [NSURL URLWithString:urlExif];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    [[session dataTaskWithURL:JSONURL completionHandler:^(NSData *data,
                                                          NSURLResponse *response, NSError *error) {
        // handle response
        if ([data length] >0 && error == nil)
        {
            JSONData = [NSMutableData data];
            [JSONData appendData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = nil;
                NSDictionary *results = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                        options:kNilOptions error:&error];
                //Update NSDictionary with JSON format ---> results contain that
                
                NSLog(@"%@",results);
               
                _label1.text = [[results objectForKey:@"photo"] objectForKey:@"camera"];
                _label2.text = [[results objectForKey:@"photo"] objectForKey:@"secret"];//change me for other info
                _label3.text = [[results objectForKey:@"photo"] objectForKey:@"server"];//change me for other info

                _label4.text = [[results objectForKey:@"photo"] objectForKey:@"id"];//change me for other info

                
                //Update Info with the resources you have
                
                
            });
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
        }
        else if (error != nil){
            NSLog(@"Error = %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Unable to connect to Flickr. Please make sure you are connected to a network."
                                                               delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                [alert show];
            });
            
            
        }
        
    }] resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:_detailItem]];
    
    [self updatePhotoInfo];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
