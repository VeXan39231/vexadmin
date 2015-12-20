--[[
.----------------.  .----------------.  .----------------.  .----------------.  .-----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| | ____   ____  | || |  _________   | || |  ____  ____  | || |      __      | || | ____  _____  | |
| ||_  _| |_  _| | || | |_   ___  |  | || | |_  _||_  _| | || |     /  \     | || ||_   \|_   _| | |
| |  \ \   / /   | || |   | |_  \_|  | || |   \ \  / /   | || |    / /\ \    | || |  |   \ | |   | |
| |   \ \ / /    | || |   |  _|  _   | || |    > `' <    | || |   / ____ \   | || |  | |\ \| |   | |
| |    \ ' /     | || |  _| |___/ |  | || |  _/ /'`\ \_  | || | _/ /    \ \_ | || | _| |_\   |_  | |
| |     \_/      | || | |_________|  | || | |____||____| | || ||____|  |____|| || ||_____|\____| | |
| |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
'----------------'  '----------------'  '----------------'  '----------------'  '----------------'
http://www.steamcommunity.com/id/SmellyWetSock
]]--

--This is some crappy admin menu I made with Derma.

--VexAdmin V 0.2

--Loading message.
MsgC( Color( 255, 0, 0 ), "-------------------\n" )
MsgC( Color( 0, 255, 255 ), "Loading VexAdmin...\n" )

--Add the console command.
concommand.Add( "_vexadminmenu", function( ply )

--Create the background for the menu.
local background = vgui.Create( "DFrame" )
background:Center()
background:MakePopup()
background:SetTitle( "VexAdmin Menu" )
background:ShowCloseButton( true )
background:SetSize( 425, 450 )



--Add the list of players
local players = vgui.Create( "DListView" )
players:SetParent( background )
players:Dock( LEFT )
players:SetSize( 300, 150 )
players:SetMultiSelect( false )
players:AddColumn( "Name" )
players:AddColumn( "SteamID" )



--Add all the players
for k, v in pairs( player.GetAll() ) do

  SID = v:SteamID() --Set the SteamID
  if v:IsBot() then --Is the SteamID a bot?
    SID = "Bot" --If it is, make it say Bot.
  end

  local NCK = v:Nick() --Find the player's name.
  players:AddLine( NCK, SID ) --Add the players and steamIDs to the list.
end


--Find who we selected
players.OnRowSelected = function( panel , line )
    selected = panel:GetLine( line ):GetValue( 1 ) --If not, go by SteamID so all players with the same name don't get kicked.
end

--Add the kick button.
local kick = vgui.Create( "DImageButton" )
kick:SetParent( background )
kick:SetPos( 310, 30 )
kick:SetImage( "vexadmin/kick.png" )
kick:SetToolTip( "Kick" )
kick:SizeToContents()
function kick.DoClick( ply )
  RunConsoleCommand( "ulx", "kick", selected, "You have been kicked from the server." ) --Kick the selected player
  players:RemoveLine(players:GetSelectedLine()) --Update the list
end

--How long should the player be banned for? **UNTESTED
local bantime = vgui.Create( "DNumberWang" )
bantime:SetParent( background )
bantime:SetPos( 357, 72 )
bantime:SetSize( 45, 15 )
bantime:SetToolTip( "Ban for x minutes" )

--Create the ban button.
local ban = vgui.Create( "DImageButton" )
ban:SetParent( background )
ban:SetPos( 310, 65 )
ban:SetImage( "vexadmin/ban.png" )
ban:SetToolTip( "Ban" )
ban:SizeToContents()
function ban.DoClick( ply )
	local ban_time = bantime:GetValue()
  RunConsoleCommand( "ulx", "ban", selected, ban_time, "You have been banned from the server for ", ban_time, " minutes." ) --Ban the selected player
  players:RemoveLine(players:GetSelectedLine()) --Update the list
end

--Create the slay button.
local slay = vgui.Create( "DImageButton" )
slay:SetParent( background )
slay:SetPos( 310, 100 )
slay:SetImage( "vexadmin/slay.png" )
slay:SetToolTip( "Slay" )
slay:SizeToContents()
function slay.DoClick( ply )
  RunConsoleCommand( "ulx", "slay", selected ) --Slay the selected player
end

--Create the jail button.
local jail = vgui.Create( "DImageButton" )
jail:SetParent( background )
jail:SetPos( 310, 135 )
jail:SetImage( "vexadmin/jail.png" )
jail:SetToolTip( "Jail" )
jail:SizeToContents()
function jail.DoClick( ply )
  RunConsoleCommand( "ulx", "jail", selected, "30" ) --Jail the selected player
end

--Create the unjail button.
local unjail = vgui.Create( "DImageButton" )
unjail:SetParent( background )
unjail:SetPos( 350, 135 )
unjail:SetImage( "vexadmin/unjail.png" )
unjail:SetToolTip( "Unjail" )
unjail:SizeToContents()
function unjail.DoClick( ply )
  RunConsoleCommand( "ulx", "unjail", selected ) --Jail the selected player
end

--Create the ignite button.
local ignite = vgui.Create( "DImageButton" )
ignite:SetParent( background )
ignite:SetPos( 310, 170 )
ignite:SetImage( "vexadmin/ignite.png" )
ignite:SetToolTip( "Ignite" )
ignite:SizeToContents()
function ignite.DoClick( ply )
  RunConsoleCommand( "ulx", "ignite", selected, "30" ) --Ignite the selected player
end

--Create the teleport button. **PLAY CANNOT TELEPORT THEMSELF
local teleport = vgui.Create( "DImageButton" )
teleport:SetParent( background )
teleport:SetPos( 310, 205 )
teleport:SetImage( "vexadmin/teleport.png" )
teleport:SetToolTip( "Teleport" )
teleport:SizeToContents()
function teleport.DoClick( ply )
  local tpmenu = DermaMenu()
  tpmenu:SetParent( background )
  tpmenu:AddOption( "Users" ):SetIcon( "icon16/user_go.png" )
  tpmenu:AddSpacer()
  tpmenu:SetPos( 310, 205 )

	--Add to the list of players to teleport to.
  for k, v in pairs( player.GetAll() ) do
    tpmenu:AddOption( v:Nick(), function( ply ) RunConsoleCommand( "ulx", "send", selected, v:Nick() ) end ):SetIcon( "icon16/user.png" )
	end

--End the teleport function
end

--How much health do you want the player to have?
local health = vgui.Create( "DNumberWang" )
health:SetParent( background )
health:SetPos( 357, 255 )
health:SetSize( 45, 15 )
health:SetToolTip( "How much health to set." )

--Create the health button.
local sethp = vgui.Create( "DImageButton" )
sethp:SetParent( background )
sethp:SetPos( 310, 245 )
sethp:SetImage( "vexadmin/health.png" )
sethp:SetToolTip( "Set Health" )
sethp:SizeToContents()
function sethp.DoClick( ply )
	local hp_val = health:GetValue()
  RunConsoleCommand( "ulx", "hp", selected, hp_val ) --Set the player's health.
end

--Create the slap button.
local slap = vgui.Create( "DImageButton" )
slap:SetParent( background )
slap:SetPos( 310, 285 )
slap:SetImage( "vexadmin/slap.png" )
slap:SetToolTip( "Slap" )
slap:SizeToContents()
function slap.DoClick( ply )
  RunConsoleCommand( "ulx", "slap", selected ) --Slap the player.
end

--Create the freeze button.
local freeze = vgui.Create( "DImageButton" )
freeze:SetParent( background )
freeze:SetPos( 310, 325 )
freeze:SetImage( "vexadmin/freeze.png" )
freeze:SetToolTip( "Freeze" )
freeze:SizeToContents()
function freeze.DoClick( ply )
  RunConsoleCommand( "ulx", "freeze", selected ) --Freeze the player.
end

--Create the unfreeze button.
local unfreeze = vgui.Create( "DImageButton" )
unfreeze:SetParent( background )
unfreeze:SetPos( 350, 325 )
unfreeze:SetImage( "vexadmin/unfreeze.png" )
unfreeze:SetToolTip( "Unfreeze" )
unfreeze:SizeToContents()
function unfreeze.DoClick( ply )
  RunConsoleCommand( "ulx", "unfreeze", selected ) --Freeze the player.
end

--Create the mute button.
local mute = vgui.Create( "DImageButton" )
mute:SetParent( background )
mute:SetPos( 310, 365 )
mute:SetImage( "vexadmin/mute.png" )
mute:SetToolTip( "Mute" )
mute:SizeToContents()
function mute.DoClick( ply )
  RunConsoleCommand( "ulx", "mute", selected ) --Mute the player.
end

--Create the unmute button.
local unmute = vgui.Create( "DImageButton" )
unmute:SetParent( background )
unmute:SetPos( 350, 365 )
unmute:SetImage( "vexadmin/unmute.png" )
unmute:SetToolTip( "Unmute" )
unmute:SizeToContents()
function unmute.DoClick( ply )
  RunConsoleCommand( "ulx", "unmute", selected ) --Unmute the player.
end

--Create the gag button.
local gag = vgui.Create( "DImageButton" )
gag:SetParent( background )
gag:SetPos( 310, 405 )
gag:SetImage( "vexadmin/gag.png" )
gag:SetToolTip( "Gag" )
gag:SizeToContents()
function gag.DoClick( ply )
  RunConsoleCommand( "ulx", "gag", selected ) --Gag the player.
end

--Create the ungag button.
local ungag = vgui.Create( "DImageButton" )
ungag:SetParent( background )
ungag:SetPos( 350, 405 )
ungag:SetImage( "vexadmin/ungag.png" )
ungag:SetToolTip( "Ungag" )
ungag:SizeToContents()
function ungag.DoClick( ply )
  RunConsoleCommand( "ulx", "ungag", selected ) --Ungag the player.
end

--End the command itself.
end )

--Loaded/Added messages, just for fancy looks.
MsgC( Color( 0, 255, 210 ), "Player list loaded...\n" )
MsgC( Color( 0, 255, 168 ), "Player selection loaded...\n" )
MsgC( Color( 0, 255, 126 ), "Players added...\n" )
MsgC( Color( 0, 255, 84 ), "Administrator buttons loaded...\n" )

--Add chat command
hook.Add( "OnPlayerChat", "VexAdminMenu", function( ply, text )
	if ( string.sub( text, 1, 4 ) == "!vex" ) then
		ply:ConCommand( "_vexadminmenu" )
	end
end )

--Command added message
MsgC( Color( 0, 255, 42 ), "Command added...\n" )

--Last loading messages
MsgC( Color( 0, 255, 0 ), "VexAdmin loaded without errors!\n" )
MsgC( Color( 255, 0, 0 ), "-------------------\n" )












--This is what I started when I made an attempt to paint it, it's pretty ugly, but you can add this to the bottom of the DFrame.

--[[
background.Paint = function( self, w, h )
  draw.RoundedBox( 6, 0, 0, w, h, Color( 100, 100, 200, 255 ) )
end
local closebox = vgui.Create( "DFrame" )
closebox:SetParent( background )
closebox:SetPos( 780, 0 )
closebox:SetTitle( " " )
closebox:SetSize( 20, 15 )
closebox:ShowCloseButton( false )
closebox.Paint = function( self, w, h )
  draw.RoundedBoxEx( 6, 0, 0, 30, 20, Color( 200, 100, 100 ), false, true, false, false )
end
local close = vgui.Create( "DLabel" )
close:SetParent( background )
close:SetPos( 786, -3 )
close:SetFont( "Close" )
close:SetText( "X" )
function close:DoClick()
  background:Remove()
	MsgC( Color( 0, 255, 242 ), "Frame and close loaded...\n" )
end
]]--
