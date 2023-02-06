//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import FirebaseAuth
import SwiftMessages

//-----------------------------------------------------------------------------------------------------------------------------------------------
class SignUpView: UIViewController {

	@IBOutlet var imageViewProfile: UIButton!
	@IBOutlet var textFieldFullName: UITextField!
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Sign Up"

		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(actionClose))

		textFieldFullName.setLeftPadding(value: 15)
		textFieldEmail.setLeftPadding(value: 15)
		textFieldPassword.setLeftPadding(value: 15)
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionClose() {

		dismiss(animated: true)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionImagePick(_ sender: Any) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCreateAccount(_ sender: Any) {
        let email = textFieldEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let view = MessageView.viewFromNib(layout: .cardView)
                view.configureTheme(.error)
                view.configureContent(title: "Error", body: error.localizedDescription)
                view.button?.isHidden = true
                SwiftMessages.show(view: view)
            } else {
                let changeRequest = authResult?.user.createProfileChangeRequest()
                changeRequest?.displayName = self?.textFieldFullName.text
                changeRequest?.commitChanges()
            }
        }
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionTerms(_ sender: Any) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPrivacy(_ sender: Any) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionHaveAccount(_ sender: Any) {
        dismiss(animated: true)
	}
}
