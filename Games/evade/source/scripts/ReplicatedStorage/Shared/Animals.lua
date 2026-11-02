-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local _ = require(l_Packages_0.Trove);
local v4 = require(l_Packages_0.Observers);
local v5 = require(l_Packages_0.Trove);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v7 = require(l_Datas_0.Animals);
local v8 = require(l_Datas_0.Game);
local _ = require(l_Datas_0.Rebirth);
local v10 = require(l_Datas_0.Rarities);
local v11 = require(l_Datas_0.Mutations);
local _ = require(l_Datas_0.MutationsTextures);
local v13 = require(l_Datas_0.Traits);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local l_MutationSurfaces_0 = l_ReplicatedStorage_0:WaitForChild("MutationSurfaces");
local l_Models_0 = l_ReplicatedStorage_0:WaitForChild("Models");
local l_Animals_1 = l_Models_0.Animals;
local l_Traits_0 = l_Models_0.Traits;
local l_Traits_1 = l_ReplicatedStorage_0:WaitForChild("Vfx").Traits;
local l_Vfx_0 = l_ReplicatedStorage_0:WaitForChild("Vfx");
local v21 = {};
local l_Unit_0 = Vector3.new(-1, 0.25, -1, 0).Unit;
local function v41(v23, v24) --[[ Line: 41 ]] --[[ Name: GetBoundingBox ]]
	local v25 = 1e999;
	local v26 = 1e999;
	local v27 = 1e999;
	local v28 = -1e999;
	local v29 = -1e999;
	local v30 = -1e999;
	for _, v32 in v23:GetDescendants() do
		if v32:IsA("BasePart") and v32.Transparency < 1 and not v24[v32] then
			local l_CFrame_0 = v32.CFrame;
			local v34 = v32.Size * 0.5;
			for v35 = -1, 1, 2 do
				for v36 = -1, 1, 2 do
					for v37 = -1, 1, 2 do
						local v38 = l_CFrame_0:PointToWorldSpace((Vector3.new(v34.X * v35, v34.Y * v36, v34.Z * v37)));
						v25 = math.min(v25, v38.X);
						v26 = math.min(v26, v38.Y);
						v27 = math.min(v27, v38.Z);
						v28 = math.max(v28, v38.X);
						v29 = math.max(v29, v38.Y);
						v30 = math.max(v30, v38.Z);
					end;
				end;
			end;
		end;
	end;
	local v39 = Vector3.new(v28 - v25, v29 - v26, v30 - v27);
	local v40 = Vector3.new((v25 + v28) / 2, (v26 + v29) / 2, (v27 + v30) / 2);
	return CFrame.new(v40), v39;
end;
local function v56(v42, v43, v44, v45, v46, v47) --[[ Line: 77 ]] --[[ Name: FitCam ]]
	-- upvalues: v41 (copy), l_Unit_0 (copy)
	v46 = v46 or 0.8;
	v47 = v47 or 0.5;
	local v48 = {};
	if v43 == "Los Noobinis" then
		v48[v44["Cube.003"]] = true;
	end;
	local l_FakeRootPart_0 = v44:FindFirstChild("FakeRootPart");
	if l_FakeRootPart_0 then
		v48[l_FakeRootPart_0] = true;
	end;
	if v43 == "Tacorita Bicicleta" then
		local l_RootPart_0 = v44:FindFirstChild("RootPart");
		if l_RootPart_0 then
			v48[l_RootPart_0] = true;
		end;
	end;
	local _, v52 = v41(v44, v48);
	if v43 == "Tacorita Bicicleta" then
		v46 = v46 + 0.2;
	end;
	local v53 = if v43 == "Tacorita Bicicleta" then v44:GetPivot() + Vector3.new(0, v52.Y * 0.5, 0) else v44.PrimaryPart and v44.PrimaryPart.CFrame or v44:GetPivot();
	local v54 = math.max(v52.X, v52.Y, v52.Z);
	local v55 = v54 * 0.5 / math.tan((math.rad(v45 * 0.5))) * v46;
	v42.CFrame = CFrame.new((v53 * CFrame.new(l_Unit_0 * (v55 + v54 * v47))).Position, v53.Position);
end;
v21.GetSellValue = function(_, v58) --[[ Line: 116 ]] --[[ Name: GetSellValue ]]
	-- upvalues: v21 (copy), v8 (copy)
	return (math.ceil(v21:GetPrice(v58) * v8.Animal.SellModifier));
end;
local function _(v59, v60) --[[ Line: 120 ]] --[[ Name: ShouldIgnoreColor ]]
	local l_v59_Attribute_0 = v59:GetAttribute((("%*IgnoreColor"):format(v60)));
	if l_v59_Attribute_0 == false then
		return false;
	else
		return v59:GetAttribute("IgnoreColor") or l_v59_Attribute_0;
	end;
end;
v21.ApplyMutation = function(_, v64, v65, v66, v67) --[[ Line: 130 ]] --[[ Name: ApplyMutation ]]
	-- upvalues: v5 (copy), v11 (copy), l_MutationSurfaces_0 (copy), l_Vfx_0 (copy)
	local v68 = v5.new();
	if v67 then
		v68:Add(v64.Destroying:Connect(function() --[[ Line: 133 ]]
			-- upvalues: v68 (copy)
			v68:Destroy();
		end));
	else
		v68:Add(v64.AncestryChanged:Connect(function(_, v70) --[[ Line: 137 ]]
			-- upvalues: v68 (copy)
			if v70 then
				return;
			else
				v68:Destroy();
				return;
			end;
		end));
	end;
	local v71 = v11[v66];
	local v72 = l_MutationSurfaces_0[v65];
	local v73 = tonumber(v64:GetAttribute((("%*Palette"):format(v66))) or v64:GetAttribute("Palette") or 1) or 1;
	if not v71 or not v71.Palettes[v73] then
		v73 = 1;
	end;
	local v74 = {};
	if v66 == "Rainbow" then
		v68:Add(function() --[[ Line: 156 ]]
			-- upvalues: v64 (copy)
			v64:RemoveTag("RainbowModel");
		end);
		for _, v76 in v64:GetDescendants() do
			if v76:IsA("BasePart") and not v76:GetAttribute("IgnoreRainbowColor") then
				local l_SurfaceAppearance_0 = v76:FindFirstChildOfClass("SurfaceAppearance");
				if l_SurfaceAppearance_0 then
					v68:Add(function() --[[ Line: 167 ]]
						-- upvalues: v76 (copy), l_SurfaceAppearance_0 (copy)
						local l_SurfaceAppearance_1 = v76:FindFirstChildOfClass("SurfaceAppearance");
						if l_SurfaceAppearance_1 then
							l_SurfaceAppearance_1:Destroy();
						end;
						l_SurfaceAppearance_0:Clone().Parent = v76;
					end);
				else
					local l_Color_0 = v76.Color;
					v68:Add(function() --[[ Line: 177 ]]
						-- upvalues: v76 (copy), l_Color_0 (copy)
						v76.Color = l_Color_0;
					end);
					local l_MaterialVariant_0 = v76.MaterialVariant;
					if l_MaterialVariant_0 == "Strawberry Stud Light" or l_MaterialVariant_0 == "Strawberry Stud Dark" then
						v76.MaterialVariant = "";
						v68:Add(function() --[[ Line: 184 ]]
							-- upvalues: v76 (copy), l_MaterialVariant_0 (copy)
							v76.MaterialVariant = l_MaterialVariant_0;
						end);
					end;
				end;
			end;
		end;
		v64:AddTag("RainbowModel");
	else
		for _, v82 in v64:GetDescendants() do
			if v82:IsA("BasePart") then
				local l_v82_Attribute_0 = v82:GetAttribute((("%*IgnoreColor"):format(v66)));
				if not (l_v82_Attribute_0 ~= false and (v82:GetAttribute("IgnoreColor") or l_v82_Attribute_0)) then
					local v84 = v71.Palettes[v73];
					l_v82_Attribute_0 = v71.Palettes[v73];
					local v85 = tonumber(v82:GetAttribute((("%*Color"):format(v66))) or v82:GetAttribute("Color") or 1) or 1;
					local v86 = l_v82_Attribute_0[v85] or v84[v85] or l_v82_Attribute_0[math.clamp(v85, 1, #l_v82_Attribute_0)];
					local l_SurfaceAppearance_2 = v82:FindFirstChildOfClass("SurfaceAppearance");
					if l_SurfaceAppearance_2 then
						l_SurfaceAppearance_2:Destroy();
						local v88 = v68:Clone(v72);
						v88.Color = v86;
						v88.Parent = v82;
						v68:Add(function() --[[ Line: 212 ]]
							-- upvalues: v82 (copy), l_SurfaceAppearance_2 (copy)
							local l_SurfaceAppearance_3 = v82:FindFirstChildOfClass("SurfaceAppearance");
							if l_SurfaceAppearance_3 then
								l_SurfaceAppearance_3:Destroy();
							end;
							l_SurfaceAppearance_2:Clone().Parent = v82;
						end);
					else
						local l_MaterialVariant_1 = v82.MaterialVariant;
						if l_MaterialVariant_1 == "Strawberry Stud Light" or l_MaterialVariant_1 == "Strawberry Stud Dark" then
							v74[v82] = true;
							v82.MaterialVariant = ("%* Strawberry Stud Light"):format(v66);
							v68:Add(function() --[[ Line: 225 ]]
								-- upvalues: v82 (copy), l_MaterialVariant_1 (copy)
								v82.MaterialVariant = l_MaterialVariant_1;
							end);
							if l_MaterialVariant_1 == "Strawberry Stud Light" then
								continue;
							end;
						end;
						local l_Color_1 = v82.Color;
						v82.Color = v86;
						v68:Add(function() --[[ Line: 237 ]]
							-- upvalues: v82 (copy), l_Color_1 (copy)
							v82.Color = l_Color_1;
						end);
					end;
				end;
			end;
		end;
	end;
	if v66 == "Lava" then
		for _, v93 in v64:GetDescendants() do
			if v93:IsA("BasePart") and not v74[v93] then
				local l_v93_Attribute_0 = v93:GetAttribute((("%*IgnoreColor"):format(v66)));
				if not (l_v93_Attribute_0 ~= false and (v93:GetAttribute("IgnoreColor") or l_v93_Attribute_0)) and (v93:GetAttribute((("%*Color"):format(v66))) or v93:GetAttribute("Color")) == 1 then
					l_v93_Attribute_0 = v93.Material;
					v93.Material = Enum.Material.Neon;
					v68:Add(function() --[[ Line: 254 ]]
						-- upvalues: v93 (copy), l_v93_Attribute_0 (copy)
						v93.Material = l_v93_Attribute_0;
					end);
				end;
			end;
		end;
	elseif v66 == "Galaxy" then
		for _, v96 in v64:GetDescendants() do
			if v96:IsA("BasePart") and not v74[v96] then
				local l_v96_Attribute_0 = v96:GetAttribute((("%*IgnoreColor"):format(v66)));
				if not (l_v96_Attribute_0 ~= false and (v96:GetAttribute("IgnoreColor") or l_v96_Attribute_0)) then
					if (v96:GetAttribute((("%*Color"):format(v66))) or v96:GetAttribute("Color")) == 1 then
						l_v96_Attribute_0 = v96.Material;
						v96.Material = Enum.Material.Neon;
						local l_l_v96_Attribute_0_0 = l_v96_Attribute_0 --[[ copy: 16 -> 22 ]];
						v68:Add(function() --[[ Line: 269 ]]
							-- upvalues: v96 (copy), l_l_v96_Attribute_0_0 (copy)
							v96.Material = l_l_v96_Attribute_0_0;
						end);
					end;
					l_v96_Attribute_0 = v96.MaterialVariant;
					v96.MaterialVariant = "Galaxy Stud";
					v68:Add(function() --[[ Line: 276 ]]
						-- upvalues: v96 (copy), l_v96_Attribute_0 (copy)
						v96.MaterialVariant = l_v96_Attribute_0;
					end);
				end;
			end;
		end;
	elseif v66 == "YinYang" then
		for _, v100 in v64:GetDescendants() do
			if v100:IsA("BasePart") and not v74[v100] then
				local l_v100_Attribute_0 = v100:GetAttribute((("%*IgnoreColor"):format(v66)));
				if not (l_v100_Attribute_0 ~= false and (v100:GetAttribute("IgnoreColor") or l_v100_Attribute_0)) then
					local v102 = v100:GetAttribute((("%*Color"):format(v66))) or v100:GetAttribute("Color") or 1;
					l_v100_Attribute_0 = true;
					if v102 ~= 3 then
						l_v100_Attribute_0 = v102 == 4;
					end;
					if l_v100_Attribute_0 then
						v100.Material = Enum.Material.Neon;
					end;
				end;
			end;
		end;
	elseif v66 == "Radioactive" then
		for _, v_u_110 in v64:GetDescendants() do
			if v_u_110:IsA("BasePart") and not v74[v_u_110] then
				local v111 = v_u_110:GetAttribute((("%*IgnoreColor"):format(v66)))
				local v112
				if v111 == false then
					v112 = false
				else
					v112 = v_u_110:GetAttribute("IgnoreColor") or v111
				end
				if not v112 then
					local v_u_113 = v_u_110.MaterialVariant
					local v_u_114 = v_u_110.Material
					local v115 = v_u_110:GetAttribute((("%*Color"):format(v66))) or (v_u_110:GetAttribute("Color") or 1)
					local v116
					if v115 == 2 and v73 == 1 or v115 == 2 and v73 == 4 then
						v116 = true
					elseif v115 == 2 or v115 == 6 then
						v116 = v73 == 5
					else
						v116 = false
					end
					if v116 then
						v_u_110.Material = Enum.Material.Neon
						v68:Add(function()
							v_u_110.Material = v_u_114
						end)
					end
					local v117 = v_u_110:GetAttribute((("%*Stud"):format(v66)))
					if v117 == false or v_u_110.MaterialVariant ~= "Custom Stud" and v117 ~= true or v_u_110:GetAttribute((("%*Ignore"):format(v66))) then
						if v117 == false then
							v_u_110.MaterialVariant = ""
							v68:Add(function()
								v_u_110.MaterialVariant = v_u_113
							end)
						end
					elseif v_u_110:GetAttribute((("%*MaterialMode"):format(v66))) == 2 or v64:GetAttribute((("%*MaterialMode"):format(v66))) == 2 then
						if v_u_110:GetAttribute((("%*Material"):format(v66))) == 2 or v64:GetAttribute((("%*Material"):format(v66))) == 2 then
							v_u_110.Material = Enum.Material.SmoothPlastic
							v_u_110.MaterialVariant = "Radioactive Stud"
							v68:Add(function()
								v_u_110.MaterialVariant = v_u_113
								v_u_110.Material = v_u_114
							end)
						else
							v_u_110.Material = Enum.Material.SmoothPlastic
							v_u_110.MaterialVariant = "Radioactive Stud2"
							v68:Add(function()
								v_u_110.MaterialVariant = v_u_113
								v_u_110.Material = v_u_114
							end)
						end
					elseif v115 ~= 2 and v115 ~= 6 then
						if v_u_110:GetAttribute((("%*Material"):format(v66))) == 2 or v64:GetAttribute((("%*Material"):format(v66))) == 2 then
							v_u_110.Material = Enum.Material.SmoothPlastic
							v_u_110.MaterialVariant = "Radioactive Stud"
							v68:Add(function()
								v_u_110.MaterialVariant = v_u_113
								v_u_110.Material = v_u_114
							end)
						else
							v_u_110.Material = Enum.Material.SmoothPlastic
							v_u_110.MaterialVariant = "Radioactive Stud2"
							v68:Add(function()
								v_u_110.MaterialVariant = v_u_113
								v_u_110.Material = v_u_114
							end)
						end
					end
				end
			end
		end
	end;
	local l_l_Vfx_0_FirstChild_0 = l_Vfx_0:FindFirstChild(v66);
	local l_VfxInstance_0 = v64:FindFirstChild("VfxInstance");
	if l_l_Vfx_0_FirstChild_0 and l_VfxInstance_0 then
		for _, v106 in l_l_Vfx_0_FirstChild_0:GetChildren() do
			v68:Clone(v106).Parent = l_VfxInstance_0;
		end;
	end;
	return v68:WrapClean();
end;
v21.ApplyTraits = function(_, v108, v109, v110) --[[ Line: 307 ]] --[[ Name: ApplyTraits ]]
	-- upvalues: v5 (copy), v13 (copy), l_Models_0 (copy), l_ReplicatedStorage_0 (copy), v4 (copy), l_Traits_0 (copy), l_Traits_1 (copy)
	local v111 = v5.new();
	local v112 = {};
	for _, v114 in v110 do
		v112[v114] = true;
	end;
	for _, v116 in v110 do
		local function v128() --[[ Line: 316 ]] --[[ Name: loadSpecificAnimalModel ]]
			-- upvalues: v13 (ref), v116 (copy), l_Models_0 (ref), v109 (copy), v111 (copy), v108 (copy), l_ReplicatedStorage_0 (ref), v4 (ref)
			if not v13[v116] then
				return;
			else
				local l_FirstChild_0 = l_Models_0.TraitsPerAnimal:FindFirstChild(v116);
				if not l_FirstChild_0 then
					return;
				else
					local l_l_FirstChild_0_FirstChild_0 = l_FirstChild_0:FindFirstChild(v109);
					if not l_l_FirstChild_0_FirstChild_0 then
						return;
					else
						local v119 = v111:Clone(l_l_FirstChild_0_FirstChild_0);
						v119.Name = ("_Trait.%*"):format(v116);
						for _, v121 in v119:GetChildren() do
							local l_Attachment_0 = v121:FindFirstChildOfClass("Attachment");
							if l_Attachment_0 then
								local l_v108_FirstChild_0 = v108:FindFirstChild(l_Attachment_0.Name, true);
								if l_v108_FirstChild_0 then
									local l_RigidConstraint_0 = Instance.new("RigidConstraint");
									l_RigidConstraint_0.Attachment0 = l_Attachment_0;
									l_RigidConstraint_0.Attachment1 = l_v108_FirstChild_0;
									l_RigidConstraint_0.Parent = v121;
								end;
							end;
						end;
						v119.Parent = v108;
						if v116 == "Jackolantern Pet" then
							local l_v119_FirstChildWhichIsA_0 = v119:FindFirstChildWhichIsA("Animator", true);
							if l_v119_FirstChildWhichIsA_0 then
								l_v119_FirstChildWhichIsA_0:SetAttribute("Animation", "Animations.Traits.Jackolantern Pet");
								l_v119_FirstChildWhichIsA_0:AddTag("ClientLoadAnimation");
								local v126 = l_v119_FirstChildWhichIsA_0:LoadAnimation(l_ReplicatedStorage_0.Animations.Traits["Jackolantern Pet"].Walk);
								v111:Add(function() --[[ Line: 347 ]]
									-- upvalues: v126 (copy)
									v126:Stop(0);
									v126:Destroy();
								end);
								v111:Add(v4.observeAttribute(v108, "Walking", function(v127) --[[ Line: 352 ]]
									-- upvalues: v126 (copy)
									if v127 then
										if not v126.IsPlaying then
											v126:Play();
										end;
									elseif v126.IsPlaying then
										v126:Stop();
									end;
									return nil;
								end));
							end;
						end;
						return;
					end;
				end;
			end;
		end;
		local function v141() --[[ Line: 369 ]] --[[ Name: loadModels ]]
			-- upvalues: v13 (ref), v116 (copy), l_Traits_0 (ref), v111 (copy), v108 (copy), v112 (copy)
			local v129 = v13[v116];
			if not v129 then
				return;
			else
				local l_l_Traits_0_FirstChild_0 = l_Traits_0:FindFirstChild(v116);
				if not l_l_Traits_0_FirstChild_0 then
					return;
				else
					local v131 = v111:Clone(l_l_Traits_0_FirstChild_0);
					v131.Name = ("_Trait.%*"):format(v116);
					for _, v133 in v131:GetChildren() do
						local v134 = false;
						for _, v136 in v133:GetChildren() do
							if v136:IsA("Attachment") then
								local l_v108_FirstChild_1 = v108:FindFirstChild(v136.Name, true);
								if l_v108_FirstChild_1 then
									v134 = true;
									local v138 = Vector3.new(0, 0, 0, 0);
									if v116 == "10B" and v112["10B"] then
										v138 = v138 + Vector3.new(0, -1.4589999914169312, 0, 0);
									end;
									if (v116 == "Taco" or v116 == "10B") and v112["RIP Gravestone"] then
										v138 = v138 + Vector3.new(0, -3.5820000171661377, 0, 0);
									end;
									if (v116 == "Taco" or v116 == "10B" or v116 == "RIP Gravestone") and v112["Matteo Hat"] then
										v138 = v138 + Vector3.new(0, -1.3300000429153442, 0, 0);
									end;
									if (v116 == "Taco" or v116 == "10B" or v116 == "Matteo Hat" or v116 == "RIP Gravestone") and v112["Witch Hat"] then
										v138 = v138 + Vector3.new(0, -2.450000047683716, 0, 0);
									end;
									if (v116 == "Taco" or v116 == "10B" or v116 == "Matteo Hat" or v116 == "Witch Hat" or v116 == "RIP Gravestone") and v112.Sombrero then
										v138 = v138 + Vector3.new(0, -2.7279999256134033, 0, 0);
									end;
									if v138 ~= Vector3.new(0, 0, 0, 0) then
										v136.Position = v136.Position + v138;
									end;
									local l_RigidConstraint_1 = Instance.new("RigidConstraint");
									l_RigidConstraint_1.Attachment0 = v136;
									l_RigidConstraint_1.Attachment1 = l_v108_FirstChild_1;
									l_RigidConstraint_1.Parent = v133;
									if v129.Modify then
										v129.Modify(v133, v136, l_v108_FirstChild_1);
									end;
								end;
							end;
						end;
						if not v134 then
							v133:Destroy();
						end;
					end;
					v131.Parent = v108;
					if v112.Lightning then
						local l_v131_FirstChildWhichIsA_0 = v131:FindFirstChildWhichIsA("Animator", true);
						if l_v131_FirstChildWhichIsA_0 then
							l_v131_FirstChildWhichIsA_0:SetAttribute("Animation", "Animations.Traits.Lightning");
							l_v131_FirstChildWhichIsA_0:AddTag("ClientLoadAnimation");
						end;
					end;
					return;
				end;
			end;
		end;
		local function v149() --[[ Line: 443 ]] --[[ Name: loadVfx ]]
			-- upvalues: v13 (ref), v116 (copy), l_Traits_1 (ref), v108 (copy), v111 (copy)
			local v142 = v13[v116];
			if not v142 then
				return;
			else
				local l_l_Traits_1_FirstChild_0 = l_Traits_1:FindFirstChild(v116);
				if l_l_Traits_1_FirstChild_0 then
					for _, v145 in l_l_Traits_1_FirstChild_0:GetChildren() do
						local l_v108_FirstChild_2 = v108:FindFirstChild(v145.Name);
						if l_v108_FirstChild_2 then
							local v147 = v111:Clone(v145);
							v147.Massless = true;
							v147.CanCollide = false;
							v147.CanQuery = false;
							v147.CanTouch = false;
							v147.Transparency = 1;
							v147.CFrame = l_v108_FirstChild_2.CFrame;
							local v148 = Instance.new("WeldConstraint", v147);
							v148.Part0 = l_v108_FirstChild_2;
							v148.Part1 = v147;
							v147.Parent = v108;
							v147.Name = ("_%*"):format(v145.Name);
							if v142.ModifyVFX then
								v142.ModifyVFX(v147, l_v108_FirstChild_2);
							end;
						end;
					end;
				end;
				return;
			end;
		end;
		if v116 ~= "Strawberry" or v109 ~= "Strawberry Elephant" then
			v128();
			v141();
			v149();
			if v116 == "Strawberry" then
				for _, v151 in v108:GetDescendants() do
					if v151:IsA("BasePart") then
						local l_MaterialVariant_2 = v151.MaterialVariant;
						local l_Color_2 = v151.Color;
						if v151:HasTag("Strawberry") then
							v151.Color = Color3.fromRGB(255, 255, 255);
							v151.Material = Enum.Material.SmoothPlastic;
							v151.MaterialVariant = "Strawberry Stud Light";
							v111:Add(function() --[[ Line: 497 ]]
								-- upvalues: v151 (copy), l_MaterialVariant_2 (copy), l_Color_2 (copy)
								v151.MaterialVariant = l_MaterialVariant_2;
								v151.Color = l_Color_2;
							end);
						end;
						if v151:HasTag("Strawberry2") then
							v151.Color = Color3.fromRGB(193, 193, 193);
							v151.Material = Enum.Material.SmoothPlastic;
							v151.MaterialVariant = "Strawberry Stud Light";
							v111:Add(function() --[[ Line: 507 ]]
								-- upvalues: v151 (copy), l_MaterialVariant_2 (copy), l_Color_2 (copy)
								v151.MaterialVariant = l_MaterialVariant_2;
								v151.Color = l_Color_2;
							end);
						end;
						if v151:HasTag("Strawberry3") then
							v151.Color = Color3.fromRGB(147, 147, 147);
							v151.Material = Enum.Material.SmoothPlastic;
							v151.MaterialVariant = "Strawberry Stud Light";
							v111:Add(function() --[[ Line: 517 ]]
								-- upvalues: v151 (copy), l_MaterialVariant_2 (copy), l_Color_2 (copy)
								v151.MaterialVariant = l_MaterialVariant_2;
								v151.Color = l_Color_2;
							end);
						end;
					end;
				end;
			end;
		end;
	end;
	return v111:WrapClean();
end;
v21.GetAnimatedModel = function(_, v155, v156) --[[ Line: 529 ]] --[[ Name: GetAnimatedModel ]]
	-- upvalues: l_Animals_1 (copy), l_Animals_0 (copy)
	local l_l_Animals_1_FirstChild_0 = l_Animals_1:FindFirstChild(v155);
	if not l_l_Animals_1_FirstChild_0 then
		warn((("Animal not found %* in model folder"):format(v155)));
		return nil;
	else
		local v158 = l_l_Animals_1_FirstChild_0:Clone();
		if v158.PrimaryPart then
			v158.PrimaryPart.Anchored = true;
		end;
		v158.Parent = workspace;
		local l_l_Animals_0_FirstChild_0 = l_Animals_0:FindFirstChild(v155);
		local v160 = l_l_Animals_0_FirstChild_0 and l_l_Animals_0_FirstChild_0:FindFirstChild(v156);
		local v161 = v158:FindFirstChild("AnimationController") or Instance.new("AnimationController", v158);
		local v162 = v161:FindFirstChild("Animator") or Instance.new("Animator", v161);
		if v160 and v162 then
			local v163 = v162:LoadAnimation(v160);
			v163.Looped = true;
			v163:Play();
		end;
		for _, v165 in v158:GetDescendants() do
			if v165:IsA("BasePart") then
				v165.Massless = true;
				v165.CanCollide = false;
				v165.CanQuery = false;
				v165.CanTouch = false;
				v165.Anchored = false;
			end;
		end;
		return v158;
	end;
end;
v21.AttachOnViewportWithOptimizations = function(_, v167, v168, _, v170, _) --[[ Line: 573 ]] --[[ Name: AttachOnViewportWithOptimizations ]]
	-- upvalues: v5 (copy), l_Animals_1 (copy), v21 (copy), v4 (copy), l_Animals_0 (copy), v56 (copy)
	local v172 = v5.new();
	local l_l_Animals_1_FirstChild_1 = l_Animals_1:FindFirstChild(v167);
	if not l_l_Animals_1_FirstChild_1 then
		warn((("Animal not found %* in model folder"):format(v167)));
		return v172;
	else
		local v174 = v172:Clone(l_l_Animals_1_FirstChild_1);
		local v175 = v172:Add(Instance.new("WorldModel"));
		v174.Parent = v175;
		local v176 = true;
		v172:Add(function() --[[ Line: 587 ]]
			-- upvalues: v176 (ref)
			v176 = false;
		end);
		v172:Add(v168.Destroying:Connect(function() --[[ Line: 591 ]]
			-- upvalues: v172 (copy)
			v172:Destroy();
		end));
		if v170 and v170 ~= "Default" then
			v172:Add(v21:ApplyMutation(v174, v167, v170));
		end;
		local function v177() --[[ Line: 599 ]] --[[ Name: unparent ]]
			-- upvalues: v176 (ref), v175 (copy)
			if v176 then
				v175.Parent = nil;
			end;
		end;
		local function v188(v178) --[[ Line: 605 ]] --[[ Name: updateAncestry ]]
			-- upvalues: v177 (copy), v4 (ref), v176 (ref), v175 (copy), v168 (copy), l_Animals_0 (ref), v167 (copy), v174 (copy)
			if not v178 then
				return v177;
			else
				local l_v178_FirstAncestorWhichIsA_0 = v178:FindFirstAncestorWhichIsA("LayerCollector");
				if not l_v178_FirstAncestorWhichIsA_0 then
					return v177;
				else
					local l_GuiObject_0 = l_v178_FirstAncestorWhichIsA_0:FindFirstChildWhichIsA("GuiObject");
					if not l_GuiObject_0 then
						return v177;
					else
						return v4.observeProperty(l_v178_FirstAncestorWhichIsA_0, "Enabled", function(v181) --[[ Line: 620 ]]
							-- upvalues: v177 (ref), v4 (ref), l_GuiObject_0 (copy), v176 (ref), v175 (ref), v168 (ref), l_Animals_0 (ref), v167 (ref), v174 (ref)
							if not v181 then
								return v177;
							else
								return v4.observeProperty(l_GuiObject_0, "Visible", function(v182) --[[ Line: 625 ]]
									-- upvalues: v177 (ref), v176 (ref), v175 (ref), v168 (ref), l_Animals_0 (ref), v167 (ref), v174 (ref)
									if not v182 then
										return v177;
									else
										if v176 then
											v175.Parent = v168;
										end;
										task.spawn(function() --[[ Line: 636 ]]
											-- upvalues: v176 (ref), l_Animals_0 (ref), v167 (ref), v174 (ref)
											if not v176 then
												return;
											else
												local l_l_Animals_0_FirstChild_1 = l_Animals_0:FindFirstChild(v167);
												local v184 = l_l_Animals_0_FirstChild_1 and l_l_Animals_0_FirstChild_1:FindFirstChild("Idle");
												local v185 = v174:FindFirstChild("AnimationController") or Instance.new("AnimationController", v174);
												local v186 = v185:FindFirstChild("Animator") or Instance.new("Animator", v185);
												if v184 and v186 then
													local v187 = v186:LoadAnimation(v184);
													v187.Looped = true;
													v187:Play(0);
												end;
												return;
											end;
										end);
										return v177;
									end;
								end);
							end;
						end);
					end;
				end;
			end;
		end;
		local v189 = nil;
		local function _(v190) --[[ Line: 660 ]] --[[ Name: requestUpdateAncestry ]]
			-- upvalues: v189 (ref), v188 (copy)
			if type(v189) == "function" then
				v189();
			end;
			v189 = v188(v190);
		end;
		v172:Add(v168.AncestryChanged:Connect(function(_, v193) --[[ Line: 668 ]]
			-- upvalues: v189 (ref), v188 (copy)
			if type(v189) == "function" then
				v189();
			end;
			v189 = v188(v193);
		end));
		if v168.Parent then
			local l_Parent_0 = v168.Parent;
			if type(v189) == "function" then
				v189();
			end;
			v189 = v188(l_Parent_0);
		end;
		local v195 = v172:Add(Instance.new("Camera"));
		v195.FieldOfView = 50;
		v195.Parent = v168;
		v168.CurrentCamera = v195;
		v56(v195, v167, v174, v195.FieldOfView, 0.75, 0.7);
		return v172, v174;
	end;
end;
v21.AttachOnViewport = function(_, v197, v198, _, v200, _) --[[ Line: 687 ]] --[[ Name: AttachOnViewport ]]
	-- upvalues: v21 (copy), v5 (copy), l_Animals_1 (copy), l_Animals_0 (copy), v56 (copy)
	return v21:AttachOnViewportWithOptimizations(v197, v198, nil, v200);
end;
v21.GetListOfRarity = function(_, v203) --[[ Line: 764 ]] --[[ Name: GetListOfRarity ]]
	-- upvalues: v7 (copy)
	local v204 = {};
	for v205, v206 in v7 do
		if v206.Rarity == v203 then
			table.insert(v204, v205);
		end;
	end;
	return v204;
end;
v21.GetList = function(_, v208, v209) --[[ Line: 775 ]] --[[ Name: GetList ]]
	-- upvalues: v7 (copy), v10 (copy)
	local v210 = {};
	for v211, v212 in v7 do
		if not v212.IsEnabled or v212.IsEnabled() then
			table.insert(v210, v211);
		end;
	end;
	if v208 == "Rarity" then
		table.sort(v210, function(v213, v214) --[[ Line: 786 ]]
			-- upvalues: v7 (ref), v10 (ref), v209 (copy)
			local v215 = v7[v213];
			local v216 = v7[v214];
			local v217 = v215 and v215.Rarity;
			local v218 = v216 and v216.Rarity;
			local v219 = v217 and v10[v217] and v10[v217].Weight or 0;
			local v220 = v218 and v10[v218] and v10[v218].Weight or 0;
			if v209 then
				return v219 < v220;
			else
				return v220 < v219;
			end;
		end);
		return v210;
	elseif v208 == "Price" then
		table.sort(v210, function(v221, v222) --[[ Line: 802 ]]
			-- upvalues: v7 (ref), v209 (copy)
			local v223 = v7[v221];
			local v224 = v7[v222];
			local v225 = v223 and v223.Price or 0;
			local v226 = v224 and v224.Price or 0;
			if v209 then
				return v225 < v226;
			else
				return v226 < v225;
			end;
		end);
		return v210;
	else
		if v208 == "Generation" then
			table.sort(v210, function(v227, v228) --[[ Line: 815 ]]
				-- upvalues: v7 (ref), v209 (copy)
				local v229 = v7[v227];
				local v230 = v7[v228];
				local v231 = v229 and v229.Generation or 0;
				local v232 = v230 and v230.Generation or 0;
				if v209 then
					return v231 < v232;
				else
					return v232 < v231;
				end;
			end);
		end;
		return v210;
	end;
end;
v21.GetGeneration = function(_, v234, v235, v236, v237) --[[ Line: 833 ]] --[[ Name: GetGeneration ]]
	-- upvalues: v7 (copy), v8 (copy), v11 (copy), v13 (copy), l_ReplicatedStorage_0 (copy)
	local v238 = 0;
	local v239 = v7[v234];
	if not v239 then
		return v238;
	else
		v238 = if v239.Generation then v238 + v239.Generation else v238 + v239.Price * v8.Game.AnimalGanerationModifier;
		local v240 = 1;
		if v235 then
			v240 = v240 + v11[v235].Modifier;
		end;
		local v241 = false;
		if v236 then
			for _, v243 in v236 do
				local v244 = v13[v243];
				if v244 then
					if v243 == "Sleepy" then
						v241 = true;
					else
						v240 = v240 + v244.MultiplierModifier;
					end;
				end;
			end;
		end;
		v238 = v238 * v240;
		if v241 then
			v238 = v238 * 0.5;
		end;
		if v237 then
			v238 = v238 * require(l_ReplicatedStorage_0.Shared.Game):GetPlayerCashMultiplayer(v237);
		end;
		return (math.round(v238));
	end;
end;
v21.GetPrice = function(_, v246, _) --[[ Line: 884 ]] --[[ Name: GetPrice ]]
	-- upvalues: v7 (copy)
	return v7[v246].Price;
end;
v21.GetRarityStringFormat = function(_, v249) --[[ Line: 891 ]] --[[ Name: GetRarityStringFormat ]]
	-- upvalues: v10 (copy)
	local v250 = v10[v249];
	if v249 == "OG" then
		return "<og>%s</og>";
	elseif v249 == "Admin" or v249 == "Taco" or v249 == "Spooky" then
		return "<yellowred>%s</yellowred>";
	elseif v249 == "Secret" then
		return "<zebra>%s</zebra>";
	elseif v249 == "Brainrot God" then
		return "<rainbow>%s</rainbow>";
	elseif v250 == "Radioactive" then
		return "<radioactive>%s</radioactive>";
	elseif v250 then
		return (("<font color=\"#%*\">%%s</font>"):format((v250.Color:ToHex())));
	else
		return "%s";
	end;
end;
return v21;