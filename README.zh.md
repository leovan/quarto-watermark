# Quarto 水印扩展

![Release](https://img.shields.io/github/release/leovan/quarto-watermark.svg)
![License](https://img.shields.io/github/license/leovan/quarto-watermark.svg)
![Issues](https://img.shields.io/github/issues/leovan/quarto-watermark.svg)

---

🇺🇸 [README](README.md) | 🇨🇳 [中文说明](README.zh.md)

一个用于在 `html` 和 `pdf` 格式添加水印的 Quarto 扩展。`html` 格式基于 [X-Watermark](https://github.com/xpyjs/watermark) 实现，`pdf` 格式基于 `draftwatermark` 包实现。

## 安装

```bash
quarto add leovan/quarto-watermark
```

这将在 `_extensions` 子目录中安装本插件。如果使用版本控制，请检入到此目录。

## 使用

将如下内容添加到文档的头部或 `_quarto.yml` 文件中：

```yml
filters:
  - watermark
```

扩展参数如下所示：

| 参数              | 默认值    | 格式    | 说明                                                         |
| ----------------- | --------- | ------- | ------------------------------------------------------------ |
| `text`            | Watermark | all     | 水印文本。仅支持单行文本。                                   |
| `scale`           | 1.0       | all     | 基于文档基础字体大小的水印文本字体比例，至多两位小数。例如：`scale: 1.5`，文档基础字体大小为 10pt，则水印文本字体大小为 15pt。 |
| `angle`           | 15        | all     | 水印旋转的角度值。正数表示逆时针旋转，反之亦然。需介于 -90 至 90 之间，建议介于 -45 至 45 之间。 |
| `color`           | #000000   | all     | 水印文本颜色 Hex 值。                                        |
| `opacity`         | 0.1       | all     | 水印文本颜色不透明度。需介于 0 和 1 之间，至多两位小数。     |
| `cols`            | 10        | all[^1] | 水印文本的列数。                                             |
| `rows`            | 50        | all[^1] | 水印文本的行数。                                             |
| `col-space-scale` | 4.0       | all     | 基于文档基础字体大小的水印文本列间距比例，至多两位小数。     |
| `row-space-scale` | 4.0       | all     | 基于文档基础字体大小的水印文本行间距比例，至多两位小数。     |
| `html-font`[^2]   |           | html    | HTML 输出格式的水印文本字体。                                |
| `html-z-index`    | -1        | html    | HTML 输出格式的水印 z-index 值。                             |
| `pdf-font`[^3]    |           | pdf     | PDF 输出格式的水印文本字体。                                 |

[^1]: 由于上游库原因针对 HTML 输出不暂起作用。
[^2]: 默认值为 `system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'`，与常见操作系统兼容。
[^3]: 默认值为空，这将使用 `\normalfont` 作为默认值。

> [!CAUTION]
> 不支持 `pdflatex` PDF 引擎。

## 示例

示例文档代码详见：[example.qmd](example.qmd)。

## 版权

The MIT License (MIT)

Copyright (c) 2024 [范叶亮 | Leo Van](https://leovan.me)
