//  PresentationLink bug workaround for SwiftUI (Xcode b3)
import SwiftUI
import UIKit
extension UIApplication {
  /// The top most view controller
  static var topMostViewController: UIViewController? {
    return UIApplication.shared.windows.first?.rootViewController?.visibleViewController
  }
}

extension UIViewController {
  /// The visible view controller from a given view controller
  var visibleViewController: UIViewController? {
    if let navigationController = self as? UINavigationController {
      return navigationController.topViewController?.visibleViewController
    } else if let tabBarController = self as? UITabBarController {
      return tabBarController.selectedViewController?.visibleViewController
    } else if let presentedViewController = presentedViewController {
      return presentedViewController.visibleViewController
    } else {
      return self
    }
  }
}

extension UIViewController {
  
  func presentViewControllerFromVisibleViewController(viewControllerToPresent: UIViewController,
                                                      animated flag: Bool,
                                                      completion: (() -> Void)?) {
    if let navigationController = self as? UINavigationController {
      navigationController.topViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: true, completion: nil)
    } else if (presentedViewController != nil) {
      presentedViewController!.presentViewControllerFromVisibleViewController(viewControllerToPresent: viewControllerToPresent, animated: true, completion: nil)
    } else {
      present(viewControllerToPresent, animated: true, completion: nil)
    }
  }
}

public struct PresentationLink2<Label: View, Destination: View>: View {
  public let destination: Destination
  
  let _label: () -> Label
  
  public var label: Label {
    return _label()
  }
  
  public init(destination: Destination, label: @escaping () -> Label) {
    self.destination = destination
    self._label = label
  }
  
  public var body: some View {
    return _label().tapAction {
      UIApplication.topMostViewController?.presentViewControllerFromVisibleViewController(viewControllerToPresent: UIHostingController(rootView: self.destination), animated: true, completion: nil)
      
    }
  }
}
