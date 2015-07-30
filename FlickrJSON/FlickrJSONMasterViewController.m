//
//  FlickrJSONMasterViewController.m
//  FlickrJSON
//
//  Created by Serhan Khan on 24/11/2013.
//  Revised 1st December 2014
//  Copyright (c) 2013 Serhan Khan. All rights reserved.
//

#import "FlickrJSONMasterViewController.h"

#import "FlickrJSONDetailViewController.h"

#import "FlickrAPIKey.h"

@interface FlickrJSONMasterViewController ()

@end

@implementation FlickrJSONMasterViewController

- (void)loadFlickrPhotos
{

    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&tag_mode=%@&per_page=10&format=json&nojsoncallback=1", FlickrAPIKey, @"trend", @"any"];


    NSURL *JSONURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];

        
    /*  NSURLRequest *request = [NSURLRequest requestWithURL:JSONURL
        cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];*/
  /*  [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)*/
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
                 NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
                 for (NSDictionary *photo in photos) {
                     
                     
                     
                     NSString *title = [photo objectForKey:@"title"];
                     [photoNames addObject:(title.length > 0 ? title : @"Untitled")];
                     NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"],
                                                 [photo objectForKey:@"server"], [photo objectForKey:@"id"],
                                                 [photo objectForKey:@"secret"]];
                     [photoURLs addObject:[NSURL URLWithString:photoURLString]];
                 
    
                     NSString *photoURLBIGString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_b.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                 
                     [photoURLsBIG addObject:[NSURL URLWithString:photoURLBIGString]];
                     
                     //create an nsmutable array in the header similar to above to hold photoIDs
                     [photoIDs addObject:[photo objectForKey:@"id"]];
                 }
                 

                 [self.tableView reloadData];
             
             
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


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (self) {
        photoURLs = [[NSMutableArray alloc] init];
        photoNames = [[NSMutableArray alloc] init];

        photoIDs = [[NSMutableArray alloc] init];

        photoURLsBIG = [[NSMutableArray alloc] init];
        [self loadFlickrPhotos];
    }
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [photoNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [photoNames objectAtIndex:indexPath.row];
    NSData *imageData = [NSData dataWithContentsOfURL:[photoURLs objectAtIndex:indexPath.row]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FlickrJSONDetailViewController *webController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        webController.detailItem = photoURLsBIG[indexPath.row];
        webController.title = photoNames[indexPath.row];
        webController.photoID = photoIDs[indexPath.row];
        webController.FlickrKey = FlickrAPIKey;
    }
}

@end
