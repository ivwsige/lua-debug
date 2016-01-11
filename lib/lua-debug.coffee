LuaDebugView = require './lua-debug-view'
{CompositeDisposable} = require 'atom'

module.exports = LuaDebug =
  luaDebugView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @luaDebugView = new LuaDebugView(state.luaDebugViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @luaDebugView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'lua-debug:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @luaDebugView.destroy()

  serialize: ->
    luaDebugViewState: @luaDebugView.serialize()

  toggle: ->
    console.log 'LuaDebug was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
