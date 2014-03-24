define [
  'backbone.marionette',
  'templates/coding-rules'
], (
  Marionette,
  Templates
) ->

  class CodingRulesDetailQualityProfilesView extends Marionette.ItemView
    className: 'coding-rules-detail-quality-profile'
    template: Templates['coding-rules-detail-quality-profile']


    ui:
      change: '.coding-rules-detail-quality-profile-change'


    enableUpdate: ->
      @ui.update.prop 'disabled', false


    getParent: ->
      return null unless @model.get 'inherits'
      @options.qualityProfiles.findWhere(key: @model.get('inherits')).toJSON()


    enhanceParameters: ->
      parent = @getParent()
      parameters = @model.get 'parameters'
      return parameters unless parent
      parameters.map (p) ->
        _.extend p, original: _.findWhere(parent.parameters, key: p.key).value


    serializeData: ->
      _.extend super,
        parent: @getParent()
        parameters: @enhanceParameters()