
import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    
    @IBAction func shop(_ sender: Any) {
        
        performSegue(withIdentifier: "toChooseVC", sender: self)
    }
    
    
    @IBAction func play(_ sender: Any) {
        
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
}
