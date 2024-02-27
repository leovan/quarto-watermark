local function ensure_html_deps()
  quarto.doc.add_html_dependency({
    name = "watermark",
    version = "1.0.11",
    scripts = { "watermark.min.js" }
  })
end

local function ensure_latex_deps()
  quarto.doc.use_latex_package("fontspec")
  quarto.doc.use_latex_package("draftwatermark")
  quarto.doc.use_latex_package("xcolor")
  quarto.doc.use_latex_package("forloop")
end

local function html_watermark(options)
  local angle = tonumber(options.angle * -1)

  local script = string.format(
    [[<script>
    const baseFontSize = parseFloat(getComputedStyle(document.documentElement).fontSize);
    const watermark = new XWatermark.XWatermark();
    watermark.init("%s", {
      parentSelector: "body",
      prevent: true,
      observer: true,
      mode: "normal",
      font: "%s",
      fontsize: baseFontSize * %f,
      angle: %f,
      color: "%s",
      alpha: %f,
      cols: %d,
      rows: %d,
      xSpace: baseFontSize * %f,
      ySpace: baseFontSize * %f,
      zIndex: %d
    });
    </script>]],
    options.text,
    options.html_font,
    options.size,
    angle,
    options.color,
    options.opacity,
    options.cols,
    options.rows,
    options.col_space,
    options.row_space,
    options.z_index
  )
  quarto.doc.include_text("after-body", script)
end

local function latex_watermark(options)
  local text = string.gsub(options.text, " ", "\\ ")
  local color = string.gsub(options.color, "#", "")
  local font_define = ""
  local font_command = ""

  if options.pdf_font then
    font_define = string.format("\\newfontfamily{\\watermarkfont}{%s}", options.pdf_font)
    font_command = "\\watermarkfont"
  end

  local opacity = tonumber(options.opacity * 100)

  local script = string.format(
    [[
    \definecolor{watermark}{HTML}{%s}
    %s
    \newcounter{watermarkrow}
    \newcounter{watermarkcol}

    \DraftwatermarkOptions{
      text={
        \begin{tabular}{c}
          \forloop{watermarkrow}{0}{\value{watermarkrow} < %d}{
            \forloop{watermarkcol}{0}{\value{watermarkcol} < %d}{
              {%s %s}\hspace{%fem}
            }
            \\[%fem]
          }
        \end{tabular}
      },
      fontsize=%fem,
      angle=%f,
      color=watermark!%d
    }
    ]],
    color,
    font_define,
    options.rows,
    options.cols,
    font_command,
    text,
    options.col_space,
    options.row_space,
    options.size,
    options.angle,
    opacity
  )
  quarto.doc.include_text("in-header", script)
end

function Pandoc(doc)
  local options = {
    text = "Watermark",
    size = 1.0,
    angle = 15,
    color = "#000000",
    opacity = 0.1,
    cols = 10,
    rows = 50,
    col_space = 4.0,
    row_space = 4.0,
    z_index = -1,
    html_font = "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'",
    pdf_font = nil
  }

  if doc.meta["watermark"] then
    watermark_meta = doc.meta["watermark"]

    if watermark_meta["text"] then
      options.text = pandoc.utils.stringify(watermark_meta["text"])
    end

    if watermark_meta["size"] then
      options.size = tonumber(pandoc.utils.stringify(watermark_meta["size"]))
    end

    if watermark_meta["angle"] then
      options.angle = tonumber(pandoc.utils.stringify(watermark_meta["angle"]))
    end

    if watermark_meta["color"] then
      options.color = pandoc.utils.stringify(watermark_meta["color"])
    end

    if watermark_meta["opacity"] then
      options.opacity = tonumber(pandoc.utils.stringify(watermark_meta["opacity"]))
    end

    if watermark_meta["cols"] then
      options.cols = tonumber(pandoc.utils.stringify(watermark_meta["cols"]))
    end

    if watermark_meta["rows"] then
      options.rows = tonumber(pandoc.utils.stringify(watermark_meta["rows"]))
    end

    if watermark_meta["col-space"] then
      options.col_space = tonumber(pandoc.utils.stringify(watermark_meta["col-space"]))
    end

    if watermark_meta["row-space"] then
      options.row_space = tonumber(pandoc.utils.stringify(watermark_meta["row-space"]))
    end

    if watermark_meta["z-index"] then
      options.z_index = pandoc.utils.stringify(watermark_meta["z-index"])
    end

    if watermark_meta["html-font"] then
      options.html_font = pandoc.utils.stringify(watermark_meta["html-font"])
    end

    if watermark_meta["pdf-font"] then
      options.pdf_font = pandoc.utils.stringify(watermark_meta["pdf-font"])
    end
  end

  if quarto.doc.is_format("html") then
    ensure_html_deps()
    html_watermark(options)
  elseif quarto.doc.is_format("latex") then
    ensure_latex_deps()
    latex_watermark(options)
  end
end
