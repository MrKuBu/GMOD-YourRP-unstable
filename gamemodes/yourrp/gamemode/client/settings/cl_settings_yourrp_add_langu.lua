--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

--cl_settings_yourrp_add_langu.lua

hook.Add( "open_yourp_add_langu", "open_yourp_add_langu", function()
  local ply = LocalPlayer()

  local w = settingsWindow.sitepanel:GetWide()
  local h = settingsWindow.sitepanel:GetTall()

  settingsWindow.site = createD( "DPanel", settingsWindow.sitepanel, w, h, 0, 0 )
  settingsWindow.site.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, yrp.colors.dbackground ) end

  function settingsWindow.sitepanel:Paint()
    --
  end

  local form = vgui.Create( "HTML", settingsWindow.site )
  form:SetSize( ctrW( 2070 ), ctrW( 2070 - 80 ) )
  form:SetPos( ctrW( 5 ), ctrW( 5 + 80 ) )
  form:OpenURL( "https://docs.google.com/document/d/e/2PACX-1vRrbPJkC5Eel86Hw9AeFTMCgebee1Ep2zB73jKV07-aMf4mSkcGiIdNXXdJ_wYPWguzWbrrPQ9OwV6B/pub" )

  local button = vgui.Create( "DButton", settingsWindow.site )
  button:SetSize( ctrW( 2070 ), ctrW( 160 ) )
  button:SetPos( ctrW( 5 ), ctrW( 5 ) )
  button:SetText( "Open Discord link in browser" )
  function button:DoClick()
    gui.OpenURL( "https://discord.gg/CXXDCMJ" )
  end
end)
