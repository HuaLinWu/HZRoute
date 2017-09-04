#HZRouteGlobalConstant
//这个是webURL 打开的方式key
static NSString *const kWebURLOpenTypeQueryName = @"openWith";
//这个是webURL 用系统自带的webView 打开时候 kWebURLOpenTypeQueryName 对应的value
static NSString *const kWebURLOpenWithBrowserValue = @"browser";
//系统自带webview 的类名(这个随着APP 不同可以自定义设置)
static NSString *const kWebViewClass = @"HZWebView";
//承载url 地址的key
static NSString *const kWebViewURLName = @"url";
//初始化viewController的方法名，这个可以根据APP 不同设置不同的（不过请保证参数只有一个）
static NSString *const kInitViewControllerMethod = @"initWithQuery:";
//表示当前的是一个页面跳转host
static NSString *const kViewHost = @"view";
//表示调用APP 的一个服务的host(这个暂定)
static NSString *const kServiceHost = @"service";
//表示页面打开的方式的(没有这个参数默认是尝试用push的方式打开)
static NSString *const kPresentTypeName = @"presentType";
//表示希望新的页面是push 方式打开的
static NSString *const kPresentTypePushValue = @"push";
//表示希望新的页面是present 方式打开的
static NSString *const kPresentTypePresentValue = @"present";
//如果url 地址没有scheme 的时候我们需要设置一个默认的scheme
static NSString *const kDefaultURLScheme = @"http";
//方法调用


# HZRoute
本组件分两部分，1.是远程打开APP 的页面，调用本地的方法 2.APP本地页面的跳转和方法调用
一：是远程打开APP 的页面，调用本地的方法（注释：这部分功能的思路，主要参照URI 的定义来的）
1.1 远程打开APP 指定的页面
打开APP指定页面url定义:[scheme:][//authority][path][?query]
scheme：APP 的scheme
authority:这个可以理解为host+端口号（端口号用户上）在前端约等于host（默认是kViewHost 对应的值）
path:是路径，由于OC 是运行时的，所以在本组件中这个是需要打开的viewController 的类名
query:这个是参数（本组件会优先去找默认初始化方法（本组件默认方法是kInitViewControllerMethod 对应的方法名）如果没有实现指定的初始化方法，将会从property 列表中去查找参数名相同的
进行赋值，如果没找到将会从Ivar 中查找名字相同进行赋值，如果还是没有找到，将对参数的key进行添加前缀_再从Ivar 中查找名字相同，如果还是找不到，将会丢失本参数
所以我推荐实现初始化方法kInitViewControllerMethod，我们可以通过设置参数kPresentTypeName 的值来控制页面打开的方式
1.2 在APP 中打开web 的url
如果url 中包含了kWebURLOpenTypeQueryName 参数并且值为 kWebURLOpenWithBrowserValue对应的值，这时候会用系统自带的浏览器打开，如果没有设置这个
参数或者值不是 kWebURLOpenWithBrowserValue对应的值，将会用kWebViewClass 对应的类来打开url，如果url，没有scheme 我们将会用kDefaultURLScheme 指定的值进行替代
）
1.3 在APP 中调用系统的功能（可以直接调用）
二.通过远程来调用本地的方法
2.1 调用APP方法的url的定义：[scheme:][//authority][path][?query]
scheme：APP 的scheme
authority:这个可以理解为host+端口号（端口号用户上）在前端约等于host（默认是kServiceHost 对应的值）
path:指定类的类名和方法名（/class/method）
query:这些参数将合并成一个字典，传入到方法中，通过本方法调用的本地方法最多只有一个参数，可以没有






