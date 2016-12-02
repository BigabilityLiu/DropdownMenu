# DropdownMenu
下拉选择控件

##Useage
```swift
let dropdownMenuView = DropdownMenuView()
dropdownMenuView.delegate = self
dropdownMenuView.data = ["首页","好友圈","群微博","我的微博","特别关注","名人明星","同事","同学"]
dropdownMenuView.selectedTitles = label2selectedTitles
dropdownMenuView.canBeMultiSelecte = true//default is false
dropdownMenuView.show()
```

##Property
```swift
var delegate: DropdownMenuDelegate!
var selectedTitles: [String]!
var data: [String]!
var canBeMultiSelecte = false
```
##Function
```swift
func show()

func dismiss()

```
##Protocol
```swift
 func dropdownMenuDidDismiss(_ menu: DropdownMenuView)
 func dropdownMenuDidShow(_ menu: DropdownMenuView)
 func selectedAt(_ titles: [String])
```
##Use Example
```swift
import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!

    var selectedIndexPath: IndexPath!
    var label2selectedTitles = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0{
        let dropdownMenuView = DropdownMenuView()
        dropdownMenuView.delegate = self
        dropdownMenuView.data = ["首页","好友圈","群微博"]
        dropdownMenuView.selectedTitles = [label1.text!]
        dropdownMenuView.show()
    }
    else if indexPath.row == 1{
        let dropdownMenuView = DropdownMenuView()
        dropdownMenuView.delegate = self
        dropdownMenuView.data = ["首页","好友圈","群微博","我的微博","特别关注","名人明星","同事","同学"]
        dropdownMenuView.selectedTitles = label2selectedTitles
        dropdownMenuView.canBeMultiSelecte = true
        dropdownMenuView.show()
    }
}
}
extension TableViewController: DropdownMenuDelegate{
    func dropdownMenuDidShow(_ menu: DropdownMenuView) {
        print("dropdownMenuDidShow")
    }
    func dropdownMenuDidDismiss(_ menu: DropdownMenuView) {
        print("dropdownMenuDidDismiss")
    }
    func selectedAt( _ titles: [String]) {
        if selectedIndexPath == IndexPath(row: 0, section: 0){
            label1.text = titles[0]
    }
        if selectedIndexPath == IndexPath(row: 1, section: 0){
            label2selectedTitles = titles
            print(titles)
        }
    }
}

```

