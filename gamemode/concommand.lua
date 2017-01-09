function buyEntity(ply, cmd, args)

	if(args[1] != nil) then

		local ent = ents.Create(args[1])
		local tr = ply:GetEyeTrace()
		local balance = ply:GetNWInt("playerMoney")

		if(ent:IsValid()) then
			local ClassName = ent:GetClass()

			if(!tr.Hit) then return end
				local entCount = ply:GetNWInt(ClassName.."count")
				if(!IsValid(ent.Limit) or entCount < ent.Limit && balance >= ent.Cost) then
					local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

					ent.Owner = ply

					local ent = ents.Create(ClassName)
					ent:SetPos(SpawnPos)
					ent:Spawn()
					ent:Activate()

					ply:SetNWInt("playerMoney", balance - ent.Cost)
					ply:SetNWInt(ClassName.."count", entCount + 1)

					return ent
				else
					ply:PrintMessage(HUD_PRINTTALK, "Not Enough Money!")
					ply:EmitSound( "Resource/warning.wav" )
				end

		return
		end

	end

end

function maxAmmo(ply)
	ply:GiveAmmo(ply:GetActiveWeapon():GetPrimaryAmmoType(),99999,true)
end
concommand.Add("maxAmmo", maxAmmo)


function resetScore(ply)
	ply:SetNWInt("playerExp",0)
	ply:SetNWInt("playerLvl",0)
	ply:SetNWInt("playerMoney", 0)
	ply:SetNWInt("playerPerkPoint", 0)
	ply:SetNWInt("playerPoint", 0)
end

concommand.Add("reset_score", resetScore)
concommand.Add("buy_entity", buyEntity)


function buyGun(ply, cmd, args)
	local weaponPrices = {}
	weaponPrices[1] = {"fas2_deagle", "100"}
	weaponPrices[2] = {"fas2_sks", "200"}

	for k,v in pairs(weaponPrices) do
		if(args[1] == v[1]) then
			local balance = tonumber(ply:GetNWInt("playerMoney"))
			local gunCost = tonumber(v[2])

			if (balance >= gunCost) then
				ply:SetNWInt("playerMoney", balance - gunCost)
				ply:Give(args[1])
				ply:GiveAmmo(20, ply:GetWeapon(args[1]):GetPrimaryAmmoType(), false)
			else
				ply:PrintMessage(HUD_PRINTTALK, "Not Enough Money!")
				ply:EmitSound( "Resource/warning.wav" )
			end

			return
		end
	end
end
concommand.Add("buy_gun", buyGun)
