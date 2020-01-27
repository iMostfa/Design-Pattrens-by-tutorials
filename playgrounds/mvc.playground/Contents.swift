
import UIKit
//MARK:MODEL
public struct Adress {
    public var street:String
    public var city:String
    public var state:String
    public var zipCode:String
    
    
}

//MARK:VIEW
public final class AdressView:UIView { //FINAL MEANS THAT NO ONE CAN INHERIT THIS CLASS
    @IBOutlet public var streetTextField:UITextField!
    @IBOutlet public var cityTextField:UITextField!
    @IBOutlet public var stateTextField:UITextField!
    @IBOutlet public var zipCodeTextField:UITextField!

    
    
    
}

//MARK:CONTROLLER

public final class adressViewController:UIViewController {
    
    public var adress:Adress? {
        didSet {
            updateViewFromAdress() // if updated after viewdidload is called
        }
    }
    public var adressView:AdressView!
    {
        //COMPUTED PROPERTY
        guard isViewLoaded else {return nil }
        return (view as! AdressView)
    }

    public override func viewDidLoad() {
updateViewFromAdress()
        
        
        
    }
    func updateViewFromAdress() {
            guard let adressView = adressView,let adress = adress else {return}
        
            adressView.streetTextField.text = adress.street
            adressView.cityTextField.text = adress.city
            adressView.stateTextField.text = adress.state
            adressView.zipCodeTextField.text = adress.zipCode
            
        
    }
    
}
