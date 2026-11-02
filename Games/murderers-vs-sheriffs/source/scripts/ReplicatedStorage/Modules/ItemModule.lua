-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
_G.Cache = _G.Cache or {}
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local v2 = {
	Weapons = true, 
	Pets = true
};
local l_Rarities_0 = l_Sync_0.Rarities;
v0.GetImage = function(v4) --[[ Line: 11 ]] --[[ Name: GetImage ]]
	if _G.Cache[v4] ~= nil then
		return _G.Cache[v4];
	else
		local v5 = (tonumber(v4) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. v4 or v4) .. "&bust=" .. math.random(1, 10000);
		_G.Cache[v4] = v5;
		return v5;
	end;
end;
v0.GetImageSmall = function(v6) --[[ Line: 24 ]] --[[ Name: GetImageSmall ]]
	if _G.SmallCache[v6] ~= nil then
		return _G.SmallCache[v6];
	else
		local v7 = (tonumber(v6) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=110&height=110&assetId=" .. v6 or v6) .. "&bust=" .. math.random(1, 10000);
		_G.SmallCache[v6] = v7;
		return v7;
	end;
end;
local v18 = {
	Chroma = function(v8, v9) --[[ Line: 38 ]]
		v8.Tags.Chroma.Visible = v9.Chroma == true;
	end, 
	AFX = function(v10, v11) --[[ Line: 41 ]]
		v10.Tags.AFX.Visible = v11.FX == true;
	end, 
	Evo = function(v12, v13) --[[ Line: 44 ]]
		v12.Tags.Evo.Visible = v13.EvoBaseID ~= nil;
	end, 
	Halloween = function(v14, v15) --[[ Line: 47 ]]
		if not v2[v15.DataType] then
			v14.Tags.Halloween.Visible = v15.Event == "Halloween";
			v14.Tags.Halloween.Year.Text = v15.Year or "";
		end;
	end, 
	Christmas = function(v16, v17) --[[ Line: 53 ]]
		if not v2[v17.DataType] then
			v16.Tags.Christmas.Visible = v17.Event == "Christmas";
			v16.Tags.Christmas.Year.Text = v17.Year or "";
		end;
	end
};
v0.DisplayItem = function(v19, v20, v21, v22)
	if v20 == nil then
		v19.ItemName.Label.Text = "";
		v19.Container.Icon.Image = "";
		v19.Container.Amount.Text = "";
		v19.ItemName.BackgroundColor3 = Color3.fromRGB(95, 95, 95);
		for _, v24 in pairs(v19.Tags:GetChildren()) do
			if v24:IsA("Frame") then
				v24.Visible = false;
			end;
		end;
		return;
	else
		v19.ItemName.Label.Text = v20.ItemName or v20.Name;
		v20.Rarity = v20.Rarity or "Common";
		local l_Color_0 = l_Rarities_0[v20.Rarity].Color;
		local v26 = Color3.fromRGB(l_Color_0.r, l_Color_0.g, l_Color_0.b) or Color3.new(1, 1, 1);
		v19.ItemName.BackgroundColor3 = v26;
		local l_Icon_0 = v19.Container.Icon;
		local l_Image_0 = v20.Image or v20.Icon or "";
		local v29;
		if _G.Cache[l_Image_0] ~= nil then
			v29 = _G.Cache[l_Image_0];
		else
			local v30 = (tonumber(l_Image_0) and "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=" .. l_Image_0 or l_Image_0) .. "&bust=" .. math.random(1, 10000);
			_G.Cache[l_Image_0] = v30;
			v29 = v30;
		end;
		l_Icon_0.Image = v29;
		if v19.Container:FindFirstChild("Amount") then
			l_Icon_0 = v21 or v20.Amount;
			v19.Container.Amount.Text = l_Icon_0 and l_Icon_0 > 1 and "x" .. l_Icon_0 or "";
		end;
		if v19.Container:FindFirstChild("Classic") then
			v19.Container.Classic.Visible = v20.Classic ~= nil;
		end;
		if v19.ItemName:FindFirstChild("ColoredName") then
			v19.ItemName.ColoredName.Text = v20.ItemName or v20.Name;
			l_Icon_0 = v26;
			if v20.Rarity == "Common" then
				l_Icon_0 = Color3.new(1, 1, 1);
			end;
			v19.ItemName.ColoredName.TextColor3 = l_Icon_0;
			v19.ItemName.RarityBar.BackgroundColor3 = l_Icon_0;
		end;
		pcall(function() 
			for v31, v32 in pairs(v18) do
				if v19.Tags:FindFirstChild(v31) then
					v32(v19, v20);
				end;
			end;
		end)
		if v20.Signature then
			l_Icon_0 = v20.Signature;
			if l_Icon_0 ~= "" then
				v19.Tags.Unique.PlayerName.Text = l_Icon_0 .. "'s";
				v19.Tags.Unique.Visible = true;
				if tonumber(l_Icon_0) then
					spawn(function()
						v19.Tags.Unique.PlayerName.Text = game.Players:GetNameFromUserIdAsync((math.abs(v20.Signature))) .. "'s";
					end);
				end;
			end;
			v19.Container.Amount.Text = v20.Rank and "#" .. v20.Rank or "";
		end;
		if v22 then
			pcall(function() 
				for _, v34 in pairs(v19.Tags:GetChildren()) do
					if v34:IsA("Frame") and v34.Visible == false then
						v34:Destroy();
					end;
				end;
				if #v19.Tags:GetChildren() == 1 then
					v19.Tags:Destroy();
				end;		
			end)
		end;
		return;
	end;
end;
v0.Commafy = function(v35) --[[ Line: 151 ]]
	local v36 = tostring(v35);
	repeat
		local v37, v38 = string.gsub(v36, "^(-?%d+)(%d%d%d)", "%1,%2");
		k = v38;
		v36 = v37;
	until k == 0;
	return v36;
end;
v0.AnimateItemIconIntoInventory = function(v39, v40, v41) --[[ Line: 165 ]]
	local v42 = v39:Clone();
	local l_X_0 = v39.AbsoluteSize.X;
	local l_Y_0 = v39.AbsoluteSize.Y;
	local l_X_1 = v39.AbsolutePosition.X;
	local l_Y_1 = v39.AbsolutePosition.Y;
	v42.Size = UDim2.new(0, l_X_0, 0, l_Y_0);
	v42.BackgroundTransparency = 1;
	v42.Position = UDim2.new(0, l_X_1 + l_X_0 / 2, 0, l_Y_1 + l_Y_0 / 2);
	v42.AnchorPoint = Vector2.new(0.5, 0.5);
	v42.ZIndex = 10;
	v42.Parent = v41;
	spawn(function() --[[ Line: 182 ]]
		v42:TweenSizeAndPosition(UDim2.new(0, 25, 0, 25), UDim2.new(0, v40.AbsolutePosition.X + v40.AbsoluteSize.X / 2 - 3, 0, v40.AbsolutePosition.Y + v40.AbsoluteSize.Y / 2 - 20), "InOut", "Sine", 0.5);
		wait(0.5);
		v42:Destroy();
	end);
end;
return v0;