
import UIKit

class SettingViewController: UIViewController {
    var circleLoad = CircleView()
    var timer: Timer!
    var timerOn: Bool = false
    var current: CGFloat = 0
    var limit: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadView = UIView()
        loadView.backgroundColor = UIColor.blue
        self.view.addSubview(loadView)
        self.view.backgroundColor=UIColor.white
        self.view.addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: loadView)
        self.view.addConstraintWithFormat(format: "V:|-16-[v0(200)]|", views: loadView)
       loadView.addSubview(circleLoad)
       loadView.addConstraintWithFormat(format: "V:|-16-[v0(150)]-16-|", views: circleLoad)
       loadView.addConstraintWithFormat(format: "H:|-16-[v0(150)]|", views: circleLoad)
     
        
        let startButton = UIButton()
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(startButton)
        self.view.addConstraintWithFormat(format:"V:|-16-[v0]-8-[v1(44)]|", views:loadView,startButton)
     
        let stopButton = UIButton()
        stopButton.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(stopButton)
        
        self.view.addConstraintWithFormat(format: "H:|[v0(44)]-20-[v1(50)]|", views: startButton,stopButton)
         self.view.addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(50)]|", views: loadView,stopButton)
   
    }
    
    @objc func startAnimation() {
        
        circleLoad.masterSlider = current
        circleLoad.setNeedsDisplay()
        current += 0.05
        
    }
    
    
    func startTimer() {
        if !timerOn {
            timerOn = true
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startAnimation), userInfo: nil, repeats: true)
        } else { print("Animation Already running") }
    }
    
    
    func stopTimer() {
        
        timer.invalidate()
        timerOn = false
        current = 0
        circleLoad.masterSlider = 1
        circleLoad.setNeedsDisplay()
        
    }
    
    @objc func startAction(){
        startTimer()
    }
    
    @objc func stopAction(){
         stopTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
