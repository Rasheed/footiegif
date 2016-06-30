//
//  FGMatchDetailConfigurator.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 29/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchDetailConfigurator: NSObject {
    
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
