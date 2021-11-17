//
//  Extension.swift

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIApplication {
    
    var screenShot: UIImage?  {
        
        if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let scale = UIScreen.main.scale
            let bounds = rootViewController.view.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
            if let _ = UIGraphicsGetCurrentContext() {
                rootViewController.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
                let screenshot = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return screenshot
            }
        }
        return nil
    }
    
    public func runInBackground(_ closure: @escaping () -> Void, expirationHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let taskID: UIBackgroundTaskIdentifier
            if let expirationHandler = expirationHandler {
                taskID = self.beginBackgroundTask(expirationHandler: expirationHandler)
            } else {
                taskID = self.beginBackgroundTask(expirationHandler: { })
            }
            closure()
            self.endBackgroundTask(taskID)
        }
    }
    
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UIViewController {
    
    //MARK: - Show/Hide Navigation Bar Methods
    func showNavigationBar(isTabbar : Bool = false) {
        if isTabbar {
            self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func hideNavigationBar(isTabbar : Bool = false) {
        if isTabbar {
            self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func setNavigationHeader(strTitleName : String = "", strImageName : String = "", isTabbar : Bool = false) {
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: (UIFont(name: "Inter-Bold" , size: 20)?.withWeight(UIFont.Weight.bold) ?? UIFont.systemFont(ofSize: 20).withWeight(UIFont.Weight.bold))]
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        if strImageName == "" {
            navBarAppearance.backgroundColor = .appBlack()
        } else {
            navBarAppearance.backgroundImage = UIImage(named: strImageName)
        }
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font : (UIFont(name: "Inter-Bold" , size: 20)?.withWeight(UIFont.Weight.bold) ?? UIFont.systemFont(ofSize: 20).withWeight(UIFont.Weight.bold))]
        navBarAppearance.shadowColor = .clear
        
        if isTabbar {
            self.tabBarController?.navigationItem.hidesBackButton = true
            
            self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = (titleDict as! [NSAttributedString.Key : Any])
            self.tabBarController?.navigationItem.title = strTitleName
            
            self.tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
            
            self.tabBarController?.navigationController?.navigationBar.barTintColor = .appBlack()
            self.tabBarController?.navigationController?.navigationBar.tintColor = .white
            self.tabBarController?.navigationController?.navigationBar.isTranslucent = false
            
            if #available(iOS 13.0, *) {
                self.tabBarController?.navigationController?.navigationBar.standardAppearance = navBarAppearance
                self.tabBarController?.navigationController?.navigationBar.compactAppearance = navBarAppearance
                self.tabBarController?.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            }
        } else {
            self.navigationItem.hidesBackButton = true
            self.navigationItem.title = ""
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            
            if strImageName == "" {
                self.navigationController?.navigationBar.titleTextAttributes = (titleDict as! [NSAttributedString.Key : Any])
                self.navigationItem.title = strTitleName
                
                self.navigationController?.navigationBar.barTintColor = .appBlack()
            } else {
                let image = UIImage(named: strImageName)
                let imageView = UIImageView(image: image)
                
                let bannerWidth = (self.navigationController?.navigationBar.frame.size.width ?? 0.0) * 0.32
                let bannerHeight = (self.navigationController?.navigationBar.frame.size.height ?? 0.0) * 0.64
                
                imageView.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: bannerHeight)
                imageView.contentMode = .top
                
                self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            }
            
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.isTranslucent = false
            
            if #available(iOS 13.0, *) {
                self.navigationController?.navigationBar.standardAppearance = navBarAppearance
                self.navigationController?.navigationBar.compactAppearance = navBarAppearance
                self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            }
        }
    }
    
    //MARK: - Setup Menu Button Method
    func setupMenuButton(isTabbar : Bool) {
        
        let btnMenu = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu"), style: .plain, target: self, action: #selector(openMenu))
        
        if isTabbar {
            self.tabBarController?.navigationItem.leftBarButtonItem = btnMenu
        } else {
            self.navigationItem.leftBarButtonItem = btnMenu
        }
    }
    
    @objc func openMenu() {
        
        SideMenuManager.default.menuShadowOpacity = 0
        SideMenuManager.default.menuAnimationFadeStrength = 0.25
        SideMenuManager.default.menuPushStyle = .popWhenPossible
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAllowPushOfSameClassTwice = false
        SideMenuManager.default.menuWidth = Constants.ScreenSize.SCREEN_WIDTH * (3/4)
        SideMenuManager.default.menuAnimationBackgroundColor = .clear
        SideMenuManager.default.menuAlwaysAnimate = true
        SideMenuManager.default.menuEnableSwipeGestures = false
        
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    //MARK: - Setup Back Button Method
    func setupBackButton(isTabbar : Bool = false) {
        
        let btnBack = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popVC))
        
        if isTabbar {
            self.tabBarController?.navigationItem.leftBarButtonItem = btnBack
        } else {
            self.navigationItem.leftBarButtonItem = btnBack
        }
    }
    
    //MARK: - Setup Close Button Method
    func setupCloseButton(isTabbar : Bool = false) {
        
        let btnClose = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_web_close"), style: .plain, target: self, action: #selector(popVC))
        
        if isTabbar {
            self.tabBarController?.navigationItem.rightBarButtonItem = btnClose
        } else {
            self.navigationItem.rightBarButtonItem = btnClose
        }
    }
    
    //MARK: - Setup Back Button With Title Method
    func setupBackButtonWithTitle(strTitleName :  String, isTabbar : Bool = false) {
        
        let vCustom = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 250.0, height: 44.0))
        
        let btnBack = UIButton.init(type: .custom)
        btnBack.setBackgroundImage(UIImage(named: "ic_back"), for: .normal)
        btnBack.frame = CGRect(x: 0.0, y: 5.0, width: 32.0, height: 32.0)
        btnBack.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        vCustom.addSubview(btnBack)
        
        let marginX = CGFloat(btnBack.frame.origin.x + btnBack.frame.size.width + 15)
        let label = UILabel(frame: CGRect(x: marginX, y: 0.0, width: 150.0, height: 44.0))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Roboto-Medium", size: 20.0)!
        label.textAlignment = .left
        label.textColor = .white
        label.text = strTitleName
        vCustom.addSubview(label)
        
        if isTabbar {
            self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vCustom)
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vCustom)
        }
    }
    
    @objc func popVC() {
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    //MARK: - Setup Reset Button Method
    func setupResetButton(isTabbar : Bool = false) {
        
        let btnResetFilter = UIBarButtonItem(title: "RESET", style: .plain, target: self, action: #selector(resetFilter))
        
        if isTabbar {
            self.tabBarController?.navigationItem.rightBarButtonItem = btnResetFilter
        } else {
            self.navigationItem.rightBarButtonItem = btnResetFilter
        }
    }
    
    @objc func resetFilter() {
        clearGlobalVariables()
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    //MARK: - Share Link Method
    func shareLink(strShareLink : String) {
        
        let urlShareLink = URL(string: strShareLink)
        let activityViewController = UIActivityViewController(activityItems: [urlShareLink!] as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Show UIAlertController Method
    func showAlertControl(strTitle : String, strMessage : String, isPurchase : Bool = false) {
        
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

public extension UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func setShadowNavigationBar(){
        self.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationBar.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationBar.shadowRadius = 4.0
        self.navigationBar.shadowOpacity = 2.0
        self.navigationBar.layer.masksToBounds = false
    }
    
    func popViewController(_ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}

public extension UICollectionView {
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

public extension UITableView {
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    func removeTableFooterView() {
        tableFooterView = nil
    }
    
    func removeTableHeaderView() {
        tableHeaderView = nil
    }
    
    func scrollToBottom(animated: Bool = true) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
    
    func setAttributes(isSeparator : Bool = false) {
        estimatedRowHeight = UITableView.automaticDimension
        rowHeight = UITableView.automaticDimension
        tableFooterView = UIView()
        
        if isSeparator {
            separatorColor = .lightGray
        }
    }
}

public extension UISearchBar {
    
    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public extension UISlider {
    
    func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
}

public extension UIViewController {
    
    //MARK: - Add/Remove Notification Observer Method
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

@IBDesignable
extension UIDatePicker {
    @IBInspectable var textLabelColor: UIColor? {
        get {
            return self.value(forKey: "textColor") as? UIColor
        }
        set {
            self.setValue(newValue, forKey: "textColor")
        }
    }
}

public extension CLLocation {
    
    static func midLocation(start: CLLocation, end: CLLocation) -> CLLocation {
        let lat1 = Double.pi * start.coordinate.latitude / 180.0
        let long1 = Double.pi * start.coordinate.longitude / 180.0
        let lat2 = Double.pi * end.coordinate.latitude / 180.0
        let long2 = Double.pi * end.coordinate.longitude / 180.0
        
        let bx = cos(lat2) * cos(long2 - long1)
        let by = cos(lat2) * sin(long2 - long1)
        let mlat = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + bx) * (cos(lat1) + bx) + (by * by)))
        let mlong = (long1) + atan2(by, cos(lat1) + bx)
        
        return CLLocation(latitude: (mlat * 180 / Double.pi), longitude: (mlong * 180 / Double.pi))
    }
    
    
    func midLocation(to point: CLLocation) -> CLLocation {
        return CLLocation.midLocation(start: self, end: point)
    }
    
    func bearing(to destination: CLLocation) -> Double {
        let lat1 = Double.pi * coordinate.latitude / 180.0
        let long1 = Double.pi * coordinate.longitude / 180.0
        let lat2 = Double.pi * destination.coordinate.latitude / 180.0
        let long2 = Double.pi * destination.coordinate.longitude / 180.0
        
        let rads = atan2(sin(long2 - long1) * cos(lat2),
                         cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(long2 - long1))
        let degrees = rads * 180 / Double.pi
        
        return (degrees+360).truncatingRemainder(dividingBy: 360)
    }
}

@IBDesignable
class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 3
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
}

class CustomLabel: UILabel {
    override var text: String? {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)))
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat , font : UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat , font : UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
}

class CustomTitleView: UIView {
    
    override var intrinsicContentSize: CGSize {
        self.translatesAutoresizingMaskIntoConstraints = false
        return UIView.layoutFittingExpandedSize
    }
}

extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

extension Encodable {
    
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

extension UINavigationController {
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}
