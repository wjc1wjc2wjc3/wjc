//
//  ErrorUserInfo.h
//  HZBitSmartLock
//
//  Created by Apple on 2018/8/20.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnderlyingError : NSObject

@property (nonatomic, copy)NSString *_kCFStreamErrorCodeKey;
@property (nonatomic, copy)NSString *_kCFStreamErrorDomainKey;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface ErrorUserInfo : NSObject

@property (nonatomic, copy)NSString *NSErrorFailingURLKey;
@property (nonatomic, copy)NSString *NSErrorFailingURLStringKey;
@property (nonatomic, copy)NSString *NSLocalizedDescription;
@property (nonatomic, assign)BOOL bCannotConnectServer;
@property (nonatomic, strong)UnderlyingError *uError;
@property (nonatomic, strong)NSError *NSUnderlyingError;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
