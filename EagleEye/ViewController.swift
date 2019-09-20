import UIKit
import Branch

class ViewController: UIViewController {
    
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    let instructionString = "Before testing referrals for referrer users, please follow the following steps:\n 1) Uninstall the app\n 2) Reset Adevertising Identifier from Setting -> Privacy -> Advertising\n 3) Tap on the link below\n 4) Run the app from xcode \n"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.instructionsLabel.isHidden = true
        
        let event:BranchEvent = BranchEvent.standardEvent(.login)
        event.logEvent()
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        let buo = BranchUniversalObject(canonicalIdentifier: "referrer/\(UUID().uuidString)")
        buo.title = "Test"
        buo.contentDescription = "Test"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.feature = "referral"
        lp.addControlParam("user_id", withValue: UUID().uuidString)
        
        buo.showShareSheet(with: lp, andShareText: instructionString, from: self) { (params, success) in
            if(success == true){
                self.instructionsLabel.isHidden = false;
                self.instructionsLabel.text = self.instructionString
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

