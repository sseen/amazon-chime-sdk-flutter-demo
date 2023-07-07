/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 */
 
import AmazonChimeSDK
import Foundation

class VideoTileView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _paras: Any?

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) {
        _view = DefaultVideoRenderView()
        super.init()
           
        // Receieve tileId as a param.
        let tileId = args as! Int
        let videoRenderView = _view as! VideoRenderView
           
        print("ssn: \(tileId)")
        
        // Bind view to VideoView
        MeetingSession.shared.meetingSession?.audioVideo.bindVideoView(videoView: videoRenderView, tileId: tileId)
           
        // Fix aspect ratio
        _view.contentMode = .scaleAspectFit
           
        // Declare _view as UIView for Flutter interpretation
        _view = _view as UIView
        _paras = args

        _view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        _view.addGestureRecognizer(tapGesture)

    }


        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            print("CustomView tapped")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.methodChannel?.callFlutterMethod(method: .clickOnVideo, args: _paras)
        }


    func view() -> UIView {
        return _view
    }
}
