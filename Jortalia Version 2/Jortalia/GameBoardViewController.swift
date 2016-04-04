//
//  ViewController.swift
//  Jortalia
//
//  Created by Lily McKeirnan on 2/29/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var GameBoardScrollView: UIScrollView!
 ////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let image = UIImage(named: "GameBoardRough")!
//        imageView = UIImageView(image: image)
//        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size)
//        GameBoardScrollView.addSubview(imageView)
//        
//        GameBoardScrollView.contentSize = image.size
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "GameBoardScrollViewDoubleTapped:")
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.numberOfTouchesRequired = 1
        GameBoardScrollView.addGestureRecognizer(doubleTapRecognizer)
        
      //  let scrollViewFrame = GameBoardScrollView.frame
       // let scaleWidth = scrollViewFrame.size.width / GameBoardScrollView.contentSize.width
       // let scaleHeight = scrollViewFrame.size.height / GameBoardScrollView.contentSize.height
        let minScale :CGFloat = 1.0; //min(scaleWidth, scaleHeight);
        GameBoardScrollView.minimumZoomScale = minScale;
        
        GameBoardScrollView.maximumZoomScale = 2.0
        GameBoardScrollView.zoomScale = minScale
        
        centerScrollViewContents()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true);
    }
    
 //////////////////////////////////////////
    func centerScrollViewContents() {
          let boundsSize = GameBoardScrollView.bounds.size
          var contentsFrame = imageView.frame
        
          if contentsFrame.size.width < boundsSize.width{
              contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
          } else {
              contentsFrame.origin.x = 0.0
          }
        
          if contentsFrame.size.height < boundsSize.height {
              contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
          } else {
              contentsFrame.origin.y = 0.0
          }
        
          imageView.frame = contentsFrame
    }
/////////////////////////////////////////
    func GameBoardScrollViewDoubleTapped(recognizer: UITapGestureRecognizer){
        let pointInView = recognizer.locationInView(imageView)
        
        var newZoomScale = GameBoardScrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, GameBoardScrollView.maximumZoomScale)
        
        let scrollViewSize = GameBoardScrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRectMake(x, y, w, h);
        
        GameBoardScrollView.zoomToRect(rectToZoomTo, animated: true)
    }
//////////////////////////////////////
    func viewForZoomingInScrollView(GameBoardScrollView: UIScrollView!) -> UIView!{
        return imageView
    }
////////////////////////////////////////
    func scrollViewDidZoom(GameBoardScrollView: UIScrollView!) {
        centerScrollViewContents()
    }
//////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

