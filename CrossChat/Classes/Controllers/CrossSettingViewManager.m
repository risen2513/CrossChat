//
//  CrossSettingManager.m
//  CrossChat
//
//  Created by chaobai on 15/9/21.
//  Copyright (c) 2015年 chaobai. All rights reserved.
//

#import "CrossSettingViewManager.h"
#import "CrossNewAccountSetting.h"
#import "CrossSettingGroup.h"
#import "String.h"
#import "CrossCertificateSetting.h"

@implementation CrossSettingViewManager

- (id) init
{
    self = [super init];
    
    if(self)
    {
        [self initArrayGroups];
    }
    
    return self;
}

- (void) initArrayGroups
{
    //0. init setting array list
    NSMutableArray * allSettingGruops = [NSMutableArray array];
    
    //1. init add account gruop
    NSMutableArray * newAccountArray = [NSMutableArray array];
    
    //1.1 create account setting
    CrossNewAccountSetting * newAccountSetting = [[CrossNewAccountSetting alloc]initWithTitle:NEW_ACCOUNTS_STRING description:nil];
    
    
    //1.2 add new account setting into new account array
    [newAccountArray addObject:newAccountSetting];
    
    //1.3 add new account setting into newAccountSettingGroup
    CrossSettingGroup * newAccountSettingGroup = [[CrossSettingGroup alloc]initWithTitle:ACCOUNTS_STRING settings:newAccountArray];
    
    //1.4 add new account array into setting array list
    [allSettingGruops addObject:newAccountSettingGroup];
    
    
    //2. init security setting group
    NSMutableArray * securitySettingArray = [NSMutableArray array];
    
    //2.1 create certificateSetting
    CrossCertificateSetting * certificateSetting = [[CrossCertificateSetting alloc]initWithTitle:PINNED_CERTIFICATES_STRING description:PINNED_CERTIFICATES_DESCRIPTION_STRING];
    
    //2.2 add certificateSetting into securitySettingArray
    [securitySettingArray addObject:certificateSetting];
    
    //2.3 add securitySettingArray into securitySettingGroup
    CrossSettingGroup * securitySettingGroup = [[CrossSettingGroup alloc]initWithTitle:SECURITY_STRING settings:securitySettingArray];
    
    //2.4 add securitySettingGroups into all setting group
    [allSettingGruops addObject:securitySettingGroup];
    
    self.arrayGroups = allSettingGruops;
}


- (void) addSetting: (CrossSetting *)newSetting AtIndexPath:(NSIndexPath*)indexPath
{
    CrossSettingGroup * settingGroup = self.arrayGroups[indexPath.section];
    NSMutableArray * array = (NSMutableArray *)settingGroup.settings;
    
    if ([array count] < indexPath.row+1)
    {
        [array insertObject:newSetting atIndex:indexPath.row];
    }
    
    settingGroup.settings = array;
}

@end
