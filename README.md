# CustomTabBar

Thanks to  [Riccardo Cipolleschi](https://betterprogramming.pub/how-to-create-a-custom-tabbar-in-swift-d44b3db3ac0e) for his awesome tutorial.

The TabBar is created with `ViewController` 's child parent concept.
Three basic functionality added,
* `switchTab(_)`
* `hideTabBar()`
* `showTabBar()`

Hide and Show is done with a Slide Up and Down Animation.
Assin Your `ViewControllers` to `TabBarController`'s `[viewControllers]` array.
Design your required cell in `TabBarCell`
As the basic component is a `UICollectionView`, feel free to contomize according to your likings.

![](https://github.com/smarifahmed/CustomTabBar/TabBar.gif)

 
