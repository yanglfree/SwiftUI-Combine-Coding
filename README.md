# SwiftUI-Combine-Coding
objc中国 SwiftUI与Combine编程 学习笔记，课后练习，代码

[课后习题](https://github.com/yanglfree/SwiftUI-Combine-Coding/blob/master/习题.md)

## 创建自定义ViewModifier

ViewModifier在Swift中的定义
``` swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ViewModifier {

    /// The type of view representing the body.
    associatedtype Body : View

    /// Gets the current body of the caller.
    ///
    /// `content` is a proxy for the view that will have the modifier
    /// represented by `Self` applied to it.
    func body(content: Self.Content) -> Self.Body

    /// The content view type passed to `body()`.
    typealias Content
}
```
ViewModifier是SwiftUI中定义的一个协议，只有一个要求实现的方法func body(content: Self.Content) -> Self.Body


```
  HStack {
      Spacer()
      Button(action: {print("star")} ){
          Image(systemName: "star")
              .font(.system(size: 25))
              .foregroundColor(.white)
              .frame(width: 30, height: 30)
      }
      Button(action: {print("panel")}) {
          Image(systemName: "chart.bar")
              .font(.system(size: 25))
              .foregroundColor(.white)
              .frame(width: 30, height: 30)
      }
      Button(action: {print("web")}){
          Image(systemName: "info.circle")
              .font(.system(size: 25))
              .foregroundColor(.white)
              .frame(width: 30, height: 30)
      }
  }
  .padding(.bottom, 12)
```
上面的Image创建自定义的Modifier
``` swift
struct ToolButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
    }
}
```
使用Modifier
```
 Button(action: {print("star")} ){
          Image(systemName: "star")
              .modifier(ToolButtonModifier())
      }
```

## SwiftUI动画

- 隐式动画 .animation(.default)

  隐式动画作用范围很大，只要这个View甚至是它的子View上的可动画属性发生变化，这个动画就将适用。

- 显式动画 .withAnimation{ self.expanded.toggle() }

  可以将改变app状态的操作放在withAnimation的闭包中，由闭包中状态变化所触发的View变化，将以动画的形式呈现



## 封装UIView

SwiftUI中的UIViewRepresentable协议提供了封装UIView的功能

这个协议要求实现两个方法：makeUIView（）、updateUIView（）

```swift
    public protocol UIViewRepresentable : View where Self.Body == Never {

        /// The type of view to present.
        associatedtype UIViewType : UIView

        func makeUIView(context: Self.Context) -> Self.UIViewType

        func updateUIView(_ uiView: Self.UIViewType, context: Self.Context)

        static func dismantleUIView(_ uiView: Self.UIViewType, coordinator: Self.Coordinator)

        associatedtype Coordinator = Void

        func makeCoordinator() -> Self.Coordinator

        typealias Context = UIViewRepresentableContext<Self>
    }
```

以封装一个半透明效果的BlurView为例

创建一个BlurView，实现UIViewRepresentable协议，实现其中的makeUIView(context: Context) -> **some** UIView 和updateUIView(**_** uiView: UIViewType, context: Context)方法，在这个例子中，只需要实现makeUIView这个方法即可，更新无需做任何操作。代码如下：

```swift
struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIView {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
```

为了便于blurview的使用，创建一个extension方法

```swift
extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
```

使用：

```swift
    var body: some View {
        VStack(spacing: 20) {
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
        }
        .padding(EdgeInsets(
            top:12,
            leading: 30,
            bottom: 30,
            trailing: 30
        ))
        .blurBackground(style: .systemMaterial) //使用毛玻璃效果
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
```

效果如下：
![WX20201217-151043.png](http://ww1.sinaimg.cn/mw690/006WHNMxgy1glqvguzqr2j30cn0oojyw.jpg)

## 响应式异步编程

- 异步编程的本质是响应未来的事件流
- 异步操作中，某个事件发生时，将这个事件和与其相关的数据“发布”出来。对这个事件感兴趣的代码可以订阅这个事件，来进行后续的操作。
- 用户界面只是状态的函数, View = f(State)
- 将状态变化看做是被发布出来的异步操作的事件，订阅这个事件，即为SwiftUI的根据状态更新和绘制View的代码
- 需要对事件数据进行某个操作

## Combine基础

![image-20201217173409735.png](http://ww1.sinaimg.cn/mw690/006WHNMxgy1glqzk1ixuoj30jp05iwf8.jpg)

combine中有三种重要角色：

- 负责发布事件的Publisher
- 负责订阅事件的Subscriber
- 负责转换事件和数据的Operator

### Publisher

在 Combine 中，我们使用 Publisher 协议来代表事件的发布者。Swift 提倡使用面 向协议编程的方式，Combine 中包括 Publisher 在内的一系列角色都使用协议来进 行定义，也正是这一思想的具体体现。

publisher的定义

```swift
public protocol Publisher {

associatedtype Output
associatedtype Failure : Error

func receive<S>(subscriber: S) where
    S : Subscriber,
    Self.Failure == S.Failure,
    Self.Output == S.Input
}
```

Publisher最主要的工作其实有两个：

- 发布新的事件及其数据
- 以及准备好被Subscribe订阅

Publisher发布三种事件

1. 类型为Output的新值： 代表事件流中出现了新的值
2. 类型为Failure的错误：代表事件流中发生了问题，事件流到此终止。
3. 完成事件：表示事件流中所有的元素都已经发布结束，事件流到此终止。

### 有限事件流和无限事件流

最终会终结的事件流称为有限事件流

不会发出failure或者finished的事件流称为无限事件流

## Publisher和常用Operator

## 响应式编程边界

## SwiftUI架构

### SwiftUI的架构方式
![WX20201227-011403@2x.png](http://ww1.sinaimg.cn/mw690/006WHNMxgy1gm1rhn835fj31200nydig.jpg)

* app当做一个状态机，状态决定用户界面
* 状态都保存在一个Store对象中
* View不能直接操作State，而只能通过发送Action的方式，间接改变存储在Store中的State
* Reducer接受原有的State和发送过来的Action，生成新的State
* 用新的State替换Store中原有的状态，并用新状态来驱动更新界面

SwiftUI中对传统的Redux架构进行了一些改变。
- 除了通过Action外，还可以通过Binding来改变状态。
- 在Reducer处理当前State和Action后，除了返回新State，再额外返回一个Command值，让Command来执行所需的副作用

### 为什么选择单向数据流？
* 防止View和Model耦合，解耦
* 将AppStae的修改分散在app各处，很快将会难以维护
* 方便测试

### 另一个版本的基于Redux的SwiftUI架构
![redux](https://gitee.com/yanglfree/img/raw/master/test/three-ducks-redux-workflow-650x309.png
)

## 用户体验和布局进阶

### 自定义绘制和动画

#### Path和Shape

Shape协议是自定义绘制中最基本的部分

```swift
public protocol Shape : Animatable, View {

	func path(in rect: CGRect) -> Path

}
```

常用的一些形状都是Shape协议的具体实现，例如Circle、Rectangle

自定义View，实现Shape协议中的path方法

例子：实现下面这个自定义的图形

![image-20210701002037071](https://gitee.com/yanglfree/img/raw/master/test/image-20210701002037071.png)

```swift
//TriangleArrow.swift

import Foundation
import SwiftUI

struct TriangleArrow: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            path.addArc(center: CGPoint(x: -rect.width / 5, y: rect.height / 2), radius: rect.width / 2, startAngle: .degrees(-45), endAngle: .degrees(45), clockwise: false)
            
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
            
            path.closeSubpath()
        }
    }
}


struct Demo: View {
    var body: some View {
        TriangleArrow()
            .fill(Color.green)
            .frame(width: 80, height: 80)
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
```

结果：



![image-20210701002443673](https://gitee.com/yanglfree/img/raw/master/test/image-20210701002443673.png)

#### Geometry Reader

SwiftUI中，可以通过GeometryReader来读取parentView提供的一些信息。

GeometryReader也是一个View，初始化方法传入一个ViewBuilder的闭包，用来构建被包装的View，这个闭包提供一个GeometryProxy的结构体

GeometryReader的定义：

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct GeometryReader<Content> : View where Content : View {

    public var content: (GeometryProxy) -> Content

    @inlinable public init(@ViewBuilder content: @escaping (GeometryProxy) -> Content)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required ``View/body-swift.property`` property.
    public typealias Body = Never
}
```

GeometryProxy:

```swift
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct GeometryProxy {

    /// The size of the container view.
    public var size: CGSize { get }

    /// Resolves the value of `anchor` to the container view.
    public subscript<T>(anchor: Anchor<T>) -> T { get }

    /// The safe area inset of the container view.
    public var safeAreaInsets: EdgeInsets { get }

    /// Returns the container view's bounds rectangle, converted to a defined
    /// coordinate space.
    public func frame(in coordinateSpace: CoordinateSpace) -> CGRect
}
```

proxy中有个size，可以获取container view的尺寸，这让我们可以按照尺寸自适应缩放构建UI。



#### Animatable Data



### 布局和对齐

#### 布局规则

##### SwiftUI布局流程

总体：协商解决，层层上报

具体规则：

父层级的View根据某种规则，向子View“提议”一个可行的尺寸；

子View以这个尺寸为参考，按照自己的需求进行布局：

或占满所有可能的尺寸（比如Rectangle和Circle），

或按照自己要显示的内容确定新的尺寸（比如Text），

或把这个任务再委托给自己的子View继续进行布局（比如各类StackView）。

在子View确定自己的尺寸后，将这个需要的尺寸汇报回父View，

父View最后把这个确定好尺寸的子View放置在坐标系合适的位置上。



Text并不“盲目”遵守自身内容的尺寸，而是会更多地尊重提案的尺寸，通过换行或是把内容省略为“...”来修改内容，去尽量满足提案。

#### 布局优先级

通过.layoutPriority，可以控制计算布局的优先级，让父View优先对某个字View进行考虑和提案。默认情况下，布局优先级都是0，传一个更大的值就可以提高优先级。

```swift
  HStack(alignment: .center) {
            
            Image(systemName: "person.circle")
                .background(Color.yellow)
            Text("User:")
                .background(Color.red)
            Text("onevcat | Wei Wang")
                .layoutPriority(1)
                .background(Color.green)

        }
        .lineLimit(1)
        .frame(width: 200)
        .background(Color.purple)
```

![image-20210701005556435](https://gitee.com/yanglfree/img/raw/master/test/image-20210701005556435.png)

#### 强制固定尺寸

fixedSize，这个modifier将提示布局系统忽略掉外界条件，让被修饰的View使用它在无约束下原本应有的理想尺寸

#### Frame

将fixedSize跟frame两个modifier调换顺序，布局和不加fixedSize的时候完全一致。

因为大部分View modifier所做的，并不是“改变”View上的某个属性，而是“用一个带有相关属性的新View来包装原有的View”。

frame 也不例外： 它并不是将所作用的 View 的尺寸进行更改，而是新创建一个 View，并强制地用指 定的尺寸，对其内容 (其实也就是它的子 View) 进行提案。这也是为什么将 fixedSize 写在 frame 之后会变得没有效果的原因：因为 frame 这个 View 的理想尺寸就是宽 度 200，它已经是按照原本的理想尺寸进行布局了，再用 fixedSize 包装也不会带来 任何改变。

frame方法的两种版本里，所有的参数都有默认值nil，如果使用默认值，那么frame将不在这个方向上改变原有的尺寸提案，而是将它直接传递给子View

frame中不设置width的情况下，只使用对齐，对齐将不会生效，因为内容已经占满了frame的全部空间，内容已经贴边，使用哪种对齐没有意义。

#### Alignment Guide


