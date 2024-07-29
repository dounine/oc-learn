import UIKit

@objc public class FloatBtnBuilder: NSObject {
    @objc public static func new(frame: CGRect) -> FloatBtn {
        return FloatBtn(frame: frame)
    }
}

@available(iOS 13.0,*)
public class FloatBtn: UIView {
    var startLocation: CGPoint?
    var safeAreaTop: CGFloat = 0 // 顶部安全距离
    var safeAreaBottom: CGFloat = 0 // 底部安全距离

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true // 允许事件交互
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapSelf)) // 添加点击事件
        self.addGestureRecognizer(tap)
        self.backgroundColor = .red
        self.layer.cornerRadius = frame.width / 2
        let window = UIApplication.shared.windows.last
        if let window = window {
            self.safeAreaTop = window.safeAreaInsets.top
            self.safeAreaBottom = window.safeAreaInsets.bottom
        }
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        self.startLocation = location // 记录点击位置
        superview?.bringSubviewToFront(self) // 把按钮放到视图最前面
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        guard let location = location, let startLocation = startLocation else {
            return
        }
        let moveX = location.x - startLocation.x
        let moveY = location.y - startLocation.y
        self.center.x += moveX
        self.center.y += moveY
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changeLocation()
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changeLocation()
    }

    private func changeLocation() {
        guard let superview = superview else {
            return
        }
        let pointer = self.center // 按钮中心点
        var y = max(self.frame.origin.y, self.safeAreaTop) // 防止超出顶部
        y = min(superview.frame.height - self.frame.height - self.safeAreaBottom, y) // 防止超出底部
        if pointer.x > superview.bounds.width / 2 { // 滑动到右边
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                print(y)
                self.frame = CGRect(
                    x: superview.frame.width - self.frame.width,
                    y: y,
                    width: self.frame.width,
                    height: self.frame.height
                )
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.frame = CGRect(
                    x: 0,
                    y: y,
                    width: self.frame.width,
                    height: self.frame.height
                )
            })
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapSelf() {
        print("click")
    }
}
