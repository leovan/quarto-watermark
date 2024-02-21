# Quarto Watermark Extension

![Release](https://img.shields.io/github/release/leovan/quarto-watermark.svg)
![License](https://img.shields.io/github/license/leovan/quarto-watermark.svg)
![Issues](https://img.shields.io/github/issues/leovan/quarto-watermark.svg)

---

🇺🇸 [README](README.md) | 🇨🇳 [中文说明](README.zh.md)

A Quarto extension to add watermark for `html` and `pdf` format output. It's based on [X-Watermark](https://github.com/xpyjs/watermark) for `html` format, `draftwatermark` package for `pdf` format.

## Installing

```bash
quarto add leovan/quarto-watermark
```

This will install the extension under the `_extensions` subdirectory. If you're using version control, you will want to check in this directory.

## Using

Put this in the header of your document, or in the `_quarto.yml` file.

```yml
filters:
  - watermark
```

Options for this extension are listed as below:

| option          | default   | format  | description                                                  |
| --------------- | --------- | ------- | ------------------------------------------------------------ |
| `text`          | Watermark | all     | Watermark text, single line supported only.                  |
| `font-scale`    | 1.0       | all     | Watermark text font scale of document base font size. Value should be up to three decimal places. e.g. `font-scale = 1.5` and document base font size is 10pt, then the font size of watermark text will be 15pt. |
| `angle`         | 15        | all     | The angle, in degrees, at which the watermark should be. Positive value will rotate anticolckwise, and vice versa. A value between -90 and 90 is required, and a value between -45 and 45 is suggested. |
| `color`         | #000000   | all     | The color of watermark text in hex format.                   |
| `opacity`       | 0.1       | all     | The opacity of color.  A value between 0 and 1 up to three decimal places is required. |
| `cols`          | 10        | all[^1] | # of watermark text columns.                                 |
| `rows`          | 50        | all[^1] | # of watermark text rows.                                    |
| `x-space-scale` | 4.0       | all     | Space scale of document base font size between watermark text columns. Value should be up to three decimal places. |
| `y-space-scale` | 4.0       | all     | Space scale of document base font size between watermark text rows. Value should be up to three decimal places. |
| `html-font`[^2] |           | html    | The font of watermark text for html format output.           |
| `html-z-index`  | -1        | html    | Z order of watermark for html format output.                 |
| `pdf-font`[^3]  |           | pdf     | The font of watermark text for pdf format output.            |

[^1]: It's not working currently for HTML output due to upstream library problems.
[^2]: Default value is `system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'`, which is compatible with common operation system.
[^3]: Default value is empty, which will use `\normalfont` as default.

> [!NOTE]
> Enable CJK environment first for PDF output if you use Chinese character in watermark text.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

## License

The MIT License (MIT)

Copyright (c) 2024 [范叶亮 | Leo Van](https://leovan.me)
