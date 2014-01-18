require [
  "marionette",
  "../bower_components/handlebars/handlebars",
  "templates"
], (Marionette, Handlebars, JST) ->

  Handlebars.partials = JST

  _.extend Marionette.Renderer,

    render: (template, data) ->
      template_name = _.result(t: template, 't')
      template = JST[template_name]
      if template then template(data) else throw "Template '#{template}' does not exist!"
