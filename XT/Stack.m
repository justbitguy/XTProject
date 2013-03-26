//
//  Stack.m
//  XT
//
//  Created by kyle on 13-3-26.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import "Stack.h"

@implementation Stack
- (id)init
{
    [super init];
    if (self)
    {
        m_array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(id)object
{
    [m_array addObject:object];
}

- (id)pop
{
   if(m_array.count > 0)
   {
       id object = [m_array lastObject];
       [m_array removeLastObject];
       return object;
   }
    else
    {
        return  nil;
    }
}

- (id)top
{
    if (m_array.count > 0)
        return [m_array lastObject];
    else
        return nil;
}
- (int)count
{
    return m_array.count;
}

- (BOOL)isEmpty
{
    return m_array.count == 0;
}

- (void)dealloc
{
    [m_array release];
    [super dealloc];
}
@end
