`/** @jsx React.DOM */`
React = require 'react/addons'
ReactBootstrap = require 'react-bootstrap'
Modal = ReactBootstrap.Modal
OverlayMixin = ReactBootstrap.OverlayMixin
Button = ReactBootstrap.Button
Calendar = React.createClass
  displayName : 'Calendar'
  mixins:[OverlayMixin]
  getInitialState:->
    isModalOpen:false
  handleToggle:(data)->
    @setState
      isModalOpen: !@state.isModalOpen
      modalContent: data
  componentDidMount : ->
    $calendar = $(@refs.calendar.getDOMNode())
    $calendar.fullCalendar(
      lang:'zh-tw'
      header:
        left:'prev,next today'
        center:'title'
        right: 'month,agendaWeek,agendaDay'
      editable:false
      eventClick:(data, jsEvent, view)=>
        @handleToggle(data)
      events: @props.EventList
      )
  render: ->
    <div ref="calendar"></div>
  renderOverlay:->
    if not @state.isModalOpen
      return <span />
    <Modal bsStyle='primary' title={@state.modalContent.title} onRequestHide={@handleToggle}>
      <div className='modal-body'>
        <h4>地點：{@state.modalContent.location}</h4>
        <p>{@state.modalContent.start_time+' ~ '+ @state.modalContent.end_time}</p>
        {@state.modalContent.description}
      </div>
      <div className='modal-footer'>
        <Button onClick={@handleToggle}>關閉</Button>
      </div>
    </Modal>

module.exports = Calendar
