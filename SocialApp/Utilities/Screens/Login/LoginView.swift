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

class LoginView: UIViewController {
	@IBOutlet var textFieldEmail: UITextField!
	@IBOutlet var textFieldPassword: UITextField!
	@IBOutlet var buttonHideShowPassword: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		textFieldEmail.setLeftPadding(value: 15)
		textFieldPassword.setLeftPadding(value: 15)
		textFieldPassword.setRightPadding(value: 40)
	}

	@IBAction func actionHideShowPassword(_ sender: Any) {
		buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
		textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
	}

	@IBAction func actionLogin(_ sender: Any) {
        let email = textFieldEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        UserApiService.signIn(email: email, password: password).request()
	}

    @IBAction func actionSignUp(_ sender: Any) {
        let controller = SignUpView()
        present(controller, animated: true)
	}
}
