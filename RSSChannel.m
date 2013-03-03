//
//  RSSChannel.m
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel
@synthesize items, shortTitle, parentParserDelegate, title;

-(id) init
{
    self = [super init];
    if (self) {
        //create the container for the RSS Items 
        //we'll create the RSSItem class shortly
        
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"\t%@ found a %@ element " , self, elementName);
    if ([elementName isEqual:@"title"]) {
        currentString = [[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"description"])
    {
        currentString = [[NSMutableString alloc] init];
        [self setShortTitle:currentString];
    }
    else if ([elementName isEqual:@"item"])
    {
        //when we find an item, create and instance of RSS Item
        RSSItem *entry =  [[RSSItem alloc] init];
        
        //set up its parent as ourselves so we can regain control of the parser
        [entry setParentParserDelegate:self];
        
        //Turn the parser to the RSS Item
        [parser setDelegate:entry];
        
        //add the item to our array and release our hold on it
        [items addObject:entry];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //[currentString nil];
    
    if ([elementName isEqual:@"channel"]) {
        [parser setDelegate:parentParserDelegate];
    }
}


@end
