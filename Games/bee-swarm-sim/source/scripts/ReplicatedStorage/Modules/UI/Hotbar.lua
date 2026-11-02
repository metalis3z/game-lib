local Module = {}; do
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Items = require(game.ReplicatedStorage.Modules.Items).Eggs
	local TweenService = game:GetService("TweenService")
	local Player = game.Players.LocalPlayer
	local PlayerData = nil
	local UI = Player.PlayerGui:WaitForChild("UI")
	local Frame = UI.Hotbar
	local ChosenSlot = nil
	local Keys = {
		Enum.KeyCode.One,
		Enum.KeyCode.Two,
		Enum.KeyCode.Three,
		Enum.KeyCode.Four,
		Enum.KeyCode.Five,
	}
	local CanChoose = false

	local function Animate(Slot: Frame, Type: "Down" | "Up" | "Default")
		if Type == "Down" then
			Slot:TweenSize(UDim2.new(0.2 / 1.2, 0, 1 / 1.2, 0), "Out", "Elastic", 0.2, true)
			if Slot.Icon.Image ~= "" then
				Slot.Icon:TweenSize(UDim2.new(0.8 / 1.2, 0, 0.8 / 1.2, 0), "Out", "Elastic", 0.2, true)
			end
		elseif Type == "Up" then
			Slot:TweenSize(UDim2.new(0.2 * 1.2, 0, 1 * 1.2, 0), "Out", "Elastic", 0.2, true)
			if Slot.Icon.Image ~= "" then
				Slot.Icon:TweenSize(UDim2.new(0.8 * 1.2, 0, 0.8 * 1.2, 0), "Out", "Elastic", 0.2, true)
			end
		elseif Type == "Default" then
			Slot:TweenSize(UDim2.new(0.2, 0, 1, 0), "Out", "Elastic", 0.2, true)
			if Slot.Icon.Image ~= "" then
				Slot.Icon:TweenSize(UDim2.new(0.8, 0, 0.8, 0), "Out", "Elastic", 0.2, true)
			end
		end
	end

	function Module.Update()
		PlayerData = _G.PData
		for _, HotbarSlot in Frame:GetChildren() do
			if HotbarSlot:IsA("ImageButton") then
				if HotbarSlot.Icon.Visible and PlayerData.Hotbar[tonumber(HotbarSlot.Name)] == "" then
					TweenService:Create(HotbarSlot.Icon, TweenInfo.new(0.1), {
						Size = UDim2.fromScale(0,0)
					}):Play()
					TweenService:Create(HotbarSlot.Amount, TweenInfo.new(0.1), {
						Size = UDim2.fromScale(0,0)
					}):Play()
					task.delay(0.3, function()
						HotbarSlot.Icon.Visible = false
						HotbarSlot.Amount.Visible = false
					end)
				elseif PlayerData.Hotbar[tonumber(HotbarSlot.Name)] ~= "" then
					if not HotbarSlot.Icon.Visible then
						HotbarSlot.Icon.Visible = true
						HotbarSlot.Amount.Visible = true
						TweenService:Create(HotbarSlot.Icon, TweenInfo.new(0.1), {
							Size = UDim2.fromScale(0.8, 0.8)
						}):Play()
						TweenService:Create(HotbarSlot.Amount, TweenInfo.new(0.1), {
							Size = UDim2.fromScale(1,0.25)
						}):Play()
					end
					local Item = PlayerData.Hotbar[tonumber(HotbarSlot.Name)]
					HotbarSlot.Amount.Text = Utils:AbNumber(PlayerData.Inventory[Item])
					HotbarSlot.Amount.Amount.Text = HotbarSlot.Amount.Text
					HotbarSlot.Icon.Image = Items[Item].Image
				end
			end
		end
	end

	local function Use(Slot: number)
		local Item = PlayerData.Hotbar[Slot]
		if Item ~= "" then
			game.ReplicatedStorage.Remotes.UseItem:FireServer(Item)
		end
	end

	function Module.Init()
		PlayerData = _G.PData
		for _, Button in Frame:GetChildren() do
			if Button:IsA("ImageButton") then
				Button.MouseButton1Click:Connect(function()
					Use(tonumber(Button.Name))
				end)
				Button.MouseMoved:Connect(function()
					ChosenSlot = tonumber(Button.Name)
					Animate(Button, "Up")
					_G.HotbarSlot = tonumber(Button.Name)
				end)
				Button.MouseLeave:Connect(function()
					ChosenSlot = nil
					_G.HotbarSlot = nil
					Animate(Button, "Default")
				end)
				Button.MouseButton1Down:Connect(function()
					CanChoose = true
					Animate(Button, "Down")
				end)
				Button.MouseButton1Up:Connect(function()
					if _G.DraggedItem ~= nil and not table.find({"Value", "Food", "EffectFood", "Jelly", "Egg"}, Items[_G.DraggedItem].Type)  then
						game.ReplicatedStorage.Remotes.ChangeHotbar:FireServer(ChosenSlot, _G.DraggedItem)
					end
					CanChoose = false
					Animate(Button, "Default")
				end)
			end
		end
		game.UserInputService.InputBegan:Connect(function(input, gpe)
			if not gpe and table.find(Keys, input.KeyCode) then
				Animate(Frame:FindFirstChild(tostring(table.find(Keys, input.KeyCode))), "Down")
			end
		end)
		game.UserInputService.InputEnded:Connect(function(input, gpe)
			if not gpe and table.find(Keys, input.KeyCode) then
				Use(table.find(Keys, input.KeyCode))
				Animate(Frame:FindFirstChild(tostring(table.find(Keys, input.KeyCode))), "Default")
			--elseif not gpe and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			--	warn(ChosenSlot)
			--	if _G.DraggedItem ~= nil and not table.find({"Value", "Food", "EffectFood", "Jelly", "Egg"}, Items[_G.DraggedItem].Type) then
			--		game.ReplicatedStorage.Remotes.ChangeHotbar:FireServer(ChosenSlot, _G.DraggedItem)
			--	end
			end
		end)
		Module.Update()
	end

end

return Module