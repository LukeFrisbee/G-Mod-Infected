-- Zombie Spawn

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)


	local phys = self:GetPhysicsObject()

	if(IsValid(phys))then
		phys:Wake()
	end

	self:SetHealth(self.BaseHealth)
end

function ENT:SpawnFunction(ply,tr,ClassName)
end

function ENT:Think() end
