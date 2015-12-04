# Another

> 【仿】韩寒 - 一个

## Done

- TBC + CVC 结构 & MVC 模式, 实现页面展示 & 数据传递的基本层次;

- Storyboard + Autolayout 布局, 实现页面内容的详细布局;

- 网络工具单例封装以UISession 实现 GET 请求, 获取 JSON 转模型, 实现存储数据;

- JSON 解析 & 字符串处理 (字符过滤 HTML 标签 & 设置行高);

- NSURLConnection 异步下载图片, 后尝试 NSURLSession 实现;

- GET请求 & 图片下载 均封在 KCLNetworkTools 工具类中;

   > 此处纠正自己的认识错误, 最初以为网络工具类继承 NSURLSession 直接将 self 当 session 使用, 后改为继承 NSObject;
   
- 抽取重复代码, 封在基类中, 由于 GET 请求地址格式不统一, 故为避免参数过多, 部分方法未抽取;

- 刷新数据, 预加载下一页，提升体验;

## Todo:

- 本地存储

- 昼夜主题

- 三方分享
