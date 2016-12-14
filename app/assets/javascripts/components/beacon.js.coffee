@Beacon = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.record.beacon_uuid
        React.DOM.td null, @props.record.beacon_name
        React.DOM.td null, @props.record.beacon_status
        React.DOM.td null, @props.record.power
        React.DOM.td null, @props.record.created_at
