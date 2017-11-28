//
//  WebViewController.swift
//  iOS_OAuth2Test
//
//  Created by Taylor Newton on 4/21/17.
//  Copyright © 2017 Taylor Newton. All rights reserved.
//

import UIKit
import SafariServices

enum AccessTokenResponse {
    case accessToken(String), code(String, state:String?), error(String,String), none
    
    var responseType: String {
        switch self {
        case .accessToken:
            return "token"
        case .code:
            return "code"
        case .error:
            return "code"
        case .none:
            return "code"
        }
    }
}

class OAuthWebViewController: SFSafariViewController, UIApplicationDelegate {
//class OAuthWebViewController: OAuthViewController, OAuthSwiftURLHandlerType {
    var targetURL : URL?
    var webView : UIWebView = UIWebView()
    
//    var accessTokenResponse : AccessTokenResponse?
    
    let googleClientID = "***CLIENT*ID***"
    let authorizationEndPoint = "https://accounts.google.com/o/oauth2/auth"
    let accessTokenEndPoint = "https://accounts.google.com/o/oauth2/token"
    let redirectURI = "***REDIRECT*URI***"
    
    override init(url URL: URL, entersReaderIfAvailable: Bool) {
        super.init(url: URL, entersReaderIfAvailable: entersReaderIfAvailable)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        view.addSubview(webView)
        startAuthorization()
    }
    
    func startAuthorization() {
        let responseType = "code"
        let redirectURL = redirectURI.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        let state = "gmail\(Int(NSDate().timeIntervalSince1970))"
        let scope = "https://www.googleapis.com/auth/gmail.readonly".addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(googleClientID)&"
        authorizationURL += "redirect_uri=\(redirectURL)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        if let url = URL(string: authorizationURL) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}
