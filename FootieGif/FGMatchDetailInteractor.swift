//
//  FGMatchDetailInteractor.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 29/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchDetailInteractor: NSObject {
    
    var output: FGMatchDetailPresenter!
    var match: FGMatch!

    private var gifArray: [FGGif]!
    private var currentGif : FGGif!
    
    override init() {
        
        self.gifArray = [FGGif]()
        super.init()
    }
    
    func setCurrentGif(gif: FGGif) -> Void {
        
        self.currentGif = gif
        
        if (!self.gifArray.contains(gif)) {
            
            self.gifArray.append(gif)
        }
        
        self.fetchGifData(gif)
    }
    
    func nextGif(query: String) -> Void {
        
        let nextGifIndex = self.gifArray.indexOf(self.currentGif)! + 1
        
        if (nextGifIndex < self.gifArray.count) {
            
            self.setCurrentGif(self.gifArray[nextGifIndex])
            
        } else {
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)
                
                g.random(query, rating: nil) { gif, err in
                    //fixed_width_downsampled_url
                    
                    if (gif != nil) {
                        
                        let gifUrlString = gif!.json["image_url"] as! String
                        let gifURL = NSURL(string: gifUrlString);
                        let previewGifUrlString = gif!.json["fixed_width_small_url"] as! String
                        let previewGifUrl = NSURL(string: previewGifUrlString);
                        
                        let gif = FGGif()
                        gif.previewGifURL = previewGifUrl
                        gif.gifURL = gifURL
                        
                        self.setCurrentGif(gif)
                    }
                    
                }
            }
        }
    }
    
    func previousGif() -> Void {
        
        let previousGifIndex = self.gifArray.indexOf(self.currentGif)! - 1
        guard previousGifIndex >= 0 else { return }
        
        self.setCurrentGif(self.gifArray[previousGifIndex])
    }
    
    private func fetchGifData(gif: FGGif) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let networkRequest = FGNetworkRequest()
            networkRequest.executeRequest(gif.previewGifURL) { (responseData, response, error) in
                
                if (responseData != nil) {
                    
                    self.output.updateImageViewGif(responseData)
                    self.output.updateBackgroundImageData(responseData)
                    
                    let networkRequest = FGNetworkRequest()
                    networkRequest.executeRequest(gif.gifURL) { (responseData, response, error) in
                        
                        if (self.currentGif.gifURL == gif.gifURL) {
                            
                            guard responseData != nil else { return }
                            self.output.updateImageViewGif(responseData!)
                        }
                    }

                }
            }
        }
    }
}
