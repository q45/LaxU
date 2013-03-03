//
//  ListViewController.m
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

@implementation ListViewController

@synthesize webViewController;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }//end if
    
    RSSItem *item = [[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[item title]];
    cell.textLabel.font = [ UIFont fontWithName:@"ArialMT" size:12];
    
    return cell;
}

-(void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    //add the incoming chunk of data to the container we are keeping
    //the data always comes in the correct order
    [xmlData appendData:data];
}

-(void)fetchEntries
{
    //create a new data container for the stuff that comes back from the service
    xmlData = [[NSMutableData alloc]init];
    
    
    //Construct a URL that will ask the service for what you want
    //note we can concatenate literal strings together on multiple
    //lines in this way = this results in a single NSString instance
    NSURL *url = [NSURL URLWithString:@"http://www.utahlacrossenews.com/feed/"];
    
    //for Apples Hot News Feed, replace the line above with
    
    NSURLRequest *urlRequest =  [NSURLRequest requestWithURL:url];
    
    //create a connection that will exchange this request for data from the URL
    connection = [[NSURLConnection alloc] initWithRequest:urlRequest  delegate:self startImmediately:YES];
    
}

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self fetchEntries];
    }
    return self;
}

-(void)connectionDidFinishLoading:(NSURLConnection *) conn
{
   
    //create the parser object with the data received from the web service
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
     
    //give it a delegate
    [parser setDelegate:self];
    
    //tell it to start parsing - the document will be parsed and 
    //the delegate of NSXMLParser will get all of its delgate messages
    //sent to it before this line finishes execution - it is blocking
    [parser parse];
    
    //The parser is done (it blocks until done), you can release it immediately
    
    //get Rid of the XML data as we no longer need it
    connection = nil;
    
    //Reload the table.. for now, the table will be empty
    [[self tableView] reloadData];
    
    NSLog(@"%@\n %@\n %@\n", channel , [channel title], [channel shortTitle]);
    
    
    
    // we are just checking to make sure we are getting the XML
   // NSString *xmlCheck = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    //NSLog(@"xmlCheck = %@ ", xmlCheck);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element ", self , elementName);
    if ([elementName isEqual:@"channel"]) {
        //if parser saw a channel, create a new instance, store in our Ivar
        channel = [[RSSChannel alloc] init];
        
        //Give the channel object a pointer back to ourselves for later
        [channel setParentParserDelegate:self];
        
        
        //Set the parser's delegate to the channel object
        [parser setDelegate:channel];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //push the web view controller onto the navigation stack 
    //creates the web view controllers view the first time through
    [[self navigationController] pushViewController:webViewController animated:YES];
    
    //Grab the selected item
    RSSItem *entry = [[channel items] objectAtIndex:[indexPath row]];
    
    //construct a URL with the link string of the item
    NSURL *url = [NSURL URLWithString:[entry link]]; 
    
    //Construct a request object with that URL
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    //load the request into the web view
    [[webViewController webView] loadRequest:req];
    
    //Set the title of the web view controllers navigation item
    [[webViewController navigationItem] setTitle:[entry title]];
    
    
    
        
}
//chang background color of cells
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 || indexPath.row%2 == 0)
    {
        UIColor *altCellColor = [UIColor colorWithWhite:0.4 alpha:0.05];
                                 cell.backgroundColor = altCellColor;
    }
}



@end
