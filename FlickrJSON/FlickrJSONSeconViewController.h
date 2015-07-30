//
//  FlickrJSONSeconViewController.h
//  FlickrJSON
//
//  Created by  Serhan Khan on 03/01/2015.
//  Copyright (c) 2015 Serhan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrJSONSeconViewController : UITableViewController<UISearchBarDelegate> {
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
