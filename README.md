# SwiftUI-Combine-Coding
objc中国 SwiftUI与Combine编程 学习笔记，课后练习，代码


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


