//
//  CameraViewController.swift
//  WandB
//
//  Created by mara shen on 15/7/15.
//  Copyright (c) 2015 mara shen. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, /* For capturing barcodes */AVCaptureMetadataOutputObjectsDelegate {

    // MARK: -Properties
    @IBOutlet weak var cameraView: UIView!
    var barcodeString:String = ""
    
    //init stuff for camera
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("camerapresenting")
        
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        println("Capture device found")
                        beginSession()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -Functions
    
    func beginSession() {
        
        var err : NSError? = nil
        //add video input from camera
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        //add metadata for the CaptureSessionOutput
        addOutputForBarcodeMetadata()
        
        //settings for the camera to fill the entire cameraView
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        let bounds = cameraView.layer.bounds
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        cameraView.layer.addSublayer(previewLayer)
        
        //get the INITIAL orientation
        let previewLayerConnection = previewLayer?.connection
        var orientation = UIApplication.sharedApplication().statusBarOrientation
        
        //change camera orientation based on app orientation
        if orientation == UIInterfaceOrientation.Portrait{
            previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.Portrait
        }else if orientation == UIInterfaceOrientation.LandscapeLeft{
            previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        }else if orientation == UIInterfaceOrientation.LandscapeRight{
            previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
        }else if orientation == UIInterfaceOrientation.PortraitUpsideDown{
            previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.PortraitUpsideDown
        }
        
        captureSession.startRunning()
        
    }
    
    // Capture metadata for barcodes
    var metadataOutput = AVCaptureMetadataOutput()
    func addOutputForBarcodeMetadata() {
        metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureSession.addOutput(metadataOutput)
        // This line is required, as little sense at that makes
        metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
    }
    
    // MARK: -ViewControllerDelegate
    
    //detect the orientation change
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        let previewLayerConnection = previewLayer?.connection
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.sharedApplication().statusBarOrientation
            
            switch orient {
            case .Portrait:
                println("Portrait")
                previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                // Do something
            case .LandscapeLeft:
                println("LF")
                previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
            case .LandscapeRight:
                println("LR")
                previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
            case .PortraitUpsideDown:
                println("PUD")
                previewLayerConnection?.videoOrientation = AVCaptureVideoOrientation.PortraitUpsideDown
            default:
                println("default")
                // Do something else
            }
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                println("rotation completed")
        })
    }
    
    // MARK: AVCaptureMetadataOutputObjectsDelegate
    var canCaptureBarcode = true
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if !canCaptureBarcode {
            return
        }
        
        // Types of barcodes AVKit will be able to find
        let barcodeTypes = [AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode] as [String]
        
        // Loop through the returned metadata objects (might include a barcode)
        for metadata in metadataObjects {
            
            // Use Swift's find() function to get the index of the metadata type, to see if it's in the list of barcode types
            // e.g. is the metadata object a barcode
            if find(barcodeTypes, String(metadata.type)) != nil {
                // If it is, print out the type so we can see what it is
                
                println("Barcode type is \(String(metadata.type))")
                
                // Get the barcode object in machine readable format
                if let barcode = self.previewLayer?.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataObject) as? AVMetadataMachineReadableCodeObject {
                    
                    // Get the barcode string
                    barcodeString = barcode.stringValue
                    
                    //go to next scene if barcode detected
                    //push sa navigationbarstack
                    dismissViewControllerAnimated(true, completion: {
                        NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self, userInfo: ["item":self.barcodeString])

                        //stop camera session
                        //self.captureSession.stopRunning()
                        //self.previewLayer?.removeFromSuperlayer()
                        //self.previewLayer = nil

                        return
                    })

                    //self.captureSession = nil
                    
                }
            }
        }
    }

    
    //MARK: -Actions
    
    @IBAction func cancelCameraButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func enterSKUButton(sender: UIBarButtonItem) {
        //present new view controller for sku
        var skuController : skuViewController = skuViewController(nibName: "skuViewController", bundle: nil)
        skuController.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        presentViewController(skuController, animated: true, completion: nil)
    }

}
