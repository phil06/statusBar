//
//  SearchViewController.swift
//  DictionaryBar
//
//  Created by NHNEnt on 04/03/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Cocoa
import WebKit

class SearchViewController: NSViewController {

    @IBOutlet weak var webview: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let request = URLRequest(url: URL(string: "https://endic.naver.com/popManager.nhn?sLn=kr&m=miniPopMain")!)
        webview.load(request)
    }

}

extension SearchViewController {
    // MARK: Storyboard instantiation
    static func initialLoad() -> SearchViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("SearchViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SearchViewController else {
            fatalError("Why cant i find SearchViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
