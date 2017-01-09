-- BARRICADE

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if(IsValid(phys))then
		phys:Wake()
	end

	self:SetHealth(self.BaseHealth)
end

function ENT:SpawnFunction(ply,tr,ClassName)
	if(!tr.Hit) then return end

	local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

	self.Owner = ply

	local ent = ents.Create(ClassName)

	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Think() end

util.AddNetworkString("OpenBarricadeMenu")
function ENT:Use(Activator, caller)
	if(caller == self.Owner) then
		net.Start("OpenBarricadeMenu")
			net.WriteEntity(self)
			net.WriteEntity(caller)
			net.WriteInt(self:Health(), 11)
		net.Send(caller)
	end
end

function ENT:OnTakeDamage(damage)
	self:SetHealth(self:Health() - damage:GetDamage())

	if(self:Health() <= 0) then
		self:Remove()
	end
end
