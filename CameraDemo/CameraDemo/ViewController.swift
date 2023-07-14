//
//  ViewController.swift
//  CameraDemo
//
//  Created by james on 02/06/2023.
//

import UIKit
import CoreServices
import AVKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var livePhotoView: PHLivePhotoView?
    
    var source: UIImagePickerController.SourceType = .camera
    var newlyCapturedMedia: Bool { source == .camera }
    //var media = [UTType.image.identifier] // using UTType for LivePhoto does not work with UIImagePickerController
    
    // kUTTypeLivePhoto used this way is the only way to get Live Photos using a UIImagePickerController:
    let kMedia = [kUTTypeImage as String,
                  kUTTypeLivePhoto as String,
                  kUTTypeMovie as String]
    
    var playerViewController: AVPlayerViewController?
//    lazy var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func useCamera(_ sender: Any) {
        source = .camera
        presentPicker(fromSource: source, forMedia: kMedia, allowingEditing: false)
    }
    
    @IBAction func openCameraRoll(_ sender: Any) {
        source = .savedPhotosAlbum
        presentPicker(fromSource: source, forMedia: kMedia, allowingEditing: false)
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        source = .photoLibrary
        presentPicker(fromSource: source, forMedia: kMedia, allowingEditing: false)
    }
}

extension ViewController {
    private func presentPicker(fromSource source: UIImagePickerController.SourceType,
                               forMedia media: [String],
                               allowingEditing: Bool) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            print("\(source) is not available on this device.")
            return
        }
        
        guard let availableMedia = UIImagePickerController.availableMediaTypes(for: source) else {
            print("\(source) is not able to provide any type of media")
            return
        }
        
        print("Available media for this source: \(availableMedia)")
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.mediaTypes = media
        imagePicker.videoQuality = .typeIFrame1280x720
        if source == .camera {
            imagePicker.cameraCaptureMode = .video
        }
        imagePicker.allowsEditing = allowingEditing
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let mediaType = info[.mediaType] as! String
        
        switch mediaType {
        case UTType.image.identifier:
            print("This is a still image")
            
            var imageToSave: UIImage
            if let image = info[.editedImage] as? UIImage {
                imageToSave = image
            } else { imageToSave = info[.originalImage] as! UIImage }
            
            display(imageToSave)
            
            if newlyCapturedMedia {
                UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(Self.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
            
        case UTType.movie.identifier:
            print("This is a movie")
            
            if let videoURL = info[.mediaURL] as? URL {
                display(videoURL)
            } else {
                print("Could not get a video URL")
            }
            
        case UTType.livePhoto.identifier:
            print("This is a Live Photo")
            
            if let livePhoto = info[.livePhoto] as? PHLivePhoto {
                display(livePhoto)
            } else {
                print("Could not get the live photo object")
            }
            
        default:
            print("Unsupported media type: \(mediaType)")
        }
    }
    
}

extension ViewController {
    private func display(_ image: UIImage) {
        videoView.isHidden = true
        livePhotoView?.isHidden = true
        
        imageView.image = image
        view.bringSubviewToFront(imageView)
        imageView.isHidden = false
    }
    
    private func display(_ videoURL: URL) {
        imageView.isHidden = true
        livePhotoView?.isHidden = true
        videoView.isHidden = false
        
        addPlayerVCIfNeeded()
        view.bringSubviewToFront(videoView)
        
        if let player = playerViewController?.player {
            player.replaceCurrentItem(with: AVPlayerItem(url: videoURL))
        } else {
            playerViewController?.player = AVPlayer(url: videoURL)
        }
        
        playerViewController?.player?.play()
        
        
    }
    
    private func display(_ livePhoto: PHLivePhoto) {
        imageView.isHidden = true
        videoView.isHidden = true
        addLivePhotoViewIfNeeded()
        livePhotoView?.isHidden = false
        
        livePhotoView?.livePhoto = livePhoto
        livePhotoView?.startPlayback(with: .hint)
    }
    
    
    
    @objc func image(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer?) {
        if let error {
            let alert = UIAlertController(title: "Save failed", message: error.localizedDescription, preferredStyle: .alert)
            present(alert, animated: true)
        } else {
            print("Image was saved successfully.")
        }
    }
}

extension ViewController {
    private func addPlayerVCIfNeeded() {
        if self.playerViewController == nil {
            let playerVC = AVPlayerViewController()
            playerVC.exitsFullScreenWhenPlaybackEnds = true
            playerVC.allowsPictureInPicturePlayback = false
            
            self.addChild(playerVC)
            playerVC.didMove(toParent: self)
            
            videoView.addSubview(playerVC.view)
            playerVC.view.frame = videoView.bounds
            
            self.playerViewController = playerVC
        }
    }
    
    private func addLivePhotoViewIfNeeded() {
        if self.livePhotoView == nil {
            let livePhotoView = PHLivePhotoView(frame: imageView.frame)
            self.view.addSubview(livePhotoView)
            self.livePhotoView = livePhotoView
        }
    }
}
