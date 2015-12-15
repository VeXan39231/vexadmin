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
background:SetSize( 800, 450 )



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
  else
    SID = v:SteamID() --Don't change the SteamID
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

--Create the ban button.
local ban = vgui.Create( "DImageButton" )
ban:SetParent( background )
ban:SetPos( 310, 65 )
ban:SetImage( "vexadmin/ban.png" )
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
slay:SizeToContents()
function slay.DoClick( ply )
  RunConsoleCommand( "ulx", "slay", selected ) --Slay the selected player
end

--Create the jail button.
local jail = vgui.Create( "DImageButton" )
jail:SetParent( background )
jail:SetPos( 310, 135 )
jail:SetImage( "vexadmin/jail.png" )
jail:SizeToContents()
function jail.DoClick( ply )
  RunConsoleCommand( "ulx", "jail", selected, "30" ) --Jail the selected player
end

--Create the ignite button.
local ignite = vgui.Create( "DImageButton" )
ignite:SetParent( background )
ignite:SetPos( 310, 170 )
ignite:SetImage( "vexadmin/ignite.png" )
ignite:SizeToContents()
function ignite.DoClick( ply )
  RunConsoleCommand( "ulx", "ignite", selected, "30" ) --Ignite the selected player
end

--Create the teleport button. **PLAY CANNOT TELEPORT THEMSELF
local teleport = vgui.Create( "DImageButton" )
teleport:SetParent( background )
teleport:SetPos( 310, 205 )
teleport:SetImage( "vexadmin/teleport.png" )
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
