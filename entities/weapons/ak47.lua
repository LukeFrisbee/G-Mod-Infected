
/*AddCSLuaFile( "shared.lua" )
AddCSLuaFile()

SWEP.HoldType              = "ar2"

SWEP.Author			= "Brian Kim"
SWEP.Instructions	= "Power Assult Rifle"
   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54
   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.UseHands           = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_ak47.mdl"
SWEP.PrintName 			   = "AK-47"
SWEP.Kind                   = WEAPON_HEAVY
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.Delay = 0.19
SWEP.CSMuzzleFlashes	    = true

//SWEP.Primary.Sound         = Sound(  )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Slot				= 3
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

local ShootSound = Sound("")

function SWEP:PrimaryAttack()
	self:ShootBullet( 35, 1, 0.06 )
	if ( !self:CanPrimaryAttack() ) then return end
	self:TakePrimaryAmmo( 1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.1 )
	self:EmitSound( "Weapon_AK47.Single" )
	self:ShootEffects( self )
	self.Owner:ViewPunch( Angle( math.random(-0.9,-1.4), 0, 0 ) )
	if (!SERVER) then return end

end

function SWEP:SecondaryAttack()

end

function SWEP:ShouldDropOnDie()
	return false
end

function SWEP:Reload()
    if (self:Clip1() == self.Primary.ClipSize or
        self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
       return
    end
    self:DefaultReload(ACT_VM_RELOAD)
end*/
