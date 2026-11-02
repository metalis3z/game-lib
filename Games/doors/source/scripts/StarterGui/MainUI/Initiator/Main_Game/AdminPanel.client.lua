print("never")
local Main_Game = require(script.Parent)
local AdminPanel = script.Parent.Parent.Parent.AdminPanel
local CustomEntity = script.Parent.Parent.Parent.CustomEntity
local GuidingLightGenerator = script.Parent.Parent.Parent.GuidingLightEditor
local SpecialPlayers = require(game.ReplicatedStorage.SpecialPlayers)
local key_to_open = Enum.KeyCode.Z -- key that's opens admin panel
local Helper = game.ReplicatedStorage.UncopylockedHelper
local h_ui = script.Parent.Parent.Parent.UncopylockedHelper
local answer = false
Helper.UncopylockedHelper_Client.OnClientEvent:Connect(function(id)
	print("bip")
	if id == "Failed_Run" then
		print("bop")
		Main_Game.freemouse = true
		h_ui.Visible = true
	end
end)
h_ui.Hunt.Activated:Connect(function()
	Helper.UncopylockedHelper_Server:FireServer({id = "GameRun", isStudio = game["Run Service"]:IsStudio(), val = "Hunt"})
	h_ui.rjrjrj.Visible = true
	answer = true
end)
h_ui.Hotel.Activated:Connect(function()
	Helper.UncopylockedHelper_Server:FireServer({id = "GameRun", isStudio = game["Run Service"]:IsStudio(), val = "Hotel"})
	h_ui.rjrjrj.Visible = true
	answer = truec
end)
local pt = game.Players.LocalPlayer
local AdminPanel_Module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
local h_a = AdminPanel_Module:haveAccess(pt)
if pt:WaitForChild("PlayerStats"):WaitForChild("TypeRun").Value ~= "Nonil" and pt:WaitForChild("PlayerStats"):WaitForChild("TypeRun").Value ~= "Lobby" then
	answer = true
end 
while not answer do
	task.wait()
end
if not h_a or pt.PlayerStats.AdminPanel.Value == false or pt.PlayerStats.TypeRun.Value == "HardHotel" and not SpecialPlayers.isSpecial(pt.Name) and not game["Run Service"]:IsStudio() then
   GuidingLightGenerator:Destroy()	
   CustomEntity:Destroy()
   script:Destroy()
	return
end

AdminPanel.Parent.PanelAccess.Visible = true
AdminPanel.Parent.PanelAccess.KnobBonus.Text = "0%"
AdminPanel.Parent.PanelAccess.NoProgress.Visible = true
AdminPanel.Parent.PanelAccess.Tip.Visible = true
AdminPanel.Parent.PanelAccess.NoRift.Visible = true
AdminPanel.Parent.PanelAccess.DescPanel.Visible = true
local admin_items = {
	all_rooms = nil
}
game.ReplicatedStorage.Bricks.GetAllRooms:FireServer()

--[[game.ReplicatedStorage.Bricks.GetAllRooms.OnClientEvent:Connect(function(r) r = removed, huh
	admin_items.all_rooms = r 
end)]]
--[[repeat wait()
	--print("waits")
until admin_items.all_rooms ~= nil]]

AdminPanel.Title_Store.Text = "Admin Panel"

if Main_Game.platform == "pc" then
	AdminPanel.Title_Store.Text = "Admin Panel [Z to close]"
end

if Main_Game.platform == "mobile" then
	AdminPanel.Parent.MainFrame.MobileButtons.AdminButton.Visible = true
	
	AdminPanel.Parent.MainFrame.MobileButtons.AdminButton.MouseButton1Up:Connect(function()
		if AdminPanel.Visible == false then
			AdminPanel.Visible = true
			Main_Game.freemouse = true
		elseif AdminPanel.Visible == true then
			AdminPanel.Visible = false
			Main_Game.freemouse = false
		end
	end)
end

AdminPanel.CloseButton.MouseButton1Up:Connect(function()
	if AdminPanel.Visible == false then
		AdminPanel.Visible = true
		Main_Game.freemouse = true
	elseif AdminPanel.Visible == true then
		AdminPanel.Visible = false
		Main_Game.freemouse = false
	end
end)

if Main_Game.platform == "console" then
	local button = AdminPanel.Parent.MainFrame.MobileButtons.AdminButton
	button.KeyXbox.Visible = true
	button.KeyXbox.Image = require(script.Parent.PromptServiceHint.HintConsole).Default
	button.Visible = true
	
	AdminPanel:GetPropertyChangedSignal("Visible"):Connect(function()
		if AdminPanel.Visible == true then
			Main_Game.freemouse = true
		elseif AdminPanel.Visible == false then
			Main_Game.freemouse = false
		end
	end)
	
	game.UserInputService.InputEnded:Connect(function(key)
		
		if key.KeyCode == Enum.KeyCode.ButtonX then
			if AdminPanel.Visible == true then
				AdminPanel.Visible = false
			elseif AdminPanel.Visible == false then
				AdminPanel.Visible = true
			end
		end
		
	end)
end

game.UserInputService.InputEnded:Connect(function(key)
	key = key.KeyCode


	if key == key_to_open then
		if AdminPanel.Visible == false then
			AdminPanel.Visible = true
			Main_Game.freemouse = true
		elseif AdminPanel.Visible == true then
			AdminPanel.Visible = false
			Main_Game.freemouse = false
		end
	end
end)
task.delay(15, function()
	AdminPanel.Parent.PanelAccess.Visible = false
end)
local List = AdminPanel.List1
local Input = List.Input
local Input2 = List.InputRoom
local Input3 = List.InputCoins
local Input4 = List.InputPlayer1
local Input5 = List.InputPlayer2
local Input6 = List.InputPlayer3
local Input7 = List.InputSpeed
local Input8 = List.InputDamage
local ItemsListButton = AdminPanel.ItemsList
local ItemsListFrame = AdminPanel.ItemsListFrame
for i,v in pairs(game.ReplicatedStorage.ClientBricks.ServerStorage:GetChildren()) do
	local cl = ItemsListFrame.List.Title:Clone()
	cl.Parent = ItemsListFrame.List
	cl.Text = v.Name
	cl.Visible = true
end
ItemsListButton.MouseButton1Up:Connect(function()
	if ItemsListFrame.Visible == true then
		ItemsListFrame.Visible = false
	elseif ItemsListFrame.Visible == false then
		ItemsListFrame.Visible = true
	end
end)
local function addButton(pt1, id)
	local ptName = pt1.Name
	local button
	if id == "Kill" then
		button = List.KillPlayer:Clone()
	elseif id == "Revive" then
		button = List.RevivePlayer:Clone()
	elseif id == "SpawnScreech" then
		button = List.KillPlayer:Clone()
		button.LayoutOrder = 4
		button.Name = "ScreechPlayer"
	elseif id == "GiveItem" then
		button = List.KillPlayer:Clone()
		button.LayoutOrder = 0
		button.Name = "GiveItemToPlayer"
	elseif id == "Damage" then
		button = List.DamageSelf:Clone()
		button.Name = "DamagePlayer"
	elseif id == "SetBoostPlayer" then
		button = List.SetBoost:Clone()
		button.Name = "SetBoostPlayer"
	end
	local format = "Kill"
	if id == "Revive" then
		format = "Revive"
	elseif id == "SpawnScreech" then
		format = "Spawn Screech for"
		button:SetAttribute("ID", "ScreechPlayer")
		button:SetAttribute("TypeRun", "Hotel")
	elseif id == "GiveItem" then
		format = "Give item to"
		button:SetAttribute("ID", "GiveItemPlayer")
	elseif id == "Damage" then
		format = "Damage"
		button:SetAttribute("ID", "DamagePlayer")
	elseif id == "SetBoostPlayer" then
		format = "Set speedboost for"
		button:SetAttribute("ID", "SetBoostPlayer")
	end
	button.Parent = List
	button.Text = string.format("%s %s", format, ptName)
	button.Visible = true
	button:SetAttribute("PlayerName", ptName)

	return button
end

--[[for i,v in pairs(admin_items.all_rooms) do
	task.wait(0.01)
		local bt = List.KillPlayer:Clone()
		bt.Parent = List
		bt.LayoutOrder = 7
		bt.Name = "SetRoom"
		bt:SetAttribute("ID", "SetNextRoom")
		bt.Text = "Set next room to "..v
		bt.Visible = true
	bt:SetAttribute("RoomID", v)
end]]
local function removeButtons(pt1)
	for i,v in pairs(List:GetChildren()) do
		if v:GetAttribute("PlayerName") == pt1.Name then
			v:Destroy()
		end
	end
end
local function packAdd(v)
	addButton(v, "Kill")
	addButton(v, "Revive")
	addButton(v, "SpawnScreech")
	addButton(v, "GiveItem")
	addButton(v, "Damage")
	addButton(v, "SetBoostPlayer")
end
for i,v in pairs(game.Players:GetPlayers()) do
	if v ~= pt then
	packAdd(v)
	end
end

game.Players.PlayerAdded:Connect(function(pt1)
	if pt ~= pt1 then
		packAdd(pt1)
	end
end)

game.Players.PlayerRemoving:Connect(function(pt1)
	if pt ~= pt1 then
		removeButtons(pt1)
	end
end)
local PageButtons = AdminPanel.PageButtons
local AllPages = 2
local currentPage = 1
PageButtons.PageText.Text = string.format("%s/%s", currentPage, AllPages)
local function updatePage(val)
	currentPage = val
	if val > AllPages then
		currentPage = 1
	elseif val < 1 then
		currentPage = AllPages
	end
	PageButtons.PageText.Text = string.format("%s/%s", currentPage, AllPages)
	pcall(function()
		local f = string.format("List%s", tostring(currentPage))
		for i,v in pairs(AdminPanel:GetChildren()) do
			if string.find(v.Name, "List") then
				if v.Name == f then
					v.Visible = true
				elseif v.Name ~= f then
					v.Visible = false
				end
			end
		end
	end)
	print(currentPage)
end
PageButtons.NextPage.MouseButton1Up:Connect(function()
	updatePage(currentPage + 1)
end)
PageButtons.PreviousPage.MouseButton1Up:Connect(function()
	updatePage(currentPage - 1)
end)
local local_values = {
	fb = false,
	esp = false,
	fb_func = function(val)
		local Light = game.Lighting
		if val == true then
			script.Parent.Parent:SetAttribute("ESPbright", true)
			--[[Light.Ambient = Color3.new(1,1,1)
			Light.ColorShift_Top = Color3.new(1,1,1)
			Light.ColorShift_Bottom = Color3.new(1,1,1)
			script.Parent.DarkAmbience.Enabled = false--]]
		elseif val == false then
			script.Parent.Parent:SetAttribute("ESPbright", false)
		--[[Light.Ambient = Color3.new(0,0,0)
			Light.ColorShift_Top = Color3.new(0,0,0)
			Light.ColorShift_Bottom = Color3.new(0,0,0)]]
			--script.Parent.DarkAmbience.Enabled = true
		end
	end,
	Guiding_l = {},
	CE_Menu = {},
	noclip = false
}

local esp_frames = Instance.new("Folder", script)
esp_frames.Name = "ESP_Folder"

spawn(function()
	local Light = game.Lighting
	
	local humrp1 = Main_Game.char:GetChildren()
	local function doCollide(v1, v2, v3)
		if not v1.Parent:FindFirstChild("Humanoid") then
		   v1.CanCollide = v2
		end
	end
	for i, humrp in pairs(humrp1) do
	local work, callback = pcall(function()
		local item = nil
	humrp.Touched:Connect(function(ot)
		if local_values.noclip and ot.CanCollide == true then
			item = ot
			doCollide(ot, false, humrp)
		end
	end)
	humrp.TouchEnded:Connect(function(ot)
		if ot.CanCollide == false and local_values.noclip and ot == item then
				doCollide(ot, true, humrp)
		end
	end)
	end)
	if not work then
		warn(callback)
	end
	end
	local function fuinc()
		if local_values.esp == true then			

			local b = game.Workspace.CurrentRooms.CurrentRoom.Value - 1
			
		
			for i, v in pairs(game.Workspace.CurrentRooms:GetDescendants()) do
				
				local function setup(val, obj)
					local obj1 = nil
					obj1 = v
					if obj ~= nil then
						obj1 = obj
					end
					if obj1:FindFirstChild("ESP") then
						local e = script.ESP:Clone()
						e.Enabled = false
						e.TextLabel.Text = val

						return e
					else
						local e = script.ESP:Clone()
						e.Enabled = true
						e.Parent = obj1
						e.Adornee = obj1
						e.TextLabel.Text = val
						return e
					end
				end
				local esp_work, esp_callback = pcall(function()
				if v.Name == "KeyObtain" then
					local e, d = setup("Key")
					e.TextLabel.TextColor3 = Color3.fromRGB(233, 255, 34)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(233, 255, 34)
					d.OutlineColor = Color3.fromRGB(233, 255, 34)
					
					d.Parent = v
				elseif v.Name == "BandageHandle" then
				local e, d = setup("Bandage", v.Prop)
				e.TextLabel.TextColor3 = Color3.fromRGB(233, 255, 34)

				local d = script.ESP_high:Clone()
				d.FillColor = Color3.fromRGB(233, 255, 34)
				d.OutlineColor = Color3.fromRGB(233, 255, 34)

				d.Parent = v.Prop
				elseif v.Name == "Door" and v:IsA("Model") then
					local f = "Door"
					if v:FindFirstChild("Lock") then
						f = "Door [LOCKED]"
					end
					local e, d = setup(f)
					e.TextLabel.TextColor3 = Color3.fromRGB(37, 215, 255)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(37, 215, 255)
					d.OutlineColor = Color3.fromRGB(37, 215, 255)

					d.Parent = v.Door
				elseif v.Name == "ClosetDupe" then
					local e, d = setup("Dupe")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 0, 0)
					d.OutlineColor = Color3.fromRGB(255, 0, 0)

					d.Parent = v.DoorFake.Door
				elseif v.Name == "LighterHandle" or v.Name == "Lighter" and v:IsA("Model") then
					local e, d = setup("Lighter")
						e.TextLabel.TextColor3 = Color3.fromRGB(233, 255, 34)

					local d = script.ESP_high:Clone()
						d.FillColor = Color3.fromRGB(233, 255, 34)
						d.OutlineColor = Color3.fromRGB(233, 255, 34)
						d.Parent = v.DoorFake.Door
				elseif v.Name == "Vitamins" or v.Name == "VitaminsHandler" and v:IsA("Model") then
						local e, d = setup("Vitamins")
						e.TextLabel.TextColor3 = Color3.fromRGB(233, 255, 34)

						local d = script.ESP_high:Clone()
						d.FillColor = Color3.fromRGB(233, 255, 34)
						d.OutlineColor = Color3.fromRGB(233, 255, 34)
						d.Parent = v.DoorFake.Door
				elseif v.Name == "ClosetChest" then
					local e, d = setup("Chest Room")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 205, 6)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 205, 6)
					d.OutlineColor = Color3.fromRGB(255, 205, 6)

					d.Parent = v.DoorNormal.Door
				elseif v.Name == "Wardrobe" then
					local e, d = setup("Wardrobe")
					e.TextLabel.TextColor3 = Color3.fromRGB(77, 255, 37)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(77, 255, 37)
					d.OutlineColor = Color3.fromRGB(77, 255, 37)

					d.Parent = v
				elseif v.Name == "RushNew" then
					local e, d = setup("Rush")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 0, 0)
					d.OutlineColor = Color3.fromRGB(255, 0, 0)

					d.Parent = v.Primar
				elseif v.Name == "AmbushMoving" then
					local e, d = setup("Ambush")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 0, 0)
					d.OutlineColor = Color3.fromRGB(255, 0, 0)

					d.Parent = v.Primar
					elseif v.Name == "Prop" and v.Parent.Parent.Parent.Name == "Paintings" then
					local e, d = setup("Painting")
					e.TextLabel.TextColor3 = Color3.fromRGB(37, 215, 255)

					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(37, 215, 255)
					d.OutlineColor = Color3.fromRGB(37, 215, 255)

					d.Parent = v
				elseif v.Name == "Blitz" then
					local e, d = setup("Blitz")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
					
					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 0, 0)
					d.OutlineColor = Color3.fromRGB(255, 0, 0)

					d.Parent = v.Primar
				elseif v.Name == "A60Moving" then
					local e, d = setup("A-60")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 60, 60)

					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 60, 60)
					d.OutlineColor = Color3.fromRGB(255, 60, 60)

					d.Parent = v.Primar
				elseif v.Name == "TrololoMoving" then
					local e, d = setup("Trololo")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 60, 60)

					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 60, 60)
					d.OutlineColor = Color3.fromRGB(255, 60, 60)

					d.Parent = v.Primar
				elseif v.Name == "KreekMoving" then
					local e, d = setup("Super Duper Cool Person in da world")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 60, 60)

					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 60, 60)
					d.OutlineColor = Color3.fromRGB(255, 60, 60)

					d.Parent = v.Primar
				elseif v.Name == "CustomEntity" then
					local e, d = setup("Custom Entity")
					e.TextLabel.TextColor3 = Color3.fromRGB(255, 60, 60)

					local d = script.ESP_high:Clone()
					d.FillColor = Color3.fromRGB(255, 60, 60)
					d.OutlineColor = Color3.fromRGB(255, 60, 60)

					d.Parent = v.Primar
				end
				end)
				if not esp_work then
					warn("ESP Error:", esp_callback)
				end
				end
		elseif local_values.esp == false then
			for i,v in pairs(workspace:GetDescendants()) do
				if v.Name == "ESP" or v.Name == "ESP_high" then
					v:Destroy()
				end
			end
		end
		pcall(function()
			if workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2) then
				for i,v in pairs(workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2):GetDescendants()) do
					if v.Name == "ESP" or v.Name == "ESP_high" and v:IsA("BillboardGui") or v:IsA("Highlight") then
						v:Destroy()
					end
				end
			end
			if workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3) then
				for i,v in pairs(workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3):GetDescendants()) do
					if v.Name == "ESP" or v.Name == "ESP_high" and v:IsA("BillboardGui") or v:IsA("Highlight") then 
						v:Destroy()
					end
				end
			end
		end)
	end
	
	script:GetAttributeChangedSignal("ESP"):Connect(function()
		for i = 1, 2 do
			wait(0.5)
			fuinc()
		end
	end)
	
	game.Workspace.CurrentRooms.ChildAdded:Connect(function()
		
		for i = 1, 2 do
			wait(0.5)
			fuinc()
		end
		
	end)
	
end)

local function localDo(bt)
	local id = bt:GetAttribute("ID")
	bt.MouseButton1Up:Connect(function()
		if id == "EnableFb" then
			script.Parent.Parent:SetAttribute("ESPbright", true)
			local_values.fb = true
		elseif id == "DisableFb" then
			script.Parent.Parent:SetAttribute("ESPbright", false)
			local_values.fb = false
		elseif id == "EnableESP" then
			script:SetAttribute("ESP", true)
			local_values.esp = true
		elseif id == "DisableESP" then
			script:SetAttribute("ESP", false)
			local_values.esp = false
		elseif id == "Noclip" then
			local_values.noclip = not local_values.noclip
		elseif id == "OpenCustomEntity" then
			AdminPanel.Visible = false
			CustomEntity.Visible = true
			for i,v in pairs(local_values.CE_Menu) do
				v:Disconnect()
			end
			local build_data = {icon = "rbxassetid://1", sound = "rbxassetid://1", AmbushMoving = false}
			local_values.CE_Menu.update = game["Run Service"].RenderStepped:Connect(function()
				local ambv = CustomEntity.AmbushMoving:GetAttribute("Value")
				local entity_icon = string.lower(CustomEntity.IconInput.Text)
				local entity_sound = string.lower(CustomEntity.SoundInput.Text)
				CustomEntity.EntityIcon.Image = entity_icon
				build_data.icon = entity_icon
				build_data.sound = entity_sound
				build_data.AmbushMoving = ambv
			end)
			local_values.CE_Menu.spawn = CustomEntity.Spawn.MouseButton1Up:Connect(function()
				CustomEntity.Visible = false
				Main_Game.freemouse = false
				game.ReplicatedStorage.AdminPanelReq:FireServer("CustomEntitySpawn", build_data)
			end)
			local_values.CE_Menu.switch1 = CustomEntity.AmbushMoving.MouseButton1Up:Connect(function()
				local val = false
				if CustomEntity.AmbushMoving:GetAttribute("Value") == false then
					val = true
				end
				CustomEntity.AmbushMoving:SetAttribute("Value", val)
			end)
			
			local_values.CE_Menu.AmbushValueChanged = CustomEntity.AmbushMoving.AttributeChanged:Connect(function(atr)
				if atr == "Value" then
					local ambv = CustomEntity.AmbushMoving:GetAttribute("Value")
					local color1 = Color3.fromRGB(121, 86, 74);
					local value1 = 0.9;
					local pos1 = UDim2.new(0.2, 0, 0.5, 0);
					if ambv then
						color1 = Color3.fromRGB(255, 222, 189);
						value1 = 0.35;
						pos1 = UDim2.new(0.8, 0, 0.5, 0);
					end;
					game.TweenService:Create(CustomEntity.AmbushMoving.Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						BackgroundTransparency = value1
					}):Play();
					game.TweenService:Create(CustomEntity.AmbushMoving.Toggle.Switch, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Position = pos1, 
						BackgroundColor3 = color1
					}):Play();
				end
			end)
			
			
			
		elseif id == "OpenEditor" then
			GuidingLightGenerator.Visible = true
			GuidingLightGenerator.Editor.Visible = false
			GuidingLightGenerator.SelectColor.Visible = false
			AdminPanel.Visible = false
			local currentColor = "Blue"
			local all_colors = {"Blue", "Red", "Yellow", "Green", "Grey", "Orange", "Purple"}
			for i,v in pairs(GuidingLightGenerator.SelectColor.ScrollingFrame:GetChildren()) do
				if v.Name == "selectColor" then
					v:Destroy()
				end
			end
			
			for i,v in pairs(all_colors) do
				local temp = GuidingLightGenerator.SelectColor.ScrollingFrame.Template:Clone()
				temp.Parent = GuidingLightGenerator.SelectColor.ScrollingFrame
				temp.Visible = true
				temp.Title.Text = v
				temp.Name = "selectColor"
				temp.MouseButton1Up:Connect(function()
					currentColor = v
					GuidingLightGenerator.SelectColor.Title2.Text = "Current Color: "..v
				end)
			end
			
			
			for i,v in pairs(GuidingLightGenerator.ScrollingFrame:GetChildren()) do
				if v.Name == "Toggle" then
					v:Destroy()
				end
			end
			if local_values.Guiding_l ~= {} then
				for i,v in pairs(local_values.Guiding_l) do
					v:Disconnect()
				end
			end
			local texts = {}
			
			local_values.Guiding_l.selectColor = GuidingLightGenerator.ChangeColor.MouseButton1Up:Connect(function()
				GuidingLightGenerator.Editor.Visible = false
				GuidingLightGenerator.SelectColor.Visible = true
			end)
			
			local_values.Guiding_l.rembt = GuidingLightGenerator.Editor.RemoveBt.MouseButton1Up:Connect(function()
				local_values.Guiding_l.remove(GuidingLightGenerator.Editor:GetAttribute("EditID"))
			end)
			local_values.Guiding_l.editbt = GuidingLightGenerator.Editor.Save.MouseButton1Up:Connect(function()
				local bt = local_values.Guiding_l.getButton(GuidingLightGenerator.Editor:GetAttribute("EditID"))
				bt:SetAttribute("Text", GuidingLightGenerator.Editor.Input.Text)
				local_values.Guiding_l.update(GuidingLightGenerator.Editor:GetAttribute("EditID"), GuidingLightGenerator.Editor.Input.Text)
			end)
			local_values.Guiding_l.send = GuidingLightGenerator.Generate.MouseButton1Up:Connect(function()
				local new = {}
				for i,v in pairs(GuidingLightGenerator.ScrollingFrame:GetChildren()) do
					if v.Name == "Toggle" and i - 3 == v:GetAttribute("Count") then
						print("asd")
						table.insert(new, v:GetAttribute("Text"))
					end
				end
				print(new)
				if #new >= 1 then
					GuidingLightGenerator.Visible = false
					game.ReplicatedStorage.AdminPanelReq:FireServer("CustomGL", {text = new, main_color = currentColor})
				end
			end)
			local_values.Guiding_l.getButton = function(id)
				local bt = nil
				for i,v in pairs(GuidingLightGenerator.ScrollingFrame:GetChildren()) do
					if id == v:GetAttribute("ID") then
						bt = v
					end
				end
				return bt
			end
			local_values.Guiding_l.update = function(id, val)
				texts[tostring(id)] = val
			end
			local_values.Guiding_l.add = GuidingLightGenerator.Add.MouseButton1Up:Connect(function()
				local id = math.random(1, 123456)
				local button = GuidingLightGenerator.ScrollingFrame.Template:Clone()
				button.Parent = GuidingLightGenerator.ScrollingFrame
				button.Visible = true
				button.Title.Text = "Text "..#GuidingLightGenerator.ScrollingFrame:GetChildren() - 3
				button.Name = "Toggle"
				button:SetAttribute("ID", id)
				button:SetAttribute("Text", "Template")
				button:SetAttribute("Count", #GuidingLightGenerator.ScrollingFrame:GetChildren() - 3)
				button.MouseButton1Up:Connect(function()
					local_values.Guiding_l.edit(button)
				end)
				texts[tostring(id)] = button:GetAttribute("Text")
			end)
			local_values.Guiding_l.remove = function(id)
				for i,v in pairs(GuidingLightGenerator.ScrollingFrame:GetChildren()) do
					if v:GetAttribute("ID") == id then
						v:Destroy()
					end
				end
				GuidingLightGenerator.Editor.Visible = false
			end
			local_values.Guiding_l.edit = function(button)
				GuidingLightGenerator.Editor.Visible = true
				GuidingLightGenerator.SelectColor.Visible = false
				GuidingLightGenerator.Editor.Input.Text = button:GetAttribute("Text")
				GuidingLightGenerator.Editor:SetAttribute("EditID", button:GetAttribute("ID"))
			end
		end
	end)
end
for _,l in pairs(AdminPanel:GetChildren()) do
	if string.find(l.Name, "List") then
		for i,v in pairs(l:GetChildren()) do
			if v:IsA("TextButton") then
				local skip = false
				if v:GetAttribute("StaffOnly") then
					if not SpecialPlayers.isSpecial(pt.Name) then
						local staff = script.staffonlyimage:Clone()
						staff.Parent = v
						staff.Visible = true
						skip = true
					end
				end
				local id = v:GetAttribute("ID")
				if v:GetAttribute("Local") and not skip then
					localDo(v)
				elseif v:GetAttribute("Local") ~= true and not skip then
					local function callRemote()
						local atr = nil
						if id == "GiveItem" then
							atr = string.lower(Input.Text)
						elseif id == "SetEndRoom" then
							atr = string.lower(Input2.Text)
						elseif id == "GiveCoins" then
							atr = tonumber(Input3.Text)
							if atr > 100000 then
								atr = 100000
								Input3.Text = "100000"
							end
						elseif string.find(id, "Jumpscare") then
							local isSpecial = SpecialPlayers.isSpecial(Input5.Text)
							if isSpecial then
								Main_Game.caption("You can't jumpscare "..Input5.Text, true, 0.65)
								return
							end
							atr = Input5.Text


						elseif id == "SetBoost" then
							atr = tonumber(Input7.Text)
						elseif id == "SetBoostPlayer" then
							atr = {tonumber(Input7.Text), v:GetAttribute("PlayerName")}
						elseif id == "SetNextRoom" then
							atr = v:GetAttribute("RoomID")
						elseif id == "KillPlayer" then
							atr = v:GetAttribute("PlayerName")
						elseif id == "RevivePlayer" then
							atr = v:GetAttribute("PlayerName")
						elseif id == "ScreechPlayer" then
							atr = v:GetAttribute("PlayerName")
						elseif id == "DamageSelf" then
							atr = Input8.Text
						elseif id == "DamagePlayer" then
							atr = {Input8.Text, v:GetAttribute("PlayerName")}
						elseif id == "GiveItemPlayer" then
							atr = {string.lower(Input.Text), v:GetAttribute("PlayerName")}
						end
						game.ReplicatedStorage.AdminPanelReq:FireServer(id, atr)
					end
					v.MouseButton1Up:Connect(callRemote)
					if v:GetAttribute("TypeRun") ~= nil then
						local pt_run = pt:WaitForChild("PlayerStats").TypeRun
						local function check(t)
							local att = v:GetAttribute("TypeRun")
							if att == "Hotel" and pt_run.Value == "HuntExit" then
								att = "HuntExit"
							elseif att == "Hotel" and pt_run.Value == "HardHotel" then
								att = "HardHotel"
							end
							if pt_run.Value == att then
								print('true', att)
								return true
							elseif pt_run.Value ~= att then
								print('false', att)
								return false
							end
						end

						local t1 = false
						if check("Hunt") == false then
							v:Destroy()
							t1 = true
						end
						if t1 == false and check("Hotel") == false then
							v:Destroy()
						end

					end
				end
			end
		end
	end
end