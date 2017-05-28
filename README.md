# WeiBo

## 仿写微博客户端

这是一个仿写微博客户端的Swift程序，基于Swift 3.0 开发

### 近期主要功能实现

- 新浪微博首页（未登录）
- 新浪微博登录功能（Oauth 2.0 授权）
- 首页微博内容图文混排
- 微博页面的图片浏览器功能
- 微博未登录情况下访客视图
- 微博发布功能
- 微博表情键盘

### 开发进度与日期

2017年05月18日 — 

【状态】：开始项目 <br>
【计划】：创建仓库、部署项目、项目初始化设置 <br>
【实现步骤】：<br>

1. 创建github仓库，并填写基本项目信息
2. 添加.gitignore文件，设置项目中的忽略文件
3. 将仓库clone到本地，创建Xcode项目
4. Xcode项目进行WeiBo项目的基础配置（displayName、icon、luanchScrean等）
5. 项目基本文件划分

【当前效果】：
<br><br>
2017年05月19日 — 

【状态】：完成项目基础配置 <br>
【计划】：完成项目框架、加载和完善访客视图、实现和完善titleBtn的点击动画等 <br>
【实现步骤】：<br>

1. 代码实现项目框架，可根据对应的json数据动态加载VC
2. 使用SB这中的refrence创建项目框架，用NullVC来填充中间item
3. 完善tabbar的items布局和监听中间item的事件
4. 创建布局并完善访客视图、不同item下设置对应访客数据
5. 分析导航栏并设置对应左右item监听点击效果
6. 自定义titleBtn，监听点击效果弹出自定义弹出控制器
7. 设置Model的style和delegate监听动画过程，自定义弹出VC的frame，自定义弹出、消失动画
8. 完善titleBtn的点击细节，封装对应转场代码，抽取弹出视图的frame和设置对应titleBtn的选中状态等

【当前效果】：<br>
![5.19](http://oozx6yayl.bkt.clouddn.com/5.19WeiBo.gif)

<br><br>
2017年05月23日 — 

【状态】：完成项目框架、加载和完善访客视图、实现和完善titleBtn的点击动画等 <br>
【计划】：集成CocoaPod，导入三方框架，完成微博Oauth授权，完善登录和欢迎页面逻辑等 <br>
【实现步骤】：<br>

1. 集成CocoaPods,导入Alamofire，SDWebImage等常用三方框架
2. 封装一个自己的网络层工具，和Alamofire进行分层
3. 新浪Oauth授权的分析和授权页面的布局（XIB）
4. 加载登录页面，执行JS代码自动填充账号密码。
5. 获取Oauth授权code并通过code请求到accessToken
6. 封装一个UserAccount类封装对应的授权信息，并处理过期时间（秒数转成日期）
7. 通过accesstoken请求用户信息，归档和解档 account 对象
8. 封装UserAccountViewModel，更方便的管理用户信息
9. 布局欢迎界面，并处理欢迎界面的逻辑

【当前效果】：<br>
![5.23](http://oozx6yayl.bkt.clouddn.com/5.23WeiBo.gif)

<br><br>
2017年05月25日 — 

【状态】：完成项目框架、加载和完善访客视图、实现和完善titleBtn的点击动画等 <br>
【计划】：集成CocoaPod，导入三方框架，完成微博Oauth授权，完善登录和欢迎页面逻辑等 <br>
【实现步骤】：<br>

1. 集成CocoaPods,导入Alamofire，SDWebImage等常用三方框架
2. 封装一个自己的网络层工具，和Alamofire进行分层
3. 新浪Oauth授权的分析和授权页面的布局（XIB）
4. 加载登录页面，执行JS代码自动填充账号密码。
5. 获取Oauth授权code并通过code请求到accessToken
6. 封装一个UserAccount类封装对应的授权信息，并处理过期时间（秒数转成日期）
7. 通过accesstoken请求用户信息，归档和解档 account 对象
8. 封装UserAccountViewModel，更方便的管理用户信息
9. 布局欢迎界面，并处理欢迎界面的逻辑

【当前效果】：<br>
![5.23](http://oozx6yayl.bkt.clouddn.com/5.23WeiBo.gif)


## 主要页面效果如图

## 安装和使用

- 直接clone/download到本地
- 打开终端到项目路径下执行 'pod update' 安装Pod依赖，(默认你CocoaPod已经装好)
- 打开Xcode运行程序
