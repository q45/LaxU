//
//  RSSItem.h
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject <NSXMLParserDelegate>
{
    NSString *title;
    NSString *link;
    NSMutableString *currentString;
    
    id parentParserDelegate;
}

@property (nonatomic, retain) id parentParserDelegate;
@property (nonatomic, retain ) NSString *title;
@property (nonatomic, retain) NSString *link;

@end
