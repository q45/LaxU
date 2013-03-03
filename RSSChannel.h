//
//  RSSChannel.h
//  LaxU
//
//  Created by Quintin Smith on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSChannel : NSObject <NSXMLParserDelegate>
{
    
    NSMutableString *currentString;
    NSString *title;
    NSString *shortTitle;
    NSMutableArray *items;
    
    id parentParserDelegate;
}

@property (nonatomic, retain) id parentParserDelegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic,retain) NSString *shortTitle;
@property (nonatomic, readonly ) NSMutableArray *items;

@end
