---
title: WebGL 概念
date: 2020-07-24 10:10:42
tags: 
- JavaScript
- WebGL
categories: WebGL
description: 学习 WebGL 的一些笔记；
---

{% note info %}
    WebGL 概念繁杂，整理核心概念以备忘；
{% endnote %}

## Shader - 着色器

使用 OpenGL ES 着色语言(GLSL)编写的程序，它携带着绘制形状的顶点信息以及构造绘制在屏幕上像素的所需数据，换句话说，它负责**记录着像素点的位置和颜色。**

### 顶点着色器
输入原始的顶点坐标，输出经过你计算出的坐标。

### 片段着色器
输入一个像素位置，输出根据你计算出的像素颜色。

## Resource - 资源


