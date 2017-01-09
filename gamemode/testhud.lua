surface.CreateFont( "HUDNAME", {
	font = "AR DESTINE", //Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 33,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
surface.CreateFont( "HUDAMMO", {
	font = "Segoe UI", //Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 73,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
surface.CreateFont( "HUDAMMOT", {
	font = "Segoe UI", //Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 33,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function HUD()
	local client = LocalPlayer()

	if !client:Alive() then
		return
	end

	-- HUD : Health
	draw.RoundedBox(0,0,ScrH() - 130,250,110,Color(50,50,50,230))
	draw.SimpleText("Health: "..client:Health(), "HUDNAME", 10, ScrH() - 125, Color(255,255,255,255,0,0))
	draw.RoundedBox(0, 10, ScrH() - 95, 100 * 2.25, 15, Color(255,0,0,30))
	draw.RoundedBox(0, 10, ScrH() - 95, math.Clamp(client:Health(), 0, 100) * 2.25, 15, Color(255,0,0,255))
	draw.RoundedBox(0, 10, ScrH() - 95, math.Clamp(client:Health(), 0, 100) * 2.25, 5, Color(255,30,30,255))

	-- HUD : Armor
	draw.SimpleText("Armor: "..client:Armor(), "HUDNAME", 10, ScrH() - 76, Color(255,255,255,255,0,0))
	draw.RoundedBox(0, 10, ScrH() - 48, 100 * 2.25, 15, Color(0,0,255,30))
	draw.RoundedBox(0, 10, ScrH() - 48, math.Clamp(client:Armor(), 0, 100) * 2.25, 15, Color(0,0,255,255))
	draw.RoundedBox(0, 10, ScrH() - 48, math.Clamp(client:Armor(), 0, 100) * 2.25, 5, Color(15,15,255,255))

	-- HUD : Ammo
	draw.RoundedBox(0, ScrH() + 540, ScrH() - 115, 315, 33, Color(30,30,30,230))
	draw.RoundedBox(0, ScrH() + 540, ScrH() - 80, 315, 65, Color(30,30,30,230))

	-- HUD : Gun Name

	if(client:GetActiveWeapon():IsValid()) then
		if (client:GetActiveWeapon() != nil) then
			draw.SimpleText(client:GetActiveWeapon():GetPrintName(), "HUDNAME", ScrH() + 555, ScrH() - 115, Color(255,255,255,255),0,0)
		end
	end

	-- AMMO : Primary Ammo

	if (client:GetActiveWeapon():Clip1() != -1) then
		draw.SimpleText(client:GetActiveWeapon():Clip1(), "HUDAMMO",ScrH() + 640, ScrH() - 88, Color(255,255,255,255),TEXT_ALIGN_RIGHT,0)
		draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "HUDAMMOT",ScrH() + 655, ScrH() - 55, Color(255,255,255,255),0,0)
	else
		draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "HUDAMMO", ScrH() + 555, ScrH() - 88, Color(255,255,255,255),0,0)
	end

	-- AMMO : Secondary Ammo

	if (client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType()) > 0) then
		draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType()), "HUDAMMO", ScrH() + 724, ScrH() - 88 , Color(255,255,255,255) ,0,0)
	end


	client:SetNWInt("expToLevel",(client:GetNWInt("playerLvl") * 100) * 2)

	-- INFO : Lvl / EXP
	draw.RoundedBox(0,0, 40 ,250,40,Color(30,30,30,230))
	draw.SimpleText("Level "..client:GetNWInt("playerLvl"), "DermaDefaultBold", 10, 45, Color(255,255,255,255),0 )
	draw.SimpleText("EXP: "..client:GetNWInt("playerExp").."/"..client:GetNWInt("expToLevel"),"DermaDefaultBold",10,60,Color(255,255,255,255))

	-- INFO : Money
	draw.RoundedBox(0,0, 94, 125, 25, Color(30,30,30,230))
	draw.SimpleText("$ " .. client:GetNWInt("playerMoney"), "DermaDefaultBold", 10, 100, Color(255,255,255,255))

	-- INFO : EXP Bar
	draw.RoundedBox(0,0, 82 ,250, 8 ,Color(30,30,30,230))
	draw.RoundedBox(0,0, 82 ,(client:GetNWInt("playerExp") / client:GetNWInt("expToLevel")) * 250, 8 ,Color(50,200,10,255))

	-- INFO : Points
	draw.RoundedBox(0,0,ScrH() - 165,250,30,Color(30,30,30,230))
	draw.SimpleText("Points: "..client:GetNWInt("playerPoint"), "HUDAMMOT", 10,ScrH() - 167, Color(255,255,255,255,0,0))

end

hook.Add("HUDPaint", "TestHud", HUD)

function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then
			return false
		end
	end
end

hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)
