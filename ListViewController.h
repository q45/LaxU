//
//  ListViewController.h
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController <NSXMLParserDelegate>
{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    RSSChannel *channel;
    
    WebViewController *webViewController;
}

@property (nonatomic, retain) WebViewController *webViewController;

-(void)fetchEntries;


@end
