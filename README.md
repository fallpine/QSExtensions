# QSExtensions
常用类扩展，其中UIImageView+Qs和UIButton+Qs涉及到设置图片，引入了Kingfisher，所以在Podfile文件中需要添加pod 'Kingfisher’

#### Date+Qs
日期操作
```
/// 日期转换为字符串
func qs_changeToString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String
/// 转换为时间戳（秒）
func qs_changeToSecondTimestamp() -> String
/// 转换为时间戳（毫秒）
func qs_changeToMilliSecondTimestamp() -> String
/// 比较2个日期差
func qs_intervalToDate(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> (days: Int, hours: Int, minutes: Int, seconds: Int)
/// 与当前的日期差
func qs_intervalToNow() -> (days: Int, hours: Int, minutes: Int, seconds: Int)
/// 获取这个月有多少天
func qs_daysInMonth() -> Int
/// 获取日期是星期几
func qs_weekDay(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Int
/// 获取当前Day
func qs_day() -> Int
/// 获取当前Month
func qs_month() -> Int
/// 获取当前Year
func qs_year() -> Int
/// 获取时
func qs_hour() -> Int
/// 获取分
func qs_minute() -> Int
/// 获取前后的日期
///
/// - Parameter days: >0：以后的日期；<0：以前的日期
func qs_theDateTo(_ days: Int) -> Date
/// 是否是今天
func qs_isToday() -> Bool
/// 是否是昨天
func qs_isYesterday() -> Bool
/// 是否是明天
public func qs_isTomorrow() -> Bool
```

#### String+QSEncode
字符串编解码
```
/// url编码
func qs_urlEncode() -> String
/// url解码
func qs_urlDecode() -> String
/// base64编码
func qs_base64Encode() -> String
/// base64解码
func qs_base64Decode() -> String
/// unicode编码
func qs_unicodeEncode() -> String
/// unicode解码
func qs_unicodeDecode() -> String
```

#### String+Md5
md5编码
```
/// MD5加密，大小写均可
func qs_md5(isUpper: Bool = false) -> String
/// 自定义MD5加密算法
func qs_customMd5(_ hexDigits: [Character] = ["0", "1", "2", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "M", "n", "i", "G", "R"]) -> String
```

#### String+Qs
字符串操作
```
/// 转换为日期
func qs_changeToDate(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date?
/// 时间戳转换为时间字符串
func qs_timeStampChangeToDateString(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String
/// 获取字符串文字的宽度
func qs_obtainWidth(font: UIFont, height: CGFloat) -> CGFloat
/// 获取字符串文字的高度
func qs_obtainHeight(font: UIFont, width: CGFloat) -> CGFloat
/// 去除字符串中的html标签
func qs_deleteHTMLTag() -> String
/// 按照字符分割字符串
func qs_division(_ with: String) -> Array<String>
/// 去掉首尾空格
func qs_removeHeadAndTailSpace() -> String
/// 去掉首尾空格 包括后面的换行 \n
func qs_removeHeadAndTailSpaceAndNewline() -> String
/// 去掉所有空格和换行 \n
func qs_removeAllSapceAndNewline() -> String
/// 字符串分组（123 456 789）
mutating func qs_group(size: Int, separator: String)
// MARK: - 子字符串
func qs_subString(to: Int) -> String
func qs_subString(from: Int) -> String
func qs_subString(from: Int, to: Int) -> String
```

#### Timer+Qs
定时器操作
```
/// 初始化
class func qs_init(timeInterval: TimeInterval, timeOut: ((Timer) -> ())?) -> Timer
/// 暂停
func qs_pause()
/// 重新开始
func qs_restart(timeInterval: TimeInterval? = nil)
/// 关闭
func qs_invalidate()
```

#### UIBarButtonItem+Qs
创建UIBarButtonItem
```
/// 图片BtnItem
class func qs_imgBtnItem(img: String, highlightImg: String? = nil, disabledImg: String? = nil, target: Any, action: Selector) -> UIBarButtonItem
/// 文字BtnItem
class func qs_titleBtnItem(title: String, color: UIColor = .black, highlightColor: UIColor? = nil, disabledColor: UIColor? = nil, font: UIFont = UIFont.systemFont(ofSize: 14.0), target: Any, action: Selector) -> UIBarButtonItem
/// 图片和文字BtnItem
class func qs_imgAndTitleBtnItem(title: String = "", selTitle: String? = nil, disTitle: String? = nil, img: String = "", selImg: String? = nil, disImg: String? = nil, titleColor: UIColor = .black, selTitleColor: UIColor? = nil, disTitleColor: UIColor? = nil, titleFont: UIFont = UIFont.systemFont(ofSize: 15.0), target: Any, action: Selector) -> UIBarButtonItem
```

#### UIButton+Qs
按钮操作
```
/// 设置图片
func qs_setImage(with imgName: String, placeholder: String? = nil, state: UIControl.State)
/// 设置按钮背景颜色
func qs_setBackgroundColor(_ color: UIColor, state: UIControl.State)
/// 设置背景图片
func qs_setBackgroundImage(with imgName: String, placeholder: String? = nil, state: UIControl.State)
/// 按钮点击事件
func qs_setAction(_ action: (@escaping(UIButton) -> ()))
```

#### UIColor+Qs
颜色操作
```
/// 设置16进制颜色
static func qs_color(hex: Int, alpha: CGFloat = 1.0) -> UIColor
/// 渐变颜色
static func qs_gradientColor(size: CGSize, angle: Double, startColor: UIColor, endColor: UIColor) -> UIColor
```

#### UIFont+Qs
字体操作，做了iPhone屏幕适配
```
/// 系统普通字体
static func qs_systemFont(size: CGFloat) -> UIFont
/// 加粗字体
static func qs_boldFont(size: CGFloat) -> UIFont
/// 根据字体名设置字体
static func qs_otherFont(fontName: String, size: CGFloat) -> UIFont
```

#### UIImage+Qs
图片操作
```
/// 添加文字水印
func qs_addWatermark(rect: CGRect, text: String, attributes: [NSAttributedString.Key : Any]) -> UIImage?
/// 添加图片水印
func qs_addWatermark(rect: CGRect, image: UIImage) -> UIImage?
/// 压缩图片到指定大小(质量大小，即data)
func qs_compressToLength(_ length: Int) -> UIImage?
/// 将图片缩放成指定尺寸
func qs_scaled(to newSize: CGSize) -> UIImage
/// 生成一张纯色的图片
class func qs_createImage(color: UIColor, size: CGSize) -> UIImage?
/// 拉伸图片
func qs_stretch(topCap: CGFloat, leftCap: CGFloat, bottomCap: CGFloat, rightCap: CGFloat, finalImgSize: CGSize) -> UIImage
```

#### UIImageView+Qs
UIImageView操作
```
/// 设置图片
func qs_setImage(with imgName: String, placeholder: String? = nil)
```

#### UILabel+Qs
UILabel操作，以下操作必须在设置文字内容后才能执行
```
/// 设置特定区域的字体大小
func qs_setText(font: UIFont, range: NSRange)
/// 设置特定文字的字体大小
func qs_setText(_ text: String, font: UIFont)
/// 设置特定区域的字体颜色
func qs_setText(color: UIColor, range: NSRange)
/// 设置特定文字的字体颜色
func qs_setText(_ text: String, color: UIColor)
/// 设置特定区域的字体大小和颜色
func qs_setText(font: UIFont, color: UIColor, range: NSRange)
/// 设置特定文字的字体大小和颜色
func qs_setText(_ text: String, font: UIFont, color: UIColor)
/// 同时设置特定区域的多个字体属性
func qs_setText(attributes: Dictionary<NSAttributedString.Key, Any>, range: NSRange)
/// 同时设置特定文字的多个字体属性
func qs_setText(_ text: String, attributes: Dictionary<NSAttributedString.Key, Any>)
/// 设置行间距
func qs_setTextLineSpace(_ space: CGFloat)
/// 设置特定区域的下划线
func qs_setTextUnderLine(color: UIColor, stytle: NSUnderlineStyle = .single, range: NSRange)
/// 设置特定文字的下划线
func qs_setTextUnderLine(_ text: String, color: UIColor, stytle: NSUnderlineStyle = .single)
/// 设置特定区域的删除线
func qs_setTextDeleteLine(color: UIColor, range: NSRange)
/// 设置特定文字的删除线
func qs_setTextDeleteLine(_ text: String, color: UIColor)
/// 插入图片
func qs_insertImage(imgName: String, imgBounds: CGRect = .zero, imgIndex: Int = 0)
/// 添加点击事件
func qs_addTapAction(textArray: Array<String>, clickBlock: @escaping ((String) -> ()))
/// 辨别电话号码
func qs_distinguishPhone(complete: ((String) -> ()))
/// 辨别网络地址
func qs_distinguishUrl(complete: ((String) -> ()))
```

#### UITextField+Qs
UITextField操作
```
/// 设置占位字符的颜色
var qs_placeholderColor: UIColor
/// 限制输入字符的长度
var qs_limitTextLength: Int?
/// 限制小数位数
var qs_limitDecimalLength: Int?
/// 字数超出限制回调
var qs_textOverLimitedBlock: ((Int) -> ())?
/// 是否允许编辑的回调
var qs_isAllowEditingBlock: (() -> (Bool))?
/// 内容改变回调
var qs_textDidChangeBlock: ((String) -> ())?
/// 结束编辑回调
var qs_textDidEndEditBlock: ((String) -> ())?
/// return按钮事件回调
var qs_returnBtnBlock: ((String) -> ())?
```

#### UITextView+Qs
UITextView操作
```
/// 占位文字
var qs_placeholder: String?
/// 占位文字颜色
var qs_placeholderColor: UIColor?
/// 占位文字字体
var qs_placeholderFont: UIFont?
/// 限制输入字符的长度
var qs_limitTextLength: Int?
/// 是否允许开始编辑的回调
var qs_isAllowEditingBlock: (() -> (Bool))?
/// 内容改变的回调
var qs_textDidChangeBlock: ((String) -> ())?
/// 结束编辑的回调
var qs_textDidEndEditBlock: ((String) -> ())?
/// return事件的回调
var qs_returnBtnBlock: ((String) -> ())?
/// 段落首行缩进
func qs_firstLineLeftEdge(_ edge: CGFloat)
/// 设置内边距
func qs_textContainerInset(_ inset: UIEdgeInsets)
```

#### UIView+Qs
UIView包括其子类操作
```
/// 添加圆角
func qs_addRoundingCorners(radius: CGFloat, corners: UIRectCorner = .allCorners)
/// 添加边框
func qs_addBorder(width: CGFloat, color: UIColor, radius: CGFloat = 0.0, corners: UIRectCorner = .allCorners, borderPath: UIBezierPath? = nil)
/// 添加阴影
func qs_addShadow(radius: CGFloat = 0.0, horizontalOffset: CGFloat = 0.0, verticalOffset: CGFloat = 0.0, shadowOpacity: CGFloat = 0.5, shadowColor:UIColor, shadowPath: UIBezierPath? = nil)
/// 清除所有子控件
func qs_clearSubViews()
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
func qs_setNavBarShadowImage(isHidden: Bool = true, color: UIColor? = nil)
/// 设置TabBar的shadowImage是否隐藏
func qs_setTabBarShadowImage(isHidden: Bool = true)
/// 设置穿透导航栏
func qs_setExtendNavBar(isExtend: Bool = false)
/// 设置穿透tabBar
func qs_setExtendTabBar(isExtend: Bool = false)
/// 设置导航栏的背景颜色
func qs_setNavBarBgColor(_ color: UIColor)
/// 设置导航栏的背景图片
func qs_setNavBarBgImg(_ imgName: String)
/// 导航栏是否使用大标题
func qs_useNavLargeTitle(_ isUse: Bool)
/// 设置导航栏title的字体大小和颜色
func qs_setNavTitle(font: UIFont = UIFont.systemFont(ofSize: 17.0), textColor: UIColor = .black)
/// 设置导航栏的按钮颜色
func qs_setNavBarBtnItemColor(color: UIColor = .black)
/// 设置导航栏largeTitle的字体大小和颜色
func qs_setNavLargeTitle(font: UIFont? = nil, textColor: UIColor = .black)
/// 是否隐藏导航栏
func qs_hideNavBar(_ hidden: Bool, animated: Bool = true)
```

这些类扩展有些写的比较久了，从OC转过来swift的，有些也是参考网上的大神的，具体的文章记不得了，总之感谢各路大神的文章参考。
如果那些写的不对的地方，还请大家指正，谢谢！
