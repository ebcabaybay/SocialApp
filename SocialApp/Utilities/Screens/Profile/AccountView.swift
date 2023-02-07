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

class AccountView: UIViewController {
    let viewModel = AccountViewModel()
    
	@IBOutlet var imageProfile: UIImageView!
	@IBOutlet var cellLogout: UITableViewCell!

    override func viewDidLoad() {
		super.viewDidLoad()
		initUI()
        setup()
	}
    
    func initUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setup() {
        imageProfile.sd_setImage(with: viewModel.imageProfileUrl, placeholderImage: UIImage(named: "logo"))
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        viewModel.logout()
    }
}
