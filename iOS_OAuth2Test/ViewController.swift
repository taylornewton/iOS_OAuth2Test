//
//  ViewController.swift
//  iOS_OAuth2Test
//
//  Created by Taylor Newton on 4/20/17.
//  Copyright © 2017 Taylor Newton. All rights reserved.
//

import UIKit
import AppAuth

class ViewController: UIViewController {

    var actionLabel: UILabel = UILabel()
    var successLabel: UILabel = UILabel()
    var authState: OIDAuthState?
    
    let googleClientID = "***CLIENT*ID***"
    let authorizationEndPoint = "https://accounts.google.com/o/oauth2/auth"
    let accessTokenEndPoint = "https://accounts.google.com/o/oauth2/token"
    let redirect = "***REDIRECT*URI***"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        actionLabel.text = "Do the thing"
        actionLabel.textAlignment = .center
        actionLabel.backgroundColor = UIColor.blue
        actionLabel.textColor = UIColor.white
        actionLabel.isUserInteractionEnabled = true
        actionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doTheThing(_:))))
        view.addSubview(actionLabel)
        
        successLabel.textAlignment = .center
        successLabel.isUserInteractionEnabled = false
        successLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        successLabel.numberOfLines = 7
        view.addSubview(successLabel)
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: actionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: actionLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: actionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
        view.addConstraint(NSLayoutConstraint(item: actionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120))
        
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: successLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: successLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: successLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 350))
    }
    

    func doTheThing(_ sender: UIButton) {
        // Configure AppAuth to use the designated authorization and access token end points
        let configuration = OIDServiceConfiguration(authorizationEndpoint: URL(string: authorizationEndPoint)!, tokenEndpoint: URL(string: accessTokenEndPoint)!)
        
        let request = OIDAuthorizationRequest(configuration: configuration, clientId: googleClientID, scopes: [OIDScopeOpenID, OIDScopeProfile], redirectURL: URL(string: redirect)!, responseType: OIDResponseTypeCode, additionalParameters: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // this callback exceutes when the SFSafariViewController closes (goes thru app delegate when successful)
        appDelegate.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: self, callback: {authState, error in
            if (authState !=  nil) {
                self.successLabel.text = "We got a token!\n\(authState!.lastTokenResponse!.accessToken!)"
            }
            else {
                print(error!)
            }
        })
    }
}

