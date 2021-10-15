---
title: HTML页面生命周期
date: 2020-08-25 20:57:04
tags: 
- HTML
- 浏览器
categories: HTML
description: 记录学习页面生命周期
---

## HTML 页面的生命周期包含三个重要事件：

- DOMContentLoaded —— 浏览器已完全加载 HTML，并构建了 DOM 树，但像 <img> 和样式表之类的外部资源可能尚未加载完成。
- load —— 浏览器不仅加载完成了 HTML，还加载完成了所有外部资源：图片，样式等。
- beforeunload/unload —— 当用户正在离开页面时。

## 每个事件都是有用的：

- DOMContentLoaded 事件 —— DOM 已经就绪，因此处理程序可以查找 DOM 节点，并初始化接口。
- load 事件 —— 外部资源已加载完成，样式已被应用，图片大小也已知了。
- beforeunload 事件 —— 用户正在离开：我们可以检查用户是否保存了更改，并询问他是否真的要离开。
- unload 事件 —— 用户几乎已经离开了，但是我们仍然可以启动一些操作，例如发送统计数据。

### DOMContentLoaded
**DOMContentLoaded 事件发生在 document 对象上。我们必须使用 addEventListener**

```js
document.addEventListener("DOMContentLoaded", ready);
// 不是 "document.onDOMContentLoaded = ..."
```

**总结 DOMContentLoaded 相关的一些需要注意的点**
- DOM 树准备就绪 —— 这是它的触发条件；
- 会等待 \<script> 标签执行（有两种例外： 1、async；2、动态生成 document.createElement('script')；）；
- 外部样式不影响 DOMContentLoaded 执行；

### window.onload
**当整个页面，包括样式、图片和其他资源被加载完成时，会触发 window 对象上的 load 事件。**

```js
window.onload = function() { // 与此相同 window.addEventListener('load', (event) => {
    alert('Page loaded');
};
```

### window.onunload
**当访问者离开页面时，window 对象上的 unload 事件就会被触发**

有一个值得注意的特殊情况是发送分析数据。假设我们收集有关页面使用情况的数据：鼠标点击，滚动，被查看的页面区域等。自然地，当用户要离开的时候，我们希望通过 unload 事件将数据保存到我们的服务器上。有一个特殊的 **navigator.sendBeacon(url, data)** 方法可以满足这种需求

```js
let analyticsData = { /* 带有收集的数据的对象 */ };

window.addEventListener("unload", function() {
  navigator.sendBeacon("/analytics", JSON.stringify(analyticsData));
})
```

### window.onbeforeunload

**如果访问者触发了离开页面的导航（navigation）或试图关闭窗口，beforeunload 处理程序将要求进行更多确认。**

```js
// 如果我们要取消事件，浏览器会询问用户是否确定。
window.onbeforeunload = function() {
  return false;
};
```

### readyState
**document.readyState 属性可以为我们提供当前加载状态的信息。**

- loading —— 文档正在被加载。
- interactive —— 文档被全部读取。
- complete —— 文档被全部读取，并且所有资源（例如图片等）都已加载完成。

```js
function work() { /*...*/ }

if (document.readyState == 'loading') {
  // 仍在加载，等待事件
  document.addEventListener('DOMContentLoaded', work);
} else {
  // DOM 已就绪！
  work();
}
```

还有一个 readystatechange 事件，会在状态发生改变时触发，因此我们可以打印所有这些状态，就像这样：

```js
// 当前状态
console.log(document.readyState);

// 状态改变时打印它
document.addEventListener('readystatechange', () => console.log(document.readyState));
```

参考链接
[MDN DOMContentLoaded](https://developer.mozilla.org/zh-CN/docs/Web/Events/DOMContentLoaded)

[加载文档和其他资源](https://zh.javascript.info/loading)
