//
//  Constants.swift

//MARK: - Colors
extension UIColor {
    
    class func app733D47() -> UIColor { return UIColor(named: "App733D47")! }
    class func appBF9B9B() -> UIColor { return UIColor(named: "AppBF9B9B")! }
    class func appBlack() -> UIColor { return UIColor(named: "AppBlack")! }
    class func appGray() -> UIColor { return UIColor(named: "AppGray")! }
    class func appTextBg() -> UIColor { return UIColor(named: "AppTextBg")! }
    class func appWhite() -> UIColor { return UIColor(named: "AppWhite")! }
}

// MARK: - Global
enum GlobalConstants {
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {
    
    static let kSignInVC = "SignInVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {
    
}

//MARK: - Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgInProgress = "In Progress"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images, Photos & Audio Related Messages
    static let msgMicrophonePermission = "Please enable microphone access from privacy settings"
    static let msgPhotoLibraryPermission = "Please enable access for photos from privacy settings"
    static let msgCameraPermission = "Please enable camera access from privacy settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    
    //General Error Message
    static let msgError = "Something went wrong. Please try after sometime"
    
    //Validation Messages
    static let msgFirstName = "Please enter first name"
    static let msgValidFirstName = "First name must contain atleast 1 characters and maximum 30 characters"
    
    static let msgLastName = "Please enter last name"
    static let msgValidLastName = "Last name must contain atleast 1 characters and maximum 30 characters"
    
    static let msgName = "Please enter name"
    static let msgValidName = "Name must contain atleast 2 characters and maximum 60 characters"
    
    static let msgEmail = "Please enter email address"
    static let msgValidEmail = "Please enter valid email address"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 16 characters"
    static let msgValidPassword = "Password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum eight character length"
    
    static let msgConfPassword = "Please enter confirm password"
    static let msgConfPasswordCharacter = "Confirm password must contain atleast 8 characters and maximum 16 characters"
    
    static let msgPasswordMatch = "Password and confirm password should be the same. Please check it"
    
    //API Message
    static let msgUnauthorized = "Your unauthorized. Please try again"
    
    //General Delete Message
    static let msgGeneralDelete = "Are you sure you want to delete?"
    
    //Logout Message
    static let msgLogout = "Are you sure you want to log out from the application?"
}

//MARK: - Web Service URLs
enum WebServiceURL {
    
    //Base URL for APIs
    static let mainURL = ""
}

//MARK: - Web Service Parameters
enum WebServiceParameter {
    
}

//MARK: - UserDefault
enum UserDefault {
    
    static let kUsername = "username"
    static let kPassword = "password"
    static let kIsKeyChain = "isKeyChain"
}

//MARK: - Constants
struct Constants {
    
    //MARK: - Device Type
    enum UIUserInterfaceIdiom : Int {
        
        case Unspecified
        case Phone
        case Pad
    }
    
    //MARK: - Screen Size
    struct ScreenSize {
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
}

//MARK: - DateTime Format
enum DateAndTimeFormatString {
    
    static let strDateFormate_ddMMMyyyyhhmmss = "dd MMM yyyy hh:mm:ss a"
    static let strDateFormate_yyyyMMdd = "yyyy-MM-dd"
    static let strDateFormate_ddMMMMyyyy = "dd MMMM yyyy"
    static let strDateFormate_MMddyyyy = "MM-dd-yyyy"
    static let strDateFormate_hhmma = "hh:mm a"
    static let strDateFormate_HHmm = "HH:mm"
    static let strDateFormate_hhmmss = "hh:mm:ss"
}

