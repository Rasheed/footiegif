//
//  FGMatchDetailConfigurator.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 29/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchDetailConfigurator: NSObject {

    class var sharedInstance: FGMatchDetailConfigurator
    {
        struct Static {
            static var instance: FGMatchDetailConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = FGMatchDetailConfigurator()
        }
        
        return Static.instance!
    }
    
    func configure(viewController: FGMatchDetailViewController)
    {
        let router = FGMatchDetailRouter()
        router.viewController = viewController
        
        let presenter = FGMatchDetailPresenter()
        presenter.output = viewController
        
        let interactor = FGMatchDetailInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }

}
