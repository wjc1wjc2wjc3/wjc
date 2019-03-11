//
//  ErrorUserInfo.m
//  HZBitSmartLock
//
//  Created by Apple on 2018/8/20.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "ErrorUserInfo.h"

@implementation UnderlyingError

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    UnderlyingError *ue = [UnderlyingError mj_objectWithKeyValues:dictionary];
    return ue;
}

@end

@implementation ErrorUserInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    ErrorUserInfo *eUI = [ErrorUserInfo mj_objectWithKeyValues:dictionary];
    if (eUI.NSUnderlyingError) {
        eUI.uError = [[UnderlyingError alloc] initWithDictionary:eUI.NSUnderlyingError.userInfo];
    }
    eUI.bCannotConnectServer = [@"Could not connect to the server." isEqualToString:eUI.NSLocalizedDescription];
    return eUI;
}

@end
