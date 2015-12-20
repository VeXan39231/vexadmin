--Laying down the files for ranks and commands. -VeXans, 12-19-15

--Define rank #
VEX_SUPERADMIN    = 1
VEX_ADMIN         = 2
VEX_MOD           = 3
VEX_USER          = 4
VEX_BAN           = 5

--Set rank names and images
VEX_S_RANKS = {}
--VEX_S_RANKS[Rank] = { Rank = "Rank String", Image = "Path to icon16 icon", Usergroup = "rank string" }
VEX_S_RANKS[1] = { Rank = "Super Admin", Image = "icon16/shield.png", Usergroup = "superadmin" }
VEX_S_RANKS[2] = { Rank = "Admin", Image = "icon16/star.png", Usergroup = "admin" }
VEX_S_RANKS[3] = { Rank = "Moderator", Image = "icon16/asterisk_yellow.png" }
VEX_S_RANKS[4] = { Rank = "User", Image = "icon16/user_green.png" }
VEX_S_RANKS[5] = { Rank = "Banned", Image = "icon16/user_red.png" }

--Is the server local?
function IsServerLan()
  return ( GetConVarNumber( "sv_lan" ) = 1 )
end
