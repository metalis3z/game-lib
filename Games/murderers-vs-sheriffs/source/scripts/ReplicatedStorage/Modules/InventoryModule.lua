
local v_u_1 = {
	["GUI"] = {},
	["MyInventory"] = {}
}
local v_u_2 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"))
local v_u_3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"))
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"))
local Config = require(game.ReplicatedStorage.Constants)
local v_u_5 = {
	"Weapons",
	"Effects",
	"Perks",
	"Emotes",
	"Radios",
	"Pets",
	"Outfits",
	"Materials"
}
local v_u_6 = {
	["Weapons"] = true,
	["Pets"] = true
}
local v_u_7 = {
	["Christmas"] = true,
	["Halloween"] = true
}
local v_u_8 = v_u_2.Rarities
local v_u_9 = require(game.ReplicatedStorage.Modules.ItemModule)
function v_u_1.ConnectOutfitMenu()
	-- upvalues: (copy) v_u_9, (copy) v_u_9, (copy) v_u_1
	v_u_1.GUI.OutfitMenu.Container.Close.MouseButton1Click:connect(function()
		-- upvalues: (ref) v_u_9
		v_u_1.GUI.OutfitMenu.Visible = false
	end)
	local v_u_66 = v_u_1.GUI.OutfitMenu.Container.Description.Username
	v_u_66:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (ref) v_u_9, (copy) v_u_66, (ref) v_u_9
		local v_u_67 = table.clone(v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit)
		v_u_67.Name = v_u_66.Text
		pcall(function()
			-- upvalues: (copy) v_u_67, (ref) v_u_66
			v_u_67.Image = string.format("rbxthumb://type=AvatarBust&id=%s&w=352&h=352", game.Players:GetUserIdFromNameAsync(v_u_66.Text))
		end)
		v_u_9.DisplayItem(v_u_1.GUI.OutfitMenu.Container.ItemFrame.ItemContainer, v_u_67)
	end)
	v_u_1.GUI.OutfitMenu.Container.Description.Confirm.Activated:Connect(function()
		-- upvalues: (copy) v_u_66, (ref) v_u_1, (ref) v_u_9, (ref) v_u_9
		local v_u_68 = game.ReplicatedStorage.Remotes.Inventory.ChangeCustomOutfitId:InvokeServer(v_u_66.Text)
		if tonumber(v_u_68) then
			v_u_4.Outfits.OutfitId = v_u_68
			v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit.Image = string.format("rbxthumb://type=AvatarBust&id=%s&w=352&h=352", v_u_68)
			task.spawn(pcall, function()
				-- upvalues: (ref) v_u_9, (copy) v_u_68
				local v69 = v_u_68
				v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit.Name = game.Players:GetNameFromUserIdAsync((math.abs(v69)))
			end)
			v_u_9.DisplayItem(v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit.Frame, v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit)
			v_u_4.Outfits.Equipped[1] = "Custom_Outfit"
			v_u_1.GUI.OutfitMenu.Visible = false
			v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
		else
			v_u_66.Text = v_u_68
		end
	end)
end
function v_u_1.CreateBlankInventoryTable()
	local v10 = {
		["Weapons"] = {
			["Current"] = {},
			["Classic"] = {},
			["Christmas"] = {},
			["Halloween"] = {}
		},
		["Effects"] = {
			["Current"] = {}
		},
		["Perks"] = {
			["Current"] = {}
		},
		["Emotes"] = {
			["Current"] = {}
		},
		["Radios"] = {
			["Current"] = {}
		},
		["Pets"] = {
			["Current"] = {}
		},
		["Outfits"] = {
			["Current"] = {}
		}
	}
	return v10
end
function v_u_1.CreateBlankTradeInventoryTable()
	local v11 = {
		["Weapons"] = {
			["Current"] = {}
		},
		["Pets"] = {
			["Current"] = {}
		}
	}
	return v11
end
function v_u_1.CreateBlankInventorySort(p12)
	local v13 = {}
	for v14, _ in pairs(p12) do
		v13[v14] = {}
		for v15, _ in pairs(p12[v14]) do
			v13[v14][v15] = {}
		end
	end
	return v13
end
function v_u_1.CreateBlankInventory(p16)
	local v17 = {
		["Data"] = p16 == "Trading" and v_u_1.CreateBlankTradeInventoryTable() or v_u_1.CreateBlankInventoryTable()
	}
	v17.Sort = v_u_1.CreateBlankInventorySort(v17.Data)
	return v17
end
function v_u_1.CreateNewItemData(p18, p19, p20)
	local v21
	if p20 == "Emotes" or p20 == "Toys" then
		v21 = v_u_2.Emotes[p18] or v_u_2.Toys[p18]
	else
		v21 = v_u_2[p20][p18]
	end
	if v21 ~= nil then
		local v22 = {}
		for v23, v24 in pairs(v21) do
			v22[v23] = v24
		end
		v22.Name = v21.ItemName or v21.Name
		v22.Amount = p19
		v22.DataID = p18
		v22.DataType = p20
		if v22.Rarity == nil then
			v22.Rarity = "Common"
		end
		v22.Frame = nil
		v22.LayoutOrder = 0
		return v22
	end
	print("ERROR LOADING ITEM: " .. p18, p20, p19)
end
function v_u_1.GenerateInventoryTables(p25, p26)
	local v27 = v_u_1.CreateBlankInventory(p26)
	for v28, _ in pairs(v27.Data) do
		for v29, v30 in pairs(p25[v28].Owned) do
			local v31
			if v_u_6[v28] then
				v31 = v29 or v30
			else
				v31 = v30
			end
			local v32 = tonumber(v30) or 1
			local v33 = v_u_1.CreateNewItemData(v31, v32, v28)
			if v33 and v28 == "Weapons" then
				v33.EvoXP = 1237500
			end
			if v28 == "Outfits" and v30 == "Custom_Outfit" then
				local v_u_30 = p25.Outfits.OutfitId or 0
				v33.Name = v33.Name
				v33.Image = tonumber(v_u_30) and string.format("rbxthumb://type=AvatarBust&id=%s&w=352&h=352", v_u_30) or v33.Image
				if tonumber(v_u_30) then
					spawn(function()
						local v31 = v_u_30
						if v31 > 0 then
							v33.Name = game.Players:GetNameFromUserIdAsync((math.abs(v31)))
						else
							--warn("Invalid user ID")
						end
					end)
				end
			end
			if v33 then
				local v34
				if p26 == "Trading" then
					v34 = "Current"
				elseif v33 == nil then
					v34 = "Weapons"
				else
					local v35 = v33.Event
					if v28 == "Weapons" and v35 then
						v34 = v35 ~= "Christmas" and v35 ~= "Halloween" and "Current" or v35
					else
						v34 = v33.Season and "Current" or (v28 == "Weapons" and "Classic" or "Current")
					end
				end
				v27.Data[v28][v34][v31] = v33
				local v36 = v27.Sort[v28][v34]
				table.insert(v36, v31)
			end
		end
	end
	for _, v37 in pairs(p25.Uniques or {}) do
		local v38 = v37.BaseItem
		if v37.EvoEquipped then
			local v39 = v_u_2.Weapons[v37.BaseItem]
			local _ = v37.XP >= v39.Evo[1].XPRequired
			local v40 = 1
			local v41 = v37.XP >= v39.Evo[2].XPRequired and 2 or v40
			local v42 = v37.XP >= v39.Evo[3].XPRequired and 3 or v41
			local v43 = v37.XP >= v39.Evo[4].XPRequired and 4 or v42
			v38 = v39.Evo[v43].ItemName
		end
		local v44 = v_u_1.CreateNewItemData(v38, 1, "Weapons")
		v44.Signature = v37.Signature or ""
		v44.Rank = v37.Rank
		v44.EvoXP = v37.XP
		v44.EvoEquipped = v37.EvoEquipped
		local v45
		if p26 == "Trading" then
			v45 = "Current"
		elseif v44 == nil then
			v45 = "Weapons"
		else
			local v46 = v44.Event
			if v46 then
				v45 = v46 ~= "Christmas" and v46 ~= "Halloween" and "Current" or v46
			else
				v45 = v44.Season and "Current" or "Classic"
			end
		end
		v27.Data.Weapons[v45][v38] = v44
		local v47 = v27.Sort.Weapons[v45]
		table.insert(v47, v38)
	end
	return v27
end
function v_u_1.SortTab(p_u_48, p_u_49, p_u_50)
	for v51, v52 in pairs(p_u_48.Sort[p_u_49][p_u_50]) do
		if p_u_48.Data[p_u_49][p_u_50][v52] == nil then
			table.remove(p_u_48.Sort[p_u_49][p_u_50], v51)
		end
	end
	local v53 = p_u_48.Sort[p_u_49][p_u_50]
	table.sort(v53, function(p54, p55)
		local v56 = p_u_48.Data[p_u_49][p_u_50][p54]
		local v57 = p_u_48.Data[p_u_49][p_u_50][p55]
		local v58 = v_u_8[v56.Rarity].Sort
		local v59 = v_u_8[v57.Rarity].Sort
		if v56.DataID == "DefaultKnife" then
			return true
		elseif v57.DataID == "DefaultKnife" then
			return false
		elseif v57.DataID == "DefaultGun" then
			return false
		elseif v56.DataID == "DefaultGun" and v57.DataID ~= "DefaultKnife" then
			return true
		elseif v56.Rarity == v57.Rarity then
			if v56.SortGroup and v57.SortGroup == nil then
				return true
			elseif v57.SortGroup and v56.SortGroup == nil then
				return false
			elseif v56.SortGroup and (v57.SortGroup and v56.SortGroup ~= v57.SortGroup) then
				return v56.SortGroup < v57.SortGroup
			elseif v56.SortGroup and (v57.SortGroup and v56.SortGroup == v57.SortGroup) then
				return v56.SortWithinGroup < v57.SortWithinGroup
			else
				return v56.Name < v57.Name
			end
		else
			return v58 < v59
		end
	end)
	for v60, v61 in pairs(p_u_48.Sort[p_u_49][p_u_50]) do
		p_u_48.Data[p_u_49][p_u_50][v61].LayoutOrder = v60
		if p_u_48.Data[p_u_49][p_u_50][v61].Frame ~= nil then
			p_u_48.Data[p_u_49][p_u_50][v61].Frame.LayoutOrder = v60
		end
	end
	return p_u_48
end
function v_u_1.SortInventory(p62)
	for v63, v64 in pairs(p62.Sort) do
		for v65, _ in pairs(v64) do
			p62 = v_u_1.SortTab(p62, v63, v65)
		end
	end
	return p62
end
function v_u_1.GenerateNewInventoryFrames(p66, p67, p68)
	for v69, v70 in pairs(p66.Data) do
		for v71, v72 in pairs(v70) do
			local v_u_73 = p67:FindFirstChild(v69).Items.Container:FindFirstChild(v71) or p67:FindFirstChild(v69).Items.Container:FindFirstChild("Holiday").Container:FindFirstChild(v71)
			local v74 = v_u_73:FindFirstChild("ItemSizer") or v_u_73.Parent.Parent:FindFirstChild("ItemSizer")
			local v75
			if v74 then
				v75 = v74.AbsoluteSize.Y
			else
				v75 = nil
			end
			if v_u_7[v71] then
				local v_u_76 = (p68 or (v_u_1.GUI.ItemGridLayout or script.ItemGridLayout)):Clone()
				v_u_76.Parent = v_u_73.Container
				v_u_76:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					v_u_73.Size = UDim2.new(1, 0, 0, v_u_76.AbsoluteContentSize.Y + 5 + 44)
				end)
				if v75 then
					local v77 = v_u_76.CellSize
					v_u_76.CellSize = UDim2.new(v77.X.Scale, v77.X.Offset, 0, v75)
				end
			else
				local v_u_78 = (p68 or (v_u_1.GUI.ItemGridLayout or script.ItemGridLayout)):Clone()
				v_u_78.Parent = v_u_73.Container
				v_u_78:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					v_u_73.CanvasSize = UDim2.new(0, 0, 0, v_u_78.AbsoluteContentSize.Y + 5)
				end)
				if v75 then
					local v79 = v_u_78.CellSize
					v_u_78.CellSize = UDim2.new(v79.X.Scale, v79.X.Offset, 0, v75)
				end
			end
			for v80, v81 in pairs(v72) do
				if v81.DoesntCreate then
					if v81.Frame then
						v_u_9.DisplayItem(v81.Frame, v81, nil, true)
					end
				elseif v81.Frame == nil then
					local v82 = script.NewItem:Clone()
					v_u_9.DisplayItem(v82, v81, nil, true)
					v82.Parent = v_u_73.Container
					v82.LayoutOrder = v81.LayoutOrder
					p66.Data[v69][v71][v80].Frame = v82
				end
			end
		end
	end
	return p66
end
function v_u_1.ConnectEquipButtons()
	for v_u_83, v84 in pairs(v_u_1.MyInventory.Data) do
		for v85, v86 in pairs(v84) do
			for v87, v_u_88 in pairs(v86) do
				local v89 = v_u_88.Frame
				if v89 and v_u_88.EquipConnection == nil then
					v_u_1.MyInventory.Data[v_u_83][v85][v87].EquipConnection = v89.Container.ActionButton.MouseButton1Click:connect(function()
						if v_u_88.ItemType == "Misc" then
							return
						elseif v_u_83 ~= "Emotes" and v_u_83 ~= "Toys" then
							if v_u_83 == "Weapons" then
								local v90 = v_u_2.Weapons[v_u_88.DataID]
								local v91 = v90.EvoBaseID
								if v91 then
									local v92 = v_u_2.Weapons[v91].Evo
									local v93 = v_u_1.GUI.EvoMenu
									v93.Container.TitleFrame.TitleLabel.Text = v90.ItemName .. " Evo"
									local v94 = v_u_88.EvoXP >= v92[1].XPRequired and 1 or 1
									local v95 = v_u_88.EvoXP >= v92[2].XPRequired and 2 or v94
									local v96 = v_u_88.EvoXP >= v92[3].XPRequired and 3 or v95
									local v97 = v_u_88.EvoXP >= v92[4].XPRequired and 4 or v96
									for v98, v99 in pairs(v92) do
										local v100 = v_u_1.GUI.EvoMenu.Container.EvoContainer:FindFirstChild("Evo" .. v98)
										local v101 = v_u_2.Weapons[v99.ItemName]
										v_u_9.DisplayItem(v100, v101, nil, true)
										v100.ItemName.Label.Text = v101.Rarity
										v100.Locked.Visible = v97 < v98
										v100:SetAttribute("ItemID", v99.ItemName)
										v100:SetAttribute("ItemType", v_u_88.ItemType)
										v100:SetAttribute("Locked", v97 < v98)
									end
									
									local v102 = v97 + 1
									if v92[v102] ~= nil then
										v97 = v102
									end
									local v103 = v93.Container.XPFrame.XPLabel
									local v104 = v_u_9.Commafy
									local v105 = v_u_88.EvoXP
									v103.Text = v104((math.floor(v105))) .. " / " .. v_u_9.Commafy(v92[v97].XPRequired)
									local v106 = v_u_88.EvoXP / v92[v97].XPRequired
									local v107 = v106 < 0 and 0 or (v106 > 1 and 1 or v106)
									v93.Container.XPFrame.Background.XPBar.Size = UDim2.new(v107, 0, 1, 0)
									v93.Visible = true
									return
								end
								v_u_4.Weapons.Equipped[v_u_88.ItemType] = v_u_88.DataID
							elseif v_u_83 == "Effects" then
								local equippedEffects = v_u_4[v_u_83].Equipped or {}
								for i, equippedEffect in pairs(equippedEffects) do
									if equippedEffect == v_u_88.DataID then
										return
									end
								end
								if not v_u_4.Gamepasses then
									v_u_4.Gamepasses = {}
								end
								local hasDoubleEffectPass = v_u_4.Gamepasses.DoubleEffect or false
								local maxSlots = hasDoubleEffectPass and 2 or 1
								table.insert(equippedEffects, 1, v_u_88.DataID)
								while #equippedEffects > maxSlots do
									table.remove(equippedEffects)
								end
								v_u_4[v_u_83].Equipped = equippedEffects
							else
								if v_u_88.Editable then
									v_u_9.DisplayItem(v_u_1.GUI.OutfitMenu.Container.ItemFrame.ItemContainer, v_u_88)
									v_u_1.GUI.OutfitMenu.Container.Description.Username.Text = v_u_88.Name == "Custom Outfit" and "" or (v_u_88.Name or "")
									v_u_1.GUI.OutfitMenu.Visible = true
									return
								end
								for _, v108 in pairs(v_u_4[v_u_83].Equipped) do
									if v108 == v_u_88.DataID then
										return
									end
								end
								local v109 = v_u_4[v_u_83].Equipped
								local v110 = v_u_88.DataID
								table.insert(v109, 1, v110)
								local v111 = #v_u_4[v_u_83].Equipped
								if v_u_4[v_u_83].Slots < v111 then
									table.remove(v_u_4[v_u_83].Equipped, v111)
								end
							end
							v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
							game.ReplicatedStorage.Remotes.Inventory.Equip:FireServer(v_u_88.DataID, v_u_88.DataType)
						end
					end)
				end
			end
		end
	end
end
function v_u_1.ConnectEvoMenu()
	v_u_1.GUI.EvoMenu.Container.Close.MouseButton1Click:connect(function()
		v_u_1.GUI.EvoMenu.Visible = false
	end)
	for _, v_u_112 in pairs(v_u_1.GUI.EvoMenu.Container.EvoContainer:GetChildren()) do
		if v_u_112:IsA("Frame") then
			v_u_112.Container.Button.MouseButton1Click:connect(function()
				local v113 = v_u_112:GetAttribute("ItemID")
				local v114 = v_u_112:GetAttribute("ItemType")
				if v_u_112:GetAttribute("Locked") ~= true then
					v_u_4.Weapons.Equipped[v114] = v113
					v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
					game.ReplicatedStorage.Remotes.Inventory.Equip:FireServer(v113, "Weapons")
				end
			end)
		end
	end
end
function v_u_1.GenerateInventory(p115, p116, p117, p118)
	local v119 = v_u_1.GenerateInventoryTables(p116, p117)
	local v120 = v_u_1.SortInventory(v119)
	return v_u_1.GenerateNewInventoryFrames(v120, p115.Main, p118)
end
--[[function v_u_1.UpdateInventory(p121, p122)
	for v123, v124 in p122.Data do
		for v125, v126 in v124 do
			for v127, v128 in v126 do
				local v129 = (v128.Rarity == "Unique" or v128.EvoEquipped) and 1 or v_u_4[v123].Owned[v127]
				for _, v130 in v_u_4[v123].Owned do
					if v130 == v127 then
						v129 = 1
					end
				end
				if v129 == nil or v129 <= 0 then
					p122.Data[v123][v125][v127].Frame:Destroy()
					p122.Data[v123][v125][v127] = nil
				else
					p122.Data[v123][v125][v127].Amount = v129
					p122.Data[v123][v125][v127].Frame.Container.Amount.Text = v129 and (v129 > 1 and "x" .. v129) or ""
					if v128.Rarity == "Unique" then
						p122.Data[v123][v125][v127].Frame.Container.Amount.Text = v128.Rank and "#" .. v128.Rank or ""
					end
				end
			end
		end
	end
	local v131 = {}
	for _, v132 in v_u_5 do
		for v133, v134 in v_u_4[v132].Owned do
			local v135
			if v_u_6[v132] then
				v135 = v133 or v134
			else
				v135 = v134
			end
			local v136 = tonumber(v134) or 1
			local v137 = v_u_2[v132][v135]
			if v137 then
				local v138 = v132 == "Weapons" and v137.Event or (v137.Season and "Current" or (v132 == "Weapons" and "Classic" or "Current"))
				if p122.Data[v132][v138][v135] == nil and v137.Rarity ~= "Unique" then
					local v139 = v_u_1.CreateNewItemData(v135, v136, v132)
					local v140
					if v137 == nil then
						v140 = "Weapons"
					else
						local v141 = v137.Event
						if v132 == "Weapons" and v141 then
							v140 = v141 ~= "Christmas" and v141 ~= "Halloween" and "Current" or v141
						else
							v140 = v137.Season and "Current" or (v132 == "Weapons" and "Classic" or "Current")
						end
					end
					p122.Data[v132][v140][v135] = v139
					local v142 = p122.Sort[v132][v138]
					table.insert(v142, v135)
					v131[v132] = v138
				end
			end
		end
	end
	if v131 then
		local v143 = v_u_1.SortInventory(p122)
		v_u_1.GenerateNewInventoryFrames(v143, p121.Main)
		v_u_1.ConnectEquipButtons()
	end
end]]


function v_u_1.UpdateInventory(v116, v117, itemType, itemId, amount)
	if itemType ~= nil then
		local sync = v_u_2[itemType] and v_u_2[itemType][itemId]
		if not sync then return end
		if itemType == "Toys" then
			itemType = "Emotes"
		end
		local section
		if itemType == "Weapons" then
			section = sync.Event or (sync.Season and "Current") or "Classic"
		else
			section = (sync.Season and "Current") or "Current"
		end
		v117.Data[itemType] = v117.Data[itemType] or {}
		v117.Data[itemType][section] = v117.Data[itemType][section] or {}
		v117.Sort[itemType] = v117.Sort[itemType] or {}
		v117.Sort[itemType][section] = v117.Sort[itemType][section] or {}

		local dataTab = v117.Data[itemType][section]
		local sortTab = v117.Sort[itemType][section]

		local itemData = dataTab[itemId]
		if not amount or amount <= 0 then
			if itemData then
				if itemData.Frame then
					itemData.Frame:Destroy()
				end
				dataTab[itemId] = nil
			end
			for i, v in ipairs(sortTab) do
				if v == itemId then
					table.remove(sortTab, i)
					break
				end
			end
		elseif itemData then
			itemData.Amount = amount
			local label = ""
			if sync.Rarity == "Unique" then
				label = sync.Rank and ("#" .. sync.Rank) or ""
			elseif amount > 1 then
				label = "x" .. amount
			end
			if itemData.Frame then
				itemData.Frame.Container.Amount.Text = label
			end
		else
			local newData = v_u_1.CreateNewItemData(itemId, amount, itemType)
			dataTab[itemId] = newData
			table.insert(sortTab, itemId)
			if itemType ~= "Materials" then
				local parentFrame = v116.Main[itemType].Items.Container:FindFirstChild(section)
				or (v116.Main[itemType].Items.Container:FindFirstChild("Holiday")
					and v116.Main[itemType].Items.Container.Holiday.Container:FindFirstChild(section))
			if not newData.DoesntCreate then
				local parentFrame = v116.Main[itemType].Items.Container:FindFirstChild(section)
					or (v116.Main[itemType].Items.Container:FindFirstChild("Holiday")
						and v116.Main[itemType].Items.Container.Holiday.Container:FindFirstChild(section))
				if parentFrame then
					local frame = script.NewItem:Clone()
					v_u_9.DisplayItem(frame, newData, nil, true)
					frame.Parent = parentFrame.Container
					newData.Frame = frame
				else
				end
			end
			end
		end
		v117 = v_u_1.SortTab(v117, itemType, section)
		for idx, id in ipairs(v117.Sort[itemType][section]) do
			local d = v117.Data[itemType][section][id]
			d.LayoutOrder = idx
			if d.Frame then d.Frame.LayoutOrder = idx end
		end
		v_u_1.ConnectEquipButtons()
		return
	end

	for v118, v119 in v117.Data do
		for v120, v121 in v119 do
			for v122, v123 in v121 do
				local v124 = (not (v123.Rarity ~= "Unique") or v123.EvoEquipped) and 1 or v_u_4[v118].Owned[v122];
				for _, v126 in v_u_4[v118].Owned do
					if v126 == v122 then
						v124 = 1;
					end;
				end;
				if v124 ~= nil and v124 > 0 then
					v117.Data[v118][v120][v122].Amount = v124;
					v117.Data[v118][v120][v122].Frame.Container.Amount.Text = v124 and v124 > 1 and "x" .. v124 or "";
					if v123.Rarity == "Unique" then
						v117.Data[v118][v120][v122].Frame.Container.Amount.Text = v123.Rank and "#" .. v123.Rank or "";
					end;
				else
					v117.Data[v118][v120][v122].Frame:Destroy();
					v117.Data[v118][v120][v122] = nil;
				end;
			end;
		end;
	end;
	local v127 = {};
	for _, v129 in v_u_5 do
		for v130, v131 in v_u_4[v129].Owned do
			local v132 = v_u_6[v129] and v130 or v131;
			local v133 = tonumber(v131) or 1;
			local v134 = v_u_2[v129][v132];
			if v134 then
				local v135 = v129 == "Weapons" and v134.Event or v134.Season and "Current" or v129 == "Weapons" and "Classic" or "Current";
				if v117.Data[v129][v135][v132] == nil and v134.Rarity ~= "Unique" then
					local v136 = v_u_1.CreateNewItemData(v132, v133, v129);
					local v137 = v134 == nil and "Weapons" or v129 == "Weapons" and v134.Event or v134.Season and "Current" or v129 == "Weapons" and "Classic" or "Current";
					v117.Data[v129][v137][v132] = v136;
					table.insert(v117.Sort[v129][v135], v132);
					v127[v129] = v135;
				end;
			end;
		end;
	end;
	if v127 then
		v117 = v_u_1.SortInventory(v117);
		v_u_1.GenerateNewInventoryFrames(v117, v116.Main);
		v_u_1.ConnectEquipButtons();
	end;
end


local v_u_144 = {}
function v_u_1.UpdateEquip(p_u_145, p146)
	if not p146 or not p146.Data then
		warn("p146 or p146.Data is nil", p146)
		return
	end
	for v_u_147, _ in pairs(p146.Data) do
		if p_u_145[v_u_147]:FindFirstChild("Equipped") then
			for _, v148 in pairs(p_u_145[v_u_147].Equipped.Container:GetChildren()) do
				if v148:FindFirstChild("Container") then
					v148.Container.Visible = false
				end
			end

			if v_u_147 == "Effects" then
				local equippedEffects = v_u_4[v_u_147].Equipped or {}

				if #equippedEffects == 0 then
					p_u_145[v_u_147].Equipped.Container.DeathEffect.Visible = false
				end

				for index, effectId in pairs(equippedEffects) do
					local effectData = v_u_2[v_u_147][effectId]
					if effectData then
						local slotName = "Item" .. index
						local effectSlot = p_u_145[v_u_147].Equipped.Container:FindFirstChild(slotName)

						if effectSlot then
							v_u_9.DisplayItem(effectSlot.Container, effectData)
							effectSlot.Container.Visible = true

							if effectData.DeathModule or effectData.DeathEffect then
								p_u_145[v_u_147].Equipped.Container.DeathEffect.Visible = true
								p_u_145[v_u_147].Equipped.Container.DeathEffect.Container2.EffectEnabled.Visible = v_u_4.DeathEffect == true
								p_u_145[v_u_147].Equipped.Container.DeathEffect.Container2.EffectDisabled.Visible = v_u_4.DeathEffect == false
								
							end
							if v_u_147 == "Effects" then
								p_u_145[v_u_147].Equipped.Container.GunEffect.Container2.EffectEnabled.Visible = v_u_4.GunEffect == true
								p_u_145[v_u_147].Equipped.Container.GunEffect.Container2.EffectDisabled.Visible = v_u_4.GunEffect == false
							end

							if p146 == v_u_1.MyInventory and effectSlot.Container:FindFirstChild("Unequip") then
								if v_u_144[effectSlot] then
									v_u_144[effectSlot]:disconnect()
									v_u_144[effectSlot] = nil
								end
								v_u_144[effectSlot] = effectSlot.Container.Unequip.Button.MouseButton1Click:connect(function()
									table.remove(v_u_4[v_u_147].Equipped, index)
									v_u_1.UpdateMyEquip()
									game.ReplicatedStorage.Remotes.Inventory.Unequip:FireServer(index, v_u_147)
								end)
							end
						end
					end
				end
			else
				local equippedItems = v_u_4[v_u_147].Equipped
				if type(equippedItems) == "table" then
					for v_u_149, v150 in pairs(equippedItems) do
						if v_u_149 ~= "Misc" then
							local v151 = p_u_145[v_u_147].Equipped.Container
							local v152
							if tonumber(v_u_149) then
								v152 = "Item" .. v_u_149 or v_u_149
							else
								v152 = v_u_149
							end
							local v153 = v151[v152]
							local v154 = v_u_2[v_u_147][v150]

							if v154 ~= nil then
								v_u_9.DisplayItem(v153.Container, v154)
							end
							if v_u_147 == "Outfits" and v150 == "Custom_Outfit" then
								v_u_9.DisplayItem(v153.Container, v_u_1.MyInventory.Data.Outfits.Current.Custom_Outfit)
							end
							v153.Container.Visible = v154 ~= nil
							if p146 == v_u_1.MyInventory and v153.Container:FindFirstChild("Unequip") then
								if v_u_144[v153] then
									v_u_144[v153]:disconnect()
									v_u_144[v153] = nil
								end
								v_u_144[v153] = v153.Container.Unequip.Button.MouseButton1Click:connect(function()
									table.remove(v_u_4[v_u_147].Equipped, v_u_149)
									v_u_1.UpdateMyEquip()
									game.ReplicatedStorage.Remotes.Inventory.Unequip:FireServer(v_u_149, v_u_147)
								end)
							end
							
						end
					end
				end
			end
		end
	end
	
	local v_u_155 = time()
	local EffectsContainer = p_u_145.Effects.Equipped.Container
	if EffectsContainer:FindFirstChild("List") then
		EffectsContainer = EffectsContainer.List
	end

	local DeathEffect = EffectsContainer.DeathEffect.Container2
	local GunEffect = EffectsContainer.GunEffect.Container2

	DeathEffect.EffectEnabled.MouseButton1Click:connect(function()
		if time() - v_u_155 >= 1 then
			game.ReplicatedStorage.Remotes.Inventory.ToggleDeathEffects:FireServer(false)
			v_u_4.DeathEffect = false
			DeathEffect.EffectEnabled.Visible = false
			DeathEffect.EffectDisabled.Visible = true
			v_u_155 = time()
		end
	end)

	DeathEffect.EffectDisabled.MouseButton1Click:connect(function()
		if time() - v_u_155 >= 1 then
			game.ReplicatedStorage.Remotes.Inventory.ToggleDeathEffects:FireServer(true)
			v_u_4.DeathEffect = true
			DeathEffect.EffectDisabled.Visible = false
			DeathEffect.EffectEnabled.Visible = true
			v_u_155 = time()
		end
	end)

	GunEffect.EffectEnabled.MouseButton1Click:connect(function()
		if time() - v_u_155 >= 1 then
			game.ReplicatedStorage.Remotes.Inventory.ToggleGunEffects:FireServer(false)
			v_u_4.GunEffect = false
			GunEffect.EffectEnabled.Visible = false
			GunEffect.EffectDisabled.Visible = true
			v_u_155 = time()
		end
	end)

	GunEffect.EffectDisabled.MouseButton1Click:connect(function()
		if time() - v_u_155 >= 1 then
			game.ReplicatedStorage.Remotes.Inventory.ToggleGunEffects:FireServer(true)
			v_u_4.GunEffect = true
			GunEffect.EffectDisabled.Visible = false
			GunEffect.EffectEnabled.Visible = true
			v_u_155 = time()
		end
	end)

end
function v_u_1.UpdateMyEquip()
	v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
end

function v_u_1.ConnectNavButtons(p156, p_u_157)
	local v_u_158 = p156:GetChildren()
	for _, v_u_159 in pairs(v_u_158) do
		if v_u_159:IsA("TextButton") then
			v_u_159.MouseButton1Click:connect(function()
				if v_u_159.Name ~= "Close" then
					for _, v160 in pairs(v_u_158) do
						if v160:IsA("TextButton") then
							v160.Style = v160.Name == v_u_159.Name and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton
						end
					end
					for _, v161 in pairs(p_u_157:GetChildren()) do
						v161.Visible = v161.Name == v_u_159.Name
					end
				end
			end)
		end
	end
end
local v_u_tabMemory = {}
function v_u_1.ConnectTabButtons(p162, p163, p164, p165, _)
	local v166 = p164 or p162.Main[p163]
	local v_u_167 = p165 or v166.Items.Container
	local v168 = v166:FindFirstChild("TitleBar") and v166.TitleBar.Container or (v166:FindFirstChild("Tabs") or v166.Items.Tabs)
	local v_u_169 = v168:FindFirstChild("Search") and v168.Search.Container.SearchText
	local v_u_170 = {}
	for _, v172 in pairs(v168:GetChildren()) do
		if v172:FindFirstChild("View") then
			table.insert(v_u_170, v172)
		end
	end
	table.sort(v_u_170, function(a, b)
		if a.LayoutOrder == b.LayoutOrder then
			return a.Name < b.Name
		end
		return a.LayoutOrder < b.LayoutOrder
	end)
	local v_u_171 = (p162 and p162:GetFullName() or v166:GetFullName()) .. ":" .. tostring(p163 or v166.Name)
	local function v_u_172(tabName, clearSearch)
		local selectedTab = nil
		for _, tab in pairs(v_u_170) do
			if tab.Name == tabName then
				selectedTab = tab
				break
			end
		end
		if not selectedTab then
			selectedTab = v_u_170[1]
		end
		if not selectedTab then
			return
		end
		if clearSearch and v_u_169 then
			v_u_169.Text = ""
		end
		v_u_tabMemory[v_u_171] = selectedTab.Name
		for _, tab in pairs(v_u_170) do
			local border = tab:FindFirstChild("ViewBorder")
			if border then
				border.Visible = tab.Name == selectedTab.Name
			end
			tab.BackgroundTransparency = tab.Name == selectedTab.Name and 0.8 or 0.9
		end
		for _, page in pairs(v_u_167:GetChildren()) do
			page.Visible = page.Name == selectedTab.Name
		end
	end
	for _, v173 in pairs(v_u_170) do
		local v_u_174 = v173.Name
		v173.View.MouseButton1Click:connect(function()
			v_u_172(v_u_174, true)
		end)
	end
	local selectedName = v_u_tabMemory[v_u_171]
	if not selectedName then
		for _, tab in pairs(v_u_170) do
			if v_u_167:FindFirstChild(tab.Name) and v_u_167[tab.Name].Visible then
				selectedName = tab.Name
				break
			end
		end
	end
	v_u_172(selectedName or (v_u_170[1] and v_u_170[1].Name), false)
end
local v_u_177 = nil
function v_u_1.ConnectCodeFrame(p_u_178)
	p_u_178.CodeBox.Changed:connect(function()
		for v179, _ in pairs(v_u_2.Codes) do
			local v180 = p_u_178.CodeBox.Text == v179
			p_u_178.Redeem.Style = v180 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton
			if v180 then
				v_u_177 = "Normal"
				return
			end
		end
		p_u_178.CodeBox.Text = string.gsub(p_u_178.CodeBox.Text, "%s+", "")
		p_u_178.CodeBox.Text = string.gsub(p_u_178.CodeBox.Text, "~", "")
		local v181 = p_u_178.CodeBox.Text
		local v182
		if string.len(v181) == 7 then
			local v183 = p_u_178.CodeBox.Text
			v182 = string.sub(v183, 4, 4) == "-"
		else
			v182 = false
		end
		p_u_178.Redeem.Style = v182 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton
		v_u_177 = v182 and "Shirt" or nil
	end)
	p_u_178.Redeem.MouseButton1Click:connect(function()
		v_u_1.Redeem(p_u_178)
	end)
end
function v_u_1.Redeem(p184)
	if v_u_177 ~= nil then
		local v185 = v_u_177
		local v186 = tostring(v185)
		local v187 = p184.CodeBox.Text
		p184.CodeBox.Text = "Redeeming..."
		p184.Redeem.Style = Enum.ButtonStyle.RobloxRoundButton
		local v188, v189 = game.ReplicatedStorage.Remotes.Extras.RedeemCode:InvokeServer(v187, v186)
		p184.CodeBox.Text = v188
		if v189 then
			for _, v190 in pairs(v189) do
				_G.NewItem(v190.ID, "You Got...", v_u_3:GetFrame("Inventory"), v190.Type)
			end
		end
	end
end
function v_u_1.ConnectPetNaming(p_u_191)
	p_u_191.PetNameBox.Text = v_u_4.PetName
	p_u_191.Confirm.MouseButton1Click:connect(function()
		local v192 = p_u_191.PetNameBox.Text
		if string.len(v192) <= 20 then
			v_u_4.PetName = v192
			game.ReplicatedStorage.Remotes.Inventory.RenamePet:FireServer(v192)
		else
			p_u_191.PetNameBox.Text = "Name too long"
		end
	end)
end

game.ReplicatedStorage.Remotes.Inventory.ChangeProfileData.OnClientEvent:Connect(function(dataType, newValue)
	if dataType == "DoubleEffect" then
		if not v_u_4.Gamepasses then
			v_u_4.Gamepasses = {}
		end
		v_u_4.Gamepasses.DoubleEffect = newValue
		if v_u_1.GUI.MyInventory.Visible then
			v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
		end
	elseif dataType == "Gems" then
		v_u_4.Gems = newValue
	elseif dataType == "Gamepasses" then
		v_u_4.Gamepasses = newValue
		if v_u_1.GUI.MyInventory.Visible then
			v_u_1.UpdateEquip(v_u_1.GUI.MyInventory.Main, v_u_1.MyInventory)
		end
	end
end)

game.ReplicatedStorage.Remotes.Shop.GetDoubleEffect.OnClientEvent:Connect(function()
	wait(0.1)
	if v_u_1.ConnectEquipButtons then
		v_u_1.ConnectEquipButtons()
	end
end)

return v_u_1