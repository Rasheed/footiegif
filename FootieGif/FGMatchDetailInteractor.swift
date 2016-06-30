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
    
    
    func imageViewMoved(point: CGPoint) {
        
        var imageViewAlpha: CGFloat = 1.0
        var imageViewTitle: String;
        
        
        if point.y < -200 {
            
            let alpha = 1.0 - point.y / -400;
            imageViewAlpha = alpha;
            imageViewTitle = "Share"
            
        } else if point.y > 50.0 {
            
            let alpha = 1.0 - point.y / 400.0;
            imageViewAlpha = alpha;
            imageViewTitle = "Bye"
        } else if point.x > 100 {
            
            let alpha = 1.0 - point.x / 200;
            imageViewAlpha = alpha;
            imageViewTitle = "Next"
            
        } else if point.x < -100 {
            
            let alpha = 1.0 - point.x / -200;
            imageViewAlpha = alpha;
            imageViewTitle = "Previous"
        } else {
            
            imageViewTitle = ""
            imageViewAlpha = 1.0;
        }
        
        self.output.updateImageView(imageViewAlpha, title: imageViewTitle)
    }
    
    func swipeUp() {
        
        self.shareCurrentGif()
    }
    
    func swipeDown() {
        
        self.output.output.removeImageView()
    }
    
    func swipeLeft() {
        
        self.previousGif()
    }

    func swipeRight() {
        
        self.nextGif((self.match?.winningTeamName)! + " football")
    }
    
    func setCurrentGif(gif: FGGif) -> Void {
        
        self.currentGif = gif
        
        if (!self.gifArray.contains(gif)) {
            
            self.gifArray.append(gif)
        }
        
        self.fetchGifData(gif)
    }
    
    private func nextGif(query: String) -> Void {
        
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
                        let previewGifUrlString = gif!.json["fixed_width_downsampled_url"] as! String
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
    
    private func previousGif() -> Void {
        
        let previousGifIndex = self.gifArray.indexOf(self.currentGif)! - 1
        guard previousGifIndex >= 0 else { return }
        
        self.setCurrentGif(self.gifArray[previousGifIndex])
    }
    
    private func shareCurrentGif() {
        
        let shareItems:Array = [self.currentGif.gifURL]
        self.output.presentShareActivity(shareItems)
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
                            self.output.updateImageViewGif(responseData)
                        }
                    }

                }
            }
        }
    }
}
