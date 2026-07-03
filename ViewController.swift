//
//  ViewController.swift
//  The Freak Circus
//
//  Created by WebView Generator
//  Copyright © 2026 Garula. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
        // 优化游戏性能
        webConfiguration.preferences.setValue(true, forKey: "developerExtrasEnabled")
        webConfiguration.allowsAirPlayForMediaPlayback = true
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = true
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = false
        
        // 支持缩放
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        title = "The Freak Circus"
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // 添加加载指示器
        setupActivityIndicator()
        
        // 加载游戏URL
        loadGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func loadGame() {
        guard let url = URL(string: "https://playthefreakcircus.com") else {
            showError(message: "无效的游戏URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
        activityIndicator.startAnimating()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "错误", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "重试", style: .default) { [weak self] _ in
            self?.loadGame()
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        
        // 注入JavaScript优化游戏体验
        let js = """
        // 隐藏滚动条
        document.body.style.overflow = 'hidden';
        
        // 尝试自动点击开始游戏按钮（如果存在）
        setTimeout(() => {
            const buttons = document.querySelectorAll('button, .button, [role="button"]');
            buttons.forEach(btn => {
                if (btn.textContent.toLowerCase().includes('play') || 
                    btn.textContent.toLowerCase().includes('start') ||
                    btn.textContent.toLowerCase().includes('game')) {
                    // 不自动点击，只高亮显示
                    btn.style.animation = 'pulse 2s infinite';
                }
            });
        }, 3000);
        
        // 添加脉冲动画样式
        const style = document.createElement('style');
        style.textContent = `
            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.05); }
            }
        `;
        document.head.appendChild(style);
        """
        
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showError(message: "加载失败: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showError(message: "网络错误: \(error.localizedDescription)")
    }
    
    // MARK: - WKUIDelegate
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    // MARK: - 屏幕方向
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: - 状态栏
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
