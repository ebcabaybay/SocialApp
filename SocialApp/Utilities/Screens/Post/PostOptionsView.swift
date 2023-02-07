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

class PostOptionsView: UIViewController {
    
    var post: Post!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func actionCopyLink(_ sender: UIButton) {
        PostApiService.deletePost(post: post).request { [weak self] (result: Result<Bool>) in
            switch result {
                case .success(_):
                    self?.dismiss(animated: true)
                case .failure(let error):
                    print(error)
            }
        }
	}

    @IBAction func didTapBackground(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionCancel(_ sender: UIButton) {
		dismiss(animated: true)
	}
}
