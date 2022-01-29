# QSExtensions
使用方法：直接用Pod导入，pod 'QSExtensions'

常用类扩展，其中UIImageView+Qs和UIButton+Qs涉及到设置图片，引入了Kingfisher；MJRefresh+Rx引入了MJRefresh；HandyJSON+Rx引入了HandyJSON

### 子模块
- Qs：主要是一些工具方法的封装， pod 'QSExtensions/Qs'
- Setting：主要是对UI控件布局属性设置的链式封装， pod 'QSExtensions/Setting'
- Rx：对RxSwift使用的部分功能封装， pod 'QSExtensions/Rx'
- View：实现UITextField和UITextView的子类， pod 'QSExtensions/View'

### Qs
#### Date+Qs
日期操作
```
/// 转换为字符串
public func qs_toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String
/// 转换为时间戳（毫秒）
public func qs_toTimestamp() -> String
/// 从传入的date到self的日期差
public func qs_intervalSince(date: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int)
/// 与当前的日期差
public func qs_intervalSinceNow() -> (days: Int, hours: Int, minutes: Int, seconds: Int)
/// 获取这个月有多少天
public func qs_daysInMonth() -> Int?
/// 获取日期是星期几,返回数字0~6，0：星期天
public func qs_weekDay() -> Int
/// 获取当前Year
public func qs_year() -> Int?
/// 获取当前Month
public func qs_month() -> Int? 
/// 获取当前Day
public func qs_day() -> Int?
/// 获取时
public func qs_hour() -> Int?
/// 获取分
public func qs_minute() -> Int?
/// 获取秒
public func qs_second() -> Int?
/// 获取前后的日期,days: >0：以后的日期；<0：以前的日期
public func qs_theDateAfter(_ days: Int) -> Date?
/// 是否是今天
public func qs_isToday() -> Bool
/// 是否是昨天
public func qs_isYesterday() -> Bool
/// 是否是明天
public func qs_isTomorrow() -> Bool
```

#### String+QSEncode
字符串编解码
```
/// url编码
public func qs_urlEncode() -> String?
/// url解码
public func qs_urlDecode() -> String?
/// base64编码
public func qs_base64Encode() -> String?
/// base64解码
public func qs_base64Decode() -> String?
/// unicode编码
public func qs_unicodeEncode() -> String?
/// unicode解码
public func qs_unicodeDecode() -> String?
```

#### String+Md5
md5编码
```
/// MD5加密，大小写均可
public func qs_md5(isUpper: Bool = false) -> String?
/// 自定义MD5加密算法
public func qs_customMd5(_ hexDigits: [Character] = ["0", "1", "2", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "M", "n", "i", "G", "R"]) -> String?
```

#### String+Qs
字符串操作
```
/// 转换为number
public func qs_toNumber() -> NSNumber?
/// 转换为double
public func qs_toDouble() -> Double?
/// 转换为int
public func qs_toInt() -> Int?
/// 转换为日期
public func qs_toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date?
/// 时间戳转换为日期
public func qs_timeStampToDate() -> Date?
/// 获取字符串文字的宽度
public func qs_width(font: UIFont, height: CGFloat) -> CGFloat
/// 获取字符串文字的高度
public func qs_height(font: UIFont, width: CGFloat) -> CGFloat
/// 按照字符分割字符串
public func qs_division(_ with: String) -> Array<String>
/// 去掉首尾空格
public func qs_removeHeadAndTailSpace() -> String
/// 去掉首尾空格 包括后面的换行 \n
public func qs_removeHeadAndTailSpaceAndNewline() -> String
/// 去掉所有空格和换行 \n
public func qs_removeAllSapceAndNewline() -> String
/// 字符串分组（123 456 789）
public mutating func qs_group(size: Int, separator: String)
// MARK: - 子字符串
public func qs_subString(to: Int) -> String
public func qs_subString(from: Int) -> String
public func qs_subString(from: Int, to: Int) -> String
```

#### NSAttributedString+Qs
富文本操作
```
/// 设置特定区域的字体大小
public func qs_setText(font: UIFont, range: NSRange) -> NSAttributedString
/// 设置特定文字的字体大小
public func qs_setText(_ text: String, font: UIFont) -> NSAttributedString
/// 设置特定区域的字体颜色
public func qs_setText(color: UIColor, range: NSRange) -> NSAttributedString
/// 设置特定文字的字体颜色
public func qs_setText(_ text: String, color: UIColor) -> NSAttributedString
/// 设置特定区域行间距
public func qs_setText(lineSpace: CGFloat, alignment: NSTextAlignment, range: NSRange) -> NSAttributedString
/// 设置特定文字行间距
public func qs_setText(_ text: String, lineSpace: CGFloat, alignment: NSTextAlignment) -> NSAttributedString
/// 设置特定区域的下划线
public func qs_setUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange) -> NSAttributedString
/// 设置特定文字的下划线
public func qs_setUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single) -> NSAttributedString
/// 设置特定区域的删除线
public func qs_setDeleteLine(color: UIColor, range: NSRange) -> NSAttributedString
/// 设置特定文字的删除线
public func qs_setDeleteLine(_ text: String, color: UIColor) -> NSAttributedString
/// 插入图片
public func qs_insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0) -> NSAttributedString
/// 首行缩进
public func qs_firstLineLeftEdge(_ edge: CGFloat) -> NSAttributedString
/// 设置特定区域的多个字体属性
public func qs_setText(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange) -> NSAttributedString
/// 设置特定文字的多个字体属性
public func qs_setText(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>) -> NSAttributedString
```

#### Timer+Qs
定时器操作， 实现了RxSwift的Disposable协议，可用.disposed(by: DisposeBag)来实现timer的自动销毁
```
/// 创建定时器
public class func qs_timer(isPerform: Bool, interval: TimeInterval, timeOut: @escaping () -> ()) -> Timer
/// 暂停
public func qs_suspend()
/// 重新开始
public func qs_restart(timeInterval: TimeInterval? = nil)
/// 关闭
public func qs_invalidate()
```

#### UIBarButtonItem+Qs
创建UIBarButtonItem
```
/// 图片BtnItem
public class func qs_imgBtnItem(img: String, selectedImg: String? = nil, disabledImg: String? = nil, action: @escaping (UIButton) -> Void) -> UIBarButtonItem
/// 文字BtnItem
public class func qs_titleBtnItem(title: String, color: UIColor, selectedColor: UIColor? = nil, disabledColor: UIColor? = nil, font: UIFont, action: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem
```

#### UIColor+Qs
颜色操作
```
/// 设置16进制颜色
public static func qs_color(hex: Int, alpha: CGFloat = 1.0) -> UIColor
/// 渐变颜色
public static func qs_gradientColor(size: CGSize, angle: Double, startColor: UIColor, endColor: UIColor) -> UIColor?
```

#### UIImage+Qs
图片操作
```
/// 添加文字水印
public func qs_addWatermark(rect: CGRect, text: String, attributes: [NSAttributedString.Key : Any]) -> UIImage?
/// 添加图片水印
public func qs_addWatermark(rect: CGRect, image: UIImage) -> UIImage?
/// 压缩图片
public func qs_compressData(to size: Int) -> Data?
/// 将图片缩放成指定尺寸
public func qs_compressSize(to newSize: CGSize) -> UIImage?
/// 生成一张纯色的图片
public class func qs_image(with color: UIColor, size: CGSize) -> UIImage?
/// 拉伸图片
public func qs_stretch(topCap: CGFloat, leftCap: CGFloat, bottomCap: CGFloat, rightCap: CGFloat, finalImgSize: CGSize) -> UIImage
```

#### UIImageView+Qs
UIImageView操作
```
/// 设置图片
public func qs_setImage(with imgName: String, placeholder: String? = nil, complete: ((UIImage?) -> ())? = nil)
```

#### UILabel+Qs
UILabel操作，以下操作必须在设置文字内容后才能执行
```
/// 设置特定区域的字体大小
public func qs_setText(font: UIFont, range: NSRange)
/// 设置特定文字的字体大小
public func qs_setText(_ text: String, font: UIFont)
/// 设置特定区域的字体颜色
public func qs_setText(color: UIColor, range: NSRange)
/// 设置特定文字的字体颜色
public func qs_setText(_ text: String, color: UIColor)
/// 设置行间距
public func qs_setLineSpace(_ space: CGFloat)
/// 设置特定区域的下划线
public func qs_setUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange)
/// 设置特定文字的下划线
public func qs_setUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single)
/// 设置特定区域的删除线
public func qs_setDeleteLine(color: UIColor, range: NSRange)
/// 设置特定文字的删除线
public func qs_setDeleteLine(_ text: String, color: UIColor)
/// 插入图片
public func qs_insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0)
/// 首行缩进
public func qs_firstLineLeftEdge(_ edge: CGFloat)
```

#### UITextField+Qs
UITextField操作
```
/// 设置占位字符的颜色
func qs_placeholder(color: UIColor)
```

#### UIButton+Qs
UIButton操作
```
/// 设置图片
public func qs_setImage(with imgName: String, placeholder: String? = nil, state: UIControl.State)
/// 设置按钮背景颜色
public func qs_setBackgroundColor(_ color: UIColor, state: UIControl.State)
/// 设置背景图片
public func qs_setBackgroundImage(with imgName: String, placeholder: String? = nil, state: UIControl.State)
/// 设置按钮点击范围
public func qs_setEnlargeEdge(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
/// 按钮点击事件
public func qs_setAction(_ action: @escaping (UIButton) -> ())
```

#### UIView+Qs
UIView包括其子类操作
```
/// 添加圆角
public func qs_addRoundCorners(radius: CGFloat, corners: UIRectCorner = .allCorners)
/// 添加边框
public func qs_addBorder(width: CGFloat, color: UIColor)
/// 添加阴影
public func qs_addShadow(radius: CGFloat = 0.0, corners: UIRectCorner = .allCorners, horizontalOffset: CGFloat = 0.0, verticalOffset: CGFloat = 0.0, shadowOpacity: CGFloat = 1.0, shadowColor: UIColor)
/// 清除所有子控件
public func qs_clearSubViews()

/* 一些属性的设置需要考虑到阴影这个图层，不使用系统的属性和方法，应该使用下方自定义的方法 */
/// 移除阴影
public func qs_removeShadow()
/// 透明度
public func qs_alpha(_ alpha: CGFloat)
/// 隐藏
public func qs_isHidden(_ isHidden: Bool)
/// 从父控件中移除
public func qs_removeFromSuperview()
```

#### UIView+QSFrame
UIView包括其子类布局相关
```
/// 左上角x
public var qs_x : CGFloat
/// 左上角y
public var qs_y : CGFloat
/// 左上角坐标
public var qs_origin : CGPoint
/// 中点x
public var qs_centerX : CGFloat
/// 中点y
public var qs_centerY : CGFloat
/// 宽
public var qs_width : CGFloat
/// 高
public var qs_height : CGFloat
/// 大小
public var qs_size : CGSize
```

#### UIViewController+Qs
UIViewController操作
```
/// 设置导航栏的shadowImage，默认隐藏
public func qs_setNavBarShadowImage(isHidden: Bool = true, color: UIColor? = nil)
/// 设置TabBar的shadowImage是否隐藏
public func qs_setTabBarShadowImage(isHidden: Bool = true)
/// 设置穿透导航栏
public func qs_setExtendNavBar(isExtend: Bool = false)
/// 设置穿透tabBar
public func qs_setExtendTabBar(isExtend: Bool = false)
/// 设置导航栏的背景颜色
public func qs_setNavBarBgColor(_ color: UIColor)
/// 设置导航栏的背景图片
public func qs_setNavBarBgImg(_ imgName: String)
/// 导航栏是否使用大标题
public func qs_useNavLargeTitle(_ isUse: Bool)
/// 设置导航栏title的字体大小和颜色
public func qs_setNavTitle(font: UIFont = UIFont.systemFont(ofSize: 17.0), textColor: UIColor = .black)
/// 设置导航栏largeTitle的字体大小和颜色
public func qs_setNavLargeTitle(font: UIFont? = nil, textColor: UIColor = .black)
/// 是否隐藏导航栏
public func qs_hideNavBar(_ hidden: Bool, animated: Bool = true)
```

#### UIScrollView+Qs
UIScrollView操作
```
/// 获取Content宽高和起始坐标
public var qs_contentWidth: CGFloat 
public var qs_contentHeight: CGFloat 
public var qs_contentOffsetX: CGFloat 
public var qs_contentOffsetY: CGFloat 

/// 手指滚动方向
public var qs_scrollDirection: QSScrollDirection

/// 页码
public var qs_verticalPageIndex: Int 
public var qs_horizontalPageIndex: Int

/// 获取offset
public var qs_topContentOffset: CGFloat 
public var qs_bottomContentOffset: CGFloat
public var qs_leftContentOffset: CGFloat 
public var qs_rightContentOffset: CGFloat

/// 是否滚动到顶、底、左、右
public var qs_isAtTheTop: Bool 
public var qs_isAtTheBottom: Bool 
public var qs_isOnTheLeft: Bool
public var qs_isOnTheRight: Bool

/// 设置滚动到顶、底、左、右
public func qs_scrollToTop(animated: Bool)
public func qs_scrollToBottom(animated: Bool) 
public func qs_scrollToLeft(animated: Bool) 
public func qs_scrollToRight(animated: Bool)

/// 滚动到指定页码
public func qs_scrollToPage(index: Int, direction: QSScrollDirection, animated: Bool)
/// 上一页
public func qs_pageUp(direction: QSScrollDirection, animated: Bool)
/// 下一页
public func qs_pageDown(direction: QSScrollDirection, animated: Bool)

/// 滚动时调用
public var qs_didScroll: ((_ scrView: UIScrollView) -> ())?
/// 开始拖拽时调用
public var qs_beginDragging: ((_ scrView: UIScrollView) -> ())?
/// 停止滚动时调用
public var qs_didEndScroll: ((_ scrView: UIScrollView) -> ())?

/// 是否共享手势
public var qs_isShareRecognizer: Bool
/// 是否允许水平滑动
public var qs_isHorizontalScrollEnabled: Bool
/// 是否允许垂直滑动
public var qs_isVerticalScrollEnabled: Bool
```

#### UIScrollView+QSBouncesColor
弹簧效果的颜色
```
/// 设置弹簧区域的颜色
public func qs_setBouncesBackgroundColor(_ color: UIColor, direction: QSBouncesDirection = .top)
```

#### Double+Qs
Double操作
```
/// 转换为String
func qs_toString(decimal: Int = 0) -> String
```

#### Int+Qs
Int操作
```
/// 转换为String
func qs_toString() -> String
```

### Setting
#### UITextView+QSSetting
```
/// 设置背景颜色
func qs_backgroundColor(_ color: UIColor) -> UITextView
/// 设置文字
func qs_text(_ text: String) -> UITextView
/// 设置文字颜色
func qs_textColor(_ color: UIColor) -> UITextView
/// 设置文字字体大小
func qs_font(_ font: UIFont) -> UITextView
/// 设置文字对齐方式
func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextView
/// 设置键盘样式
func qs_keyboardType(_ type: UIKeyboardType) -> UITextView
```

#### UITextField+QSSetting
```
/// 设置背景颜色
func qs_backgroundColor(_ color: UIColor) -> UITextField
/// 设置文字
func qs_text(_ text: String) -> UITextField
/// 设置文字颜色
func qs_textColor(_ color: UIColor) -> UITextField
/// 设置文字字体大小
func qs_font(_ font: UIFont) -> UITextField
/// 设置占位文字
func qs_placeholder(_ placeholder: String) -> UITextField
/// 设置占位文字颜色
func qs_placeholderColor(_ color: UIColor) -> UITextField
/// 设置文字对齐方式
func qs_textAlignment(_ alignment: NSTextAlignment) -> UITextField
/// 设置键盘样式
func qs_keyboardType(_ type: UIKeyboardType) -> UITextField
```

#### UITableView+QSSetting
```
/// 创建tableView
convenience init(style: UITableView.Style)
/// 设置背景颜色
func qs_backgroundColor(_ color: UIColor) -> UITableView
/// 设置数据源
func qs_dataSource(_ dataSource: UITableViewDataSource) -> UITableView
/// 设置代理
func qs_delegate(_ delegate: UITableViewDelegate) -> UITableView
/// 设置自适应cell高度
func qs_automaticRowHeight() -> UITableView
/// 设置自适应headerView高度
func qs_automaticSectionHeaderHeight() -> UITableView
/// 设置自适应footerView高度
func qs_automaticSectionFooterHeight() -> UITableView
```

#### UIScrollView+QSSetting
```
/// 创建scrollView
convenience init(with backgroundColor: UIColor)
```

#### UILable+QSSetting
```
/// 设置背景颜色
func qs_backgroundColor(_ color: UIColor) -> UILabel
/// 设置文字
func qs_text(_ text: String) -> UILabel
/// 设置文字颜色
func qs_textColor(_ color: UIColor) -> UILabel
/// 设置文字字体
func qs_font(_ font: UIFont) -> UILabel
/// 设置文字对其方式
func qs_textAlignment(_ alignment: NSTextAlignment) -> UILabel
/// 设置文字行数
func qs_numberOfLines(_ lines: Int) -> UILabel
```

#### UIButton+QSSetting
```
/// 设置背景颜色
func qs_setBackgroundColor(_ color: UIColor, for state: UIControl.State) -> UIButton
/// 设置文字
func qs_setTitle(_ title: String, for state: UIControl.State) -> UIButton
/// 设置文字字体大小
func qs_setFont(_ font: UIFont) -> UIButton
/// 设置文字颜色
func qs_setTitleColor(_ color: UIColor, for state: UIControl.State) -> UIButton
/// 设置图片
func qs_setImage(_ image: UIImage?, for state: UIControl.State) -> UIButton
/// 设置背景图片
func qs_setBackgroundImage(_ image: UIImage?, for state: UIControl.State) -> UIButton
```

#### UICollectionView+QSSetting
```
/// 创建collectionView
convenience init(layout: UICollectionViewFlowLayout)
/// 设置背景颜色
func qs_backgroundColor(_ color: UIColor) -> UICollectionView
/// 设置数据源
func qs_dataSource(_ dataSource: UICollectionViewDataSource) -> UICollectionView
/// 设置代理
func qs_delegate(_ delegate: UICollectionViewDelegate) -> UICollectionView
```

### Rx
#### UIViewController+Rx
```
对vc对应生命周期方法转为ControlEvent可监听属性
var qs_viewDidLoad: ControlEvent<Void>
var qs_viewWillAppear: ControlEvent<Bool>
var qs_viewDidAppear: ControlEvent<Bool>
var qs_viewWillDisappear: ControlEvent<Bool>
var qs_viewDidDisappear: ControlEvent<Bool>
var qs_viewWillLayoutSubviews: ControlEvent<Void>
var qs_viewDidLayoutSubviews: ControlEvent<Void>
var qs_willMoveToParentViewController: ControlEvent<UIViewController?>  // 当一个视图控制器从视图控制器容器中被添加或者被删除之前，该方法被调用
var qs_didMoveToParentViewController: ControlEvent<UIViewController?> // 当从一个视图控制容器中添加或者移除viewController后，该方法被调用
var qs_didReceiveMemoryWarning: ControlEvent<Void>

// 表示视图是否显示的可观察序列，当VC显示状态改变时会触发
var qs_isVisible: Observable<Bool>
// 表示页面被释放的可观察序列，当VC被dismiss时会触发
var qs_isDismissing: ControlEvent<Bool>
```

#### UIScrollView+Rx
```
// 是否滚动到顶部
public var qs_reachedTop: Signal<()>
// 是否滚动到底部
public var qs_reachedBottom: Signal<()>
```

#### ObservableConvertibleType+Rx
```
/// 判断当前值是否与前一个值相同
public func qs_isEqualToBeforeValue() -> Observable<(value: Element, isEqual: Bool)>

/// 判断当前值是否与初始值相同
public func qs_isEqualToOriginValue() -> Observable<(value: Element, isEqual: Bool)>

/// 重复执行某个序列
public func qs_repeatWhen<O: ObservableType>(_ notifier: O) -> Observable<Element>
```

#### MJRefresh+Rx
```
// 添加头部刷新
public func qs_addHeaderRefresh()
// 添加尾部加载更多
public func qs_addFooterRefresh()
    
// 正在刷新，下拉和上拉都是触发这个属性
public var qs_refreshing: ControlEvent<Void>
// 停止头部刷新
public var qs_endHeaderRefreshing: Binder<Bool>
// 停止尾部刷新
public var qs_endFooterRefreshing: Binder<QSEndFooterRefreshType>
// 向上滚动，取消上拉
public var qs_isUpDragging: ControlEvent<Bool>
// 向下滚动，取消下拉
public var qs_isDrowDragging: ControlEvent<QSEndFooterRefreshType>
```

#### HandyJSON+Rx
```
/// 将JSON数据转成模型对象
func qs_mapModel<T>(type:T.Type) -> Observable<T?> where T: HandyJSON
  
/// 将JSON数据转成模型数组
func qs_mapModels<T>(type:T.Type) -> Observable<[T]?> where T: HandyJSON
```

#### UITextField+Rx
```
// 监听文字变化，代码赋值和键盘输入均会触发
public var qs_text: Observable<String?>
```

#### BehaviorRelay+Rx
```
/// 内容改变才有更新值
public func qs_acceptChange(_ event: Element)
```

### View
#### QSTextView
```
/// 占位文字
public var qs_placeholder: String?
/// 占位文字颜色
public var qs_placeholderColor: UIColor?
/// 占位文字字体
public var qs_placeholderFont: UIFont?
/// 文字垂直对齐方式
public var textVerticalAlignment: QSTextVerticalAlignment = .top
/// 设置内边距，为了配合垂直对齐方式使用
public var qs_contentInset: UIEdgeInsets?
/// 限制输入字符的长度
public var qs_limitTextLength: Int?
/// 是否允许输入emoji
public var qs_isAllowEmoji: Bool = true
/// 是否允许编辑的回调
public var qs_isAllowEditingBlock: (() -> (Bool))?
/// 内容改变的回调
public var qs_textDidChangeBlock: ((String) -> ())?
/// 开始编辑回调
public var qs_textDidBeginEditBlock: (() -> ())?
/// 结束编辑的回调
public var qs_textDidEndEditBlock: ((String) -> ())?
/// return事件的回调
public var qs_returnBtnBlock: ((String) -> ())?
/// 段落首行缩进
public func qs_firstLineLeftEdge(_ edge: CGFloat)
/// 设置内边距
public func qs_textContainerInset(_ inset: UIEdgeInsets)
/// 添加点击链接
public func qs_addLink(_ link: String, action: @escaping (() -> ()))
```

#### QSTextView+QSSetting
```
/// 设置占位文字
func qs_placeholder(_ placeholder: String) -> QSTextView
/// 设置占位文字颜色
func qs_placeholderColor(_ color: UIColor) -> QSTextView
/// 设置占位文字字体大小
func qs_placeholderFont(_ font: UIFont) -> QSTextView
/// 设置垂直对齐方式
func qs_textVerticalAlignment(_ alignment: QSTextVerticalAlignment) -> QSTextView
/// 设置内边距
func qs_contentInset(_ contentInset: UIEdgeInsets) -> QSTextView
/// 限制输入字符的长度
func qs_limitTextLength(_ length: Int) -> QSTextView
/// 是否允许输入emoji
func qs_isAllowEmoji(_ isAllow: Bool) -> QSTextView
```

#### QSTextField
```
/// 限制输入字符的长度
public var qs_limitTextLength: Int?
/// 限制小数位数
public var qs_limitDecimalLength: Int?
/// 是否允许输入emoji
public var qs_isAllowEmoji: Bool = true 
/// 只允许输入数字和字母
public var qs_isOnlyLetterAndNumber: Bool = false
/// 字数超出限制回调
public var qs_textOverLimitedBlock: ((Int) -> ())?
/// 是否允许编辑的回调
public var qs_isAllowEditingBlock: (() -> (Bool))?
/// 内容改变回调
public var qs_textDidChangeBlock: ((String) -> ())? 
/// 开始编辑回调
public var qs_textDidBeginEditBlock: (() -> ())?
/// 结束编辑回调
public var qs_textDidEndEditBlock: ((String) -> ())?
/// return按钮事件回调
public var qs_returnBtnBlock: ((String) -> ())?
```

#### QSTextField+QSSetting
```
/// 限制输入字符的长度
func qs_limitTextLength(_ length: Int) -> QSTextField
/// 限制小数位数
func qs_limitDecimalLength(_ length: Int) -> QSTextField
/// 限制小数位数
func qs_isAllowEmoji(_ isAllow: Bool) -> QSTextField
/// 只允许输入数字和字母
func qs_isOnlyLetterAndNumber(_ isOnly: Bool) -> QSTextField
```

#### QSButton
```
/// 初始化
convenience public init(btnStyle: QSButtonStyle, margin: CGFloat)
/// 设置背景颜色
public func qs_setBackgroundColor(_ color: UIColor, state: QSButtonState)
/// 设置文字
public func qs_setTitle(_ title: String, state: QSButtonState)
/// 设置文字字体大小
public func qs_setTitleFont(_ font: UIFont, state: QSButtonState)
/// 设置文字颜色
public func qs_setTitleColor(_ color: UIColor, state: QSButtonState)
/// 设置图片
public func qs_setImage(_ image: UIImage?, state: QSButtonState)
/// 按钮点击事件
public func qs_setAction(_ action: @escaping (QSButton) -> ())
```

#### QSButton+QSSetting
```
/// 设置背景颜色
func qs_setBackgroundColor(_ color: UIColor, for state: QSButtonState) -> QSButton
/// 设置文字
func qs_setTitle(_ title: String, for state: QSButtonState) -> QSButton
/// 设置文字字体大小
func qs_setFont(_ font: UIFont, for state: QSButtonState) -> QSButton
/// 设置文字颜色
func qs_setTitleColor(_ color: UIColor, for state: QSButtonState) -> QSButton
/// 设置图片
func qs_setImage(_ image: UIImage?, for state: QSButtonState) -> QSButton
/// 设置内边距
func qs_setContentInset(_ contentInset: UIEdgeInsets) -> QSButton
```

#### 版本更新
2.0.0版本之后需要使用iOS11才能使用，如果需要支持iOS11之前版本，可使用2.0.0之前版本

Rx模块的基本是参考[航歌](http://www.hangge.com)的，其他的一些类扩展有些写的比较久了，从OC转过来swift的，有些也是参考网上的大神的，具体的文章记不得了，总之感谢各路大神的文章参考。
如果哪些写的不对的地方，还请大家指正，谢谢！
