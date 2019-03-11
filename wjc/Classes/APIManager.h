//
//  APIManager.h
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

UIKIT_EXTERN NSString *const kAFNetworkReachabilityStatus;
UIKIT_EXTERN NSString *const kAFNetworkStateChange;

@interface APIManager : AFHTTPSessionManager

@property (nonatomic, assign) AFNetworkReachabilityStatus  reachabilityStatus;

+ (instancetype _Nullable)sharedManager;


+ (nullable NSURLSessionDataTask *)SafePOST:(nullable NSString *)URLString
                        parameters:(nullable id)parameters
                           success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id _Nullable responseObject))success
                           failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure;

//上传图片
+ (nullable NSURLSessionDataTask *)SafePOST:(nullable NSString *)URLString
                        parameters:(nullable id)parameters
                           picData:(nullable void (^)(id<AFMultipartFormData> __nullable afMultipartFormData))formatDataBlock
                          progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                           success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id __nullable responseObject))success
                           failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure;

+ (nullable NSURLSessionDataTask *)SafeGET:(nullable NSString *)URLString
                       parameters:(nullable id)parameters
                          success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id __nullable responseObject))success
                          failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure;

- (NSURLSessionDownloadTask *_Nullable)downloadFileWithURL:(nullable NSString*)requestURLString
                 parameters:(nullable NSDictionary *)parameters
                  savedPath:(nullable NSString *)savedPath
            downloadSuccess:(nullable void (^)(NSURLResponse * __nullable response, NSURL *__nullable filePath))success
            downloadFailure:(nullable void (^)(NSError * __nullable error))failure
           downloadProgress:(nullable void (^)(NSProgress * __nullable downloadProgress))progress;
+ (void)reset;
@end
