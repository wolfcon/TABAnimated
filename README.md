<div style="align: center">
<img src="https://upload-images.jianshu.io/upload_images/5632003-14498d8a6c786224.png"/>
</div>

<p style="align: center">
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic">
    </a>
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/language-objective--c-blue.svg">
    </a>
    <a href="https://cocoapods.org/pods/TABAnimated">
       <img src="https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic">
    </a>
    <a href="https://github.com/tigerAndBull/TABAnimated">
       <img src="https://img.shields.io/badge/support-ios%208%2B-orange.svg">
    </a>
</p>

> + [English Documents](https://github.com/tigerAndBull/TABAnimated/blob/master/README_EN.md)

## 骨架屏

骨架屏(Skeleton Screen)是一种优化用户弱网体验的方案。在弱网情况下，客户端获取到服务器数据的时间会比较长，通过骨架屏来减缓用户等待的焦躁情绪。
TABAnimated是提供给iOS开发者自动生成骨架屏的一种解决方案。开发者可以将已经开发好的视图，通过配置一些全局/局部的参数，自动生成与其结构一致的骨架屏。开发者用较少的开发成本，就可以获得和需求一致的骨架屏。  

## 优势

-  自动化、低耦合
-  列表视图、嵌套视图
-  支持上拉加载
-  支持暗黑模式
-  自定制动画及其序列化
-  实时预览

## 效果展示

| 闪光动画 | 经典动画 | 下坠动画 | 
| ------ | ------ | ------ | 
| ![闪光动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8ebdc1e964fcfbb5.gif?imageMogr2/auto-orient/strip) | ![经典动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8025a04102572ed4.gif?imageMogr2/auto-orient/strip) | ![下坠动画.gif](https://upload-images.jianshu.io/upload_images/5632003-5277740f43880cde.gif?imageMogr2/auto-orient/strip) | 

| 呼吸动画 | 上拉加载 | 复杂场景 |
| ------ | ------ | ------ | 
| ![呼吸动画.gif](https://upload-images.jianshu.io/upload_images/5632003-8edf170c90e18b4b.gif?imageMogr2/auto-orient/strip)| ![上拉加载.gif](https://upload-images.jianshu.io/upload_images/5632003-72265e19c84fe415.gif?imageMogr2/auto-orient/strip) | ![复杂场景.gif](https://upload-images.jianshu.io/upload_images/5632003-e5500766b4f66f14.gif?imageMogr2/auto-orient/strip) | 

**暗黑模式：**

| 工具箱切换 | setting页面切换 |
| ------ | ------ | 
| ![工具箱切换.gif](https://upload-images.jianshu.io/upload_images/5632003-cf5c4f50eac6fe6c.gif?imageMogr2/auto-orient/strip) | ![setting设置切换.gif](https://upload-images.jianshu.io/upload_images/5632003-2d1fb96ec07d6bca.gif?imageMogr2/auto-orient/strip) | 

**实时预览：**

![实时预览.gif](https://upload-images.jianshu.io/upload_images/5632003-4161e026819b7739.gif?imageMogr2/auto-orient/strip)

## Usages

### 流程图

![流程图.png](https://upload-images.jianshu.io/upload_images/5632003-0c16a40e0bbd78d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600)

### 一、导入

- CocoaPods

```
pod 'TABAnimated', '2.6.3'
```

- Carthage

```
github "tigerAndBull/TABAnimated"
```

- 手动将TABAnimated文件夹拖入工程

### 二、设置全局参数(可选)

在 `didFinishLaunchingWithOptions` 中设置全局参数

```
[TABAnimated sharedAnimated].openLog = YES;
[TABAnimated sharedAnimated].openAnimationTag = YES;
...
```

### 三、初始化

`NewsCollectionViewCell`就是业务方自己的cell，也可以绑定其他任意类型cell！

```
_collectionView.tabAnimated = 
[TABCollectionAnimated animatedWithCellClass:[NewsCollectionViewCell class] 
cellSize:[NewsCollectionViewCell cellSize]];
```

- 有其他初始化方法，针对不同结构的列表视图，在框架中都有注释
- 有针对这个控制视图的局部属性，在框架中都有注释

### 四、控制骨架屏开关

1. 开启动画

```
[self.collectionView tab_startAnimation];  
```

2. 关闭动画

```
[self.collectionView tab_endAnimation];
```

### 五、预处理回调+链式语法用于修改骨架元素的属性

使用变量名修改

```
_tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
    manager.animationN(@"titleImageView").down(3).radius(12);
    manager.animationN(@"nameLabel").height(12).width(110);
    manager.animationN(@"timeButton").down(-5).height(12);
};
```

使用index修改

```
_tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
    manager.animation(1).down(3).radius(12);
    manager.animation(2).height(12).width(110);
    manager.animation(3).down(-5).height(12);
};
```

Swift

```
tableView.tabAnimated?.adjustBlock = { manager in
   manager.animation()?(1)?.down()(3)?.radius()(12)
   manager.animation()?(2)?.height()(12)?.width()(110)
   manager.animation()?(3)?.down()(-5)?.height()(12)
}
```

## FAQ

### 1. `manager.animation(x)`和 `manager.animationN(@"x")`，x是几？

manager.animation(x)其实是视图addSubView尾递归排序。
在appDelegate设置TABAnimated的`openAnimationTag`属性为YES，框架就会自动为你指示，究竟x是几。

```
[TABAnimated sharedAnimated].openAnimationTag = YES;
```

animationN(@"x")的x是变量名，不支持局部变量。

### 2. 通过几个示例，了解预处理回调和链式语法

- 假如第0个元素的高度和宽度不合适

```
manager.animation(0).height(12).width(110);
```

- 假如第1个元素需要使用占位图

```
manager.animation(1).placeholder(@"占位图名称.png");
```

- 假如第1，2，3个元素宽度都为50

```
manager.animations(1,3).width(50);
```

- 假如第1，5，7个元素需要下移5px

```
manager.animationWithIndexs(1,5,7).down(5);
```

![下标示意图.png](https://upload-images.jianshu.io/upload_images/5632003-2842bd54e80dd9ef.png?imageMogr2/auto-orient/strip%7CimageView2/3/w/300)

### 3. 列表集成问题

在你集成列表视图之前，一定要理清列表视图结构。分为以下三种：

+ 以section为单元，section和cell样式一一对应
+ 视图只有1个section, 但是对应多个cell
+ 动态section：section数量是网络获取的

明确自身需求

+ 设置多个section/row，一起开启动画
+ 设置多个section/row，部分开启动画

最后到框架内找到对应的初始化方法、启动动画方法即可！

### 4. 详细说明文档列表

> + [缓存策略和线程处理](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E7%BC%93%E5%AD%98%E7%AD%96%E7%95%A5%E5%92%8C%E7%BA%BF%E7%A8%8B%E5%A4%84%E7%90%86.md)
> + [架构设计和性能测试](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1%E5%92%8C%E6%80%A7%E8%83%BD%E6%B5%8B%E8%AF%95.md)
> + [预处理回调动画元素下标问题](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E5%8A%A8%E7%94%BB%E5%85%83%E7%B4%A0%E4%B8%8B%E6%A0%87%E9%97%AE%E9%A2%98.md)
> + [问题答疑文档](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E9%97%AE%E9%A2%98%E7%AD%94%E7%96%91%E6%96%87%E6%A1%A3.md)、[版本信息记录文档](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E5%8D%87%E7%BA%A7%E6%96%87%E6%A1%A3%E5%92%8C%E5%85%B6%E4%BB%96%E4%BF%AE%E5%A4%8D.md)
> + [全局:局部属性、链式语法api](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E5%85%A8%E5%B1%80:%E5%B1%80%E9%83%A8%E5%B1%9E%E6%80%A7%E3%80%81%E9%93%BE%E5%BC%8F%E8%AF%AD%E6%B3%95api.md)
> + [豆瓣动画详解](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E8%B1%86%E7%93%A3%E5%8A%A8%E7%94%BB%E8%AF%A6%E8%A7%A3.md)
> + [不再hook setDelegate和setDataSource](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E4%B8%8D%E5%86%8Dhook%20setDelegate%E5%92%8CsetDataSource.md)
> + [上拉加载更多](https://github.com/tigerAndBull/TABAnimated/blob/master/TABAnimated.docc/%E4%B8%8A%E6%8B%89%E5%8A%A0%E8%BD%BD%E5%8A%9F%E8%83%BD.md)

## Tips

- 有问题优先查看issues和documents
- demo提供的只是不同结构视图的集成方案，开发者可以自己定制出更精美的效果
- 如有使用问题、优化建议等，可以关注公众号：tigerAndBull技术分享，加群解决

## Stargazers over time

[![Stargazers over time](https://starchart.cc/tigerAndBull/TABAnimated.svg)](https://starchart.cc/tigerAndBull/TABAnimated)

## License

All source code is licensed under the [License](https://github.com/tigerAndBull/TABAnimated/blob/master/LICENSE)

