local rs = game:GetService("ReplicatedStorage")
local layer

local function update()
	local inventory = rs.RemoteFunctions.fetchInventory:InvokeServer()
	print(inventory)
	local currentItemNum = 1
	for i,v in pairs(script.Parent.Main.Inside.Content.RightSide.Inside:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	for i, v in pairs(inventory) do
		print("successfully started: " .. v)
		if currentItemNum == 4 then
			currentItemNum = 1
		end
		if currentItemNum == 1 then
			layer = rs.InventoryAssets.Layer:Clone()
			layer.Parent = script.Parent.Main.Inside.Content.RightSide.Inside
		end
		local itemicon = rs.InventoryAssets.CrateFrame:Clone()
		itemicon.Parent = layer
		if v == "default" then
			itemicon.CrateName.Text = rs.Resource.Scooter.UIName.Value
		else
			itemicon.CrateName.Text = rs.Resource.SkinnedScooters[v].UIName.Value
		end
		local rarity = rs.RemoteFunctions.fetchRarity:InvokeServer(v)
		
		local brickColors = {
			Common = Color3.new(0.729412, 0.729412, 0.729412),
			Uncommon = Color3.new(0, 0.745098, 0),
			Rare = Color3.new(0, 0.25098, 0.721569),
			Epic = Color3.new(0.427451, 0, 0.713725),
			Legendary = Color3.new(0.729412, 0.607843, 0),
			Mythic = Color3.new(0.705882, 0.705882, 0.25098),
			Admin = Color3.new(0.7, 0, 0),
			Rebirth = Color3.new(0.756863, 0.262745, 0.756863)
		}
		itemicon["Right Side"].BackgroundColor3 = brickColors[rarity]
		-- icon rendering
		if v == "default" then
			local model = rs.Resource.Scooter:Clone()
			model.Parent = itemicon.CrateImageHolder.Icon
		else
			local model = rs.Resource.SkinnedScooters[v]:Clone()
			model.Parent = itemicon.CrateImageHolder.Icon
		end
		currentItemNum += 1
		print("successfully added: " .. v)
	end
end

rs.RemoteEvents.callForUpdate.OnClientEvent:Connect(function()
	wait(1)
	update()
end)

script.Parent.currentSelect.Changed:Connect(function(value)
	if script.Parent.currentSelect.Value == "Scooter" or script.Parent.currentSelect.Value == "default"  then
		for i, v in pairs(script.Parent.Main.Inside.Content.LeftSide.CrateImageHolder.Icon:GetChildren()) do
			if not v:IsA("Camera") then
				v:Destroy()
			end
		end
		local model = rs.Resource.Scooter:Clone()
		model.Parent = script.Parent.Main.Inside.Content.LeftSide.CrateImageHolder.Icon
		script.Parent.Main.Inside.Content.LeftSide.CrateName.Text = rs.Resource.Scooter.UIName.Value
	else
		for i, v in pairs(script.Parent.Main.Inside.Content.LeftSide.CrateImageHolder.Icon:GetChildren()) do
			if not v:IsA("Camera") then
				v:Destroy()
			end
		end
		
		local model = rs.Resource.SkinnedScooters[script.Parent.currentSelect.Value]:Clone()
		model.Parent = script.Parent.Main.Inside.Content.LeftSide.CrateImageHolder.Icon
		script.Parent.Main.Inside.Content.LeftSide.CrateName.Text =rs.Resource.SkinnedScooters[script.Parent.currentSelect.Value].UIName.Value
	end
end)

update()

local equippedOnJoin = rs.RemoteFunctions.fetchEquipped:InvokeServer()
script.Parent.currentSelect.Value = equippedOnJoin
script.Parent.currentEquip.Value = equippedOnJoin

rs.RemoteEvents.updateEquip.OnClientEvent:Connect(function(item)
	script.Parent.currentEquip.Value = item
	if script.Parent.currentSelect.Value == item then
		script.Parent.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equipped"
	else
		script.Parent.Main.Inside.Content.LeftSide.EquipButton.Back.Top.Label.Text = "Equip"
	end
end)