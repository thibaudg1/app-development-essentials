//
//  ViewController.swift
//  AVplayerDemo
//
//  Created by james on 05/06/2023.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    
    var playerViewController: AVPlayerViewController?
    lazy var player = AVPlayer(url: URL(string: "https://www.ebookfrenzy.com/ios_book/movie/movie.mov")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func removePlayer(_ sender: Any) {
        playerViewController?.player?.pause()
        playerViewController?.player = nil
        
        playerViewController?.willMove(toParent: nil)
        playerViewController?.removeFromParent()
        
        playerViewController = nil
        
        let subviews = videoView.subviews
        print(videoView.subviews)
        
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    @IBAction func playHere(_ sender: Any) {
        let playerVC = AVPlayerViewController()
        self.playerViewController = playerVC
        
        playerVC.player = player
        playerVC.canStartPictureInPictureAutomaticallyFromInline = true
        playerVC.exitsFullScreenWhenPlaybackEnds = true
        playerVC.allowsPictureInPicturePlayback = true
        
        self.addChild(playerVC)
        playerVC.didMove(toParent: self)
        
        videoView.addSubview(playerVC.view)
        playerVC.view.frame = videoView.bounds
        
        
        player.seek(to: .zero)
        player.play()
        playerVC.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AVPlayerViewController
        destination.player = player
        destination.delegate = self
    }
}

extension ViewController: AVPlayerViewControllerDelegate {
    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PiP will start")
    }
    
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        print("PiP stopped")
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        print("Failed to start PiP with error: \(error.localizedDescription)")
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        if self.presentedViewController != nil || self.children.contains(playerViewController) || self.playerViewController == nil {
            print("PlayerVC already being presented/loaded/removed")
            
            completionHandler(true)
        } else {
            print("PlayerVC not currently being presented")
            
            present(playerViewController, animated: true) {
                completionHandler(true)
            }
        }
    }
    
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        true
    }
    
}
