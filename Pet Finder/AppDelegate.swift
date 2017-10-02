/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  private let solar = Solar(latitude: 40.758899, longitude: -73.9873197)!
  
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //Theme.current.apply()
    initializeTheme()
    
    
    return true
  }
  
  
  //1
  func initializeTheme() {
    //2
    if solar.isDaytime {
      Theme.current.apply()
      scheduleThemeTimer()
    } else {
      Theme.dark.apply()
    }
  }
  
  func scheduleThemeTimer() {
    //3
    let timer = Timer(fire: solar.sunset!, interval: 0, repeats: false) { [weak self] _ in
      Theme.dark.apply()
      
      //4
      self?.window?.subviews.forEach({ (view: UIView) in
        view.removeFromSuperview()
        self?.window?.addSubview(view)
      })
    }
    
    //5
    RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
  }
  
}
