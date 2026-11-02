-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
game:GetService("RunService")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local DuelsMachineController = require(ReplicatedStorage.Controllers.DuelsMachineController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local Settings = require(ReplicatedStorage.Shared.Settings)
local Index = require(ReplicatedStorage.Shared.Index)
local BaseSkins = require(ReplicatedStorage.Shared.BaseSkins)
local Updates = require(ReplicatedStorage.Shared.Updates)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Index2 = require(ReplicatedStorage.Datas.Index)
local MutationText = require(ReplicatedStorage.Shared.MutationText)
local v20 = Net:RemoteFunction("SettingsService/ToggleSetting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local v23 = TopbarPlus.new():setImage(110481567543062, "Selected"):setImage(78403024093069, "Deselected"):setOrder(1)
local u24 = nil
local Settings2 = PlayerGui:WaitForChild("Settings").Settings
local ScrollingFrame = Settings2.Content.ScrollingFrame
local Template = ScrollingFrame.Template
local TemplateBaseSkin = ScrollingFrame.TemplateBaseSkin
local Close = Settings2.Header.Close
local v30 = Trove.new()
local t1 = {}

local function GetMutationNames()
	local t2 = { "Normal" }

	for v36, _ in Index2 do
		table.insert(t2, v36)
	end

	return t2
end
local function resolveColor(p1)
	if typeof(p1) == "table" then
		return p1.Color
	end

	return p1
end
local function ConstructSettings(p2)
	local v40 = Synchronizer:Get(LocalPlayer)

	v30:Clean()

	local g69 = nil
	local g73 = nil
	local g81 = nil

	for v41, v42 in p2 do
		if not Settings[v41] then
			continue
		end

		local Order = Settings[v41].Order

		if v41 ~= "Base Skin" then
			if v41 == "Receive Duels from" then
				local clone = v30:Clone(Template)

				clone.Name = v41
				clone.Function.Text = v41

				local v45 = if v42 ~= "Everyone" then if v42 ~= "Friends" then Color3.fromRGB(245, 56, 56) else Color3.fromRGB(255, 149, 0) else Color3.fromRGB(12, 119, 60)
					local v46 = if v42 ~= "Everyone" then if v42 ~= "Friends" then Color3.fromRGB(177, 0, 0) else Color3.fromRGB(190, 111, 0) else Color3.fromRGB(2, 56, 0)
						local Button = clone.Buttons.Button

						Button.Text.Text = v42
						Button.BackgroundColor3 = v45
						Button.UIStroke.Color = v46
						Button.Text.UIStroke.Color = v46

						local v48 = AnimatedButton.new(Button)

						v30:Add(v48)
						v48:Animate()
						v30:Add(v48.OnActivated:Connect(function()
							local v109 = if v42 ~= "Everyone" then v42 ~= "Friends" and "Everyone" or "No one" else "Friends"
							local v110, v111 = v20:InvokeServer(v41, v109)

							if not v110 then
								NotificationController:Error(v111)
								SoundController:PlaySound("Sounds.Sfx.Error")
							end
						end))

						local v49 = v41 ~= "Receive Duels from" or DuelsMachineController:IsEnabled()

						clone.LayoutOrder = Order
						clone.Visible = not ServerData.IsNewPlayersServer() and v49
						clone.Parent = ScrollingFrame
			elseif v41 ~= "Receive Gifts from" and v41 ~= "Only Receive Trades With" and v41 ~= "Receive Trades from" then
				local clone = v30:Clone(Template)

				clone.Name = v41
				clone.Function.Text = v41

				local Button = clone.Buttons.Button

				Button.Text.Text = not v42 and "Off" or "On"
				Button.BackgroundColor3 = v42 and Color3.new(0.0470588, 0.466667, 0.235294) or Color3.new(0.490196, 0.435294, 0.435294)
				Button.UIStroke.Color = v42 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863)
				Button.Text.UIStroke.Color = v42 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863)

				local v52 = AnimatedButton.new(Button)

				v30:Add(v52)
				v52:Animate()
				v30:Add(v52.OnActivated:Connect(function()
					local v112, v113 = v20:InvokeServer(v41)

					if not v112 then
						NotificationController:Error(v113)
						SoundController:PlaySound("Sounds.Sfx.Error")
					end
				end))

				local v53 = v41 ~= "Mobile Shift Lock" or UserInputService.PreferredInput == Enum.PreferredInput.Touch

				clone.LayoutOrder = Order
				clone.Visible = v53
				clone.Parent = ScrollingFrame
			end

			continue
		end

		local clone = v30:Clone(TemplateBaseSkin)

		clone.Name = v41
		clone.Function.Text = v41
		clone.Button.DropDown.AnchorPoint = Vector2.new(0.5, 0)
		clone.Button.DropDown.Position = UDim2.fromScale(0.5, 1.2)
		clone.Button.DropDown.Size = UDim2.fromScale(1.221, 0)
		clone.Button.DropDown.AutomaticSize = Enum.AutomaticSize.Y

		local t3 = {}
		local t4 = {}

		local function calculateCanvasSize(p3)
			local AbsoluteContentSizeY = ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
			local v89 = not clone.Button.DropDown.Visible and 0 or (#t3 + 1) * ((p3 or clone.Button.AbsoluteSize).Y + 8)

			return UDim2.fromOffset(0, AbsoluteContentSizeY + v89)
		end

		local t5 = { "Normal" }

		for v59, _ in Index2 do
			table.insert(t5, v59)
		end

		for _, v62 in t5 do
			if v62 == v42 then
				continue
			end

			local v63 = Index2[v62]
			local v64 = Index2[v62] and Index2[v62].DisableAutomaticSkin
			local v65 = not not v40 and (BaseSkins.Owns(v40, v62) or false)
			local v66 = v62 == "Normal" or if not BaseSkins.IsInventoryManaged(v62) then Index:IsComplete(LocalPlayer, v62) and not v64 or v65 else v65

			if not v66 and v63.ShowInSettings == false then
				continue
			end

			local clone2 = v30:Clone(clone.Button.DropDown.Template)

			table.insert(t3, clone2)
			clone2.Name = v62
			MutationText.ApplyToLabel(clone2.Text, v62, "Settings")
			clone2.Locked.Visible = not v66
			clone2.BackgroundColor3 = v62 ~= "Normal" and v63.MainColor or Color3.new(0.490196, 0.435294, 0.435294)

			local UIStroke = clone2.UIStroke
			local v71

			repeat
				if not g69 and v62 ~= "Normal" then
					if v63.Palettes then
						local v70 = v63.Palettes[1][2]

						v71 = if typeof(v70) ~= "table" then v70 else v70.Color
					else
						v71 = v63.MainColor
					end

					if not v71 then
						g69 = true
					end
				else
					g69 = false
					v71 = Color3.new(0.490196, 0.435294, 0.435294)
				end
			until not g69

			UIStroke.Color = v71

			local UIStroke2 = clone2.Text.UIStroke
			local v75

			repeat
				if not g73 and v62 ~= "Normal" then
					if v63.Palettes then
						local v74 = v63.Palettes[1][2]

						v75 = if typeof(v74) ~= "table" then v74 else v74.Color
					else
						v75 = v63.MainColor
					end

					if not v75 then
						g73 = true
					end
				else
					g73 = false
					v75 = Color3.new(0.490196, 0.435294, 0.435294)
				end
			until not g73

			UIStroke2.Color = v75

			if v66 then
				local v76 = AnimatedButton.new(clone2)

				v30:Add(v76)
				v76:Animate()
				v30:Add(v76.OnActivated:Connect(function()
					ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

					local DropDown = clone.Button.DropDown

					if DropDown.Visible then
						DropDown.Visible = not DropDown.Visible
						clone.Button.Polygon.Rotation = not DropDown.Visible and 0 or 180

						local v91 = ScrollingFrame
						local AbsoluteContentSizeY = ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
						local v93 = not clone.Button.DropDown.Visible and 0 or (#t3 + 1) * (clone.Button.AbsoluteSize.Y + 8)

						v91.CanvasSize = UDim2.fromOffset(0, AbsoluteContentSizeY + v93)
						ScrollingFrame.CanvasPosition = DropDown.Visible and Vector2.new(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteSize.Y) or Vector2.new(0, 0)
					end

					local v94, v95 = v20:InvokeServer(v41, v62)

					if not v94 then
						NotificationController:Error(v95)
						SoundController:PlaySound("Sounds.Sfx.Error")
					end
				end))
				table.insert(t4, v76)
			end

			clone2.LayoutOrder = v62 ~= "Normal" and Index2[v62].Order or 1
			clone2.Visible = true
			clone2.Parent = clone.Button.DropDown
		end

		local function updateScaling()
			local AbsoluteSize = clone.Button.AbsoluteSize
			local uDim2 = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)

			for _, v99 in t3 do
				v99.Size = uDim2
			end

			for _, v101 in t4 do
				v101.DefaultSize = uDim2
			end

			local v102 = ScrollingFrame
			local AbsoluteContentSizeY = ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
			local v104 = not clone.Button.DropDown.Visible and 0 or (#t3 + 1) * ((AbsoluteSize or clone.Button.AbsoluteSize).Y + 8)

			v102.CanvasSize = UDim2.fromOffset(0, AbsoluteContentSizeY + v104)
		end

		v30:Add(clone.Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScaling))
		v30:Add(clone.Button.DropDown:GetPropertyChangedSignal("Visible"):Connect(updateScaling))
		v30:Add(task.spawn(updateScaling))

		local v78 = Index2[v42]
		local Button = clone.Button

		MutationText.ApplyToLabel(Button.Text, v42, "Settings")
		Button.BackgroundColor3 = v42 ~= "Normal" and (not not v78 and v78.MainColor) or Color3.new(0.490196, 0.435294, 0.435294)

		local UIStroke = Button.UIStroke
		local v83

		repeat
			if not g81 and (v42 ~= "Normal" and v78) then
				if v78.Palettes then
					local v82 = v78.Palettes[1][1]

					v83 = if typeof(v82) ~= "table" then v82 else v82.Color
				else
					v83 = v78.MainColor
				end

				if not v83 then
					g81 = true
				end
			else
				g81 = false
				v83 = Color3.new(0.490196, 0.435294, 0.435294)
			end
		until not g81

		UIStroke.Color = v83

		local v84 = AnimatedButton.new(Button)

		v30:Add(v84)
		v30:Add(v84.OnActivated:Connect(function()
			local DropDown = Button.DropDown

			DropDown.Visible = not DropDown.Visible
			Button.Polygon.Rotation = not DropDown.Visible and 0 or 180

			local v106 = ScrollingFrame
			local AbsoluteContentSizeY = ScrollingFrame.UIListLayout.AbsoluteContentSize.Y
			local v108 = not clone.Button.DropDown.Visible and 0 or (#t3 + 1) * (clone.Button.AbsoluteSize.Y + 8)

			v106.CanvasSize = UDim2.fromOffset(0, AbsoluteContentSizeY + v108)
			ScrollingFrame.CanvasPosition = DropDown.Visible and Vector2.new(0, ScrollingFrame.AbsoluteCanvasSize.Y - ScrollingFrame.AbsoluteSize.Y) or Vector2.new(0, 0)
		end))
		clone.LayoutOrder = Order
		clone.Visible = true
		clone.Parent = ScrollingFrame
	end
end

function t1.Start(_)
	local u86 = nil

	u24 = InterfaceController:Register("Settings", Settings2, "TopQuint")
	u24:AttachCloseButton(Close)
	u24:Close()
	v23.selected:Connect(function()
		InterfaceController:SetState("Settings", true)
	end)
	v23.deselected:Connect(function()
		InterfaceController:SetState("Settings", false)
	end)
	Synchronizer:WaitAndCall(LocalPlayer, function(p5)
		local function tryConstruct()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end

		UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		u24.OnOpen:Connect(function()
			if u86 then
				task.spawn(ConstructSettings, p5:Get("Settings"))
				u86 = nil
			end

			v23:select()
		end)
		u24.OnClose:Connect(function()
			v23:deselect()
		end)

		local v116 = p5:Get("Settings")

		p5:OnDictionaryInserted("UnlockedBaseSkins", function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		p5:OnDictionaryRemoved("UnlockedBaseSkins", function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		p5:OnDictionaryInserted("BaseSkinInventory", function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		p5:OnDictionaryRemoved("BaseSkinInventory", function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		Updates.OnUpdateEnabled:Connect(function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)
		Updates.OnUpdateDisabled:Connect(function()
			if u24:IsOpened() then
				task.spawn(ConstructSettings, p5:Get("Settings"))

				return
			end

			u86 = true
		end)

		for v117, _ in v116 do
			p5:OnChanged(`Settings.{ v117 }`, function(_: boolean)
				if u24:IsOpened() then
					task.spawn(ConstructSettings, p5:Get("Settings"))

					return
				end

				u86 = true
			end)
		end

		local t6 = {}
		local t7 = {
			"Strawberry",
			"Meowl",
			"Skibidi",
			"Headless"
		}

		p5:OnChanged("AnimalAddedOrRemoved", function()
			local v122 = false

			for _, v124 in t7 do
				local v125 = Index:IsComplete(LocalPlayer, v124)

				if v125 ~= t6[v124] then
					t6[v124] = v125
					v122 = true
				end
			end

			if v122 then
				if u24:IsOpened() then
					task.spawn(ConstructSettings, p5:Get("Settings"))

					return
				end

				u86 = true
			end
		end)

		if u24:IsOpened() then
			task.spawn(ConstructSettings, p5:Get("Settings"))

			return
		end

		u86 = true
	end)
end

return t1
