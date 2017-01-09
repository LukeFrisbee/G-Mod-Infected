AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if(IsValid(phys)) then
		phys:Wake()
	end


end


function ENT:Use(activator, caller)
	local ammoType = activator:GetActiveWeapon():GetPrimaryAmmoType()

	if(activator:GetNWInt("playerPoint") > 1250) then
		if (activator:HasWeapon("fas2_m14")) then
			activator:GiveAmmo(60, "7.62x51MM", false)
			activator:SetNWInt("playerPoint", activator:GetNWInt("playerPoint") - 1250)
		else
			activator:Give("fas2_m14")
		end

	end
end

function ENT:Think()

end


function ENT:OnRemove()

end
