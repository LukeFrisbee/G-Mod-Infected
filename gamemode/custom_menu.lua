local Menu

function gameMenu()
	if(Menu == nil) then
		Menu = vgui.Create("DFrame")
		Menu:SetSize(750, 500)
		Menu:SetPos(ScrW()/2 - 325, ScrH()/2 - 250)
		Menu:SetTitle("Gamemode Menu")
		Menu:SetDraggable(false)
		Menu:ShowCloseButton(false)
		Menu:SetDeleteOnClose(false)
		Menu.Paint = function()
			surface.SetDrawColor(60,60,60,255)
			surface.DrawRect(0,0,Menu:GetWide(),Menu:GetTall())

			surface.SetDrawColor(40,40,40,255)
			surface.DrawRect(0,24,Menu:GetWide(),1)
		end
	-- Adding Button Visual
	addButtons(Menu)
	gui.EnableScreenClicker(true)
	else
		if(Menu:IsVisible())then
			Menu:SetVisible(false)
			gui.EnableScreenClicker(false)
		else
			Menu:SetVisible(true)
			gui.EnableScreenClicker(true)
		end
	end
end

-- Command for opening Game Menu
concommand.Add("open_game_menu", gameMenu)

-- Button GUI Create

function addButtons(Menu)
	local playerButton = vgui.Create("DButton")
	playerButton:SetParent(Menu)
	playerButton:SetText("")
	playerButton:SetSize(100,50)
	playerButton:SetPos(0,25)
	playerButton.Paint = function()

		-- Color of entire button

		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, playerButton:GetWide(), playerButton:GetTall())

		-- Draw Bottom and Right border

		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(0,49,playerButton:GetWide(),1)
		surface.DrawRect(200,0,1,playerButton:GetTall())

		-- Draw Text

		draw.DrawText("Player", "DermaDefaultBold", playerButton:GetWide()/2,17, Color(255,255,255,255),1)
	end

	-- Calling Function for Clicking

	playerButton.DoClick = function(playerButton)

		-- Player Panel : Draw Menu

		local playerPanel = Menu:Add("PlayerPanel")

		playerPanel.Paint = function()
			surface.SetDrawColor(50,50,50,255)
			surface.DrawRect(0,0, playerPanel:GetWide(), playerButton:GetTall())
			surface.SetTextColor(255,255,255,255)

			-- Player Panel : Draw Player Name
			surface.CreateFont("HeaderFont", {font="Default", size=30, weight=5000})
			surface.SetFont("HeaderFont")
			surface.SetTextPos(5,0)
			surface.DrawText(LocalPlayer():GetName())

			-- Player Panel : Draw Player Exp and Level
			local expToLevel = (LocalPlayer():GetNWInt("playerLvl") * 100) * 2

			surface.SetFont("Default")
			surface.SetTextPos(8,35)
			surface.DrawText("Level "..LocalPlayer():GetNWInt("playerLvl"))
			surface.DrawText("\tExp "..LocalPlayer():GetNWInt("playerExP").."/"..expToLevel)

			-- Player Panel : Draw Balance

			surface.SetTextPos(8,55)
			surface.DrawText("Balance: " ..LocalPlayer():GetNWInt("playerMoney"))

			-- Player Panel : Draw Player Point

			surface.SetTextPos(8, 75)
			surface.DrawText("Points: "..LocalPlayer():GetNWInt("playerPoint"))

			-- Player Panel : Draw Player Perk Points

			surface.SetTextPos(8, 95)
			surface.DrawText("Perk Points: "..LocalPlayer():GetNWInt("playerPerkPoint"))

		end

	end

	-- Making Button
	local shopButton = vgui.Create("DButton")
	shopButton:SetParent(Menu)
	shopButton:SetText("")
	shopButton:SetSize(100,50)
	shopButton:SetPos(0,75)
	shopButton.Paint = function()
		-- Color of entire button
		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0, shopButton:GetWide(), shopButton:GetTall())

		-- Draw Bottom and Right border
		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(0,49,shopButton:GetWide(),1)
		surface.DrawRect(99,0,1,shopButton:GetTall())

		-- Draw Text
		draw.DrawText("Shop", "DermaDefaultBold", shopButton:GetWide()/2,17, Color(255,255,255,255),1)
	end

	-- Button Click

	shopButton.DoClick = function(shopButton)
		local shopPanel = Menu:Add("ShopPanel")

		-- Shop Panel: Entity Category
		local entityCategory = vgui.Create("DCollapsibleCategory", shopPanel)
		entityCategory:SetPos(0,0)
		entityCategory:SetSize(shopPanel:GetWide(), 100)
		entityCategory:SetLabel("Entities")

		-- Shop Panel: Weapon Category
		local weaponCategory = vgui.Create("DCollapsibleCategory", shopPanel)
		weaponCategory:SetPos(0,100)
		weaponCategory:SetSize(shopPanel:GetWide(), 100)
		weaponCategory:SetLabel("Weapons")

		-- Shop Panel: Entity
		local entityList = vgui.Create("DIconLayout", entityCategory)
		entityList:SetPos(0,20)
		entityList:SetSize(entityCategory:GetWide(), entityCategory:GetTall())
		entityList:SetSpaceY(5)
		entityList:SetSpaceX(5)

		-- Shop Panel: Weapon
		local weaponList = vgui.Create("DIconLayout", weaponCategory)
		weaponList:SetPos(0,20)
		weaponList:SetSize(weaponCategory:GetWide(), weaponCategory:GetTall())
		weaponList:SetSpaceY(5)
		weaponList:SetSpaceX(5)


		local entsArr= {}
		entsArr[1] = scripted_ents.Get("ammo_dispenser")

		-- Shop : Ammo Dispenser
		for k, v in pairs(entsArr) do
			local icon = vgui.Create("SpawnIcon", entityList)
			icon:SetModel(v["Model"])
			icon:SetToolTip(v["PrintName"])
			entityList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("buy_entity "..v["ClassName"])

			end
		end

		-- Shop : Deagle
		local weaponsArr= {}
		weaponsArr[1] = {"models/weapons/w_pist_deagle.mdl" , "fas2_deagle" , "Desert Eagle - FA:S", "100"}

		for k, v in pairs(weaponsArr) do
			local icon = vgui.Create("SpawnIcon", weaponList)
			icon:SetModel(v[1])
			icon:SetToolTip(v[3].."\nCost: "..v[4])
			weaponList:Add(icon)
			icon.DoClick = function(icon)
				LocalPlayer():ConCommand("buy_gun "..v[2])

			end
		end
	end
end


-- Player Panel

PANEL = {} -- Create an empty panel

function PANEL:Init() -- Initialize the Panel
	self:SetSize(650,475)
	self:SetPos(100,25)
end

function PANEL:Paint(w,h)
	draw.RoundedBox(0,0,0,w,h,Color(0,0,0,255))
end

if(vgui != nil) then
	vgui.Register("PlayerPanel", PANEL, "Panel")
end

-- End Player Panel

-- Shop Panel
PANEL = {} -- Create an empty panel

function PANEL:Init() -- Initialize the Panel
	self:SetSize(650,475)
	self:SetPos(100,25)
end

function PANEL:Paint(w,h)
	draw.RoundedBox(0,0,0,w,h,Color(255,255,255,255))
end

if(vgui != nil) then
	vgui.Register("ShopPanel", PANEL, "Panel")
end

-- End Shop Panel
