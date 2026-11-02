-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = {
	Classic = 1, 
	Common = 2, 
	Uncommon = 3, 
	Rare = 4, 
	Legendary = 5, 
	Godly = 6, 
	Mythic = 6.6, 
	Exotic = 6.8, 
	Custom = 10, 
	Victim = 7, 
	Unique = 7, 
	Christmas = 1.5, 
	Halloween = 1.6, 
	Ancient = 6.5
	
};
v1.GUI = nil;
v1.Mode = "Craft";
local u1 = nil;
local u2 = nil;
local u3 = nil;
function v1.SetCraftGUI(p1, p2, p3, p4, p5, p6, p7, p8, p9)
	v1.GUI = p1;
	v1.RecipesFrame = p2;
	v1.NewRecipeFrame = p3;
	v1.ActionNav = p4;
	v1.SalvageInventoryFrame = p5;
	v1.NewItemFrame = p6;
	v1.SalvageConfirmFrame = p7;
	v1.SalvageGUI = p8;
	v1.SalvageConfirmButton = p9;
	u1 = nil;
	u2 = nil;
	u3 = v1.SalvageConfirmButton.MouseButton1Click:connect(v1.ActionConfirmButtonFunction);
end;
function v1.CraftConfirm()

end;
function v1.SalvageConfirm()

end;
function v1.SetCraftConfirmButton(p10)
	v1.CraftConfirm = p10;
end;
function v1.SetSalvageConfirmButton(p11)
	v1.SalvageConfirm = p11;
end;
function v1.ChangeMode(p12, p13)
	v1.Mode = p12;
	local v3
	if p13 then
		if p12 == "Salvage" then
			v3 = u1 and Enum.ButtonStyle.RobloxRoundDefaultButton or (Enum.ButtonStyle.RobloxRoundButton or u2 and Enum.ButtonStyle.RobloxRoundDefaultButton);
		else
			v3 = u2 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
		end;
		v1.ActionNav.Confirm.Style = v3;
	end;
end;
function v1.CheckHasRecipe(p14)
	local l__Database__4 = _G.Database;
	local v5 = 0;
	local v6 = 0;
	local v7 = 0;
	local v8 = {};
	if l__Database__4.Recipes[p14].CombinationRecipe then
		local v9 = false;
		for v10, v11 in pairs(l__Database__4.Recipes) do
			if v11.CombinedRecipe == p14 then
				local v12, v13, v14, v15 = v1.CheckHasRecipe(v10);
				if v12 then
					return true, true, v14, v15;
				end;
				if v9 then
					v9 = true;
				end;
			end;
		end;
		return false, v9;
	end;
	for v16, v17 in pairs(l__Database__4.Recipes[p14].Materials) do
		v7 = v7 + 1;
		if _G.PlayerData.Materials.Owned[v16] and _G.PlayerData.Materials.Owned[v16] > 0 then
			v5 = v5 + 1;
			v8[v16] = "Has";
			if v17 <= _G.PlayerData.Materials.Owned[v16] then
				v6 = v6 + 1;
				v8[v16] = "Completed";
			end;
		end;
	end;
	local v18 = false;
	if v5 > 0 then
		v18 = not (v7 <= v6);
	end;
	return v7 <= v6, v5 > 0, v18, v8;
end;
function v1.GetRecipes()
	local l__Database__19 = _G.Database;
	local v20 = {};
	for v21, v22 in pairs(l__Database__19.Recipes) do
		if v22.CombinedRecipe then
			if v20[v22.CombinedRecipe] then
				v20[v22.CombinedRecipe][v21] = v22;
			else
				v20[v22.CombinedRecipe] = {
					[v21] = v22
				};
			end;
		end;
	end;
	local v23 = {};
	for v24, v25 in pairs(l__Database__19.Recipes) do
		if not v25.CombinedRecipe then
			table.insert(v23, {
				ID = v24, 
				Data = v25
			});
		end;
	end;
	for v29, v30 in pairs(v20) do
		for v31, v32 in pairs(v23) do
			if v32.ID == v29 then
				local v33 = {};
				for v34, v35 in pairs(v30) do
					table.insert(v33, {
						ID = v34, 
						Data = v35
					});
				end;
				table.sort(v33, function(p15, p16)
					return p15.ID < p16.ID;
				end);
				v23[v31].Data.RecipeList = v33;
				break;
			end;
		end;	
	end;
	table.sort(v23, function(p17, p18)
		local v36, v37, v38 = v1.CheckHasRecipe(p17.ID);
		local v39, v40, v41 = v1.CheckHasRecipe(p18.ID);
		return p18.Data.SortPriority < p17.Data.SortPriority;
	end);
	return v23;
end;
function v1.MakeMaterialFrame(p19, p20, p21, p22, p23)
	p21.Visible = true;
	local v42 = p21:FindFirstChild("Container") or p21;
	v42.Icon.Image = p20.Image;
	if not p23 then
		if tonumber(p22) then
			v42.Amount.Text = "x" .. p22;
			return;
		else
			v42.Amount.Text = p22[1] ~= p22[2] and p22[1] .. "-" .. p22[2] or p22[1];
			return;
		end;
	end;
	local v43, v44, v45, v46 = v1.CheckHasRecipe(p23);
	local v47
	if _G.PlayerData.Materials.Owned[p19] then
		v47 = _G.PlayerData.Materials.Owned[p19] > 0 and _G.PlayerData.Materials.Owned[p19] .. "/" .. p22 or "x" .. p22;
	else
		v47 = "x" .. p22;
	end;
	v42.Amount.Text = v47;
	v42.BorderColor3 = Color3.new(0, 0, 0);
end;
function v1.MakeMaterialFrames(p24, p25, p26, p27)
	local v48 = 1;
	if p27 then
		for v49, v50 in pairs(p24) do
			v1.MakeMaterialFrame(v49, _G.Database.Materials[v49], p25["Material" .. v48], v50, p26 and nil);
			v48 = v48 + 1;
		end;
		return;
	end;
	for v51, v52 in pairs(_G.Database.Recipes[p24].Materials) do
		v1.MakeMaterialFrame(v51, _G.Database.Materials[v51], p25["Material" .. v48], v52, p26 and p24 or nil);
		v48 = v48 + 1;
	end;
end;
function v1.ActionConfirmButtonFunction()
	local v53
	if v1.Mode == "Craft" then
		v53 = u2;
	else
		v53 = u1;
	end;
	if v53 then
		v1[v1.Mode](v53);
	end;
end;
local u4 = require(game.ReplicatedStorage.Modules.GridCreator);
function v1.UpdateCraftConfirm(p28, p29, p30, p31)
	local l__Action__54 = v1.GUI.Action;
	local l__Craft__55 = l__Action__54.Craft;
	if not p28 or not (not p30) then
		for v56, v57 in pairs(l__Craft__55.Recipe:GetChildren()) do
			v57.Container.Icon.Image = "";
			v57.Container.Amount.Text = "";
		end;
		l__Craft__55.Reward.Container.Icon.Image = "";
		l__Craft__55.Reward.Container.Amount.Text = "";
		l__Craft__55.Reward.Container.ItemName.Text = "";
		l__Action__54.Confirm.Style = Enum.ButtonStyle.RobloxRoundButton;
		u2 = nil;
		return;
	end;
	local v58 = _G.Database.Recipes[p28];
	local v59 = v1.CheckHasRecipe(p28);
	if p31 then
		v1.MakeMaterialFrames(p31, l__Craft__55.Recipe, v58.CombinedRecipe and v58.Materials or nil, p31);
	else
		v1.MakeMaterialFrames(p28, l__Craft__55.Recipe, v58.CombinedRecipe and v58.Materials or nil, p31);
	end;
	u4.MakeItemFrame(l__Craft__55.Reward.Container, {
		ItemID = v58.RewardItem or v58
	});
	l__Action__54.Confirm.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
	if p31 then
		u2 = p31;
		return;
	end;
	u2 = v58.Materials;
end;
local v60 = {};
function v1.UpdateCraftConfirmMobile(p32, p33, p34, p35)
	if p34 == nil then
		p34 = not p33.Result.Confirm.Visible;
	end;
	if p34 == true then
		for v61, v62 in pairs(v1.RecipesFrame.Container:GetChildren()) do
			if v62 ~= p33 then
				v1.UpdateCraftConfirmMobile(nil, v62, false);
			end;
		end;
	end;
	if p33 then
		p33.Result.Confirm.Visible = p34;
		local v63
		if p34 then
			v63 = "Cancel";
		else
			v63 = "Craft";
		end;
		p33.Result.Container.Craft.Text = v63;
		p33.Result.Container.Craft.TextColor3 = p34 and Color3.new(1, 1, 1) or Color3.fromRGB(159, 255, 130);
	end;
end;
local u5 = {};
function v1.CheckSalvageable(p36)
	if not p36 then
		return false;
	end;
	local v64 = _G.Database.SalvageRewards[p36] or _G.Database.SalvageRewards[_G.Database.Item[p36].Rarity];
	--[[if _G.Database.Item[p36].Chroma then
		v64 = _G.Database.SalvageRewards.Chroma;
	end;]]
	local v65 = v64 and v64.Rewards;
	local v66 = not u5[p36];
	if v66 then
		if _G.Database.Item[p36].Event ~= nil then
			v66 = false;
			if _G.Database.SalvageRewards[p36] ~= nil then
				v66 = false;
				if _G.Database.Item[p36].Galaxy == nil then
					v66 = false;
					if _G.Database.Item[p36].ItemType ~= "Misc" then
						v66 = v65;
					end;
				end;
			end;
		else
			v66 = false;
			if _G.Database.Item[p36].Galaxy == nil then
				v66 = false;
				if _G.Database.Item[p36].ItemType ~= "Misc" then
					v66 = v65;
				end;
			end;
		end;
	end;
	return v66 and v65 or false;
end;
local u6 = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity");
function v1.ShowSalvageRewards(p37)
	local v67 = v1.CheckSalvageable(p37);
	u4.MakeItemFrame(v1.SalvageConfirmFrame, {
		ItemID = p37
	});
	v1.SalvageConfirmFrame.Icon.ItemName.TextColor3 = v67 and u6[_G.Database.Item[p37].Rarity] or Color3.new(0.5, 0.5, 0.5);
	v1.SalvageConfirmFrame.Icon.ImageColor3 = v67 and Color3.new(1, 1, 1) or Color3.new(0.2, 0.2, 0.2);
	local v68 = v1.SalvageConfirmFrame:FindFirstChild("Rewards") or v1.SalvageConfirmFrame;
	for v69, v70 in pairs(v68:GetChildren()) do
		v70.Visible = false;
	end;
	if v67 then
		u1 = p37;
		local v71 = 1;
		for v72, v73 in pairs(v67) do
			v1.MakeMaterialFrame(v72, _G.Database.Materials[v72], v68["Material" .. v71], v73.Amount);
			v71 = v71 + 1;
		end;
	else
		u1 = nil;
	end;
	v1.SalvageConfirmButton.Style = u1 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
end;
function v1.SalvageConfirmMobile(p38, p39)
	local v74 = not p39.Cancel.Visible;
	for v75, v76 in pairs(v1.SalvageInventoryFrame.Container:GetChildren()) do
		v76.Container.Cancel.Visible = false;
		v76.Container.BackgroundColor3 = Color3.fromRGB(54, 54, 54);
	end;
	p39.Cancel.Visible = v74;
	p39.BackgroundColor3 = v74 and Color3.fromRGB(130, 130, 130) or Color3.fromRGB(54, 54, 54);
	if v74 then
		v1.ShowSalvageRewards(p38);
	else
		v1.ShowSalvageRewards(nil);
	end;
	v1.SalvageConfirmFrame.Visible = v74;
end;
function v1.MakeSalvageItemFrame(p40, p41)
	u4.MakeItemFrame(p40, p41);
	local l__ItemID__77 = p41.ItemID;
	p40.Container.Cover.Visible = not v1.CheckSalvageable(l__ItemID__77);
	if p40.Container:FindFirstChild("Cancel") then
		p40.Container.Cancel.MouseButton1Click:connect(function()
			p40.Container.Cancel.Visible = false;
			p40.Container.BackgroundColor3 = Color3.fromRGB(54, 54, 54);
			v1.SalvageConfirmFrame.Visible = false;
		end);
	end;
	p40.Container.Button.MouseButton1Click:connect(function()
		v1.SalvageConfirm(l__ItemID__77, p40.Container);
	end);
end;
function v1.CreateRecipeFrame(p42, p43, p44)
	local l__Data__78 = p43.Data;
	local l__ID__79 = p43.ID;
	local l__Materials__80 = _G.Database.Materials;
	if not l__Data__78.CombinationRecipe then
		p42.RecipeName.Text = l__Data__78.Name;
		p42.RecipeName.TextColor3 = u6[l__Data__78.Rarity];
		p42.Result.Container.Icon.Image = l__Data__78.Image;
		v1.MakeMaterialFrames(l__ID__79, p42.Materials, true);
		local v81, v82, v83 = v1.CheckHasRecipe(l__ID__79);
		if v81 then
			p42.Complete.Visible = true;
			p42.Result.Container.Craft.Visible = true;
			p42.Result.Container.Craft.MouseButton1Click:connect(function()
				v1.CraftConfirm(l__ID__79, p42);
			end);
		elseif v82 then
			p42.InProgress.Visible = true;
		end;
		if p42.Result:FindFirstChild("Confirm") then
			p42.Result.Confirm.MouseButton1Click:connect(function()
				v1.Craft(p43.Data.Materials, true);
			end);
		end;
		p42.Missing.Visible = not v82;
		return;
	end;
	local l__Data__84 = (l__Data__78.RecipeList[0 + 1] or l__Data__78.RecipeList[1]).Data;
	p42.RecipeName.Text = l__Data__78.Name;
	p42.RecipeName.TextColor3 = u6[l__Data__84.Rarity];
	p42.Result.Container.Icon.Image = l__Data__84.Image;
	local v85, v86, v87 = v1.CheckHasRecipe(l__ID__79);
	v1.MakeMaterialFrames(l__Data__84.Materials, p42.Materials, l__ID__79, true);
	if v85 then
		p42.Complete.Visible = true;
		p42.Result.Container.Craft.Visible = true;
		p42.Result.Container.Craft.MouseButton1Click:connect(function()
			v1.CraftConfirm(l__ID__79, p42, nil, l__Data__84.Materials);
		end);
	elseif v86 then
		p42.InProgress.Visible = true;
	end;
	if p42.Result:FindFirstChild("Confirm") then
		p42.Result.Confirm.MouseButton1Click:connect(function()
			v1.Craft(p43.Data.Materials, true);
		end);
	end;
	p42.Missing.Visible = not v86;
end;
function v1.GenerateSalvageInventory()
	u4.CreateGrid(v1.MakeSalvageItemFrame, v1.NewItemFrame, u4.GetSortedInventory(), v1.SalvageInventoryFrame);
end;
function v1.GenerateRecipes()
	u4.CreateList(v1.CreateRecipeFrame, v1.NewRecipeFrame, v1.GetRecipes(), v1.RecipesFrame);
end;
game.ReplicatedStorage.UpdateSalvageClient.Event:connect(function()
	v1.GenerateSalvageInventory();
end);
function v1.Salvage()
	local l__SalvageGUI__88 = v1.SalvageGUI;
	l__SalvageGUI__88.Claim.Style = Enum.ButtonStyle.RobloxRoundButton;
	l__SalvageGUI__88.Claim.Text = "Salvaging...";
	v1.GUI.Visible = false;
	_G.Process("Salvaging");
	local v89 = time();
	local v90 = game.ReplicatedStorage.Remotes.Inventory.Salvage:InvokeServer(u1);
	game.ReplicatedStorage.UpdateSalvageClient:Fire();
	v1.ShowSalvageRewards(u1);
	v1.GenerateSalvageInventory();
	v1.GenerateRecipes();
	local l__Container__91 = l__SalvageGUI__88.Main.Item1.Container;
	local l__Container__92 = l__SalvageGUI__88.Main.Item2.Container;
	local l__Container__93 = l__SalvageGUI__88.Main.Item3.Container;
	l__Container__91.Icon.Image = "";
	l__Container__91.ItemName.Text = "";
	l__Container__92.Icon.Image = "";
	l__Container__92.ItemName.Text = "";
	l__Container__93.Icon.Image = "";
	l__Container__93.ItemName.Text = "";
	wait(0.75 - (time() - v89));
	if v90 then
		_G.Process(nil);
		l__Container__91.Icon.Image = u4.GetImage(_G.Database.Weapons[u1].Image);
		l__Container__91.ItemName.Text = _G.Database.Weapons[u1].ItemName;
		l__Container__91.ItemName.TextColor3 = u6[_G.Database.Weapons[u1].Rarity];
		l__SalvageGUI__88.Visible = true;
		wait(0.5);
		l__Container__91.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		l__Container__92.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		l__Container__93.Slider:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2);
		wait(0.5);
		for v94, v95 in pairs(v90) do
			local l__Container__96 = l__SalvageGUI__88.Main["Item" .. v94].Container;
			l__Container__96.Icon.Image = _G.Database.Materials[v95.ID].Image;
			l__Container__96.ItemName.Text = _G.Database.Materials[v95.ID].Name .. " [x" .. v95.Amount .. "]";
			l__Container__96.ItemName.TextColor3 = u6[_G.Database.Materials[v95.ID].Rarity];
		end;
		l__Container__91.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		l__Container__92.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		l__Container__93.Slider:TweenPosition(UDim2.new(0, 0, -1, 0), "Out", "Quad", 0.2);
		wait(0.4);
		l__SalvageGUI__88.Claim.Style = Enum.ButtonStyle.RobloxRoundDefaultButton;
		l__SalvageGUI__88.Claim.Text = "Claim!";
	end;
	v1.ShowSalvageRewards(nil);
end;
function v1.Craft(p45, p46)
	v1.GUI.Visible = false;
	_G.Process("Crafting");
	local v97 = time();
	local v98, v99, v100 = game.ReplicatedStorage.Remotes.Inventory.Craft:InvokeServer(p45);
	v1.GenerateRecipes();
	v1.CraftConfirm(nil, nil, true);
	wait(0.75 - (time() - v97));
	_G.Process(nil);
	v1.GUI.Visible = true;
	if _G.ViewLobbyFrame ~= nil then
		_G.ViewLobbyFrame("Inventory");
	end;
	if v98 then
		_G.NewItem(v98, "You Crafted...", v1.GUI, v100);
	end;
	game.ReplicatedStorage.UpdateSalvageClient:Fire();
end;
return v1;

