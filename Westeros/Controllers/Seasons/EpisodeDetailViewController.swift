//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit
import WebKit

final class EpisodeDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var model: Episode
    private var videoWebView: WKWebView!
    
    // MARK: - Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButtom()
        
        setupUI()
        syncModelWithView()
    }
    
    // MARK: - Sync
    
    private func syncModelWithView() {
        
        // Si la vista no se ha iniciado por primera vez, no permitimos sincronizar
        guard let _ = self.view else {
            return
        }
        
        // Model -> View
        seasonNameLabel.text = model.season?.title
        episodeNameLabel.text = model.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        releaseDateLabel.text = "Release date: \(dateFormatter.string(from: model.releaseDate))"
        title = model.title
        
        // Video
        if let videoUrl = model.video {
        let url = "\(videoUrl.absoluteURL)?playsinline=1&frameborder=0&allowfullscreen=allowfullscreen"
            videoWebView.load(URLRequest(url: URL(string: url)!))
            activityIndicator.startAnimating()
        } else {
            videoView.isHidden = true
            activityIndicator.isHidden = true
        }
    }
    
    // MARK: - UI
    
    private func setupUI() {

        // Video
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        prefs.javaScriptCanOpenWindowsAutomatically = true
        
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.preferences = prefs
        
        videoWebView = WKWebView(frame: videoView.bounds, configuration: config)
        videoWebView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        videoWebView.scrollView.bounces = false
        videoWebView.navigationDelegate = self
        videoView.addSubview(videoWebView)
        
        activityIndicator.hidesWhenStopped = true
    }

}

// MARK: - WKNavigationDelegate
extension EpisodeDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
    
}
