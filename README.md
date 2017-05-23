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

【当前效果】：
!(5.19)[http://oozx6yayl.bkt.clouddn.com/5.19WeiBo.gif]


## 主要页面效果如图

## 安装和使用

- 直接clone/download到本地
- 打开终端到项目路径下执行 'pod update' 安装Pod依赖，(默认你CocoaPod已经装好)
- 打开Xcode运行程序
