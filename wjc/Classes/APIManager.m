//
//  APIManager.m
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "APIManager.h"
//#import "ErrorUserInfo.h"

static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

NSString *const kAFNetworkReachabilityStatus = @"AFNetworkReachabilityStatusNotReachable";
NSString *const kAFNetworkStateChange = @"AFNetworkStateChange";

@implementation APIManager
+ (instancetype _Nullable)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:[URI_REQUEST stringByAppendingString:URI_ROOT]]];
        AFSecurityPolicy *sec = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [sec setAllowInvalidCertificates:YES];
        [sec setValidatesDomainName:NO];
        
        [_sharedManager setSecurityPolicy:sec];
        
        [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _sharedManager.reachabilityStatus = status;
            NSDictionary *userInfo = @{kAFNetworkReachabilityStatus:@(status)};
            [[NSNotificationCenter defaultCenter] postNotificationName:kAFNetworkStateChange object:userInfo];
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    DLog(@"3G网络已连接");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    DLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    DLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedManager.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        
        //发送json数据
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
        //响应json数据
        _sharedManager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml", nil]];
        
    });
    
    return _sharedManager;
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error))failure{
    APIManager *manager = [APIManager sharedManager];

    //todo 统一封装请求参数
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        [MBManager hideAlert];
//        ErrorUserInfo *eUI = [[ErrorUserInfo alloc] initWithDictionary:error.userInfo];
        if (_sharedManager.reachabilityStatus == AFNetworkReachabilityStatusNotReachable || eUI.bCannotConnectServer) {
            failure(task,error);
        }
        else
        {
//            [MBManager showBriefAlert:LOCALIZEDSTRING(@"paramError")];
        }
    }];
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                           parameters:(id)parameters
                              picData:(void (^)(id<AFMultipartFormData> afMultipartFormData))formatDataBlock
                             progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{

    
    APIManager *manager = [APIManager sharedManager];
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (formatDataBlock) {
            formatDataBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull progress) {
        uploadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_sharedManager.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
            failure(task,error);
        }
        else
        {
//            [MBManager showBriefAlert:LOCALIZEDSTRING(@"paramError")];
        }
    }];
}

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    
    return [manager GET:URLString parameters:parameters  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        if (_sharedManager.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
            failure(task,error);
        }
        else
        {
//            [MBManager showBriefAlert:LOCALIZEDSTRING(@"paramError")];
        }
    }];
}
- (NSURLSessionDownloadTask *)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress

{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURLString parameters:parameters error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            if (_sharedManager.reachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
                failure(error);
            }
            else
            {
                [MBManager showBriefAlert:LOCALIZEDSTRING(@"paramError")];
            }
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
    
    return task;
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0;
}
@end
