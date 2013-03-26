//
//  Stack.h
//  XT
//
//  Created by kyle on 13-3-26.
//  Copyright (c) 2013年 kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
    NSMutableArray* m_array;
}

- (void)push:(id)object;
- (id)pop;
- (id)top;
- (int)count;
- (BOOL)isEmpty;

@end
