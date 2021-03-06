--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

--cl_settings_server_whitelist.lua

net.Receive( "getRoleWhitelist", function( len )
  local _tmpWhiteList = net.ReadTable()
  local _tmpRoleList = net.ReadTable()
  local _tmpGroupList = net.ReadTable()

  local _whitelistListView = createVGUI( "DListView", settingsWindow.site, 1500, 1800, 10, 10 )
  _whitelistListView:AddColumn( "uniqueID" ):SetFixedWidth( 0 )
  _whitelistListView:AddColumn( "SteamID" ):SetFixedWidth( ctrW( 120 ) )
  _whitelistListView:AddColumn( lang.nick )
  _whitelistListView:AddColumn( lang.group )
  _whitelistListView:AddColumn( lang.role )

  for k, v in pairs( _tmpWhiteList ) do
    for l, w in pairs( _tmpRoleList ) do
      if ( w.uniqueID == v.roleID ) then
        for m, x in pairs( _tmpGroupList ) do
          if ( x.uniqueID == w.groupID ) then
            _whitelistListView:AddLine( v.uniqueID, v.SteamID, v.nick, x.groupID, w.roleID )
            break
          end
        end
        break
      end
    end
  end


  local _buttonAdd = createVGUI( "DButton", settingsWindow.site, 300, 50, 10 + 1500 + 10, 10 )
  _buttonAdd:SetText( lang.addentry )
  function _buttonAdd:DoClick()
    local _whitelistFrame = createVGUI( "DFrame", nil, 400, 405, 0, 0 )
    _whitelistFrame:Center()
    _whitelistFrame:ShowCloseButton( true )
    _whitelistFrame:SetDraggable( true )
    _whitelistFrame:SetTitle( "Whitelist" )

    local _whitelistComboBoxPlys = createVGUI( "DComboBox", _whitelistFrame, 380, 50, 10, 85 )
    for k, v in pairs( player.GetAll() ) do
      _whitelistComboBoxPlys:AddChoice( v:Nick(), v:SteamID() )
    end

    local _whitelistComboBox = createVGUI( "DComboBox", _whitelistFrame, 380, 50, 10, 185 )
    for k, v in pairs( _tmpGroupList ) do
      _whitelistComboBox:AddChoice( v.groupID, v.uniqueID )
    end

    local _whitelistComboBox2 = createVGUI( "DComboBox", _whitelistFrame, 380, 50, 10, 285 )
    function _whitelistComboBox:OnSelect()
      _whitelistComboBox2:Clear()
      for k, v in pairs( _tmpRoleList ) do
        for l, w in pairs( _tmpGroupList ) do
          if ( _whitelistComboBox:GetOptionData( _whitelistComboBox:GetSelectedID() ) == v.groupID ) then
            _whitelistComboBox2:AddChoice( v.roleID, v.uniqueID )
            break
          end
        end
      end
    end

    local _whitelistButton = createVGUI( "DButton", _whitelistFrame, 380, 50, 10, 285+10+50 )
    _whitelistButton:SetText( lang.whitelistplayer )
    function _whitelistButton:DoClick()
      net.Start( "whitelistPlayer" )
        net.WriteString( _whitelistComboBoxPlys:GetOptionData( _whitelistComboBoxPlys:GetSelectedID() ) )
        net.WriteInt( _whitelistComboBox2:GetOptionData( _whitelistComboBox2:GetSelectedID() ), 16 )
      net.SendToServer()
      _whitelistListView:Remove()
      _whitelistFrame:Close()
    end

    function _whitelistFrame:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, yrp.colors.dbackground )

      draw.SimpleTextOutlined( lang.player .. ":", "sef", ctrW( 10 ), ctrW( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.group .. ":", "sef", ctrW( 10 ), ctrW( 85+65 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.role .. ":", "sef", ctrW( 10 ), ctrW( 185+65 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )
    end

    _whitelistFrame:MakePopup()
  end

  local _buttonRem = createVGUI( "DButton", settingsWindow.site, 300, 50, 10 + 1500 + 10, 10 + 50 + 10 )
  _buttonRem:SetText( lang.removeentry )
  function _buttonRem:DoClick()
    if _whitelistListView:GetSelectedLine() != "" then
      net.Start( "whitelistPlayerRemove" )
        net.WriteInt( _whitelistListView:GetLine( _whitelistListView:GetSelectedLine() ):GetValue( 1 ) , 16 )
      net.SendToServer()
      _whitelistListView:RemoveLine( _whitelistListView:GetSelectedLine() )
    end
  end

  function _whitelistListView:OnRemove()
    _buttonAdd:Remove()
    _buttonRem:Remove()
  end
end)

hook.Add( "open_server_whitelist", "open_server_whitelist", function()
  local ply = LocalPlayer()

  local w = settingsWindow.sitepanel:GetWide()
  local h = settingsWindow.sitepanel:GetTall()

  settingsWindow.site = createD( "DPanel", settingsWindow.sitepanel, w, h, 0, 0 )

  function settingsWindow.site:Paint( pw, ph )
    draw.RoundedBox( 4, 0, 0, pw, ph, yrp.colors.dbackground )
  end

  net.Start( "getRoleWhitelist" )
  net.SendToServer()
end)
