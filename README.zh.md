# Quarto 水印扩展

![Release](https://img.shields.io/github/release/leovan/quarto-watermark.svg)
![License](https://img.shields.io/github/license/leovan/quarto-watermark.svg)
![Issues](https://img.shields.io/github/issues/leovan/quarto-watermark.svg)

---

🇺🇸 [README](README.md) | 🇨🇳 [中文说明](README.zh.md)

一个用于在 `html` 和 `pdf` 文档添加水印的 Quarto 扩展。`html` 文档基于 [X-Watermark](https://github.com/xpyjs/watermark) 实现，`pdf` 文档基于 `draftwatermark` 包实现。

> [!CAUTION]
> 不支持 `pdflatex` PDF 引擎。

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

| 参数        | 默认值    | 格式   | 说明                       |
| ----------- | --------- | ------ | -------------------------- |
| `text`      | Watermark | 全部   | 水印文本，仅支持单行文本。 |
| `size`      | 1         | 全部   | 水印字体大小。             |
| `angle`     | 15        | 全部   | 水印旋转角度值。           |
| `color`     | #000000   | 全部   | 水印颜色。                 |
| `opacity`   | 0.1       | 全部   | 水印颜色不透明度。         |
| `cols`      | 10        | `pdf`  | 水印列数。                 |
| `rows`      | 50        | `pdf`  | 水印行数。                 |
| `col-space` | 4         | 全部   | 水印列间距。               |
| `row-space` | 4         | 全部   | 水印行间距。               |
| `z-index`   | -1        | `html` | 水印堆叠顺序。             |
| `html-font` |           | `html` | 水印字体。                 |
| `pdf-font`  |           | `pdf`  | 水印字体。                 |

> [!NOTE]
>
> 1. `rem` 用作所有 `html` 文档长度、宽度和尺寸的单位。
> 2. `em` 用作所有 `pdf` 文档长度、宽度和尺寸的单位。
> 3. 正 `angle` 值表示逆时针旋转，反之亦然。需介于 -90 至 90 之间，建议介于 -45 至 45 之间。
> 4. `color` 应为 Hex 格式。
> 5. `opacity` 应介于 0 和 1 之间。
> 6. 所有小数值至多保留两位小数。
> 7. `html-font` 默认值为 `system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'`，这将与常见操作系统兼容。
> 8. `pdf-font` 默认值为空，这将使用 `\normalfont` 作为默认字体。

## 示例

示例文档代码详见：[example.qmd](example.qmd)。

## 版权

The MIT License (MIT)

Copyright (c) 2024 [范叶亮 | Leo Van](https://leovan.me)
