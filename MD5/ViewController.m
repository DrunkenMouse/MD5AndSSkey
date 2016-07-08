//
//  ViewController.m
//  MD5
//
//  Created by 王奥东 on 16/4/15.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"http:///login.php";
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *username = [defaults objectForKey:@"username"];
//    NSString *password = [defaults objectForKey:@"password"];

    NSString *username = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:@"username"];
    NSString *password = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:@"password"];
    
    if (username!=nil&&password!=nil) {
        
    }else{
        username = @"username";
        password = @"password";
     
        password = [password md5String];
        
        [SSKeychain setPassword:username forService:[NSBundle mainBundle].bundleIdentifier account:@"username"];
        [SSKeychain setPassword:password forService:[NSBundle mainBundle].bundleIdentifier account:@"password"];
    }
    NSLog(@"%@---%@",username,password);
    
    request.HTTPMethod = @"POST";
    NSString *pargarm = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    request.HTTPBody = [pargarm dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dict);
        
        
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
