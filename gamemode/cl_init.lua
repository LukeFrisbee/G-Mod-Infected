AddCSLuaFile( "testhud.lua" )

include( 'shared.lua' )
include( 'testhud.lua' )
include( 'custom_menu.lua' )
include( 'custom_scoreboard.lua')

function GM:ContextMenuOpen()
	return false
end
