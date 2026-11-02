-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0:WaitForChild("Math Utility"));
local l_ParseAbbreviatedNumber_0 = v3.ParseAbbreviatedNumber;
local v5 = v3.Zero();
local function _(v6) --[[ Line: 13 ]] --[[ Name: cloneBig ]]
	-- upvalues: v3 (copy)
	return v3.Clone(v6) or v3.Zero();
end;
local function _(v8, v9) --[[ Line: 18 ]] --[[ Name: normalizeBig ]]
	-- upvalues: v3 (copy), v5 (copy)
	local v10 = v3.Normalize(v8);
	if v10 then
		return v10;
	else
		local v11 = v9 or v5;
		return v3.Clone(v11) or v3.Zero();
	end;
end;
local function _(v13) --[[ Line: 27 ]] --[[ Name: floorBig ]]
	-- upvalues: v3 (copy)
	return v3.Floor(v13) or v3.Zero();
end;
local function _(v15, v16) --[[ Line: 32 ]] --[[ Name: maxBig ]]
	-- upvalues: v3 (copy)
	return v3.Max(v15, v16) or v3.Clone(v15) or v3.Zero();
end;
local function _(v18, v19) --[[ Line: 37 ]] --[[ Name: minBig ]]
	-- upvalues: v3 (copy)
	return v3.Min(v18, v19) or v3.Clone(v18) or v3.Zero();
end;
local function _(v21, v22) --[[ Line: 42 ]] --[[ Name: multiplyBig ]]
	-- upvalues: v3 (copy)
	return v3.Multiply(v21, v22) or v3.Zero();
end;
v0.Products = {
	AuraBoosts = {
		[1] = {
			Id = 0, 
			Boost = 2, 
			Price = 3
		}, 
		[2] = {
			Id = 0, 
			Boost = 4, 
			Price = 9
		}, 
		[3] = {
			Id = 0, 
			Boost = 10, 
			Price = 29
		}, 
		[4] = {
			Id = 3567384390, 
			Boost = 25, 
			Price = 67
		}, 
		[5] = {
			Id = 3567384806, 
			Boost = 100, 
			Price = 149
		}
	}, 
	RebirthPacks = {
		[1] = {
			Id = 0, 
			Price = 9, 
			PercentOfCurrent = 1.8, 
			MinFlat = l_ParseAbbreviatedNumber_0("500"), 
			NewbieFlat = l_ParseAbbreviatedNumber_0("1B"), 
			NewbieThreshold = l_ParseAbbreviatedNumber_0("100K"), 
			DiminishRate = 0.93, 
			DiminishFloor = 0.45, 
			AbsoluteCap = nil
		}, 
		[2] = {
			Id = 3571083676, 
			Price = 9, 
			PercentOfCurrent = 11.5, 
			MinFlat = l_ParseAbbreviatedNumber_0("5K"), 
			NewbieFlat = l_ParseAbbreviatedNumber_0("10B"), 
			NewbieThreshold = l_ParseAbbreviatedNumber_0("100K"), 
			DiminishRate = 0.96, 
			DiminishFloor = 0.6, 
			FloorAgainstLowerTier = 4, 
			AbsoluteCap = nil
		}
	}
};
v0.FreeAuraBoostPlaytimeRequirements = {
	[1] = 90 * 60,
	[2] = 180 * 60,
	[3] = 270 * 60
};
v0.FirstFreeRebirthPackCooldownSeconds = 45 * 60;
local function v29(v24) --[[ Line: 95 ]] --[[ Name: getPackAbsoluteCap ]]
	-- upvalues: v0 (copy), v3 (copy), v5 (copy)
	local v25 = v0.Products.RebirthPacks[v24];
	if not v25 then
		return nil;
	elseif v25.AbsoluteCap == nil then
		return nil;
	else
		local l_AbsoluteCap_0 = v25.AbsoluteCap;
		local v27 = v3.Normalize(l_AbsoluteCap_0);
		if v27 then
			return v27;
		else
			local l_v5_0 = v5;
			return v3.Clone(l_v5_0) or v3.Zero();
		end;
	end;
end;
local function v33(v30, v31) --[[ Line: 108 ]] --[[ Name: getDiminishMultiplier ]]
	local v32 = v30.DiminishRate or 1;
	return (math.max(v30.DiminishFloor or 0, v32 ^ v31));
end;
local function v61(v34, v35, v36, v37) --[[ Line: 115 ]] --[[ Name: getRawRebirthPackAdd ]]
	-- upvalues: v3 (copy), v5 (copy), l_ParseAbbreviatedNumber_0 (copy), v0 (copy)
	local v38 = false;
	local v39 = v3.Normalize(v35);
	local v40;
	if v39 then
		v40 = v39;
	else
		local l_v5_1 = v5;
		v40 = v3.Clone(l_v5_1) or v3.Zero();
	end;
	local v42 = v34.MinFlat or l_ParseAbbreviatedNumber_0("50");
	local v43 = v3.Normalize(v42);
	if v43 then
		v39 = v43;
	else
		local l_v5_2 = v5;
		v39 = v3.Clone(l_v5_2) or v3.Zero();
	end;
	v43 = v34.NewbieFlat or v39;
	local v45 = v3.Normalize(v43);
	if v45 then
		v42 = v45;
	else
		local v46 = v39 or v5;
		v42 = v3.Clone(v46) or v3.Zero();
	end;
	v45 = v34.NewbieThreshold or l_ParseAbbreviatedNumber_0("100K");
	local v47 = v3.Normalize(v45);
	if v47 then
		v43 = v47;
	else
		local l_v5_3 = v5;
		v43 = v3.Clone(l_v5_3) or v3.Zero();
	end;
	v47 = v36:GetAttribute("RebirthPackBuys_" .. v34.Id) or 0;
	local v49 = v34.DiminishRate or 1;
	local v50 = math.max(v34.DiminishFloor or 0, v49 ^ v47);
	v49 = v34.PercentOfCurrent or 0;
	local v51 = v3.Multiply(v40, v49) or v3.Zero();
	local v52 = v3.Floor(v51) or v3.Zero();
	v51 = nil;
	v51 = if (v3.Compare(v40, v43) or -1) < 0 then v3.Clone(v42) or v3.Zero() else v3.Max(v52, v39) or v3.Clone(v52) or v3.Zero();
	local v53 = v3.Multiply(v51, v50) or v3.Zero();
	local v54 = v3.Floor(v53) or v3.Zero();
	v53 = v3.Max(v54, v39) or v3.Clone(v54) or v3.Zero();
	local v55;
	if v37 then
		local v56 = v0.Products.RebirthPacks[v37];
		if not v56 then
			v55 = nil;
		elseif v56.AbsoluteCap == nil then
			v55 = nil;
		else
			local l_AbsoluteCap_1 = v56.AbsoluteCap;
			local v58 = v3.Normalize(l_AbsoluteCap_1);
			if v58 then
				v55 = v58;
			else
				local l_v5_4 = v5;
				v55 = v3.Clone(l_v5_4) or v3.Zero();
			end;
		end;
		v38 = v55;
	end;
	if not v38 then
		v55 = nil;
	end;
	v38 = false;
	if v55 then
		local l_v53_0 = v53;
		v53 = v3.Min(l_v53_0, v55) or v3.Clone(l_v53_0) or v3.Zero();
	end;
	return v53;
end;
local function v78(v62, v63, v64) --[[ Line: 146 ]] --[[ Name: getRebirthPackAdd ]]
	-- upvalues: v0 (copy), v3 (copy), v61 (copy), v5 (copy)
	local l_RebirthPacks_0 = v0.Products.RebirthPacks;
	local v66 = l_RebirthPacks_0[v62];
	if not v66 then
		return v3.Zero();
	else
		local v67 = v61(v66, v63, v64, v62);
		if v62 > 1 then
			local v68 = l_RebirthPacks_0[v62 - 1];
			local l_FloorAgainstLowerTier_0 = v66.FloorAgainstLowerTier;
			if v68 and l_FloorAgainstLowerTier_0 then
				local v70 = v61(v68, v63, v64, v62 - 1);
				local v71 = v3.Multiply(v70, l_FloorAgainstLowerTier_0) or v3.Zero();
				local v72 = v3.Floor(v71) or v3.Zero();
				v71 = v67;
				v67 = v3.Max(v71, v72) or v3.Clone(v71) or v3.Zero();
			end;
		end;
		local v73 = v0.Products.RebirthPacks[v62];
		local v74;
		if not v73 then
			v74 = nil;
		elseif v73.AbsoluteCap == nil then
			v74 = nil;
		else
			local l_AbsoluteCap_2 = v73.AbsoluteCap;
			local v76 = v3.Normalize(l_AbsoluteCap_2);
			if v76 then
				v74 = v76;
			else
				local l_v5_5 = v5;
				v74 = v3.Clone(l_v5_5) or v3.Zero();
			end;
		end;
		if v74 then
			v73 = v67;
			v67 = v3.Min(v73, v74) or v3.Clone(v73) or v3.Zero();
		end;
		return v67;
	end;
end;
v0.GetPackAbsoluteCap = v29;
v0.GetDiminishMultiplier = v33;
v0.GetRawRebirthPackAdd = v61;
v0.GetRebirthPackAdd = v78;
if l_RunService_0:IsServer() then
	return v0;
else
	local l_MarketplaceService_0 = game:GetService("MarketplaceService");
	local l_Players_0 = game:GetService("Players");
	local l_TweenService_0 = game:GetService("TweenService");
	local l_Lighting_0 = game:GetService("Lighting");
	local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
	local l_CurrentCamera_0 = workspace.CurrentCamera;
	local v85 = l_LocalPlayer_0:WaitForChild("PlayerGui", 20);
	local v86 = v85:WaitForChild("Extensions", 20);
	local l_MonetizationBlackBackground_0 = v86:WaitForChild("MonetizationBlackBackground");
	local l_ProductVignete_0 = v86:WaitForChild("ProductVignete");
	local l_Monetization_0 = v85:WaitForChild("Hud", 20):WaitForChild("RankBar"):WaitForChild("Monetization");
	local v90 = require(l_ReplicatedStorage_0.Frameworks.ConfettiModule);
	local l_PurchaseBlur_0 = l_Lighting_0:FindFirstChild("PurchaseBlur");
	if not l_PurchaseBlur_0 then
		l_PurchaseBlur_0 = Instance.new("BlurEffect");
		l_PurchaseBlur_0.Name = "PurchaseBlur";
		l_PurchaseBlur_0.Size = 0;
		l_PurchaseBlur_0.Enabled = true;
		l_PurchaseBlur_0.Parent = l_Lighting_0;
	else
		l_PurchaseBlur_0.Enabled = true;
		l_PurchaseBlur_0.Size = l_PurchaseBlur_0.Size or 0;
	end;
	local l_Sounds_0 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Sounds");
	local _ = l_Sounds_0:WaitForChild("SuccessSfx");
	local l_Reward_0 = l_Sounds_0:WaitForChild("Reward");
	local l_PromptSound_0 = l_Sounds_0:FindFirstChild("PromptSound");
	if not l_PromptSound_0 then
		l_PromptSound_0 = Instance.new("Sound");
		l_PromptSound_0.Name = "PromptSound";
		l_PromptSound_0.Parent = l_Sounds_0;
	end;
	local l_UI_0 = l_Sounds_0:FindFirstChild("UI");
	local v97 = l_UI_0 and l_UI_0:FindFirstChild("UI Hover");
	local v98 = l_UI_0 and l_UI_0:FindFirstChild("UI Click");
	local l_UIGradient_0 = l_ProductVignete_0:FindFirstChildOfClass("UIGradient");
	if not l_UIGradient_0 then
		l_UIGradient_0 = Instance.new("UIGradient");
		l_UIGradient_0.Parent = l_ProductVignete_0;
	end;
	l_UIGradient_0.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), 
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), 
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
	});
	local v100 = 0;
	local v101 = nil;
	local v102 = nil;
	local v103 = nil;
	local v104 = nil;
	local v105 = nil;
	local function _(v106) --[[ Line: 251 ]] --[[ Name: cancelTween ]]
		if v106 then
			v106:Cancel();
		end;
	end;
	local function _() --[[ Line: 257 ]] --[[ Name: cancelAllFX ]]
		-- upvalues: v101 (ref), v102 (ref), v103 (ref), v104 (ref), v105 (ref)
		local l_v101_0 = v101;
		if l_v101_0 then
			l_v101_0:Cancel();
		end;
		v101 = nil;
		l_v101_0 = v102;
		if l_v101_0 then
			l_v101_0:Cancel();
		end;
		v102 = nil;
		l_v101_0 = v103;
		if l_v101_0 then
			l_v101_0:Cancel();
		end;
		v103 = nil;
		l_v101_0 = v104;
		if l_v101_0 then
			l_v101_0:Cancel();
		end;
		v104 = nil;
		if v105 then
			v105:Cancel();
			v105 = nil;
		end;
	end;
	local v110 = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
	local v111 = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
	local v112 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
	local v113 = {
		inFOV = 82, 
		outFOV = 70, 
		inBlur = 18, 
		outBlur = 0, 
		inBgT = 0.3, 
		outBgT = 1, 
		inVigT = 0, 
		outVigT = 1, 
		inSize = UDim2.new(1, 0, 1, 0), 
		outSize = UDim2.new(1.2, 0, 1.2, 0)
	};
	local function v115() --[[ Line: 290 ]] --[[ Name: startGradientSpin ]]
		-- upvalues: v105 (ref), l_TweenService_0 (copy), l_UIGradient_0 (ref)
		local v114 = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1);
		v105 = l_TweenService_0:Create(l_UIGradient_0, v114, {
			Rotation = 360
		});
		v105:Play();
	end;
	local function v116() --[[ Line: 296 ]] --[[ Name: playFX_In ]]
		-- upvalues: v101 (ref), l_TweenService_0 (copy), l_CurrentCamera_0 (copy), v110 (copy), v113 (copy), v102 (ref), l_PurchaseBlur_0 (ref), v103 (ref), l_MonetizationBlackBackground_0 (copy), v104 (ref), l_ProductVignete_0 (copy), v115 (copy)
		v101 = l_TweenService_0:Create(l_CurrentCamera_0, v110, {
			FieldOfView = v113.inFOV
		});
		v102 = l_TweenService_0:Create(l_PurchaseBlur_0, v110, {
			Size = v113.inBlur
		});
		v103 = l_TweenService_0:Create(l_MonetizationBlackBackground_0, v110, {
			BackgroundTransparency = v113.inBgT
		});
		v104 = l_TweenService_0:Create(l_ProductVignete_0, v110, {
			ImageTransparency = v113.inVigT, 
			Size = v113.inSize
		});
		v101:Play();
		v102:Play();
		v103:Play();
		v104:Play();
		v115();
	end;
	local function v117() --[[ Line: 313 ]] --[[ Name: playFX_OutQuick ]]
		-- upvalues: v101 (ref), l_TweenService_0 (copy), l_CurrentCamera_0 (copy), v111 (copy), v113 (copy), v102 (ref), l_PurchaseBlur_0 (ref), v103 (ref), l_MonetizationBlackBackground_0 (copy), v105 (ref)
		v101 = l_TweenService_0:Create(l_CurrentCamera_0, v111, {
			FieldOfView = v113.outFOV
		});
		v102 = l_TweenService_0:Create(l_PurchaseBlur_0, v111, {
			Size = v113.outBlur
		});
		v103 = l_TweenService_0:Create(l_MonetizationBlackBackground_0, v111, {
			BackgroundTransparency = v113.outBgT
		});
		v101:Play();
		v102:Play();
		v103:Play();
		v103.Completed:Once(function() --[[ Line: 322 ]]
			-- upvalues: l_MonetizationBlackBackground_0 (ref)
			l_MonetizationBlackBackground_0.Visible = false;
		end);
		if v105 then
			v105:Cancel();
			v105 = nil;
		end;
	end;
	v0.PromptProduct = function(v118) --[[ Line: 332 ]] --[[ Name: PromptProduct ]]
		-- upvalues: v100 (ref), v101 (ref), v102 (ref), v103 (ref), v104 (ref), v105 (ref), l_ProductVignete_0 (copy), l_MonetizationBlackBackground_0 (copy), l_UIGradient_0 (ref), l_PurchaseBlur_0 (ref), l_PromptSound_0 (ref), l_MarketplaceService_0 (copy), l_LocalPlayer_0 (copy), v116 (copy), l_Reward_0 (copy)
		v100 = v100 + 1;
		local l_v100_0 = v100;
		local l_v101_1 = v101;
		if l_v101_1 then
			l_v101_1:Cancel();
		end;
		v101 = nil;
		l_v101_1 = v102;
		if l_v101_1 then
			l_v101_1:Cancel();
		end;
		v102 = nil;
		l_v101_1 = v103;
		if l_v101_1 then
			l_v101_1:Cancel();
		end;
		v103 = nil;
		l_v101_1 = v104;
		if l_v101_1 then
			l_v101_1:Cancel();
		end;
		v104 = nil;
		if v105 then
			v105:Cancel();
			v105 = nil;
		end;
		l_ProductVignete_0.Size = UDim2.new(1.3, 0, 1.3, 0);
		l_ProductVignete_0.Visible = true;
		l_ProductVignete_0.ImageTransparency = 1;
		l_MonetizationBlackBackground_0.BackgroundTransparency = 1;
		l_MonetizationBlackBackground_0.Visible = true;
		l_UIGradient_0.Rotation = 0;
		l_PurchaseBlur_0.Size = 0;
		l_PurchaseBlur_0.Enabled = true;
		if l_PromptSound_0 then
			l_PromptSound_0:Play();
		end;
		l_MarketplaceService_0:PromptProductPurchase(l_LocalPlayer_0, v118);
		task.delay(0.07, function() --[[ Line: 355 ]]
			-- upvalues: l_v100_0 (copy), v100 (ref), l_MonetizationBlackBackground_0 (ref), v116 (ref), l_Reward_0 (ref)
			if l_v100_0 ~= v100 then
				return;
			else
				l_MonetizationBlackBackground_0.Visible = true;
				v116();
				l_Reward_0:Play();
				return;
			end;
		end);
	end;
	l_MarketplaceService_0.PromptProductPurchaseFinished:Connect(function(v121, _, v123) --[[ Line: 366 ]]
		if v121 ~= l_LocalPlayer_0.UserId then
			return;
		else
			local l_v100_1 = v100;
			v117();
			if v123 then
				l_ReplicatedStorage_0.Assets.Sounds.ProductPurchased1:Play();
				local l_Character_0 = l_LocalPlayer_0.Character;
				if l_Character_0 then
					local l_Highlight_0 = l_Character_0:FindFirstChildOfClass("Highlight");
					if l_Highlight_0 then
						l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.5), {
							FillTransparency = 0
						}):Play();
						task.delay(0.6, function()
							l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(1), {
								FillTransparency = 1
							}):Play();
						end);
					end;
				end;
				v90:Burst(75);
			end;
			task.delay(0.4, function()
				if l_v100_1 ~= v100 then
					return;
				else
					v104 = l_TweenService_0:Create(l_ProductVignete_0, v112, {
						ImageTransparency = 1,
						Size = v113.outSize
					});
					v104:Play();
					v104.Completed:Once(function()
						if l_v100_1 == v100 then
							l_ProductVignete_0.Visible = false;
						end;
					end);
					return;
				end;
			end);
			return;
		end;
	end);
	local l_Small_0 = l_Monetization_0.Small;
	local l_Big_0 = l_Monetization_0.Big;
	local l_SmallPrice_0 = l_Small_0:WaitForChild("Price");
	local l_BigPrice_0 = l_Big_0:WaitForChild("Price");
	local l_MonetizationServiceRF_0 = l_ReplicatedStorage_0:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("MonetizationService"):WaitForChild("RF");
	local l_ClaimFreeFirstRebirthPack_0 = l_MonetizationServiceRF_0:WaitForChild("ClaimFreeFirstRebirthPack");
	local v129 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
	local v130 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local v131 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local v132 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
	local function v133(v134)
		v134 = math.max(0, math.floor(tonumber(v134) or 0));
		local v135 = math.floor(v134 / 3600);
		local v136 = math.floor(v134 % 3600 / 60);
		local v137 = v134 % 60;
		if v135 > 0 then
			return string.format("%d:%02d:%02d", v135, v136, v137);
		else
			return string.format("%02d:%02d", v136, v137);
		end;
	end;
	local v134 = tonumber(l_LocalPlayer_0:GetAttribute("TimePlayed")) or 0;
	local v135 = os.clock();
	local function v136()
		local v137 = tonumber(l_LocalPlayer_0:GetAttribute("TimePlayed"));
		if v137 then
			v134 = v137;
			v135 = os.clock();
		end;
	end;
	local function v137()
		local v138 = math.max(0, math.floor(os.clock() - v135));
		return v134 + v138;
	end;
	local function v138()
		local v139 = tonumber(l_LocalPlayer_0:GetAttribute("FirstFreeRebirthPackReadyAtPlaytime")) or (tonumber(v0.FirstFreeRebirthPackCooldownSeconds) or 2700);
		local v140 = v137();
		local v141 = math.max(0, v139 - v140);
		if v141 <= 0 then
			l_SmallPrice_0.Text = "FREE";
			return;
		else
			l_SmallPrice_0.Text = v133(v141);
			return;
		end;
	end;
	local function v149(v142, v143)
		local l_Size_0 = v142.Size;
		local v145 = UDim2.new(l_Size_0.X.Scale * 1.13, l_Size_0.X.Offset, l_Size_0.Y.Scale * 1.13, l_Size_0.Y.Offset);
		local v146 = UDim2.new(l_Size_0.X.Scale * 0.93, l_Size_0.X.Offset, l_Size_0.Y.Scale * 0.93, l_Size_0.Y.Offset);
		local v147 = l_TweenService_0:Create(v142, v129, {
			Size = v145
		});
		local v148 = l_TweenService_0:Create(v142, v130, {
			Size = l_Size_0
		});
		local v149 = l_TweenService_0:Create(v142, v131, {
			Size = v146
		});
		local v150 = l_TweenService_0:Create(v142, v132, {
			Size = l_Size_0
		});
		v142.MouseEnter:Connect(function()
			v147:Play();
			if v97 then
				v97:Play();
			end;
		end);
		v142.MouseLeave:Connect(function()
			v148:Play();
		end);
		v142.MouseButton1Down:Connect(function()
			v149:Play();
		end);
		v142.MouseButton1Up:Connect(function()
			v150:Play();
			if v98 then
				v98:Play();
			end;
			if typeof(v143) == "function" then
				v143();
				return;
			else
				v0.PromptProduct(v143);
				return;
			end;
		end);
	end;
	v149(l_Small_0, function()
		local v151 = tonumber(l_LocalPlayer_0:GetAttribute("FirstFreeRebirthPackReadyAtPlaytime")) or (tonumber(v0.FirstFreeRebirthPackCooldownSeconds) or 2700);
		local v152 = v137();
		if v151 > v152 then
			v138();
			return;
		else
			local l_status_0, l_result_0 = pcall(function()
				return l_ClaimFreeFirstRebirthPack_0:InvokeServer();
			end);
			v136();
			if l_status_0 and typeof(l_result_0) == "table" and l_result_0.ok then
				v138();
			end;
			return;
		end;
	end);
	v149(l_Big_0, v0.Products.RebirthPacks[2].Id);
	v136();
	v138();
	l_LocalPlayer_0:GetAttributeChangedSignal("TimePlayed"):Connect(function()
		v136();
		v138();
	end);
	l_LocalPlayer_0:GetAttributeChangedSignal("FirstFreeRebirthPackReadyAtPlaytime"):Connect(function()
		v136();
		v138();
	end);
	task.spawn(function()
		while l_SmallPrice_0 and l_SmallPrice_0.Parent do
			task.wait(1);
			v138();
		end;
	end);
	local v143 = require(l_ReplicatedStorage_0.Signals);
	local v143 = require(l_ReplicatedStorage_0.Signals);
	v143.PlayRewardFX:Connect(function() --[[ Line: 469 ]]
		l_ReplicatedStorage_0.Assets.Sounds.ProductPurchased1:Play();
		local l_Character_1 = l_LocalPlayer_0.Character;
		if l_Character_1 then
			local l_Highlight_1 = l_Character_1:FindFirstChildOfClass("Highlight");
			if l_Highlight_1 then
				l_TweenService_0:Create(l_Highlight_1, TweenInfo.new(0.5), {
					FillTransparency = 0
				}):Play();
				task.delay(0.6, function()
					l_TweenService_0:Create(l_Highlight_1, TweenInfo.new(1), {
						FillTransparency = 1
					}):Play();
				end);
			end;
			v90:Burst(75);
		end;
	end);
	v143.PlayConfetti:Connect(function() --[[ Line: 489 ]]
		v90:Burst(75);
	end);
	return v0;
end;