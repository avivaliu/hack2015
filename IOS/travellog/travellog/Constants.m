//
//  Constants.m
//  PushMug
//
//  Created by SUN Cullen on 26/8/13.
//  Copyright (c) 2013 PushMug. All rights reserved.
//

#import "Constants.h"



#ifdef DEBUG
// this is the Dev
//  /company?company_id=1
//http://tb2505.ecs01.ectomcat.com/WebProTest/api/v1/company?company_id=1

NSString * const SeverUrl = @"http://con4.fareden.com:3000/";
NSString * const PostBaseUrl = @"http://justpu.sh/post/";
NSString * const AppCompanyId = @"1";


#else
//this is the pro

NSString * const SeverUrl = @"http://con4.fareden.com:3000/";
NSString * const PostBaseUrl = @"http://justpu.sh/post/";
NSString * const AppCompanyId = @"1";

#endif

NSString * const HelpUrl = @"http://www.google.com";
NSString * const TnCUrl = @"http://justpu.sh/tnc";
NSString * const PrivacyUrl = @"http://justpu.sh/privacy";;


NSString * const ApiUserName = @"pushmug";
NSString * const ApiPassword = @"keroculle";


int const PageSize = 10;

NSString * const kUserEmail = @"com.ir-intelligent.user.email.key";
NSString * const kUserSettingLanguage = @"com.ir-intelligent.user.setting.language";
NSString * const kUserChangeLanguageNotification = @"com.ir-intelligent.userChangeLanguage.Notification";


