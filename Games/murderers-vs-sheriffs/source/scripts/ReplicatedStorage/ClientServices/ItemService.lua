-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local v2 = Color3.fromRGB(95, 95, 95);
local l_ItemFrame_0 = script:WaitForChild("ItemFrame");
local _ = script:WaitForChild("MiniItemFrame");
local v5 = {
	Unique = 100000, 
	Ancient = 200000, 
	Godly = 300000, 
	Legendary = 400000, 
	Rare = 500000, 
	Uncommon = 600000, 
	Common = 700000
};
v0.BaseItemFrame = l_ItemFrame_0;
local function v11(v6) --[[ Line: 44 ]] --[[ Name: GetItemNameOrder ]]
	local v7 = string.lower(v6);
	local v8 = 0;
	for v9 = 1, math.min(#v7, 3) do
		local v10 = string.byte(v7, v9) - 97 + 1;
		v8 = v8 * 26 + v10;
	end;
	return v8;
end;
v0.FindItemInfo = function(_, v13, v14) --[[ Line: 58 ]] --[[ Name: FindItemInfo ]]
	-- upvalues: l_Sync_0 (copy)
	if not l_Sync_0[v14] then
		return nil;
	else
		local _ = nil;
		if v14 == "Emotes" then
			return l_Sync_0.Emotes[v13] or l_Sync_0.Toys[v13];
		else
			return l_Sync_0[v14][v13];
		end;
	end;
end;
v0.GetItemInfo = function(_, v17, v18)
	local v19
	local category = v18 or "Weapons"

	if not l_Sync_0[category] then
		if l_Sync_0.Weapons[v17] then
			category = "Weapons"
		elseif l_Sync_0.Effects[v17] then
			category = "Effects"
		elseif l_Sync_0.Perks[v17] then
			category = "Perks"
		elseif l_Sync_0.Emotes[v17] then
			category = "Emotes"
		elseif l_Sync_0.Radios[v17] then
			category = "Radios"
		elseif l_Sync_0.Pets[v17] then
			category = "Pets"
		else
			warn("ItemService: Unknown category for item: " .. tostring(v17))
			return l_Sync_0.Materials.ErrorItem
		end
	end
	v19 = if category == "Emotes" then l_Sync_0.Emotes[v17] or l_Sync_0.Toys[v17] else l_Sync_0[category][v17]
	if v19 then
		return v19
	else
		warn("ItemService: Failed to find data for item: " .. tostring(v17) .. ", " .. tostring(category))
		return l_Sync_0.Materials.ErrorItem
	end
end


v0.ItemExists = function(_, v21, v22) --[[ Line: 88 ]] --[[ Name: ItemExists ]]
	-- upvalues: l_Sync_0 (copy)
	return l_Sync_0[v22][v21] ~= nil;
end;
v0.GetRarityColor = function(_, v24) --[[ Line: 93 ]] --[[ Name: GetRarityColor ]]
	-- upvalues: v2 (copy), l_Sync_0 (copy)
	local l_Rarity_0 = v24.Rarity;
	if l_Rarity_0 == "Common" or l_Rarity_0 == nil then
		return v2;
	else
		return l_Sync_0.Rarity[l_Rarity_0];
	end;
end;
v0.GetDisplayInfo = function(_, v27, v28) --[[ Line: 102 ]] --[[ Name: GetDisplayInfo ]]
	-- upvalues: v0 (copy)
	local l_v0_ItemInfo_0 = v0:GetItemInfo(v27, v28);
	return {
		Name = v0:GetDisplayName(l_v0_ItemInfo_0), 
		Image = v0:GetItemImage(l_v0_ItemInfo_0), 
		Color = v0:GetRarityColor(l_v0_ItemInfo_0)
	};
end;
v0.GetDisplayName = function(_, v31) --[[ Line: 112 ]] --[[ Name: GetDisplayName ]]
	return v31.Name or v31.DisplayName or v31.ItemName;
end;
v0.GetItemImage = function(_, v33) --[[ Line: 117 ]] --[[ Name: GetItemImage ]]
	local v34 = v33.Image or v33.Icon;
	local v35 = tonumber(v34);
	if v35 then
		return "rbxthumb://type=Asset&w=150&h=150&id=" .. v35;
	elseif typeof(v34) == "string" then
		return v34;
	else
		return "";
	end;
end;
v0.GetAmountText = function(_, v37) --[[ Line: 129 ]] --[[ Name: GetAmountText ]]
	return v37 > 1 and "x" .. v37 or "";
end;
v0.GetLayoutOrder = function(_, v39, v40) --[[ Line: 134 ]] --[[ Name: GetLayoutOrder ]]
	-- upvalues: v0 (copy), v5 (copy), v11 (copy)
	if v40 == "DefaultKnife" then
		return 0;
	elseif v40 == "DefaultGun" then
		return 1;
	else
		local l_v0_ItemInfo_1 = v0:GetItemInfo(v39, v40);
		local l_Rarity_1 = l_v0_ItemInfo_1.Rarity;
		local v43 = v0:GetDisplayName(l_v0_ItemInfo_1) or "";
		return (v5[l_Rarity_1] or v5.Common) + v11(v43);
	end;
end;
v0.UpdateTags = function(_, v45, v46) --[[ Line: 149 ]] --[[ Name: UpdateTags ]]
	local v47 = v46 or {};
	v45.Tags.Chroma.Visible = v47.Chroma == true;
	v45.Tags.FX.Visible = v47.FX == true;
	v45.Tags.Evo.Visible = v47.EvoBaseID ~= nil;
	local v48 = 0;
	for _, v50 in v45.Tags:GetChildren() do
		if v50:IsA("Frame") and v50.Visible then
			v48 = v48 + 1;
		end;
	end;
	return v48;
end;
v0.ApplyTags = function(_, v52, v53) --[[ Line: 170 ]] --[[ Name: ApplyTags ]]
	-- upvalues: v0 (copy)
	if v0:UpdateTags(v52, v53) < 1 then
		v52.Tags:Destroy();
	end;
end;
v0.ApplyMiniItemFrame = function(_, v55, v56, v57) --[[ Line: 178 ]] --[[ Name: ApplyMiniItemFrame ]]
	-- upvalues: v0 (copy)
	local v58 = v57 or 1;
	if v56 == nil then
		v55.Title.Text = "";
		v55.Icon.Image = "";
		v55.Amount.Text = "";
		return;
	else
		v55.Title.Text = v0:GetDisplayName(v56);
		v55.Icon.Image = v0:GetItemImage(v56);
		v55.Amount.Text = v0:GetAmountText(v58);
		return;
	end;
end;
v0.ApplyItemToFrame = function(_, v60, v61, v62) --[[ Line: 192 ]] --[[ Name: ApplyItemToFrame ]]
	-- upvalues: l_Sync_0 (copy), v0 (copy)
	local v63 = v62 or 1;
	if v61 == nil then
		v60.ItemName.Label.Text = "";
		v60.ItemName.BackgroundColor3 = l_Sync_0.Rarity.Common;
		v60.Container.Icon.Image = "";
		v60.Container.Amount.Text = "";
		return v60;
	else
		v60.ItemName.Label.Text = v0:GetDisplayName(v61);
		v60.ItemName.BackgroundColor3 = v0:GetRarityColor(v61);
		v60.Container.Icon.Image = v0:GetItemImage(v61);
		v60.Container.Amount.Text = v0:GetAmountText(v63);
		return v60;
	end;
end;
v0.CommaNumber = function(_, v65) --[[ Line: 211 ]] --[[ Name: CommaNumber ]]
	local _ = nil;
	local v67 = tostring(v65);
	repeat
		local v68, v69 = string.gsub(v67, "^(-?%d+)(%d%d%d)", "%1,%2");
		v67 = v68;
	until v69 == 0;
	return v67;
end;
return v0;