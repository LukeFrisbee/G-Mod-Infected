AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "testhud.lua" )
AddCSLuaFile( "custom_menu.lua")
AddCSLuaFile( "custom_scoreboard.lua" )

include( 'shared.lua' )
include( 'concommand.lua')

local open = false

function GM:PlayerInitialSpawn(ply)
	-- Player Level
	if(ply:GetPData("playerLvl") == nil) then
		ply:SetNWInt("playerLvl", 1)
	else
		ply:SetNWInt("playerLvl", tonumber(ply:GetPData("playerLvl")))
	end

	if(ply:GetPData("playerExp") == nil) then
		ply:SetNWInt("playerExp", 0)
	else
		ply:SetNWInt("playerExp", tonumber(ply:GetPData("playerExp")))
	end

	if(ply:GetPData("playerMoney") == nil) then
		ply:SetNWInt("playerMoney", 0)
	else
		ply:SetNWInt("playerMoney", tonumber(ply:GetPData("playerMoney")))
	end

	if(ply:GetPData("playerPoint") == nil) then
		ply:SetNWInt("playerPoint", 0)
	end

	if(ply:GetPData("playerPerkPoint") == nil) then
		ply:SetNWInt("playerPerkPoint", 0)
	else
		ply:SetNWInt("playerPerkPoint", tonumber(ply:GetPData("playerPerkPoint")))
	end
	if(ply:GetPData("playerBonusSpd") == nil) then
		ply:SetNWInt("playerBonusSpd", 0)
	else
		ply:SetNWInt("playerBonusSpd", tonumber(ply:GetPData("playerWalkSpd")))
	end
	if(ply:GetPData("playerHealth") == nil) then
		ply:SetNWInt("playerHealth", 100)
	else
		ply:SetNWInt("playerHealth", tonumber(ply:GetPData("playerHealth")))
	end
end

function GM:PlayerSpawn(ply)

	local WalkSpeedPlus = ply:GetNWInt("playerWalkSpd") + 200
	local RunSpeedPlus = (ply:GetNWInt("playerWalkSpd") + 200) * 1.4

	ply:SetPData("playerExp", 0)
	ply:SetModel("models/player/riot.mdl")
	ply:SetGravity(1)
	ply:SetMaxHealth(ply:GetNWInt("playerHealth"))
	ply:SetRunSpeed(RunSpeedPlus)
	ply:SetWalkSpeed(WalkSpeedPlus)
	ply:Flashlight(true)
	ply:AllowFlashlight(true)
	ply:Give("fas2_m1911")
	ply:Give("fas2_dv2")
	ply:Give("fas2_ifak")
	ply:SetupHands()
end

function GM:OnNPCKilled(npc, attacker, inflictor)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 100)

	attacker:SetNWInt("playerExp", attacker:GetNWInt("playerExp") + 101)

	checkForLevel(attacker)
end

function GM:ScaleNPCDamage(npc, HITGROUP_GENERIC, dmginfo)
	dmginfo:GetAttacker():SetNWInt("playerPoint", dmginfo:GetAttacker():GetNWInt("playerPoint") + dmginfo:GetDamage())
end





function GM:PlayerDeath(victim, inflictor, attacker)
	attacker:SetNWInt("playerMoney", attacker:GetNWInt("playerMoney") + 100)

	attacker:SetNWInt("playerExp", attacker:GetNWInt("playerExp") + 101)

	if(attacker:Frags() != nil) then
		attacker:SetFrags(attacker:Frags() + 1)
	end
	checkForLevel(attacker)

end


-- Level Up
function checkForLevel(ply)
	local expToLevel = (ply:GetNWInt("playerLvl") * 100) * 2
	local curExp = ply:GetNWInt("playerExp")
	local curLvl= ply:GetNWInt("playerLvl")
	local curPP = ply:GetNWInt("playerPerkPoint")

	if(curExp >= expToLevel) then
		curExp = curExp - expToLevel

		ply:SetNWInt("playerExp", curExp)
		ply:SetNWInt("playerLvl", curLvl + 1)
		ply:SetNWInt("playerPerkPoint", curPP + 1)
	end
end



 -- Game Menu
 function GM:ShowSpare1(ply)
	local WalkSpeedPlus = ply:GetNWInt("playerWalkSpd") + 200
 	local RunSpeedPlus = (ply:GetNWInt("playerWalkSpd") + 200) * 1.4
 	ply:SetWalkSpeed(WalkSpeedPlus)
 	ply:SetRunSpeed(RunSpeedPlus)
 end
function GM:ShowSpare2(ply)
	ply:ConCommand("open_game_menu")
end




function GM:PlayerDisconnected(ply)
	ply:SetPData("playerLvl", ply:GetNWInt("playerLvl"))
	ply:SetPData("playerExp", ply:GetNWInt("playerExp"))
	ply:SetPData("playerMoney", ply:GetNWInt("playerMoney"))
	ply:SetPData("playerPerkPoint", ply:GetNWInt("playerPerkPoint"))
	ply:SetPData("playerHealth", ply:GetNWInt("playerHealth"))
	ply:SetPData("playerBonusSpd", ply:GetNWInt("playerBonusSpd"))
end

function GM:ShutDown()
	for k, v in pairs(player.GetAll()) do
		v:SetPData("playerLvl", v:GetNWInt("playerLvl"))
		v:SetPData("playerExp", v:GetNWInt("playerExp"))
		v:SetPData("playerMoney", v:GetNWInt("playerMoney"))
		v:SetPData("playerPerkPoint", v:GetNWInt("playerPerkPoint"))
		v:SetPData("playerHealth", v:GetNWInt("playerHealth"))
		v:SetPData("playerBonusSpd", v:GetNWInt("playerBonusSpd"))
	end
end
