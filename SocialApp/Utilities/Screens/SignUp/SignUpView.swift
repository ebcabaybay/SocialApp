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

class SignUpView: UIViewController {
    var viewModel = SignUpViewModel()
    
	@IBOutlet var textFieldFullName: UITextField!
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
        initUI()
	}
    
    func initUI() {
        textFieldFullName.setLeftPadding(value: 15)
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
    }

	@IBAction func actionCreateAccount(_ sender: Any) {
        let fullName = textFieldFullName.text ?? ""
        let email = textFieldEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        viewModel.signUp(fullName: fullName, email: email, password: password)
	}

	@IBAction func actionHaveAccount(_ sender: Any) {
        dismiss(animated: true)
	}
}
