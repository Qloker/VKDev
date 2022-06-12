
import UIKit
import WebKit

class AuthVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeToAPI()
    }
    
    func authorizeToAPI() {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8134560"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "271366"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "revoke", value: "1"),
        ]
        
        //Запрос
        let request = URLRequest(url: urlComponents.url!)
        
        //Браузер отпрвляет запрос
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            print(navigationResponse.response.url as Any)
            
            decisionHandler(.allow)
            return
        }
        
        print(navigationResponse.response.url as Any)
        
        print(url.fragment as Any)

        let paramsDictionary = url
            .fragment?
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { partialResult, param in
                var dictionary = partialResult
                let key = param[0]
                let value = param[1]
                dictionary[key] = value
                return dictionary
            }
        
        print(paramsDictionary as Any)
        
        guard let token = paramsDictionary?["access_token"],
              let userId = paramsDictionary?["user_id"],
              let expiresIn = paramsDictionary?["expires_in"] else { return }
            
        
        UserSession.shared.token = token
        UserSession.shared.expiresIn = expiresIn
        UserSession.shared.userId = userId
        
        let friendsVC = FriendsVC()
        let tabBar = MainTabBarController()
        navigationController?.pushViewController(tabBar, animated: true)
        
        decisionHandler(.cancel)
    }

}

