define [
  'app',
  'jquery',
  'lib/highlight.pack'
], (App, $, hljs) ->

  App.codeFormat = (txt) ->
    openTags = /^```\s*[a-zA-Z]+\s*/
    closingTags = /^```/
    closing = null
    lang = null

    if /.*\$\$.*\$\$.*/.test(txt)
      # Tex Code
      return $('<span class="math">' + txt + '</span>')

    if not openTags.test(txt)
      return $('<span>' + txt + '</span>')

    # txt = txt.replace(/(\r\n|\n|\r)/gm, "<br/>")
    # txt = txt.replace(/\s/g, "&nbsp;")
    output = ""


    while txt.length > 0
      if openTags.test(txt) and not closing
        old = openTags.exec(txt)[0] # Get the first match (minimal)
        lang = old.replace(/[`\s]+/g, "")
        if lang == "math"
          txt = txt.replace(old, "")
          output += '<div class="math">'
          closing = "</div>"
        else
          txt = txt.replace(old, "")
          output += '<div class="' + lang + '"><pre><code>'
          closing = "</pre></code></div>"
      else if closingTags.test(txt) and closing
        txt = txt.replace("```", "")
        output += closing
        closing = null
      else
        output += txt.charAt(0)
        txt = txt.substring(1);

    if closing
      output += closing

    # Replace the leading space
    output = output.replace('<br/>', '')
    # Syntax higlighting for code
    $output = $(output)
    $output.find('pre code').each (i, e) ->
      hljs.highlightBlock(e)
    $output

  App
