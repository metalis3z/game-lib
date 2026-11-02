-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with the Synapse X Luau decompiler.

local v0 = {};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(script.Parent.ItemModule);
local l_MysteryBox_0 = l_Sync_0.MysteryBox;
local l_Weapons_0 = l_Sync_0.Weapons;
local l_Pets_0 = l_Sync_0.Pets;
local v7 = {
	Min = 20, 
	Max = 25
};
local function v16(v8) --[[ Line: 16 ]] --[[ Name: GetRarityFromRoll ]]
	local v9 = 0;
	for _, v11 in v8 do
		v9 = v9 + v11.Chance;
	end;
	assert(v9 == 100);
	assert(v8[1].Rarity == "Common");
	assert(v8[2].Rarity == "Uncommon");
	assert(v8[3].Rarity == "Rare");
	assert(v8[4].Rarity == "Legendary");
	assert(#v8 == 4);
	local v12 = Random.new():NextNumber(1, 100);
	local v13 = 0;
	for _, v15 in v8 do
		v13 = v13 + v15.Chance;
		if v12 <= v13 then
			return v15.Rarity;
		end;
	end;
end;
v0.OpenBox = function(v17, v18) --[[ Line: 38 ]]
	-- upvalues: l_MysteryBox_0 (copy), v7 (copy), l_Weapons_0 (copy), l_Sync_0 (copy), v16 (copy), v3 (copy), l_TweenService_0 (copy)
	local v19 = Random.new();
	local v20 = script:WaitForChild("Unboxing2"):Clone();
	local l_OffsetContainer_0 = v20.Container.Main.Container.Background.ItemContainer.OffsetContainer;
	local l_MainContainer_0 = l_OffsetContainer_0.MainContainer;
	local v23 = l_MysteryBox_0[v17];
	local v24 = v19:NextInteger(v7.Min, v7.Max);
	local v25 = {
		Common = {}, 
		Uncommon = {}, 
		Rare = {}, 
		Legendary = {}
	};
	for _, v27 in pairs(v23.Contents) do
		table.insert(v25[l_Weapons_0[v27].Rarity], v27);
	end;
	l_MainContainer_0:ClearAllChildren();
	local v28 = script.UIGridLayout:Clone();
	v28.Parent = l_MainContainer_0;
	local l_Offset_0 = v28.CellSize.X.Offset;
	l_OffsetContainer_0.Size = UDim2.new(0, v28.CellSize.X.Offset * (v24 + 5), 1, 0);
	l_OffsetContainer_0.Position = UDim2.new(0.5, l_Offset_0 / 2, 0, 0);
	local function v34() --[[ Line: 75 ]] --[[ Name: GetRandomItemFromBox ]]
		-- upvalues: v19 (copy), v23 (copy), l_Sync_0 (ref), v16 (ref), v25 (copy), l_Weapons_0 (ref)
		local v30 = nil;
		local v31 = nil;
		if v19:NextInteger(1, 500) == 500 then
			v30 = "Godly";
			local v32 = nil;
			if v23.GodlyCover then
				v32 = v23.GodlyCover;
			elseif v23.Godly then
				v32 = v23.Godly;
			end;
			if v32 and v19:NextInteger(1, 50) == 50 then
				local v33 = v32 .. "Chroma";
				if l_Sync_0.Weapons[v33] then
					v32 = v33;
				end;
			end;
			v31 = v32;
		end;
		if not v31 then
			v30 = v16(v23.RarityChances);
			v31 = v25[v30][v19:NextInteger(1, #v25[v30])];
		end;
		return v31, l_Weapons_0[v31], v30;
	end;
	for v35 = 1, v24 + 5 do
		local v36 = nil;
		local v37 = nil;
		local v38 = nil;
		if v35 == v24 then
			if l_Sync_0.Weapons[v18].Rarity == "Godly" and v23.GodlyCover then
				if l_Sync_0.Weapons[v18].Chroma == true and v23.GodlyCover then
					v36 = v23.GodlyCover .. "Chroma";
					v37 = l_Sync_0.Weapons[v36];
					v38 = v37.Rarity;
				else
					v36 = v23.GodlyCover;
					v37 = l_Sync_0.Weapons[v23.GodlyCover];
					v38 = v37.Rarity;
				end;
			else
				v36 = v18;
				v37 = l_Sync_0.Weapons[v18];
				v38 = v37.Rarity;
			end;
		else
			local v39, v40, v41 = v34();
			v36 = v39;
			v37 = v40;
			v38 = v41;
		end;
		local v42 = script.NewItem:Clone();
		v3.DisplayItem(v42, v37);
		v42.LayoutOrder = v35;
		v42.Parent = l_MainContainer_0;
	end;
	local v43, v44, v45 = v34();
	v3.DisplayItem(l_OffsetContainer_0["PreItem" .. 1], v44);
	v43, v44, v45 = v34();
	v3.DisplayItem(l_OffsetContainer_0["PreItem" .. 2], v44);
	v20.Parent = game.Players.LocalPlayer.PlayerGui;
	v43 = 3 + v19:NextNumber();
	v44 = -(l_Offset_0 * v24) + v19:NextInteger(-(l_Offset_0 / 2 - 5), l_Offset_0 / 2 - 5) + l_Offset_0 - l_Offset_0 / 2;
	v45 = TweenInfo.new(v43, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
	l_TweenService_0:Create(l_OffsetContainer_0, v45, {
		Position = UDim2.new(0.5, v44, 0, 0)
	}):Play();
	task.wait(v43 + 1);
	v20:Destroy();
end;
local l_TweenService_1 = game:GetService("TweenService");
local v47 = TweenInfo.new(0.125, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
v0.HatchEgg = function(_, v49) --[[ Line: 194 ]]
	-- upvalues: l_Pets_0 (copy), v3 (copy), l_TweenService_1 (copy), v47 (copy)
	local v50 = script.Hatching:Clone();
	v50.Parent = game.Players.LocalPlayer.PlayerGui;
	local v51 = l_Pets_0[v49];
	v50.Cracked.PetIcon.Image = v3.GetImage(v51.Image);
	wait(1);
	local l_Egg_0 = v50.Uncracked.Egg;
	local v53 = {
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = -10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = -10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 0
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = -10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = -10
		}), 
		l_TweenService_1:Create(l_Egg_0, v47, {
			Rotation = 0
		})
	};
	for _, v55 in pairs(v53) do
		v55:Play();
		wait(0.125);
	end;
	wait(0.5);
	v50.Uncracked.Visible = false;
	v50.Cracked.Visible = true;
	wait(1);
	v50:Destroy();
end;
local v56 = {};
for _, v58 in script:GetDescendants() do
	if v58:IsA("ImageLabel") then
		table.insert(v56, v58);
	end;
end;
task.spawn(function() --[[ Line: 243 ]]
	-- upvalues: v56 (copy)
	game:GetService("ContentProvider"):PreloadAsync(v56);
end);
return v0;