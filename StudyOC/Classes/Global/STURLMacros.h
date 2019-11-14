//
//  STURLMacros.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/27.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#ifndef STURLMacros_h
#define STURLMacros_h
#pragma mark - 0.通用

#if DEBUG

//测试环境183
#define kTLSEnv                          1
#define kSdkAppId                        @"1400086046"    //1400087291
#define KAccountType                     @"25746"         //25762

#define kUrl @"http://mp.youqucheng.com"   // 测试中的测试 2018.04.18 10:37
#define KBaseLocation @"/front.php"


#elif DEBUGUAT

//测试环境
#define kTLSEnv                          0
#define kSdkAppId                        @"1400086046"
#define KAccountType                     @"25746"

#define kUrl @"http://mp.youqucheng.com"    //
#define KBaseLocation @"/front.php"             //

#else

//正式环境
#define kTLSEnv                          0
#define kSdkAppId                        @"1400086046"
#define KAccountType                     @"25746"

#define kUrl @"http://mp.youqucheng.com"    //
#define KBaseLocation @"/front.php"   //

#endif





/*================================命名空间===============================*/


/*================================ 00.初始化===============================*/


/*================================ 01.用户端 ===============================*/


#endif /* STURLMacros_h */
