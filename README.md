# Quarto Watermark Extension

![Release](https://img.shields.io/github/release/leovan/quarto-watermark.svg)
![License](https://img.shields.io/github/license/leovan/quarto-watermark.svg)
![Issues](https://img.shields.io/github/issues/leovan/quarto-watermark.svg)

---

🇺🇸 [README](README.md) | 🇨🇳 [中文说明](README.zh.md)

A Quarto extension to add watermark for `html` and `pdf` document. It's based on [X-Watermark](https://github.com/xpyjs/watermark) for `html` document, `draftwatermark` package for `pdf` document.

> [!CAUTION]
> `pdflatex` PDF engine is not supported.

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

Parameters for this extension are listed as below:

| Parameters     | Default   | Format | Description                                 |
| -------------- | --------- | ------ | ------------------------------------------- |
| `text`         | Watermark | All    | Watermark text, single line supported only. |
| `size`         | 1         | All    | Watermark font size.                        |
| `angle`        | 15        | All    | Watermark angle in degrees.                 |
| `color`        | #000000   | All    | Watermark color in Hex format.              |
| `opacity`      | 0.1       | All    | Watermark opacity.                          |
| `cols`         | 10        | `pdf`  | # of watermark columns.                     |
| `rows`         | 50        | `pdf`  | # of watermark rows.                        |
| `x-space`      | 4         | All    | Space size between watermark columns.       |
| `y-space`      | 4         | All    | Space size between watermark rows.          |
| `z-index`      | -1        | `html` | Stack order of watermark.                   |
| `html-font`    |           | `html` | Watermark font.                             |
| `pdf-font`     |           | `pdf`  | Watermark font.                             |

> [!NOTE]
>
> 1. `rem` is used as unit for all length, width and size for `html` document.
> 2. `em` is used as unit for all length, width and size for `pdf` document.
> 3. Positive `angle` will rotate counterclockwise, and vice versa. A value between -90 and 90 is required, and a value between -45 and 45 is suggested.
> 4. `color` should be in Hex format.
> 5. `opacity` should be between 0 and 1.
> 6. All decimal values should keep two decimal places at most.
> 7. `html-font` default value is `system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'`, which is compatible with common operation system.
> 8. `pdf-font` default value is empty, which will use `\normalfont` as default font.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

## License

The MIT License (MIT)

Copyright (c) 2024 [范叶亮 | Leo Van](https://leovan.me)
