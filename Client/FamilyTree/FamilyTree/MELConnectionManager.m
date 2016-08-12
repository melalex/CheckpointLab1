//
//  MELConnectionManager.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELConnectionManager.h"
#import "MELDataStore.h"
#import "MELTree.h"

static NSString *const kGetTreesListURL = @"http://localhost:8000/api/trees";
static NSString *const kGetPersonsListURL = @"http://localhost:8000/api/trees/persons/";
static NSString *const kAddTreeURL = @"http://localhost:8000/api/trees";
static NSString *const kAddPersonURL = @"http://localhost:8000/api/persons";
static NSString *const kUpdateTreeURL = @"http://localhost:8000/api/trees/";
static NSString *const kUpdatePersonURL = @"http://localhost:8000/api/persons/";
static NSString *const kDeleteTreeURL = @"http://localhost:8000/api/trees/";
static NSString *const kDeletePersonURL = @"http://localhost:8000/api/persons/";


@interface MELConnectionManager()

@property (assign) MELDataStore *dataStore;

@end

@implementation MELConnectionManager

- (instancetype)initWithDataStore:(MELDataStore *)dataStore
{
    if (self = [self init])
    {
        _dataStore = dataStore;
    }
    return self;
}

- (void)addTree:(NSDictionary *)tree
{
    NSError *error = nil;

    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:tree options:0 error:&error];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [kAddTreeURL stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {

          }];
    
    [task resume];
}

- (void)addPerson:(NSDictionary *)person
{
    NSError *error = nil;
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:person options:0 error:&error];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [kAddPersonURL stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      
                                  }];
    
    [task resume];
}

- (void)pushTree:(NSDictionary *)tree
{
    NSError *error = nil;
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:tree options:0 error:&error];
    
    NSString *updateTree = [NSString stringWithFormat:@"%@%@", kUpdateTreeURL, tree[@"identifier"]];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [updateTree stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      
                                  }];
    
    [task resume];

}

- (void)pushPerson:(NSDictionary *)person;
{
    NSError *error = nil;
    
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:person options:0 error:&error];
    
    NSString *updateTree = [NSString stringWithFormat:@"%@%@", kUpdatePersonURL, person[@"identifier"]];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [updateTree stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:bodyData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      
                                  }];
    
    [task resume];
}

- (void)deleteTree:(NSString *)identifier;
{
    NSString *updateTree = [NSString stringWithFormat:@"%@%@", kDeleteTreeURL, identifier];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [updateTree stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      
                                  }];
    
    [task resume];
}

- (void)deletePerson:(NSString *)identifier;
{
    NSString *updateTree = [NSString stringWithFormat:@"%@%@", kDeletePersonURL, identifier];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [updateTree stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURL *url = [NSURL URLWithString:encodedUrlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      
                                  }];
    
    [task resume];
}

- (void)setTreesList;
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [kGetTreesListURL stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (!error)
        {
            if ([response isKindOfClass:[NSHTTPURLResponse class]])
            {
                NSError *jsonError;
                NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.dataStore.trees = [self.dataStore treesListFromDictionaryRepresentation:jsonResponse];
                });
            }
            else
            {
                
            }
        }
        else
        {
            NSLog(@"error : %@", error.description);
        }
        
    }] resume];
}

- (void)setPersonsOfTree:(MELTree *)tree;
{
    NSString *fullRequestURL = [NSString stringWithFormat:@"%@%@", kGetPersonsListURL, tree.identifier];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [fullRequestURL stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          if (!error)
          {
              if ([response isKindOfClass:[NSHTTPURLResponse class]])
              {
                  NSError *jsonError;
                  NSArray *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      tree.persons = [self.dataStore personsListFromDictionaryRepresentation:jsonResponse];
                  });
                  
              }
              else
              {
                  
              }
          }
          else
          {
              NSLog(@"error : %@", error.description);
          }
          
      }] resume];
}

@end
