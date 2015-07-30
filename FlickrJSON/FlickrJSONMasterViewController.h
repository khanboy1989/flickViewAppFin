//
//  FlickrJSONMasterViewController.h
//  FlickrJSON
//
//  Created by Serhan Khan on 24/11/2013.
//  Copyright (c) 2013 Serhan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrJSONMasterViewController : UITableViewController <UISearchBarDelegate> {
    NSMutableArray *photoNames;
    NSMutableArray *photoIDs;
    NSMutableArray *photoURLs;
    NSMutableArray *photoURLsBIG;
    NSMutableData *JSONData;
    NSURLConnection *connectionInProgress;
    BOOL *filteredNames;
    UISearchDisplayController *searchController;
    
}

@end
