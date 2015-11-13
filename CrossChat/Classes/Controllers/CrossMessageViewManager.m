//
//  CrossMessageViewManager.m
//  CrossChat
//
//  Created by chaobai on 15/11/4.
//  Copyright © 2015年 chaobai. All rights reserved.
//

#import "CrossMessageViewManager.h"
#import "CrossMessageFrame.h"
#import "CrossMessageDataBaseManager.h"
#import "CrossMessageManager.h"
#import "Crossbuddy.h"
#import "CrossMessage.h"

#import "CrossAccountManager.h"
#import "CrossConstants.h"
#import "CrossAccount.h"

@interface CrossMessageViewManager ()

@property (nonatomic, strong) CrossBuddy *      buddy;
@property (nonatomic, strong) NSArray *         messageArray;

@end

@implementation CrossMessageViewManager

- (id) initWithCrossBuddy:(CrossBuddy *)buddy
{
    self = [super init];
    
    if(self)
    {
        self.buddy = buddy;
        [self initMessageFrameGroups];
    }
    
    return self;
}

- (void) initMessageFrameGroups
{
    //1. create basic group
    NSMutableArray * allGruops = [NSMutableArray array];
    
    CrossMessageDataBaseManager * manaeger = [[CrossMessageManager sharedInstance] databaseManagerForBuddy :self.buddy];
    self.messageArray = [manaeger MessageList];

    NSMutableArray * messageFrameArray = [NSMutableArray array];
    
    for (CrossMessage * message in self.messageArray)
    {
        CrossMessageFrame * messageFrame=[[CrossMessageFrame alloc]init];
        messageFrame.message = message;
        
        if([message.incoming intValue] == 1)
        {
            messageFrame.avatarImage = self.buddy.avatarImage;
        }
        
        else if([message.incoming intValue] == 0)
        {
            messageFrame.avatarImage = [[CrossAccountManager connectedAccount] accountImage];
        }
        
        [messageFrameArray addObject:messageFrame];
    }
    
    [allGruops addObject:messageFrameArray];
    self.messageFrameGroups = allGruops;
    
}

- (void) refreshMessageFrameGroup
{
    [self initMessageFrameGroups];
}

- (CrossMessageFrame*) messageFrameAtSection:(NSUInteger)section row:(NSInteger)row
{
    NSArray * messageFrameArray = self.messageFrameGroups[section];
    CrossMessageFrame * messageFrame = [messageFrameArray objectAtIndex:row];
    return messageFrame;
}

- (NSString*) stringForGroupInSection:(NSUInteger)section
{
    return nil;
}

- (NSUInteger) numberOfMessageFramesInSection:(NSUInteger)section
{
    NSArray * messageFrameArray = self.messageFrameGroups[section];
    return [messageFrameArray count];
}

- (void) cleanSettingGroup
{
    [self.messageFrameGroups removeAllObjects];
}

- (NSIndexPath*) getLastMessageFrameIndexPath
{
    NSIndexPath * index = [NSIndexPath indexPathForRow:[[self.messageFrameGroups lastObject] count]-1 inSection:self.messageFrameGroups.count-1];
    return index;
}
@end