
import MessageUI
import SafariServices
import UIKit

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.addSubview(subject)
        view.addSubview(recipients)
        view.addSubview(body)
        subject.delegate = self
        recipients.delegate = self
        body.delegate = self
        button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
    }

    private var subject: UITextField = {
        var field = UITextField()
        field.frame = CGRect(x: 30, y: 200, width: 350, height: 60)
        field.layer.cornerRadius = 12
        field.backgroundColor = .secondarySystemBackground
        field.setLeftPaddingPoints(10)
        field.returnKeyType = .continue
        field.placeholder = "Your Subject Here"
        field.autocapitalizationType = .sentences
        field.autocorrectionType = .yes
        field.returnKeyType = .continue
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftViewMode = .always
        return field
    }()
    
    
    
    private var recipients: UITextField = {
        var field = UITextField()
        field.frame = CGRect(x: 30, y: 300, width: 350, height: 60)
        field.layer.cornerRadius = 12
        field.backgroundColor = .secondarySystemBackground
        field.setLeftPaddingPoints(10)
        field.placeholder = "Your Recipiants Here"
        field.returnKeyType = .continue
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftViewMode = .always
        return field
    }()
    
    private var body: UITextField = {
        var field = UITextField()
        field.frame = CGRect(x: 30, y: 400, width: 350, height: 60)
        field.layer.cornerRadius = 12
        field.backgroundColor = .secondarySystemBackground
        field.setLeftPaddingPoints(10)
        field.placeholder = "Your Message Here"
        field.returnKeyType = .done
        field.autocapitalizationType = .sentences
        field.autocorrectionType = .yes
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftViewMode = .always
        return field
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Send an Email", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 30, y: 500, width: 350, height: 60)
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc func sendEmail() {
        
        body.resignFirstResponder()
        
        if MFMailComposeViewController.canSendMail() {
               let mail = MFMailComposeViewController()
               mail.mailComposeDelegate = self
               mail.setToRecipients(["\(recipients.text ?? "Email")"])
            mail.setMessageBody("<p>\(body.text ?? "Body")</p>", isHTML: true)
            mail.setSubject("\(subject.text ?? "Subject")")
               present(mail, animated: true)
            
        }
        else {
            guard let url = URL(string: "https://www.icloud.com/mail/") else {
                return }
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
            }
            
        }
        
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

       
    }
    
extension UITextField {
    
func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
func setRightPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
        }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == subject {
            recipients.becomeFirstResponder()
        }
        
        else if textField == recipients {
            body.becomeFirstResponder()
        }
        else if textField == body {
            sendEmail()
        }
        return true
    }}
