local Main_Game = require(script.Parent)
local AdminPanel = script.Parent.Parent.Parent.AdminPanel
local GuidingLightGenerator = script.Parent.Parent.Parent.GuidingLightEditor
local SpecialPlayers = require(game.ReplicatedStorage.SpecialPlayers)
local key_to_open = Enum.KeyCode.Z -- key that's opens admin panel

local pt = game.Players.LocalPlayer
local AdminPanel_Module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)
local h_a = AdminPanel_Module:haveAccess(pt)

if not h_a or pt.PlayerStats.AdminPanel.Value == false or pt.PlayerStats.TypeRun.Value == "HardHotel" and not SpecialPlayers.isSpecial(pt.Name) and not game["Run Service"]:IsStudio() then
   GuidingLightGenerator:Destroy()	
   script:Destroy()
	return
end

AdminPanel.Parent.Modifiers.Visible = true
AdminPanel.Parent.Modifiers.KnobBonus.Text = "0%"
AdminPanel.Parent.Modifiers.NoProgress.Visible = true
AdminPanel.Parent.Modifiers.Tip.Visible = true
AdminPanel.Parent.Modifiers.NoRift.Visible = true
AdminPanel.Parent.Modifiers.DescPanel.Visible = true
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
	AdminPanel.Parent.Modifiers.Visible = false
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
	Guiding_l = {}
}

local esp_frames = Instance.new("Folder", script)
esp_frames.Name = "ESP_Folder"
spawn(function()
	local Light = game.Lighting
	-- game["Run Service"].Heartbeat:Connect(function(d)
workspace.CurrentRooms.ChildAdded:Connect(function()
		task.wait(0.35)
		if math.random(1,5) == 5 then
			task.wait(0.075)
		end
		if local_values.esp == true then
			local function render(b)
				for i,v in pairs(b:GetChildren()) do
					if math.random(1, 35) == 1 then
						task.wait(0.005)
					end
					local count = #v:GetChildren()
					spawn(function()
						if count > 0 then
							render(v)
						end
					end)
					local f = {nil, false}
					for _, v2 in pairs(esp_frames:GetChildren()) do
						if v2.Adornee == v then
							f = {v2, true}
						end
					end
					if not f[2] then
						local function setup(val)
							local e = script.ESP:Clone()
							e.Enabled = true
							e.Parent = esp_frames
							e.Adornee = v
							e.TextLabel.Text = val

							return e
						end
						if v.Name == "KeyObtain" then
							local e, d = setup("Key")
							e.TextLabel.TextColor3 = Color3.fromRGB(233, 255, 34)
						elseif v.Name == "Door" and v:IsA("Model") then
							local e, d = setup("Door")
							e.TextLabel.TextColor3 = Color3.fromRGB(37, 215, 255)
						elseif v.Name == "ClosetDupe" then
							local e, d = setup("Dupe")
							e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
						elseif v.Name == "ClosetChest" then
							local e, d = setup("Chest Room")
							e.TextLabel.TextColor3 = Color3.fromRGB(255, 205, 6)
						elseif v.Name == "Wardrobe" then
							local e, d = setup("Wardrobe")
							e.TextLabel.TextColor3 = Color3.fromRGB(77, 255, 37)
						elseif v.Name == "RushNew" then
							local e, d = setup("Rush")
							e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
						elseif v.Name == "AmbushMoving" then
							local e, d = setup("Ambush")
							e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
						elseif v.Name == "Blitz" then
							local e, d = setup("Blitz")
							e.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
						end
					elseif f[2] then
						pcall(function()
							local pos1 = pt.Character.PrimaryPart.CFrame.Position
							local pos2 = v:GetPivot().Position
							local mag = (pos1-pos2).Magnitude
							if mag > 235 and f[1]:FindFirstChild("ESP") then
								f[1]:FindFirstChild("ESP"):Destroy()
							end
						end)
					end
				end
			end
			render(workspace.CurrentRooms)
		elseif local_values.esp == false then
			for i,v in pairs(esp_frames:GetChildren()) do
				v:Destroy()
			end
		end
	end)
	-- end)
	--[[while true do
		local d = 0.001
		task.wait(d)
		if local_values.fb == true then
			Light.Ambient = Color3.new(1,1,1)
			Light.ColorShift_Top = Color3.new(1,1,1)
			Light.ColorShift_Bottom = Color3.new(1,1,1)
		elseif local_values.fb == false then
			Light.Ambient = Color3.new(0,0,0)
			Light.ColorShift_Top = Color3.new(0,0,0)
			Light.ColorShift_Bottom = Color3.new(0,0,0)
		end
	end]]
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
			local_values.fb_func(true)
		elseif id == "DisableESP" then
			print("false")
			local_values.fb_func(false)
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

				local id = v:GetAttribute("ID")
				if v:GetAttribute("Local") then
					localDo(v)
				elseif v:GetAttribute("Local") ~= true then
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