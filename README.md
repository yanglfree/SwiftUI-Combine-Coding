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

