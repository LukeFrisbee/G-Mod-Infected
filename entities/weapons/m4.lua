
AddCSLuaFile( "shared.lua" )

SWEP.HoldType              = "ar2"

SWEP.Author			= "Brian Kim"
SWEP.Instructions	= "Power Assult Rifle"
   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64
   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.UseHands           = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_m4a1.mdl"
SWEP.PrintName 			   = "M4"
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
	if ( !self:CanPrimaryAttack() ) then return end
	self:ShootBullet( 15, 1, 0.02 )
    self:TakePrimaryAmmo( 1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )
	self:EmitSound( "Weapon_M4A1.Single" )
	self:ShootEffects( self )
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

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
end
