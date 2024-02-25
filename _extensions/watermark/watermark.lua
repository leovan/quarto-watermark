local function ensure_html_deps()
  quarto.doc.add_html_dependency({
    name = "watermark",
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
      parentSelector: "html",
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
    options.scale,
    angle,
    options.color,
    options.opacity,
    options.cols,
    options.rows,
    options.col_space_scale,
    options.row_space_scale,
    options.html_z_index
  )
  quarto.doc.include_text("after-body", script)
end

local function latex_watermark(options)
  local color = string.gsub(options.color, "#", "")
  local font_define = ""
  local font_command = ""

  if options.pdf_font then
    font_define = string.format("\\newfontfamily{\\watermarkfont}{%s}", options.pdf_font)
    font_command = "\\watermarkfont"
  end

  local scale = tonumber(options.scale) * 100
  local col_space_scale = tonumber(options.col_space_scale) * 100
  local row_space_scale = tonumber(options.row_space_scale) * 100
  local opacity = tonumber(options.opacity) * 100

  local script = string.format(
    [[
    \definecolor{watermarkcolor}{HTML}{%s}
    %s

    \makeatletter
    \newcommand*\watermarkfontsize{\dimexpr\f@size pt * %d / 100 \relax}
    \newcommand*\watermarkcolspacesize{\dimexpr\f@size pt * %d / 100 \relax}
    \newcommand*\watermarkrowspacesize{\dimexpr\f@size pt * %d / 100 \relax}
    \makeatother

    \DraftwatermarkOptions{
      text={
        \begin{tabular}{c}
          \newcounter{row}
          \newcounter{col}
          \forloop{row}{0}{\value{row} < %d}{
            \forloop{col}{0}{\value{col} < %d}{
              {%s %s}\hspace{\watermarkcolspacesize}
            }
            \\[\watermarkrowspacesize]
          }
        \end{tabular}
      },
      fontsize=\watermarkfontsize,
      angle=%f,
      color=watermarkcolor!%d
    }
    ]],
    color,
    font_define,
    scale,
    col_space_scale,
    row_space_scale,
    options.rows,
    options.cols,
    font_command,
    options.text,
    options.angle,
    opacity
  )
  quarto.doc.include_text("in-header", script)
end

function Pandoc(doc)
  local options = {
    text = "Watermark",
    scale = 1.0,
    angle = 15,
    color = "#000000",
    opacity = 0.1,
    cols = 10,
    rows = 50,
    col_space_scale = 4.0,
    row_space_scale = 4.0,
    html_font = "system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'",
    html_z_index = -1,
    pdf_font = nil
  }

  if doc.meta["watermark"] then
    watermark_meta = doc.meta["watermark"]

    if watermark_meta["text"] then
      options.text = pandoc.utils.stringify(watermark_meta["text"])
    end

    if watermark_meta["scale"] then
      options.scale = tonumber(pandoc.utils.stringify(watermark_meta["scale"]))
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

    if watermark_meta["col-space-scale"] then
      options.col_space_scale = tonumber(pandoc.utils.stringify(watermark_meta["col-space-scale"]))
    end

    if watermark_meta["row-space-scale"] then
      options.row_space_scale = tonumber(pandoc.utils.stringify(watermark_meta["row-space-scale"]))
    end

    if watermark_meta["html-font"] then
      options.html_font = pandoc.utils.stringify(watermark_meta["html-font"])
    end

    if watermark_meta["html-z-index"] then
      options.html_z_index = pandoc.utils.stringify(watermark_meta["html-z-index"])
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
