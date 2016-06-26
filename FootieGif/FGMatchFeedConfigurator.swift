//
//  FGMatchFeedConfigurator.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedConfigurator: NSObject {

    class var sharedInstance: FGMatchFeedConfigurator
    {
        struct Static {
            static var instance: FGMatchFeedConfigurator?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = FGMatchFeedConfigurator()
        }
        
        return Static.instance!
    }

    func configure(viewController: FGMatchCollectionViewController)
    {
        let router = FGMatchFeedRouter()
        router.viewController = viewController
        
        let presenter = FGMatchFeedPresenter()
        presenter.output = viewController
        
        let interactor = FGMatchFeedInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }

}
