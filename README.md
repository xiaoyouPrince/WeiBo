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

【状态】：完成项目授权、登录和欢迎页面逻辑等 <br>
【计划】：实现微博首页微博展示和主页功能 <br>
【实现步骤】：<br>

1. 请求微博首页数据，进行字典转模型保存
2. 处理微博时间、来源 和 用户（会员，认证）等数据
3. 微博数据视图模型的封装，更方便管理对应的微博数据
4. 布局首页微博cell，并给cell设置基本数据
5. 布局微博cell的底部工具栏
6. 添加配图View，展示并缓存单张配图。
7. 添加转发微博，调整约束并计算cell的高度
8. 集成下拉刷新和上拉加载更多
9. 添加提示更新微博数目的Label

【当前效果】：<br>
![5.25](http://oozx6yayl.bkt.clouddn.com/5.25WeiBo2.gif)

<br><br>
2017年05月31日 — 

【状态】：实现微博首页微博基本展示和主页功能 <br>
【计划】： 实现发微博页面功能和表情键盘部分<br>
【实现步骤】：<br>

1. 弹出发微博控制器、设置发布导航栏
2. 自定义发微博的TextView，并调整站位文字，内边距，发布等细节
3. 实现底部工具栏并监听对应的按键点击
4. 使用CollectionVIew自定义选中照片的布局，自定义cell
5. 根据MVC思想完成选中、展示和删除照片的功能
6. 布局表情键盘、实现表情键盘的ToolBar、加载表情数据。
7. 处理表情数据 pngPath 和 emojiCode
8. 自定义cell展示表情、并插入“空白”/“删除”表情
9. 将使用过的表情插入到最近表情中


【当前效果】：<br>
![5.31](http://oozx6yayl.bkt.clouddn.com/5.31WeiBo.jpeg)

<br><br>
2017年06月01日 — 

【状态】：实现微博首页微博基本展示和主页功能 <br>
【计划】： 实现发微博页面功能和表情键盘部分<br>
【实现步骤】：<br>

1. 将emotion表情对象回调给控制器
2. 在TextView中插入emoji表情
3. 在TextView中插入图片表情实现图文混排
4. 在TextView中获取含有表情的字符串，并封装插入和获取表情的方法。
5. 封装表情键盘
6. 发送文字微博
7. 发送图片微博

【当前效果】：<br>
![6.01](http://oozx6yayl.bkt.clouddn.com/5.25WeiBo2.gif-)


## 主要页面效果如图

## 安装和使用

- 直接clone/download到本地
- 打开终端到项目路径下执行 'pod update' 安装Pod依赖，(默认你CocoaPod已经装好)
- 打开Xcode运行程序


