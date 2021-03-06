--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

--cl_settings_client_hud.lua

function createDerma( art, parent, w, h, x, y )
  tmpDerma = vgui.Create( art, parent )
  tmpDerma:SetSize( ctr(w), ctr(h) )
  tmpDerma:SetPos( ctr(x), ctr(y) )
  return tmpDerma
end

local anchor = Material( "icon16/anchor.png" )
local font_go = Material( "icon16/font_go.png" )
local _settings = Material( "vgui/yrp/light_settings.png" )

local tal = Material( "icon16/text_align_left.png" )
local tac = Material( "icon16/text_align_center.png" )
local tar = Material( "icon16/text_align_right.png" )

local tavt = Material( "icon16/shape_align_top.png" )
local tavc = Material( "icon16/shape_align_middle.png" )
local tavb = Material( "icon16/shape_align_bottom.png" )

function createTaBu( parent, _x, _y, tmp, tx, ty, icon )
  local _tmp = createD( "DButton", parent, ctr( 50 ), ctr( 50 ), ctr( _x ), ctr( _y ) )
  _tmp:SetText( "" )
  _tmp.tx = tx
  _tmp.ty = ty
  function _tmp:Paint( pw, ph )
    local _color = Color( 255, 255, 255, 255 )
    if cl_db[tmp .. "tx"] == self.tx then
      _color = Color( 255, 255, 0, 255 )
    end
    if cl_db[tmp .. "ty"] == self.ty then
      _color = Color( 255, 255, 0, 255 )
    end
    draw.RoundedBox( 0, 0, 0, pw, ph, _color )

    local _br = 4
    surface.SetDrawColor( 255, 255, 255, 255 )
  	surface.SetMaterial( icon	) -- If you use Material, cache it!
  	surface.DrawTexturedRect( ctr( _br ), ctr( _br ), ctr( 50 ) - ctr( 2*_br ), ctr( 50 ) - ctr( 2*_br ) )
  end
  function _tmp:DoClick()
    --TextAlignment
    if self.tx != nil then
      dbUpdateHUD( tmp .. "tx", self.tx )
    end
    if self.ty != nil then
      print(self.ty)
      dbUpdateHUD( tmp .. "ty", self.ty )
    end
  end
  return _tmp
end

function changeHudElement( parent, tmp, textPre )
  local ply = LocalPlayer()
  local frame = createD( "DFrame", parent, ctr( cl_db[tmp .. "sw"] ), ctr( cl_db[tmp .. "sh"] ), anchorW( cl_db[tmp .. "aw"] ) + ctr( cl_db[tmp .. "px"] ), anchorH( cl_db[tmp .. "ah"] ) + ctr( cl_db[tmp .. "py"] ) )
  frame:SetTitle( "" )
  frame:ShowCloseButton( false )
  frame:SetSizable( true )
  frame:SetMinHeight( ctr( 40 ) )
  frame:SetMinWidth( ctr( 40 ) )

  function frame:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 0, 0, 0, 200 ) )
    draw.RoundedBox( 0, 0, 0, pw, ctr( 50 ), Color( 0, 0, 255, 200 ) )

    if frame:GetSizable() then
      draw.RoundedBox( 0, pw - ctr( 20 ), ph - ctr( 20 ), ctr( 20 ), ctr( 20 ), Color( 0, 255, 0, 200 ) )
    end

    draw.SimpleTextOutlined( textPre, "HudSettings", pw - ctr( 6 ), ctr( 25 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

    if frame:IsHovered() then

      local tw, th = frame:GetSize()
      if tw != ctr( cl_db[tmp .. "sw"] ) or th != ctr( cl_db[tmp .. "sh"] ) and !self.changing then
        self.changing = true
        cl_db[tmp .. "sw"] = (tw*ctrF( ScrH() )) - (tw*ctrF( ScrH() ))%20
        cl_db[tmp .. "sh"] = (th*ctrF( ScrH() )) - (th*ctrF( ScrH() ))%20
        frame:SetSize( ctr( cl_db[tmp .. "sw"] ), ctr( cl_db[tmp .. "sh"] ) )
        dbUpdateHUD( tmp .. "sw", cl_db[tmp .. "sw"] )
        dbUpdateHUD( tmp .. "sh", cl_db[tmp .. "sh"] )
        self.changing = false
      end

      local x, y = frame:GetPos()
      if x != anchorW( cl_db[tmp .. "aw"] ) + ctr( cl_db[tmp .. "px"] ) or y != anchorH( cl_db[tmp .. "ah"] ) + ctr( cl_db[tmp .. "py"] ) and !self.changing then
        self.changing = true
        local w, h = frame:GetSize()
        local outside = false
        if x+w > ScrW() then
          frame:SetPos( ScrW()-w, y )
          outside = true
        elseif y+h > ScrH() then
          frame:SetPos( x, ScrH()-h )
          outside = true
        elseif x < 0 then
          frame:SetPos( 0, y )
          outside = true
        elseif y < 0 then
          frame:SetPos( x, 0 )
          outside = true
        end
        if !outside then
          cl_db[tmp .. "px"] = ctrF( ScrH() ) * ( x - x%ctr(20) - anchorW( cl_db[tmp .. "aw"] ) )
          cl_db[tmp .. "py"] = ctrF( ScrH() ) * ( y - y%ctr(20) - anchorH( cl_db[tmp .. "ah"] ) )
          frame:SetPos( anchorW( cl_db[tmp .. "aw"] ) + ctr( cl_db[tmp .. "px"] ), anchorH( cl_db[tmp .. "ah"] ) + ctr( cl_db[tmp .. "py"] ) )
          dbUpdateHUD( tmp .. "px", cl_db[tmp .. "px"] )
          dbUpdateHUD( tmp .. "py", cl_db[tmp .. "py"] )
        end
        self.changing = false
      end
    end
  end

  local _tmpSettings = createD( "DButton", frame, ctr( 50 ), ctr( 50 ), 0, 0 )
  _tmpSettings:SetText( "" )
  function _tmpSettings:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255, 255 ) )

    surface.SetDrawColor( 255, 255, 255, 255 )
	  surface.SetMaterial( _settings	)
    local _br = 4
	  surface.DrawTexturedRect( ctr( _br ), ctr( _br ), ctr( 50-2*_br ), ctr( 50-2*_br ) )
  end

  function _tmpSettings:DoClick()
    local _tsx, _tsy = frame:GetPos()
    local _settingsFrame = createD( "DFrame", frame, ctr( 800 ), ctr( 200 ), _tsx, _tsy )
    function _settingsFrame:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, Color( 0, 0, 0, 200 ) )
    end
    local tmpToggle = createDerma( "DCheckBox", _settingsFrame, 50, 50, 0, 0 )
    local tmpToggleChecked = -1
    if tonumber( cl_db[tmp .. "to"] ) == 0 then
      tmpToggleChecked = false
    elseif tonumber( cl_db[tmp .. "to"] ) == 1 then
      tmpToggleChecked = true
    end
    tmpToggle:SetChecked( tmpToggleChecked )
    function tmpToggle:OnChange( bVal )
    	if ( bVal ) then
        cl_db[tmp .. "to"] = 1
    		dbUpdateHUD( tmp .. "to", cl_db[tmp .. "to"] )
    	else
        cl_db[tmp .. "to"] = 0
    		dbUpdateHUD( tmp .. "to", cl_db[tmp .. "to"] )
    	end
    end

    local _anchor = createD( "DButton", _settingsFrame, ctr( 50 ), ctr( 50 ), ctr( 60 ), ctr( 0 ) )
    _anchor:SetText( "" )
    function _anchor:DoClick()
      local mx, my = gui.MousePos()
      local _context = createD( "DPanel", nil, ctr( 190 ), ctr( 190 ), mx - ctr( 10 ), my - ctr( 10 ) )
      _context.loaded = false
      _context:MakePopup()
      local _tab = {}
      local _x = 0
      local _count = 1
      for _x = 0, 2 do
        local _y = 0
        for _y = 0, 2 do
          _tab[_count] = createD( "DButton", _context, ctr( 50 ), ctr( 50 ), ctr( 10 ) + _x* ctr( 60 ), ctr( 10 ) + _y* ctr( 60 ) )
          _tab[_count]:SetText( "" )
          local _tmp = _tab[_count]
          _tmp._x = _x
          _tmp._y = _y
          function _tmp:Paint( pw, ph )
            local _color = Color( 255, 255, 255, 255 )
            if cl_db[tmp .. "aw"] == self._x and cl_db[tmp .. "ah"] == self._y then
              _color = Color( 255, 255, 0, 255 )
            end
            draw.RoundedBox( 0, 0, 0, pw, ph, _color )

            draw.RoundedBox( 0, ctr( 4 ), ctr( 4 ) + _y * ctr( 16 ), pw - ctr( 9 ), ctr( 8 ), Color( 0, 0, 0, 255 ) )

            draw.RoundedBox( 0, ctr( 4 ) + _x * ctr( 16 ), ctr( 4 ), ctr( 8 ), ph - ctr( 9 ), Color( 0, 0, 0, 255 ) )
          end
          function _tmp:DoClick()
            --Anchor
            dbUpdateHUD( tmp .. "aw", self._x )
            dbUpdateHUD( tmp .. "ah", self._y )

            --newPosition
            local _dx, _dy = frame:GetPos()
            dbUpdateHUD( tmp .. "px", ctrF(ScrH()) * _dx - ctrF(ScrH()) * anchorW( cl_db[tmp .. "aw"] ) )
            dbUpdateHUD( tmp .. "py", ctrF(ScrH()) * _dy - ctrF(ScrH()) * anchorH( cl_db[tmp .. "ah"] ) )
          end
          _count = _count + 1
        end
      end
      function _context:Paint( pw, ph )
        draw.RoundedBox( 0, 0, 0, pw, ph, Color( 0, 0, 0, 200 ) )
        if !self:IsHovered() and _context.loaded and !_tab[1]:IsHovered() and !_tab[2]:IsHovered() and !_tab[3]:IsHovered() and !_tab[4]:IsHovered() and !_tab[5]:IsHovered() and !_tab[6]:IsHovered() and !_tab[7]:IsHovered() and !_tab[8]:IsHovered() and !_tab[9]:IsHovered() then
          self:Remove()
        else
          _context.loaded = true
        end
      end
    end
    function _anchor:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255, 200 ) )

      draw.RoundedBox( 0, ctr( 4 ), ctr( 4 ) + cl_db[tmp .. "ah"] * ctr( 16 ), pw - ctr( 9 ), ctr( 8 ), Color( 0, 0, 0, 255 ) )

      draw.RoundedBox( 0, ctr( 4 ) + cl_db[tmp .. "aw"] * ctr( 16 ), ctr( 4 ), ctr( 8 ), ph - ctr( 9 ), Color( 0, 0, 0, 255 ) )
    end

    local _fontsize = createD( "DComboBox", _settingsFrame, ctr( 80 ), ctr( 50 ), ctr( 120 ), ctr( 0 ) )
    local fontSizes = GetFontSizes()
    for k, v in pairs( fontSizes ) do
      local _cur = false
      if v == cl_db[tmp .. "sf"] then
        _cur = true
      end
      _fontsize:AddChoice( v, v, _cur )
    end
    function _fontsize:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255, 255 ) )

      --draw.SimpleTextOutlined( cl_db[tmp .. "sf"], "DermaDefault", pw/2, ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end
    function _fontsize:OnSelect( ind, val )
      dbUpdateHUD( tmp.."sf", val )
      changeFontSizeOf( tmp.."sf", val )
    end

    local _textalign = createD( "DButton", _settingsFrame, ctr( 50 ), ctr( 50 ), ctr( 210 ), ctr( 0 ) )
    _textalign:SetText( "" )
    function _textalign:DoClick()
      local mx, my = gui.MousePos()
      local _context = createD( "DPanel", nil, ctr( 190 ), ctr( 130 ), mx - ctr( 10 ), my - ctr( 10 ) )
      _context.loaded = false
      _context:MakePopup()
      local _tab = {}
      _tab[1] = createTaBu( _context, 10, 10, tmp, 0, nil, tal )
      _tab[2] = createTaBu( _context, 70, 10, tmp, 1, nil, tac )
      _tab[3] = createTaBu( _context, 130, 10, tmp, 2, nil, tar )
      _tab[4] = createTaBu( _context, 10, 70, tmp, nil, 3, tavt )
      _tab[5] = createTaBu( _context, 70, 70, tmp, nil, 1, tavc )
      _tab[6] = createTaBu( _context, 130, 70, tmp, nil, 4, tavb )

      function _context:Paint( pw, ph )
        draw.RoundedBox( 0, 0, 0, pw, ph, Color( 0, 0, 0, 200 ) )
        if !self:IsHovered() and _context.loaded and !_tab[1]:IsHovered() and !_tab[2]:IsHovered() and !_tab[3]:IsHovered() and !_tab[4]:IsHovered() and !_tab[5]:IsHovered() and !_tab[6]:IsHovered() then
          self:Remove()
        else
          _context.loaded = true
        end
      end
    end
    function _textalign:Paint( pw, ph )
      draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255, 200 ) )

      local _icon = ""
      if cl_db[tmp.."tx"] == 0 then
        _icon = tal
      elseif cl_db[tmp.."tx"] == 1 then
        _icon = tac
      elseif cl_db[tmp.."tx"] == 2 then
        _icon = tar
      end

      local _br = 4
      surface.SetDrawColor( 255, 255, 255, 255 )
    	surface.SetMaterial( _icon	) -- If you use Material, cache it!
    	surface.DrawTexturedRect( ctr( _br ), ctr( _br ), ctr( 50 ) - ctr( 2*_br ), ctr( 50 ) - ctr( 2*_br ) )
    end


    local tmpTextToggle = createD( "DCheckBox", _settingsFrame, ctr( 50 ), ctr( 50 ), ctr( 270 ), ctr( 0 ) )
    local tmpTextToggleChecked = -1
    if tonumber( cl_db[tmp .. "tt"] ) == 0 then
      tmpTextToggleChecked = false
    elseif tonumber( cl_db[tmp .. "tt"] ) == 1 then
      tmpTextToggleChecked = true
    end
    tmpTextToggle:SetChecked( tmpTextToggleChecked )
    function tmpTextToggle:OnChange( bVal )
    	if ( bVal ) then
        cl_db[tmp .. "tt"] = 1
    		dbUpdateHUD( tmp .. "tt", cl_db[tmp .. "tt"] )
    	else
        cl_db[tmp .. "tt"] = 0
    		dbUpdateHUD( tmp .. "tt", cl_db[tmp .. "tt"] )
    	end
    end

    local tmpIconToggle = createD( "DCheckBox", _settingsFrame, ctr( 50 ), ctr( 50 ), ctr( 330 ), ctr( 0 ) )
    local tmpIconToggleChecked = -1
    if tonumber( cl_db[tmp .. "it"] ) == 0 then
      tmpIconToggleChecked = false
    elseif tonumber( cl_db[tmp .. "it"] ) == 1 then
      tmpIconToggleChecked = true
    end
    tmpIconToggle:SetChecked( tmpIconToggleChecked )
    function tmpIconToggle:OnChange( bVal )
    	if ( bVal ) then
        cl_db[tmp .. "it"] = 1
    		dbUpdateHUD( tmp .. "it", cl_db[tmp .. "it"] )
    	else
        cl_db[tmp .. "it"] = 0
    		dbUpdateHUD( tmp .. "it", cl_db[tmp .. "it"] )
    	end
    end

    _settingsFrame:MakePopup()
  end
  return frame
end

function changeFont( string, _settingsFontSizes, w, h, x, y )
  local _tmp = createVGUI( "DNumberWang", _settingsFontSizes, w, h, x, y )
  _tmp:SetValue( cl_db[string] )
  _tmp:SetMin( 6 )
  _tmp:SetMax( 72 )
  function _tmp:OnValueChanged( val )
    if tonumber( val ) >= _tmp:GetMin() then
      if tonumber( val ) <= _tmp:GetMax() then
        dbUpdateHUD( string, val )
        loadDBHud( "yrp_cl_hud", string )
        createFont( string, tmpFont, cl_db[string], 500, true )
      else
        dbUpdateHUD( string, _tmp:GetMax() )
        loadDBHud( "yrp_cl_hud", string )
        createFont( string, tmpFont, cl_db[string], 500, true )
      end
    else
      dbUpdateHUD( string, _tmp:GetMin() )
      loadDBHud( "yrp_cl_hud", string )
      createFont( string, tmpFont, cl_db[string], 500, true )
    end
  end
  return _tmp
end

hook.Add( "open_client_hud", "open_client_hud", function()
  local ply = LocalPlayer()

  local w = settingsWindow.sitepanel:GetWide()
  local h = settingsWindow.sitepanel:GetTall()

  settingsWindow.site = createD( "DPanel", settingsWindow.sitepanel, w, h, 0, 0 )
  --sheet:AddSheet( lang.hud, cl_hudPanel, "icon16/photo.png" )
  function settingsWindow.site:Paint( w, h )
    --draw.RoundedBox( 0, 0, 0, sv_generalPanel:GetWide(), sv_generalPanel:GetTall(), yrp.colors.panel )
  end

  local changeHudButton = createDerma( "DButton", settingsWindow.site, 470, 50, 0, 0 )
  changeHudButton:SetText( lang.changehud )
  function changeHudButton:DoClick()
    settingsWindow:Close()

    local changeHudWindow = createDerma( "DFrame", nil, ScrW() * ctrF( ScrH() ), ScrH() * ctrF( ScrH() ), 0, 0 )
    changeHudWindow:SetDraggable( false )
    changeHudWindow:SetTitle( "" )
    changeHudWindow:ShowCloseButton( false )
    function changeHudWindow:Paint( w, h )
      local gridSize = ctr( 20 )
      draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( 0, 0, 0, 120 ) )
      for i=1, ScrW()/gridSize do
        if i%(ScrW()/gridSize/2) == 0 then
          draw.RoundedBox( 0, (i*gridSize)-ctr( 2 ), 0, ctr( 4 ), ScrH(), Color( 255, 255, 0, 60 ) )
        elseif i%10 == 1 then
            draw.RoundedBox( 0, (i*gridSize)-ctr( 2 ), 0, ctr( 4 ), ScrH(), Color( 0, 0, 255, 50 ) )
        else
          draw.RoundedBox( 0, (i*gridSize)-ctr( 2 ), 0, ctr( 4 ), ScrH(), Color( 255, 255, 255, 20 ) )
        end
      end

      for i=1, ScrH()/gridSize do
        if i%(ScrH()/gridSize/2) == 0 then
          draw.RoundedBox( 0, 0, (i*gridSize)-2, ScrW(), ctr( 4 ), Color( 255, 255, 0, 60 ) )
        elseif i%10 == 9 then
          draw.RoundedBox( 0, 0, (i*gridSize)-2, ScrW(), ctr( 4 ), Color( 0, 0, 255, 50 ) )
        else
          draw.RoundedBox( 0, 0, (i*gridSize)-2, ScrW(), ctr( 4 ), Color( 255, 255, 255, 20 ) )
        end
      end
    end

    local changeHudWindowCloseButton = createDerma( "DButton", changeHudWindow, ScrW() * ctrF( ScrH() ), ScrH() * ctrF( ScrH() ), 0, 0 )
    changeHudWindowCloseButton:SetText( "" )
    function changeHudWindowCloseButton:DoClick()
      changeHudWindow:Close()
    end
    function changeHudWindowCloseButton:Paint( pw, ph )
      draw.SimpleTextOutlined( lang.helpclose, "HudSettings", pw/2, ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )

      draw.SimpleTextOutlined( lang.helpmove, "HudSettings", pw/2, ph/2+20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
      draw.SimpleTextOutlined( lang.helpresize, "HudSettings", pw/2, ph/2+40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
    end

    changeHudElement( changeHudWindow, "hp", lang.health )
    changeHudElement( changeHudWindow, "ar", lang.armor )
    changeHudElement( changeHudWindow, "mh", lang.hunger )
    changeHudElement( changeHudWindow, "mt", lang.thirst )
    changeHudElement( changeHudWindow, "ms", lang.stamina )
    changeHudElement( changeHudWindow, "ma", lang.abilitybar )
    changeHudElement( changeHudWindow, "ca", lang.castbar )
    changeHudElement( changeHudWindow, "mo", lang.money )
    changeHudElement( changeHudWindow, "xp", lang.xpbar )

    changeHudElement( changeHudWindow, "mm", lang.minimap )
    changeHudElement( changeHudWindow, "wn", lang.wname )
    changeHudElement( changeHudWindow, "wp", lang.wprimary )
    changeHudElement( changeHudWindow, "ws", lang.wsecondary )
    changeHudElement( changeHudWindow, "tt", lang.tooltip )
    changeHudElement( changeHudWindow, "st", lang.statusbar )
    local votes = changeHudElement( changeHudWindow, "vt", lang.votes )
    votes:SetSizable( false )
    changeHudElement( changeHudWindow, "cb", lang.chatbox )

    changeHudWindow:MakePopup()
  end

  function testIf( question, atrue, afalse )
    if question == 1 then
      return atrue
    else
      return afalse
    end
  end

  local toggleHud = createVGUI( "DButton", settingsWindow.site, 470, 50, 0, 50 + 10 )
  toggleHud:SetText( lang.togglehud .. " (" .. testIf( GetConVar( "yrp_cl_hud" ):GetInt(), lang.on, lang.off ) .. ")" )
  function toggleHud:DoClick()
    if GetConVar( "yrp_cl_hud" ):GetInt() == 1 then
      GetConVar( "yrp_cl_hud" ):SetInt( 0 )
    elseif GetConVar( "yrp_cl_hud" ):GetInt() == 0 then
      GetConVar( "yrp_cl_hud" ):SetInt( 1 )
    end
    toggleHud:SetText( lang.togglehud .. " (" .. testIf( GetConVar( "yrp_cl_hud" ):GetInt(), lang.on, lang.off ) .. ")" )
  end

  local resetHudButton = createDerma( "DColorButton", settingsWindow.site, 470, 50, 470 + 10, 50 + 10 )
  resetHudButton:SetText( "" )
  function resetHudButton:Paint( pw, ph )
    if resetHudButton:IsHovered() then
      draw.RoundedBox( 0, 0,0, pw, ph, Color( 255, 255, 0 ) )
    else
      draw.RoundedBox( 0, 0,0, pw, ph, Color( 255, 0, 0 ) )
    end

    draw.SimpleTextOutlined( lang.resethud, "sef", pw/2, ph/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color( 0, 0, 0 ) )
  end
  function resetHudButton:DoClick()
    local _window = createVGUI( "DFrame", nil, 430, 50 + 10 + 50 + 10, 0, 0 )
    _window:Center()
    _window:SetTitle( lang.areyousure )

    local _yesButton = createVGUI( "DButton", _window, 200, 50, 10, 60 )
    _yesButton:SetText( lang.yes )
    function _yesButton:DoClick()
      resetHud()
      _window:Close()
    end

    local _noButton = createVGUI( "DButton", _window, 200, 50, 10 + 200 + 10, 60 )
    _noButton:SetText( lang.no )
    function _noButton:DoClick()
      _window:Close()
    end

    _window:MakePopup()
  end

  local _colorBackgroundPanel = createVGUI( "DPanel", settingsWindow.site, 470, 510, 0, 50+10+50+10 )
  function _colorBackgroundPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255 ) )

    draw.SimpleTextOutlined( lang.hudbackground, "sef", ctr( 10 ), ctr( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
  end

  local _colorBackground = createVGUI( "DColorMixer", _colorBackgroundPanel, 450, 450, 10, 50 )
  _colorBackground:SetPalette( true )
  _colorBackground:SetAlphaBar( true )
  _colorBackground:SetWangs( true )
  if cl_db["colbgr"] != nil then
    _colorBackground:SetColor( Color( cl_db["colbgr"], cl_db["colbgg"], cl_db["colbgb"], cl_db["colbga"] ) )	--Set the default color
  end
  function _colorBackground:ValueChanged( newColor )
    dbUpdateHUD( "colbgr", newColor.r )
    dbUpdateHUD( "colbgg", newColor.g )
    dbUpdateHUD( "colbgb", newColor.b )
    dbUpdateHUD( "colbga", newColor.a )
  end

  local _colorBorderPanel = createVGUI( "DPanel", settingsWindow.site, 470, 510, 470+10, 50+10+50+10 )
  function _colorBorderPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255 ) )

    draw.SimpleTextOutlined( lang.hudborder, "sef", ctr( 10 ), ctr( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
  end

  local _colorBorder = createVGUI( "DColorMixer", _colorBorderPanel, 450, 450, 10, 50 )
  _colorBorder:SetPalette( true )
  _colorBorder:SetAlphaBar( true )
  _colorBorder:SetWangs( true )
  _colorBorder:SetColor( Color( cl_db["colbrr"], cl_db["colbrg"], cl_db["colbrb"], cl_db["colbra"] ) )	--Set the default color
  function _colorBorder:ValueChanged( newColor )
    dbUpdateHUD( "colbrr", newColor.r )
    dbUpdateHUD( "colbrg", newColor.g )
    dbUpdateHUD( "colbrb", newColor.b )
    dbUpdateHUD( "colbra", newColor.a )
  end

  local _colorCrosshairPanel = createVGUI( "DPanel", settingsWindow.site, 470, 510, 0, 50+10+50+10+510+10 )
  function _colorCrosshairPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255 ) )

    draw.SimpleTextOutlined( lang.crosshair, "sef", ctr( 10 ), ctr( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
  end

  local _colorCrosshair = createVGUI( "DColorMixer", _colorCrosshairPanel, 450, 450, 10, 50 )
  _colorCrosshair:SetPalette( true )
  _colorCrosshair:SetAlphaBar( true )
  _colorCrosshair:SetWangs( true )
  _colorCrosshair:SetColor( Color( cl_db["colchcr"], cl_db["colchcg"], cl_db["colchcb"], cl_db["colchca"] ) )	--Set the default color
  function _colorCrosshair:ValueChanged( newColor )
    dbUpdateHUD( "colchcr", newColor.r )
    dbUpdateHUD( "colchcg", newColor.g )
    dbUpdateHUD( "colchcb", newColor.b )
    dbUpdateHUD( "colchca", newColor.a )
  end

  local _colorCrosshairBorderPanel = createVGUI( "DPanel", settingsWindow.site, 470, 510, 470+10, 50+10+50+10+510+10 )
  function _colorCrosshairBorderPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255 ) )

    draw.SimpleTextOutlined( lang.crosshairborder, "sef", ctr( 10 ), ctr( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
  end

  local _colorCrosshairBorder = createVGUI( "DColorMixer", _colorCrosshairBorderPanel, 450, 450, 10, 50 )
  _colorCrosshairBorder:SetPalette( true )
  _colorCrosshairBorder:SetAlphaBar( true )
  _colorCrosshairBorder:SetWangs( true )
  _colorCrosshairBorder:SetColor( Color( cl_db["colchbrr"], cl_db["colchbrg"], cl_db["colchbrb"], cl_db["colchbra"] ) )	--Set the default color
  function _colorCrosshairBorder:ValueChanged( newColor )
    dbUpdateHUD( "colchbrr", newColor.r )
    dbUpdateHUD( "colchbrg", newColor.g )
    dbUpdateHUD( "colchbrb", newColor.b )
    dbUpdateHUD( "colchbra", newColor.a )
  end

  local _settingCrosshairPanel = createVGUI( "DPanel", settingsWindow.site, 470, 510, 470+10+470+10, 50+10+50+10+510+10 )
  function _settingCrosshairPanel:Paint( pw, ph )
    draw.RoundedBox( 0, 0, 0, pw, ph, Color( 255, 255, 255 ) )

    draw.SimpleTextOutlined( lang.crosshairsettings, "sef", ctr( 10 ), ctr( 50 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )

    draw.SimpleTextOutlined( lang.length .. ":", "sef", ctr( 10 ), ctr( 100 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( lang.gap .. ":", "sef", ctr( 10 ), ctr( 200 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( lang.thickness .. ":", "sef", ctr( 10 ), ctr( 300 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
    draw.SimpleTextOutlined( lang.border .. ":", "sef", ctr( 10 ), ctr( 400 ), Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color( 0, 0, 0 ) )
  end

  local _settingCrosshairLength = createVGUI( "DNumberWang", _settingCrosshairPanel, 450, 50, 10, 100 )
  _settingCrosshairLength:SetValue( cl_db["chl"] )
  function _settingCrosshairLength:OnValueChanged( val )
    dbUpdateHUD( "chl", val )
  end

  local _settingCrosshairGap = createVGUI( "DNumberWang", _settingCrosshairPanel, 450, 50, 10, 200 )
  _settingCrosshairGap:SetValue( cl_db["chg"] )
  function _settingCrosshairGap:OnValueChanged( val )
    dbUpdateHUD( "chg", val )
  end

  local _settingCrosshairThickness = createVGUI( "DNumberWang", _settingCrosshairPanel, 450, 50, 10, 300 )
  _settingCrosshairThickness:SetValue( cl_db["chh"] )
  function _settingCrosshairThickness:OnValueChanged( val )
    dbUpdateHUD( "chh", val )
  end

  local _settingCrosshairBorder = createVGUI( "DNumberWang", _settingCrosshairPanel, 450, 50, 10, 400 )
  _settingCrosshairBorder:SetValue( cl_db["chbr"] )
  function _settingCrosshairBorder:OnValueChanged( val )
    dbUpdateHUD( "chbr", val )
  end
end)
