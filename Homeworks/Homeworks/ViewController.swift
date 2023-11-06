import UIKit
import WebKit

final class ViewController: UIViewController, WKNavigationDelegate {
    
    private var session = URLSession.shared
    
    private var networkService = NetworkService()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
        setupViews()
        webView.frame = CGRect(x: 10, y: 10, width: 300, height: 600)
        webView.load(networkService.getAuthorizeRequest())
        setupConstraints()
        view.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = ColorTheme.currentTheme.backgroundColor
    }
    
    private func setupViews(){
        view.addSubview(webView)
    }
    
    private func setupConstraints(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        networkService.receiveIDandToken(fragment: fragment)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        
        let tab1 = UINavigationController(rootViewController: FriendsViewController())
        let tab2 = UINavigationController(rootViewController: GroupsViewController())
        let tab3 = UINavigationController(rootViewController: PhotosViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        let tab4 = UINavigationController(rootViewController: UserProfileViewController())

        tab1.tabBarItem.title = "Friends"
        tab2.tabBarItem.title = "Groups"
        tab3.tabBarItem.title = "Photos"
        tab4.tabBarItem.title = "My profile"

        let controllers = [tab1, tab2, tab3, tab4]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let firstWindow = firstScene.windows.first else {
            return
        }

        firstWindow.rootViewController =  tabBarController
    }
    
}

