--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

--cl_scoreboard.lua

sb_groups = {}
net.Receive( "getScoreboardGroups", function()
  sb_groups = net.ReadTable()
end)
timer.Simple( 1, function()
  net.Start( "getScoreboardGroups" )
  net.SendToServer()
end)
timer.Simple( 6, function()
  net.Start( "getScoreboardGroups" )
  net.SendToServer()
end)

scoreboard = scoreboard or {}

local elePos = {}
elePos.x = 0
elePos.y = 0

local _yrpIcon = Material( "yrp/yrp_icon" )
local _br = 40

function hasGroupPlayers( id )
  for k, ply in pairs( player.GetAll() ) do
    if tonumber( ply:GetNWString( "groupUniqueID" ) ) == tonumber( id ) then
      return true
    end
  end
  return false
end

function hasLowerGroupPlayers( id )
  for k, group in pairs( sb_groups ) do
    if tonumber( group.uppergroup ) == tonumber( id ) then
      if hasGroupPlayers( group.uniqueID ) then
        return true
      elseif hasLowerGroupPlayers( group.uniqueID ) then
        return true
      end
    end
  end
  return false
end

function hasGroupRowPlayers( id )
  for g, groups in pairs( sb_groups ) do
    if tonumber( groups.uniqueID ) == tonumber( id ) then
      if hasGroupPlayers( groups.uniqueID ) then
        return true
      else
        if hasLowerGroupPlayers( groups.uniqueID ) then
          return true
        end
      end
    end
  end
  return false
end

function drawGroupPlayers( id )
  for k, ply in pairs( player.GetAll() ) do
    if tonumber( id ) == tonumber( ply:GetNWString( "groupUniqueID" ) ) then
      elePos.y = elePos.y + 50
      local _tmpHeader = createVGUI( "DPanel", _SBSP, 1880 - elePos.x, 50, elePos.x, elePos.y )
      function _tmpHeader:Paint( pw, ph )
        draw.RoundedBox( 0, 0, 0, pw, ph, Color( yrp.colors["epicOrange"].r, yrp.colors["epicOrange"].g, yrp.colors["epicOrange"].b, yrp.colors["epicOrange"].a ) )
        if ply != NULL then
          draw.SimpleTextOutlined( ply:RPName(), "sef", ctrW( 10 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
          draw.SimpleTextOutlined( ply:GetNWString( "roleName" ), "sef", pw - ctrW( 260 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
          draw.SimpleTextOutlined( ply:Ping(), "sef", pw - ctrW( 200 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
        end
        draw.SimpleTextOutlined( lang.mute, "sef", pw - ctrW( 100 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
      end
    end
  end
end

function drawGroup( id, name )
  elePos.y = elePos.y + 50
  local _tmpPanel = createVGUI( "DPanel", _SBSP, 1880 - elePos.x, 9999, elePos.x, elePos.y )
  function _tmpPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( yrp.colors["epicBlue"].r, yrp.colors["epicBlue"].g, yrp.colors["epicBlue"].b, yrp.colors["epicBlue"].a ) )
    draw.SimpleTextOutlined( name, "sef", ctrW( 10 ), ctrW( 25 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
  end
  if hasGroupPlayers( id ) then
    elePos.y = elePos.y + 50
    local _tmpHeader = createVGUI( "DPanel", _SBSP, 1880 - elePos.x, 50, elePos.x, elePos.y )
    function _tmpHeader:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, Color( yrp.colors["epicBlue"].r, yrp.colors["epicBlue"].g, yrp.colors["epicBlue"].b, yrp.colors["epicBlue"].a ) )
      draw.SimpleTextOutlined( lang.name, "sef", ctrW( 10 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.role, "sef", pw - ctrW( 260 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.ping, "sef", pw - ctrW( 200 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.mute, "sef", pw - ctrW( 100 ), ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end

    drawGroupPlayers( id )
  end
  return _tmpPanel
end

function hasLowerGroup( id )
  for k, group in pairs( sb_groups ) do
    if tonumber( group.uppergroup ) == tonumber( id ) then
      return true
    end
  end
  return false
end

function drawLowerGroup( id )
  for k, group in pairs( sb_groups ) do
    if tonumber( id ) == tonumber( group.uniqueID ) then
      local _tmpGroup = drawGroup( group.uniqueID, group.groupID )
      return _tmpGroup
    end
  end
end

function tryLowerGroup( id )
  if hasLowerGroup( id ) then
    elePos.x = elePos.x + ctrW( 20 )
    for k, group in pairs( sb_groups ) do
      if tonumber( group.uppergroup ) == tonumber( id ) then
        local tmp = drawLowerGroup( group.uniqueID )
        tryLowerGroup( group.uniqueID )

        elePos.y = elePos.y + ctrW( 20 )

        local tmpX, tmpY = tmp:GetPos()
        tmp:SetSize( tmp:GetWide(), ctrW( elePos.y + 50 ) - tmpY )
      end
    end
  end
end

function drawGroupRow( id )
  if hasGroupRowPlayers( id ) then
    for k, group in pairs( sb_groups ) do
      if tonumber( id ) == tonumber( group.uniqueID ) then
        local tmp = drawGroup( group.uniqueID, group.groupID )
        tryLowerGroup( group.uniqueID )

        elePos.y = elePos.y + ctrW( 20 )

        local tmpX, tmpY = tmp:GetPos()
        tmp:SetSize( tmp:GetWide(), ctrW( elePos.y+50 ) - tmpY )
      end
    end
  end
end

function drawGroups()
  for k, group in pairs( sb_groups ) do
    if tonumber( group.uppergroup ) == tonumber( -1 ) then
      elePos.x = ctrW( 20 )
      drawGroupRow( group.uniqueID )
    end
  end
end

function drawScoreboard()
  elePos.x = ctrW( 20 )
  elePos.y = ctrW( -50 )
  drawGroups()
end

isScoreboardOpen = false
function scoreboard:show()
  net.Start( "getScoreboardGroups" )
  net.SendToServer()

  isScoreboardOpen = true
  if _SBFrame != nil then
    _SBFrame:Remove()
    _SBFrame = nil
  end
  _SBFrame = createVGUI( "DFrame", nil, 2000, 2000, 10, 10 )
  _SBFrame:SetTitle( "" )
  _SBFrame:ShowCloseButton( false )
  _SBFrame:Center()

  local _mapPNG = getMapPNG()

  function _SBFrame:Paint( pw, ph )
    draw.RoundedBox( 0, ctrW( _br ), ctrW( _br ), pw - ctrW( 50 ), ctrW( 125 ), Color( yrp.colors["epicBlue"].r, yrp.colors["epicBlue"].g, yrp.colors["epicBlue"].b, yrp.colors["epicBlue"].a ) )

    draw.RoundedBox( 0, ctrW( _br ), ctrW( 256 - _br ), pw - ctrW( _br*2 ), ph, Color( yrp.colors["darkBG"].r, yrp.colors["darkBG"].g, yrp.colors["darkBG"].b, yrp.colors["darkBG"].a ) )

    draw.SimpleTextOutlined( GAMEMODE:GetGameDescription(), "ScoreBoardNormal", ctrW( 256 + 20 ), ctrW( 75 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( GetHostName(), "ScoreBoardTitle", ctrW( 256 + 20 ), ctrW( 120 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

    draw.SimpleTextOutlined( lang.map .. ": " .. string.upper( game.GetMap() ), "ScoreBoardNormal", pw - ctrW( 256 + 20 ), ctrW( 75 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( lang.players .. ": " .. #player.GetAll() .. "/" .. game.MaxPlayers(), "ScoreBoardNormal", pw - ctrW( 256 + 20 ), ctrW( 125 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

    surface.SetDrawColor( 255, 255, 255, 255 )
  	surface.SetMaterial( _yrpIcon	)
  	surface.DrawTexturedRect( 0, ctrW( 4 ), ctrW( 256 ), ctrW( 256 ) )

    draw.RoundedBox( 0, pw-ctrW( 256+8 ), 0, ctrW( 256+8 ), ctrW( 256+8 ), Color( 0, 0, 0, 255 ) )
    surface.SetDrawColor( 255, 255, 255, 255 )
  	surface.SetMaterial( _mapPNG	)
  	surface.DrawTexturedRect( pw-ctrW( 256+4 ), ctrW( 4 ), ctrW( 256 ), ctrW( 256 ) )
  end

  _SBSP = createVGUI( "DScrollPanel", _SBFrame, 2000-80, 2000-(256+48-50)-10, 40, 256+48-50+10 )

  local _SBSPBar = _SBSP:GetVBar()
  function _SBSPBar:Paint( w, h )
  	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
  end
  function _SBSPBar.btnUp:Paint( w, h )
  	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 100 ) )
  end
  function _SBSPBar.btnDown:Paint( w, h )
  	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0, 100 ) )
  end
  function _SBSPBar.btnGrip:Paint( w, h )
  	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 255, 100 ) )
  end

  local _DPanelHeader = createVGUI( "DPanel", _SBSP, 2000, 2000, 0, 0 )
  function _DPanelHeader:Paint( pw, ph )
    --draw.RoundedBox( 0, ctrW( 25 ), ctrW( 256 - 25 ), pw, ph, Color( yrp.colors["darkBG"].r, yrp.colors["darkBG"].g, yrp.colors["darkBG"].b, yrp.colors["darkBG"].a ) )
  end

  drawScoreboard()

	function scoreboard:hide()
    isScoreboardOpen = false
    if _SBFrame != nil then
      _SBFrame:Remove()
      _SBFrame = nil
      gui.EnableScreenClicker( false )
    end
	end
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end
