-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = {
	Classic = 1, 
	Common = 2, 
	Uncommon = 3, 
	Rare = 4, 
	Legendary = 5, 
	Godly = 6, 
	Victim = 7, 
	Unique = 7, 
	Christmas = 1.5, 
	Halloween = 1.6, 
	Ancient = 6.5
};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ItemPopupService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_Rarity_0 = l_Sync_0.Rarity;
local v6 = require(game.ReplicatedStorage.Modules.GridCreator);
v0.GUI = nil;
v0.Mode = "Craft";
local v7 = nil;
local v8 = nil;
local v9 = nil;
local l_Codes_0 = l_Sync_0.Codes;
local v11 = {};
for _, v13 in pairs(l_Codes_0) do
	if v11[v13.Prize] then
		v11[v13.Prize] = true;
	end
end;
v0.SetCraftGUI = function(v14, v15, v16, v17, v18, v19, v20, v21, v22) --[[ Line: 23 ]]
	-- upvalues: v0 (copy), v8 (ref), v7 (ref), v9 (ref)
	v0.GUI = v14;
	v0.RecipesFrame = v15;
	v0.NewRecipeFrame = v16;
	v0.ActionNav = v17;
	v0.SalvageInventoryFrame = v18;
	v0.NewItemFrame = v19;
	v0.SalvageConfirmFrame = v20;
	v0.SalvageGUI = v21;
	v0.SalvageConfirmButton = v22;
	v8 = nil;
	v7 = nil;
	v9 = v0.SalvageConfirmButton.MouseButton1Click:connect(v0.ActionConfirmButtonFunction);
end;
v0.CraftConfirm = function() --[[ Line: 40 ]]

end;
v0.SalvageConfirm = function() --[[ Line: 41 ]]

end;
v0.SetCraftConfirmButton = function(v23) --[[ Line: 43 ]]
	-- upvalues: v0 (copy)
	v0.CraftConfirm = v23;
end;
v0.SetSalvageConfirmButton = function(v24) --[[ Line: 47 ]]
	-- upvalues: v0 (copy)
	v0.SalvageConfirm = v24;
end;
v0.ChangeMode = function(v25, v26) --[[ Line: 51 ]]
	-- upvalues: v0 (copy), v8 (ref), v7 (ref)
	v0.Mode = v25;
	if v26 then
		v0.ActionNav.Confirm.Style = v25 == "Salvage" and (v8 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton) or v7 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
	end;
end;
v0.CheckHasRecipe = function(v27) --[[ Line: 61 ]]
	-- upvalues: l_Sync_0 (copy), v0 (copy), l_ProfileData_0 (copy)
	local v28 = 0;
	local v29 = 0;
	local v30 = 0;
	local v31 = {};
	if l_Sync_0.Recipes[v27].CombinationRecipe then
		local v32 = false;
		for v33, v34 in pairs(l_Sync_0.Recipes) do
			if v34.CombinedRecipe == v27 then
				local v35, _ = v0.CheckHasRecipe(v33);
				if v35 then
					return true, true;
				elseif v32 then
					v32 = true;
				end;
			end;
		end;
		return false, v32;
	else
		for v37, v38 in pairs(l_Sync_0.Recipes[v27].Materials) do
			v30 = v30 + 1;
			if l_ProfileData_0.Materials.Owned[v37] and l_ProfileData_0.Materials.Owned[v37] > 0 then
				v28 = v28 + 1;
				v31[v37] = "Has";
				if v38 <= l_ProfileData_0.Materials.Owned[v37] then
					v29 = v29 + 1;
					v31[v37] = "Completed";
				end;
			end;
		end;
		local v39 = v30 <= v29;
		local v40 = v28 > 0;
		local v41 = false;
		if v28 > 0 then
			v41 = not (v30 <= v29);
		end;
		return v39, v40, v41, v31;
	end;
end;
v0.GetRecipes = function() --[[ Line: 105 ]]
	-- upvalues: l_Sync_0 (copy), v0 (copy)
	local v42 = {};
	for v43, v44 in pairs(l_Sync_0.Recipes) do
		if v44.CombinedRecipe then
			if v42[v44.CombinedRecipe] then
				v42[v44.CombinedRecipe][v43] = v44;
			else
				v42[v44.CombinedRecipe] = {
					[v43] = v44
				};
			end;
		end;
	end;
	local v45 = {};
	for v46, v47 in pairs(l_Sync_0.Recipes) do
		if not v47.CombinedRecipe then
			table.insert(v45, {
				ID = v46, 
				Data = v47
			});
		end;
	end;
	for v48, v49 in pairs(v42) do
		for v50, v51 in pairs(v45) do
			if v51.ID == v48 then
				local v52 = {};
				for v53, v54 in pairs(v49) do
					table.insert(v52, {
						ID = v53, 
						Data = v54
					});
				end;
				table.sort(v52, function(v55, v56) --[[ Line: 134 ]]
					return v55.ID < v56.ID;
				end);
				v45[v50].Data.RecipeList = v52;
				break;
			end;
		end;
	end;
	table.sort(v45, function(v57, v58) --[[ Line: 146 ]]
		-- upvalues: v0 (ref)
		local _, _, _ = v0.CheckHasRecipe(v57.ID);
		local _, _, _ = v0.CheckHasRecipe(v58.ID);
		return v57.Data.SortPriority > v58.Data.SortPriority;
	end);
	return v45;
end;
v0.MakeMaterialFrame = function(v65, v66, v67, v68, v69) --[[ Line: 161 ]]
	-- upvalues: v0 (copy), l_ProfileData_0 (copy)
	v67.Visible = true;
	local v70 = v67:FindFirstChild("Container") or v67;
	v70.Icon.Image = v66.Image;
	if v69 then
		local _, _, _, v74 = v0.CheckHasRecipe(v69);
		local v75 = l_ProfileData_0.Materials.Owned[v65] and l_ProfileData_0.Materials.Owned[v65] > 0;
		v70.Amount.Text = v75 and l_ProfileData_0.Materials.Owned[v65] .. "/" .. v68 or "x" .. v68;
		v70.BorderColor3 = v74[v65] == "Completed" and Color3.new(0, 140, 0) or v74[v65] == "Has" and Color3.new(1, 1, 0) or Color3.new(0, 0, 0);
		v70.BorderSizePixel = v74[v65] and 2 or 0;
		return;
	elseif tonumber(v68) then
		v70.Amount.Text = "x" .. v68;
		return;
	else
		v70.Amount.Text = v68[1] ~= v68[2] and v68[1] .. "-" .. v68[2] or v68[1];
		return;
	end;
end;
v0.MakeMaterialFrames = function(v76, v77, v78) --[[ Line: 183 ]]
	-- upvalues: l_Sync_0 (copy), v0 (copy)
	local v79 = l_Sync_0.Recipes[v76];
	local v80 = 1;
	for v81, v82 in pairs(v79.Materials) do
		local v83 = v77["Material" .. v80];
		local v84 = l_Sync_0.Materials[v81];
		v0.MakeMaterialFrame(v81, v84, v83, v82, v78 and v76 or nil);
		v80 = v80 + 1;
	end;
end;
v0.ActionConfirmButtonFunction = function() --[[ Line: 200 ]]
	-- upvalues: v0 (copy), v7 (ref), v8 (ref)
	print("pressed");
	local v85 = v0.Mode == "Craft";
	local v86 = nil;
	v86 = if v85 then v7 else v8;
	print(v86, v7, v8, v0.Mode);
	if v86 then
		v0[v0.Mode](v86);
	end;
end;
v0.UpdateCraftConfirm = function(v87, _, v89) --[[ Line: 222 ]]
	-- upvalues: v0 (copy), v7 (ref), l_Sync_0 (copy), v6 (copy)
	local l_Action_0 = v0.GUI.Action;
	local l_Craft_0 = l_Action_0.Craft;
	if not v87 or v89 then
		for _, v93 in pairs(l_Craft_0.Recipe:GetChildren()) do
			v93.Container.Icon.Image = "";
			v93.Container.Amount.Text = "";
		end;
		l_Craft_0.Reward.Container.Icon.Image = "";
		l_Craft_0.Reward.Container.Amount.Text = "";
		l_Craft_0.Reward.Container.ItemName.Text = "";
		l_Action_0.Confirm.Style = Enum.ButtonStyle.RobloxRoundButton;
		v7 = nil;
		return;
	else
		local v94 = l_Sync_0.Recipes[v87];
		local _ = v0.CheckHasRecipe(v87);
		v0.MakeMaterialFrames(v87, l_Craft_0.Recipe);
		local v96 = {
			ItemID = v94.RewardItem or v94
		};
		v6.MakeItemFrame(l_Craft_0.Reward.Container, v96);
		l_Action_0.Confirm.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
		v7 = v87;
		return;
	end;
end;
local _ = {};
v0.UpdateCraftConfirmMobile = function(_, v99, v100) --[[ Line: 260 ]]
	-- upvalues: v0 (copy)
	if v100 == nil then
		v100 = not v99.Result.Confirm.Visible;
	end;
	if v100 == true then
		for _, v102 in pairs(v0.RecipesFrame.Container:GetChildren()) do
			if v102 ~= v99 then
				v0.UpdateCraftConfirmMobile(nil, v102, false);
			end;
		end;
	end;
	if v99 then
		v99.Result.Confirm.Visible = v100;
		v99.Result.Container.Craft.Text = v100 and "Cancel" or "Craft";
		v99.Result.Container.Craft.TextColor3 = v100 and Color3.new(1, 1, 1) or Color3.fromRGB(159, 255, 130);
	end;
end;
v0.CheckSalvageable = function(v103) --[[ Line: 282 ]]
	-- upvalues: l_Sync_0 (copy), v11 (copy)
	if not v103 then
		return false;
	else
		local v104 = l_Sync_0.SalvageRewards[v103] or l_Sync_0.SalvageRewards[l_Sync_0.Item[v103].Rarity];
		local v105 = v104 and v104.Rewards;
		return not v11[v103] and (not (l_Sync_0.Item[v103].Event ~= nil) or l_Sync_0.SalvageRewards[v103] ~= nil) and l_Sync_0.Item[v103].Season == nil and l_Sync_0.Item[v103].ItemType ~= "Misc" and v105 and v105 or false;
	end;
end;
v0.ShowSalvageRewards = function(v106) --[[ Line: 297 ]]
	-- upvalues: v0 (copy), v6 (copy), l_Rarity_0 (copy), l_Sync_0 (copy), v8 (ref)
	local v107 = v0.CheckSalvageable(v106);
	v6.MakeItemFrame(v0.SalvageConfirmFrame, {
		ItemID = v106
	});
	v0.SalvageConfirmFrame.Icon.ItemName.TextColor3 = v107 and l_Rarity_0[l_Sync_0.Item[v106].Rarity] or Color3.new(0.5, 0.5, 0.5);
	v0.SalvageConfirmFrame.Icon.ImageColor3 = v107 and Color3.new(1, 1, 1) or Color3.new(0.2, 0.2, 0.2);
	local v108 = v0.SalvageConfirmFrame:FindFirstChild("Rewards") or v0.SalvageConfirmFrame;
	for _, v110 in pairs(v108:GetChildren()) do
		v110.Visible = false;
	end;
	print((tostring(v107)));
	if v107 then
		v8 = v106;
		local v111 = 1;
		for v112, v113 in pairs(v107) do
			local v114 = v108["Material" .. v111];
			v0.MakeMaterialFrame(v112, l_Sync_0.Materials[v112], v114, v113.Amount);
			v111 = v111 + 1;
		end;
		print((tostring(v8)));
	else
		v8 = nil;
	end;
	v0.SalvageConfirmButton.Style = v8 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
end;
v0.SalvageConfirmMobile = function(v115, v116) --[[ Line: 326 ]]
	-- upvalues: v0 (copy)
	local v117 = not v116.Cancel.Visible;
	for _, v119 in pairs(v0.SalvageInventoryFrame.Container:GetChildren()) do
		v119.Container.Cancel.Visible = false;
		v119.Container.BackgroundColor3 = Color3.fromRGB(54, 54, 54);
	end;
	v116.Cancel.Visible = v117;
	v116.BackgroundColor3 = v117 and Color3.fromRGB(130, 130, 130) or Color3.fromRGB(54, 54, 54);
	if v117 then
		v0.ShowSalvageRewards(v115);
	else
		v0.ShowSalvageRewards(nil);
	end;
	v0.SalvageConfirmFrame.Visible = v117;
end;
v0.MakeSalvageItemFrame = function(v120, v121) --[[ Line: 347 ]]
	-- upvalues: v6 (copy), v0 (copy)
	v6.MakeItemFrame(v120, v121);
	local l_ItemID_0 = v121.ItemID;
	local v123 = v0.CheckSalvageable(l_ItemID_0);
	v120.Container.Cover.Visible = not v123;
	if v120.Container:FindFirstChild("Cancel") then
		v120.Container.Cancel.MouseButton1Click:connect(function() --[[ Line: 356 ]]
			-- upvalues: v120 (copy), v0 (ref)
			v120.Container.Cancel.Visible = false;
			v120.Container.BackgroundColor3 = Color3.fromRGB(54, 54, 54);
			v0.SalvageConfirmFrame.Visible = false;
		end);
	end;
	v120.Container.Button.MouseButton1Click:connect(function() --[[ Line: 364 ]]
		-- upvalues: v0 (ref), l_ItemID_0 (copy), v120 (copy)
		v0.SalvageConfirm(l_ItemID_0, v120.Container);
	end);
end;
v0.CreateRecipeFrame = function(v124, v125, _) --[[ Line: 370 ]]
	-- upvalues: l_Sync_0 (copy), l_Rarity_0 (copy), v0 (copy)
	local l_Data_0 = v125.Data;
	local l_ID_0 = v125.ID;
	local _ = l_Sync_0.Materials;
	if not l_Data_0.CombinationRecipe then
		v124.RecipeName.Text = l_Data_0.Name;
		v124.RecipeName.TextColor3 = l_Rarity_0[l_Data_0.Rarity];
		v124.Result.Container.Icon.Image = l_Data_0.Image;
		v0.MakeMaterialFrames(l_ID_0, v124.Materials, true);
		local v130, v131, _ = v0.CheckHasRecipe(l_ID_0);
		if v130 then
			v124.Complete.Visible = true;
			v124.Result.Container.Craft.Visible = true;
			v124.Result.Container.Craft.MouseButton1Click:connect(function() --[[ Line: 391 ]]
				-- upvalues: v0 (ref), l_ID_0 (copy), v124 (copy)
				v0.CraftConfirm(l_ID_0, v124);
			end);
		elseif v131 then
			v124.InProgress.Visible = true;
		end;
		if v124.Result:FindFirstChild("Confirm") then
			v124.Result.Confirm.MouseButton1Click:connect(function() --[[ Line: 401 ]]
				-- upvalues: v0 (ref), l_ID_0 (copy)
				v0.Craft(l_ID_0, true);
			end);
		end;
		v124.Missing.Visible = not v131;
	end;
end;
v0.GenerateSalvageInventory = function() --[[ Line: 410 ]]
	-- upvalues: v6 (copy), v0 (copy)
	v6.CreateGrid(v0.MakeSalvageItemFrame, v0.NewItemFrame, v6.GetSortedInventory(), v0.SalvageInventoryFrame);
end;
v0.GenerateRecipes = function() --[[ Line: 415 ]]
	-- upvalues: v6 (copy), v0 (copy)
	v6.CreateList(v0.CreateRecipeFrame, v0.NewRecipeFrame, v0.GetRecipes(), v0.RecipesFrame);
end;
game.ReplicatedStorage.Remotes.Inventory.InventoryDataChanged.Event:Connect(function(v133, _, _) --[[ Line: 419 ]]
	-- upvalues: v0 (copy)
	if v133 == "Weapons" then
		v0.GenerateSalvageInventory();
	end;
end);
game.ReplicatedStorage.Remotes.Inventory.UpdateSalvageClient.Event:connect(function() --[[ Line: 424 ]]

end);
v0.Salvage = function() --[[ Line: 436 ]]
	-- upvalues: v0 (copy), v8 (ref), v6 (copy), l_Sync_0 (copy), l_Rarity_0 (copy)
	local l_SalvageGUI_0 = v0.SalvageGUI;
	l_SalvageGUI_0.Claim.Style = Enum.ButtonStyle.RobloxRoundButton;
	l_SalvageGUI_0.Claim.Text = "Salvaging...";
	v0.GUI.Visible = false;
	_G.Process("Salvaging");
	local v137 = time();
	local v138 = game.ReplicatedStorage.Remotes.Inventory.Salvage:InvokeServer(v8);
	local l_v8_0 = v8;
	v8 = nil;
	v0.ShowSalvageRewards(nil);
	v0.GenerateSalvageInventory();
	v0.GenerateRecipes();
	local l_Container_0 = l_SalvageGUI_0.Main.Item1.Container;
	local l_Container_1 = l_SalvageGUI_0.Main.Item2.Container;
	local l_Container_2 = l_SalvageGUI_0.Main.Item3.Container;
	l_Container_0.Icon.Image = "";
	l_Container_0.ItemName.Text = "";
	l_Container_1.Icon.Image = "";
	l_Container_1.ItemName.Text = "";
	l_Container_2.Icon.Image = "";
	l_Container_2.ItemName.Text = "";
	wait(0.75 - (time() - v137));
	if v138 then
		_G.Process(nil);
		l_Container_0.Icon.Image = v6.GetImage(l_Sync_0.Item[l_v8_0].Image);
		l_Container_0.ItemName.Text = l_Sync_0.Item[l_v8_0].ItemName;
		l_Container_0.ItemName.TextColor3 = l_Rarity_0[l_Sync_0.Item[l_v8_0].Rarity];
		l_SalvageGUI_0.Visible = true;
		wait(0.5);
		l_Container_0.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		l_Container_1.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		l_Container_2.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		wait(0.5);
		for v143, v144 in pairs(v138) do
			local l_Container_3 = l_SalvageGUI_0.Main["Item" .. v143].Container;
			l_Container_3.Icon.Image = l_Sync_0.Materials[v144.ID].Image;
			l_Container_3.ItemName.Text = l_Sync_0.Materials[v144.ID].Name .. " [x" .. v144.Amount .. "]";
			l_Container_3.ItemName.TextColor3 = l_Rarity_0[l_Sync_0.Materials[v144.ID].Rarity];
		end;
		l_Container_0.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		l_Container_1.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		l_Container_2.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		wait(0.4);
		l_SalvageGUI_0.Claim.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
		l_SalvageGUI_0.Claim.Text = "Claim!";
	end;
end;
v0.Craft = function(v146, _) --[[ Line: 499 ]]
	-- upvalues: v0 (copy), l_ItemPopupService_0 (copy)
	v0.GUI.Visible = false;
	_G.Process("Crafting");
	local v148 = time();
	local v149, v150, v151 = game.ReplicatedStorage.Remotes.Inventory.Craft:InvokeServer(v146);
	v0.GenerateRecipes();
	if not v0.CheckHasRecipe(v146) then
		v0.CraftConfirm(nil, nil, true);
	end;
	wait(0.75 - (time() - v148));
	_G.Process(nil);
	v0.GUI.Visible = true;
	if _G.ViewLobbyFrame ~= nil then
		_G.ViewLobbyFrame("Inventory");
	end;
	if v149 then
		l_ItemPopupService_0:AddNewItem(v149, v151, v150);
	end;
	game.ReplicatedStorage.Remotes.Inventory.UpdateSalvageClient:Fire();
end;
return v0;