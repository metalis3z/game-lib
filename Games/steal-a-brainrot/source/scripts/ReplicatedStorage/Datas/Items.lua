-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--!native
local l_Debris_0 = game:GetService("Debris");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("ReplicatedStorage");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_ReplicatedStorage_1 = game:GetService("ReplicatedStorage");
local l_Packages_0 = l_ReplicatedStorage_1:WaitForChild("Packages");
local v6 = require(l_Packages_0.Net);
local v7 = require(l_Packages_0.Debounce);
local v8 = require(l_ReplicatedStorage_1.Packages.FFlags);
local _ = require(l_ReplicatedStorage_1.Packages.Trove);
local v10 = require(l_ReplicatedStorage_1.Shared.VFX);
local v11 = nil;
if l_RunService_0:IsServer() then
	v11 = require(l_ServerScriptService_0.Services.CombatService);
end;
local v12 = {};
local v13 = 0;
l_RunService_0.Heartbeat:Connect(function(v14) --[[ Line: 26 ]]
	-- upvalues: v13 (ref), v12 (copy)
	debug.profilebegin("Items:UpdateHUE");
	v13 = v13 + v14 * 0.2;
	if v13 > 1 then
		v13 = v13 - 1;
	end;
	local v15 = Color3.fromHSV(v13, 1, 1);
	for _, v17 in v12 do
		if v17 and v17.Parent then
			v17.FillColor = v15;
		end;
	end;
	debug.profileend();
end);
local v18 = nil;
local v19 = nil;
local v20 = nil;
local v21 = nil;
if l_RunService_0:IsServer() then
	local l_Services_0 = l_ServerScriptService_0.Services;
	v21 = require(l_Services_0.StealService);
	local l_ToolsCode_0 = l_ServerScriptService_0.ToolsCode;
	v18 = l_ToolsCode_0.AdditionalItems;
	v19 = l_ToolsCode_0.AdditionalScripts;
	v20 = l_ToolsCode_0.AdditionalSounds;
end;
return {
	Slap = {
		Name = "Slap", 
		Icon = "rbxassetid://111744314864127", 
		Cooldown = 0.7, 
		Force = 550, 
		RagdollDuration = 3
	}, 
	["Iron Slap"] = {
		Name = "Iron Slap", 
		Icon = "rbxassetid://126416331206871", 
		Cooldown = 0.7, 
		Force = 600, 
		RagdollDuration = 3
	}, 
	["Gold Slap"] = {
		Name = "Gold Slap", 
		Icon = "rbxassetid://73587459668895", 
		Cooldown = 0.7, 
		Force = 650, 
		RagdollDuration = 3
	}, 
	["Diamond Slap"] = {
		Name = "Diamond Slap", 
		Icon = "rbxassetid://103400414014905", 
		Cooldown = 0.7, 
		Force = 700, 
		RagdollDuration = 3
	}, 
	["Emerald Slap"] = {
		Name = "Emerald Slap", 
		Icon = "rbxassetid://125486072175077", 
		Cooldown = 0.7, 
		Force = 750, 
		RagdollDuration = 3
	}, 
	["Ruby Slap"] = {
		Name = "Ruby Slap", 
		Icon = "rbxassetid://135484448648993", 
		Cooldown = 0.7, 
		Force = 800, 
		RagdollDuration = 3
	}, 
	["Blackhole Slap"] = {
		Name = "Blackhole Slap", 
		Icon = "rbxassetid://78729379185611", 
		Cooldown = 0.7, 
		Force = 850, 
		RagdollDuration = 3, 
		HasHighlight = false, 
		HighlightConfig = {
			FillColor = Color3.fromRGB(255, 0, 0), 
			FillTransparency = 0.5
		}
	}, 
	["Flame Slap"] = {
		Name = "Flame Slap", 
		Icon = "rbxassetid://107751993012682", 
		Cooldown = 0.7, 
		Force = 850, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			OutlineColor = Color3.fromRGB(), 
			OutlineTransparency = 0
		}
	}, 
	["Dark Matter Slap"] = {
		Name = "Dark Matter Slap", 
		Icon = "rbxassetid://116359699709899", 
		Cooldown = 0.7, 
		Force = 900, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 0.9, 
			OutlineTransparency = 0
		}
	}, 
	["Nuclear Slap"] = {
		Name = "Nuclear Slap", 
		Icon = "rbxassetid://94800671695541", 
		Cooldown = 0.7, 
		Force = 950, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			OutlineColor = Color3.fromRGB(234, 255, 0), 
			OutilineTransparency = 0
		}
	}, 
	["Galaxy Slap"] = {
		Name = "Galaxy Slap", 
		Icon = "rbxassetid://79582982176990", 
		Cooldown = 0.7, 
		Force = 1050, 
		RagdollDuration = 3, 
		HasHighlight = true
	}, 
	["Bloodmoon Slap"] = {
		Name = "Bloodmoon Slap", 
		Icon = "rbxassetid://105241258528205", 
		Cooldown = 0.7, 
		Force = 1050, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 0.9, 
			OutlineTransparency = 0
		}
	}, 
	["Glitched Slap"] = {
		Name = "Glitched Slap", 
		Icon = "rbxassetid://87821905406599", 
		Cooldown = 0.7, 
		Force = 1150, 
		RagdollDuration = 3, 
		HasHighlight = true
	}, 
	["Rainbow Slap"] = {
		Name = "Rainbow Slap", 
		Icon = "rbxassetid://76888105480836", 
		Cooldown = 0.7, 
		Force = 1150, 
		RagdollDuration = 3, 
		HasHighlight = true
	}, 
	["Candy Slap"] = {
		Name = "Candy Slap", 
		Icon = "rbxassetid://116411677446062", 
		Cooldown = 0.7, 
		Force = 1200, 
		RagdollDuration = 3, 
		HasHighlight = true
	}, 
	["Lava Slap"] = {
		Name = "Lava Slap", 
		Icon = "rbxassetid://80560167115825", 
		Cooldown = 0.7, 
		Force = 1200, 
		RagdollDuration = 3, 
		HasHighlight = true
	}, 
	["Splatter Slap"] = {
		Name = "Splatter Slap", 
		Icon = "rbxassetid://88294870214352", 
		Cooldown = 0.7, 
		Force = 1200, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		OnHit = function(v24) --[[ Line: 249 ]] --[[ Name: OnHit ]]
			-- upvalues: l_RunService_0 (copy), v6 (copy)
			if l_RunService_0:IsServer() then
				v6:RemoteEvent("UseItem"):FireClient(v24, "PaintballHitted", 9);
			end;
		end
	}, 
	["Alien Slap"] = {
		Name = "Alien Slap", 
		Icon = "rbxassetid://89070555394271", 
		Cooldown = 0.7, 
		Force = 1250, 
		RagdollDuration = 5, 
		HasHighlight = true, 
		OnHit = function(v25, v26) --[[ Line: 263 ]] --[[ Name: OnHit ]]
			-- upvalues: v20 (ref)
			local l_AlienSlap_0 = script:FindFirstChild("AlienSlap");
			if not l_AlienSlap_0 then
				return;
			else
				local l_HumanoidRootPart_0 = v26:FindFirstChild("HumanoidRootPart");
				local v29 = l_HumanoidRootPart_0 and l_HumanoidRootPart_0:FindFirstChild("RootAttachment");
				local l_Humanoid_0 = v26:FindFirstChildOfClass("Humanoid");
				if not l_HumanoidRootPart_0 or not l_Humanoid_0 or not v29 then
					return;
				else
					task.wait(1);
					local function v35(v31) --[[ Line: 285 ]] --[[ Name: GetGround ]]
						-- upvalues: v26 (copy)
						local v32 = RaycastParams.new();
						v32.FilterType = Enum.RaycastFilterType.Exclude;
						v32.FilterDescendantsInstances = {
							v26
						};
						local v33 = v31 + Vector3.new(0, 3, 0, 0);
						local v34 = workspace:Raycast(v33, Vector3.new(0, -20, 0, 0), v32);
						if v34 then
							return v34.Position;
						else
							return v31 - Vector3.new(0, 3, 0, 0);
						end;
					end;
					local function _() --[[ Line: 301 ]] --[[ Name: IsOnGround ]]
						-- upvalues: l_HumanoidRootPart_0 (copy)
						return math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
					end;
					local function _() --[[ Line: 305 ]] --[[ Name: IsStandingStill ]]
						-- upvalues: l_HumanoidRootPart_0 (copy)
						local l_AssemblyLinearVelocity_0 = l_HumanoidRootPart_0.AssemblyLinearVelocity;
						local l_Magnitude_0 = Vector3.new(l_AssemblyLinearVelocity_0.X, 0, l_AssemblyLinearVelocity_0.Z).Magnitude;
						local v39 = false;
						if l_Magnitude_0 < 1 then
							v39 = math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
						end;
						return v39;
					end;
					local v41 = 0;
					local v42 = os.clock();
					while os.clock() - v42 < 5 do
						if math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5 then
							local l_AssemblyLinearVelocity_1 = l_HumanoidRootPart_0.AssemblyLinearVelocity;
							local l_Magnitude_1 = Vector3.new(l_AssemblyLinearVelocity_1.X, 0, l_AssemblyLinearVelocity_1.Z).Magnitude;
							local v45 = false;
							if l_Magnitude_1 < 1 then
								v45 = math.abs(l_HumanoidRootPart_0.AssemblyLinearVelocity.Y) < 1.5;
							end;
							if v45 then
								v41 = v41 + task.wait(0.05);
								if v41 < 0.3 then
									continue;
								else
									break;
								end;
							end;
						end;
						v41 = 0;
						task.wait(0.05);
					end;
					if v41 < 0.3 then
						return;
					else
						local v46 = {};
						for v47 = 1, 4 do
							local v48 = v47 / 4 * 3.141592653589793 * 2;
							local v49 = Vector3.new(math.cos(v48), 0, (math.sin(v48))) * 5;
							local v50 = v35(l_HumanoidRootPart_0.Position + v49);
							local l_florPart_0 = l_AlienSlap_0:FindFirstChild("florPart");
							if l_florPart_0 then
								local v52 = l_florPart_0:Clone();
								v52.Anchored = true;
								v52.CFrame = CFrame.new(v50);
								v52.Parent = workspace;
								table.insert(v46, v52);
							end;
						end;
						local _ = v35(l_HumanoidRootPart_0.Position);
						local l_Part_0 = l_AlienSlap_0:FindFirstChild("Part");
						local v55 = nil;
						if l_Part_0 then
							v55 = l_Part_0["002"]:Clone();
							v55.WorldCFrame = v29.WorldCFrame;
							v55.CFrame = v29.CFrame;
							v55.Parent = v29;
							for _, v57 in v46 do
								for _, v59 in v57["001"]:GetChildren() do
									if v59:IsA("Beam") then
										v59.Attachment0 = v57["001"];
										v59.Attachment1 = v55;
									end;
								end;
							end;
						end;
						local v60 = v20["Alien slap"]:Clone();
						v60.Parent = l_HumanoidRootPart_0;
						v60:Play();
						v25:SetAttribute("Freeze", true);
						task.delay(3, function() --[[ Line: 372 ]]
							-- upvalues: v55 (ref), v46 (copy), v25 (copy)
							if v55 and v55.Parent then
								v55:Destroy();
							end;
							for _, v62 in v46 do
								if v62 and v62.Parent then
									v62:Destroy();
								end;
							end;
							v25:SetAttribute("Freeze", false);
						end);
						return;
					end;
				end;
			end;
		end
	}, 
	["Yin Yang Slap"] = {
		Name = "Yin Yang Slap", 
		Icon = "rbxassetid://72523518394942", 
		Cooldown = 0.7, 
		Force = 1260, 
		RagdollDuration = 6, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 1, 
			OutlineTransparency = 0, 
			OutlineColor = Color3.fromRGB(255, 0, 0)
		}, 
		OnHit = function(_, v64) --[[ Line: 398 ]] --[[ Name: OnHit ]]
			-- upvalues: l_Debris_0 (copy)
			local l_YinYangSlap_0 = script.YinYangSlap;
			local l_HumanoidRootPart_1 = v64:FindFirstChild("HumanoidRootPart");
			local v67 = l_HumanoidRootPart_1 and l_HumanoidRootPart_1:FindFirstChild("RootAttachment");
			local l_Humanoid_1 = v64:FindFirstChildOfClass("Humanoid");
			if not l_HumanoidRootPart_1 or not l_Humanoid_1 or not v67 then
				return;
			else
				local function _(v69) --[[ Line: 412 ]] --[[ Name: isColorable ]]
					if v69:IsA("Accessory") or v69:IsA("Tool") then
						return false;
					elseif v69:IsA("BasePart") and v69.Name ~= "HumanoidRootPart" then
						return true;
					else
						return false;
					end;
				end;
				local function v75(v71) --[[ Line: 422 ]] --[[ Name: GetGround ]]
					-- upvalues: v64 (copy)
					local v72 = RaycastParams.new();
					v72.FilterType = Enum.RaycastFilterType.Exclude;
					v72.FilterDescendantsInstances = {
						v64
					};
					local v73 = v71 + Vector3.new(0, 3, 0, 0);
					local v74 = workspace:Raycast(v73, Vector3.new(0, -20, 0, 0), v72);
					if v74 then
						return v74.Position;
					else
						return v71 - Vector3.new(0, 3, 0, 0);
					end;
				end;
				local function _() --[[ Line: 438 ]] --[[ Name: IsOnGround ]]
					-- upvalues: l_HumanoidRootPart_1 (copy)
					return math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
				end;
				local function _() --[[ Line: 442 ]] --[[ Name: IsStandingStill ]]
					-- upvalues: l_HumanoidRootPart_1 (copy)
					local l_AssemblyLinearVelocity_2 = l_HumanoidRootPart_1.AssemblyLinearVelocity;
					local l_Magnitude_2 = Vector3.new(l_AssemblyLinearVelocity_2.X, 0, l_AssemblyLinearVelocity_2.Z).Magnitude;
					local v79 = false;
					if l_Magnitude_2 < 1 then
						v79 = math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
					end;
					return v79;
				end;
				task.wait(1);
				local l_Shirt_0 = v64:FindFirstChildOfClass("Shirt");
				if l_Shirt_0 then
					l_Shirt_0.Parent = nil;
				end;
				local l_Pants_0 = v64:FindFirstChildOfClass("Pants");
				if l_Pants_0 then
					l_Pants_0.Parent = nil;
				end;
				local v83 = {};
				local v84 = {};
				for _, v86 in v64:GetChildren() do
					if not v86:IsA("Accessory") and not v86:IsA("Tool") and if v86:IsA("BasePart") then v86.Name ~= "HumanoidRootPart" else false then
						table.insert(v83, v86);
						table.insert(v84, {
							part = v86, 
							color = v86.Color
						});
					end;
				end;
				for _, v88 in v83 do
					v88.Color = math.random(1, 2) == 1 and Color3.fromRGB() or Color3.fromRGB(255, 255, 255);
				end;
				local l_Head_0 = v64:FindFirstChild("Head");
				if l_Head_0 then
					local v90 = l_YinYangSlap_0.SleepVFX.SLEEPY_VFX_ATTACHMENT:Clone();
					v90.Parent = l_Head_0;
					l_Debris_0:AddItem(v90, 6);
				end;
				local v91 = 0;
				local v92 = os.clock();
				while os.clock() - v92 < 5 do
					if math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5 then
						local l_AssemblyLinearVelocity_3 = l_HumanoidRootPart_1.AssemblyLinearVelocity;
						local l_Magnitude_3 = Vector3.new(l_AssemblyLinearVelocity_3.X, 0, l_AssemblyLinearVelocity_3.Z).Magnitude;
						local v95 = false;
						if l_Magnitude_3 < 1 then
							v95 = math.abs(l_HumanoidRootPart_1.AssemblyLinearVelocity.Y) < 1.5;
						end;
						if v95 then
							v91 = v91 + task.wait(0.05);
							if v91 < 0.3 then
								continue;
							else
								break;
							end;
						end;
					end;
					v91 = 0;
					task.wait(0.05);
				end;
				if v91 < 0.3 then
					return;
				else
					local v96 = v75(l_HumanoidRootPart_1.Position);
					local l_yinyang_0 = l_YinYangSlap_0:FindFirstChild("yinyang");
					if l_yinyang_0 then
						local v98 = l_yinyang_0:Clone();
						v98.CFrame = CFrame.new(v96);
						v98.Parent = workspace;
						l_Debris_0:AddItem(v98, 4);
					end;
					task.delay(4, function() --[[ Line: 507 ]]
						-- upvalues: v84 (copy), l_Shirt_0 (copy), v64 (copy), l_Pants_0 (copy)
						for _, v100 in v84 do
							if v100.part and v100.part.Parent then
								v100.part.Color = v100.color;
							end;
						end;
						if l_Shirt_0 then
							l_Shirt_0.Parent = v64;
						end;
						if l_Pants_0 then
							l_Pants_0.Parent = v64;
						end;
					end);
					return;
				end;
			end;
		end
	}, 
	["Radioactive Slap"] = {
		Name = "Radioactive Slap", 
		Icon = "rbxassetid://134911999156077", 
		Cooldown = 0.7, 
		Force = 1200, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 1, 
			OutlineTransparency = 0, 
			OutlineColor = Color3.fromRGB(0, 255, 0)
		}, 
		OnHit = function(v101, v102, v103) --[[ Line: 537 ]] --[[ Name: OnHit ]]
			-- upvalues: l_RunService_0 (copy), v11 (ref)
			local l_Humanoid_2 = v102:FindFirstChildOfClass("Humanoid");
			local l_HumanoidRootPart_2 = v102:FindFirstChild("HumanoidRootPart");
			if not l_Humanoid_2 or not l_HumanoidRootPart_2 then
				return;
			else
				local l_Highlight_0 = Instance.new("Highlight");
				l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
				l_Highlight_0.FillColor = Color3.fromRGB(0, 255, 0);
				l_Highlight_0.FillTransparency = 0.5;
				l_Highlight_0.OutlineColor = Color3.fromRGB(75, 155, 0);
				l_Highlight_0.OutlineTransparency = 0;
				l_Highlight_0.Adornee = v102;
				l_Highlight_0.Parent = v102;
				task.delay(5, function() --[[ Line: 551 ]]
					-- upvalues: l_RunService_0 (ref), v11 (ref), v101 (copy), v103 (copy)
					if l_RunService_0:IsServer() then
						v11:ApplyImpulse(v101, 500, Vector3.new(), true, 3, true, {
							Tag = "Radioactive Slap", 
							Player = v103
						});
					end;
				end);
				task.delay(8, function() --[[ Line: 560 ]]
					-- upvalues: l_Highlight_0 (copy)
					l_Highlight_0:Destroy();
				end);
				return;
			end;
		end
	}, 
	["Cursed Slap"] = {
		Name = "Cursed Slap", 
		Icon = "rbxassetid://101392764194646", 
		Cooldown = 0.7, 
		Force = 1300, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 1, 
			OutlineTransparency = 0, 
			OutlineColor = Color3.fromRGB(255, 23, 23)
		}, 
		OnHit = function(v107, v108, v109) --[[ Line: 578 ]] --[[ Name: OnHit ]]
			-- upvalues: l_ServerScriptService_0 (copy)
			local l_Humanoid_3 = v108:FindFirstChildOfClass("Humanoid");
			local l_HumanoidRootPart_3 = v108:FindFirstChild("HumanoidRootPart");
			if not l_Humanoid_3 or not l_HumanoidRootPart_3 then
				return;
			else
				local l_Highlight_1 = Instance.new("Highlight");
				l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
				l_Highlight_1.FillColor = Color3.fromRGB(255, 23, 23);
				l_Highlight_1.FillTransparency = 0.5;
				l_Highlight_1.OutlineColor = Color3.fromRGB(155, 0, 0);
				l_Highlight_1.OutlineTransparency = 0;
				l_Highlight_1.Adornee = v108;
				l_Highlight_1.Parent = v108;
				local v113 = require(l_ServerScriptService_0.Services.ItemService.Demon);
				task.delay(1, function() --[[ Line: 593 ]]
					-- upvalues: v107 (copy), v113 (copy), l_HumanoidRootPart_3 (copy), v109 (copy), l_Highlight_1 (copy)
					local v114 = os.clock();
					while os.clock() - v114 < 5 do
						local l_v107_Attribute_0 = v107:GetAttribute("RagdollEndTime");
						local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
						if l_v107_Attribute_0 and l_v107_Attribute_0 >= l_workspace_ServerTimeNow_0 then
							task.wait(0.5);
						else
							break;
						end;
					end;
					task.wait(0.3);
					v113.FreezePlayer(v107, l_HumanoidRootPart_3, v109, 4);
					l_Highlight_1:Destroy();
				end);
				return;
			end;
		end
	}, 
	["Divine Slap"] = {
		Name = "Divine Slap", 
		Icon = "rbxassetid://107787439485133", 
		Cooldown = 0.7, 
		Force = 1400, 
		RagdollDuration = 3, 
		HasHighlight = true, 
		HighlightConfig = {
			FillTransparency = 1, 
			OutlineTransparency = 0, 
			OutlineColor = Color3.fromRGB(255, 240, 23)
		}, 
		OnHit = function(v117, v118, _, _) --[[ Line: 627 ]] --[[ Name: OnHit ]]
			-- upvalues: v8 (copy), v10 (copy)
			local l_Humanoid_4 = v118:FindFirstChildOfClass("Humanoid");
			local l_HumanoidRootPart_4 = v118:FindFirstChild("HumanoidRootPart");
			local l_UpperTorso_0 = v118:FindFirstChild("UpperTorso");
			if not l_Humanoid_4 or not l_HumanoidRootPart_4 or not l_UpperTorso_0 then
				return;
			else
				local l_Highlight_2 = Instance.new("Highlight");
				l_Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded;
				l_Highlight_2.FillColor = Color3.fromRGB(251, 255, 23);
				l_Highlight_2.FillTransparency = 0.85;
				l_Highlight_2.OutlineColor = Color3.fromRGB(155, 150, 0);
				l_Highlight_2.OutlineTransparency = 0;
				l_Highlight_2.Adornee = v118;
				l_Highlight_2.Parent = v118;
				task.delay(1, function() --[[ Line: 642 ]]
					-- upvalues: v117 (copy), v8 (ref), v118 (copy), v10 (ref), l_UpperTorso_0 (copy), l_HumanoidRootPart_4 (copy), l_Highlight_2 (copy)
					local v125 = os.clock();
					while os.clock() - v125 < 5 do
						local l_v117_Attribute_0 = v117:GetAttribute("RagdollEndTime");
						local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
						if l_v117_Attribute_0 and l_v117_Attribute_0 - 0.1 >= l_workspace_ServerTimeNow_1 then
							task.wait(0.1);
						else
							break;
						end;
					end;
					local l_v8_Instant_0 = v8:GetInstant("DivineSlap/Delay", 1.7);
					local l_v8_Instant_1 = v8:GetInstant("DivineSlap/ExtraRagdollTime", 0.9);
					v117:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow() + l_v8_Instant_0 + l_v8_Instant_1);
					local v130 = script.DivineSlap.TEMP_Halo:Clone();
					v130.Parent = v118;
					local v131 = script.DivineSlap.HitEffect:Clone();
					v10.emit(v131);
					local l_Weld_0 = Instance.new("Weld");
					l_Weld_0.Part0 = v131;
					l_Weld_0.Part1 = l_UpperTorso_0;
					l_Weld_0.Parent = v131;
					v131.Parent = l_UpperTorso_0;
					local l_LinearVelocity_0 = Instance.new("LinearVelocity");
					l_LinearVelocity_0.Name = "FloatVelocity";
					l_LinearVelocity_0.Attachment0 = l_HumanoidRootPart_4:FindFirstChildOfClass("Attachment");
					l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
					l_LinearVelocity_0.VectorVelocity = Vector3.new(0, v8:GetInstant("DivineSlap/UpwardsForce", 20), 0);
					l_LinearVelocity_0.MaxForce = 1000000000;
					l_LinearVelocity_0.Parent = l_HumanoidRootPart_4;
					v131.Sfx:Play();
					task.delay(v8:GetInstant("DivineSlap/Delay", l_v8_Instant_0), function() --[[ Line: 681 ]]
						-- upvalues: l_LinearVelocity_0 (copy), l_v8_Instant_1 (copy), l_Highlight_2 (ref), v130 (copy), v131 (copy)
						l_LinearVelocity_0:Destroy();
						task.wait(l_v8_Instant_1);
						l_Highlight_2:Destroy();
						v130:Destroy();
						task.wait(2);
						v131:Destroy();
					end);
				end);
				return;
			end;
		end
	}, 
	["Overseer Mace"] = {
		Icon = "rbxassetid://900731150", 
		Range = Vector3.new(12, 12, 12, 0), 
		Name = "Overseer Mace", 
		RagdollDuration = 3, 
		Cooldown = 0.8, 
		Force = 1000, 
		OnHit = function(v134, v135, v136) --[[ Line: 704 ]] --[[ Name: OnHit ]]
			-- upvalues: l_RunService_0 (copy), v11 (ref)
			local l_Humanoid_5 = v135:FindFirstChildOfClass("Humanoid");
			local l_HumanoidRootPart_5 = v135:FindFirstChild("HumanoidRootPart");
			if not l_Humanoid_5 or not l_HumanoidRootPart_5 then
				return;
			else
				task.wait(3);
				local v139 = 1;
				for _ = 1, 10 do
					v139 = v139 - 0.1;
					v134:SetAttribute("DivideSpeedBy", v139);
					task.wait(0.6);
				end;
				v134:SetAttribute("DivideSpeedBy", nil);
				if l_RunService_0:IsServer() then
					v11:ApplyImpulse(v134, 500, Vector3.new(), true, 3, true, {
						Tag = "Item.Overseer Mace", 
						Player = v136
					});
					v134:SetAttribute("DivideSpeedBy", nil);
				end;
				return;
			end;
		end
	}, 
	["Bambu Runcing"] = {
		Name = "Bambu Runcing", 
		Icon = "rbxassetid://0", 
		Cooldown = 0.8, 
		Force = 1250, 
		RagdollDuration = 3, 
		Range = Vector3.new(25, 25, 25, 0)
	}, 
	["Sapu Lidi"] = {
		Name = "Bambu Runcing", 
		Icon = "rbxassetid://0", 
		Cooldown = 0.8, 
		Force = 1200, 
		RagdollDuration = 3, 
		Range = Vector3.new(30, 9, 9, 0)
	}, 
	["Fire Hand"] = {
		Name = "Fire Hand", 
		Icon = "http://www.roblox.com/asset/?id=37241858", 
		Cooldown = 0.5, 
		Force = 1000, 
		RagdollDuration = 4, 
		OnHit = function(_, v142) --[[ Line: 754 ]] --[[ Name: OnHit ]]
			-- upvalues: l_RunService_0 (copy)
			if l_RunService_0:IsServer() then
				local l_HumanoidRootPart_6 = v142:FindFirstChild("HumanoidRootPart");
				if l_HumanoidRootPart_6 then
					local v144 = script.Fire.fireOnStep:Clone();
					v144.Parent = l_HumanoidRootPart_6;
					task.delay(4, function() --[[ Line: 760 ]]
						-- upvalues: v144 (copy)
						v144:Destroy();
					end);
				end;
			end;
		end
	}, 
	["Steampunk Glove"] = {
		Name = "Steampunk Glove", 
		Icon = "rbxassetid://243184138", 
		Cooldown = 0.7, 
		Force = 1500, 
		RagdollDuration = 3
	}, 
	["Ban Hammer"] = {
		Name = "Ban Hammer", 
		Icon = "rbxassetid://102903994473061", 
		Cooldown = 0.7, 
		Force = 900, 
		RagdollDuration = 3, 
		HasParticles = function(v145, v146) --[[ Line: 784 ]] --[[ Name: HasParticles ]]
			local l_Part_1 = Instance.new("Part");
			l_Part_1.CanCollide = false;
			l_Part_1.Size = Vector3.new(1, 1, 1, 0);
			l_Part_1.Anchored = false;
			l_Part_1.Transparency = 1;
			l_Part_1.CFrame = v145.CFrame * CFrame.new(0, 0.4, -3);
			l_Part_1.Parent = workspace;
			local l_WeldConstraint_0 = Instance.new("WeldConstraint");
			l_WeldConstraint_0.Part0 = v145;
			l_WeldConstraint_0.Part1 = l_Part_1;
			l_WeldConstraint_0.Parent = l_Part_1;
			local v149 = v146.Handle.Attachment:Clone();
			v149.Parent = l_Part_1;
			v149.ParticleEmitter:Emit(2);
			task.delay(1, function() --[[ Line: 802 ]]
				-- upvalues: l_Part_1 (copy), l_WeldConstraint_0 (copy), v149 (copy)
				if l_Part_1 then
					l_Part_1:Destroy();
				end;
				if l_WeldConstraint_0 then
					l_WeldConstraint_0:Destroy();
				end;
				if v149 then
					v149:Destroy();
				end;
			end);
		end
	}, 
	["Bloodmoon Hammer"] = {
		Name = "Bloodmoon Hammer", 
		Icon = "rbxassetid://96284196754755", 
		Cooldown = 0.7, 
		Force = 900, 
		RagdollDuration = 6, 
		HasParticles = function(v150, v151) --[[ Line: 823 ]] --[[ Name: HasParticles ]]
			local l_Part_2 = Instance.new("Part");
			l_Part_2.CanCollide = false;
			l_Part_2.Size = Vector3.new(1, 1, 1, 0);
			l_Part_2.Anchored = false;
			l_Part_2.Transparency = 1;
			l_Part_2.CFrame = v150.CFrame * CFrame.new(0, 0.4, -3);
			l_Part_2.Parent = workspace;
			local l_WeldConstraint_1 = Instance.new("WeldConstraint");
			l_WeldConstraint_1.Part0 = v150;
			l_WeldConstraint_1.Part1 = l_Part_2;
			l_WeldConstraint_1.Parent = l_Part_2;
			local v154 = v151.Handle.Attachment:Clone();
			v154.Parent = l_Part_2;
			v154.ParticleEmitter:Emit(2);
			task.delay(1, function() --[[ Line: 841 ]]
				-- upvalues: l_Part_2 (copy), l_WeldConstraint_1 (copy), v154 (copy)
				if l_Part_2 then
					l_Part_2:Destroy();
				end;
				if l_WeldConstraint_1 then
					l_WeldConstraint_1:Destroy();
				end;
				if v154 then
					v154:Destroy();
				end;
			end);
		end, 
		OnHit = function(_, v156) --[[ Line: 854 ]] --[[ Name: OnHit ]]
			local l_Highlight_3 = Instance.new("Highlight");
			l_Highlight_3.DepthMode = Enum.HighlightDepthMode.Occluded;
			l_Highlight_3.FillColor = Color3.fromRGB(255, 0, 0);
			l_Highlight_3.FillTransparency = 0.5;
			l_Highlight_3.OutlineTransparency = 1;
			l_Highlight_3.Adornee = v156;
			l_Highlight_3.Parent = v156;
			task.delay(2.5, function() --[[ Line: 863 ]]
				-- upvalues: l_Highlight_3 (copy)
				l_Highlight_3:Destroy();
			end);
		end
	}, 
	["Rainbow Hammer"] = {
		Name = "Rainbow Hammer", 
		Icon = "rbxassetid://139876541578910", 
		Cooldown = 0.7, 
		Force = 1000, 
		RagdollDuration = 6, 
		HasParticles = function(v158, v159) --[[ Line: 876 ]] --[[ Name: HasParticles ]]
			local l_Part_3 = Instance.new("Part");
			l_Part_3.CanCollide = false;
			l_Part_3.Size = Vector3.new(1, 1, 1, 0);
			l_Part_3.Anchored = false;
			l_Part_3.Transparency = 1;
			l_Part_3.CFrame = v158.CFrame * CFrame.new(0, 0.4, -3);
			l_Part_3.Parent = workspace;
			local l_WeldConstraint_2 = Instance.new("WeldConstraint");
			l_WeldConstraint_2.Part0 = v158;
			l_WeldConstraint_2.Part1 = l_Part_3;
			l_WeldConstraint_2.Parent = l_Part_3;
			local v162 = v159.Handle.Attachment:Clone();
			v162.Parent = l_Part_3;
			v162.ParticleEmitter:Emit(2);
			task.delay(1, function() --[[ Line: 894 ]]
				-- upvalues: l_Part_3 (copy), l_WeldConstraint_2 (copy), v162 (copy)
				if l_Part_3 then
					l_Part_3:Destroy();
				end;
				if l_WeldConstraint_2 then
					l_WeldConstraint_2:Destroy();
				end;
				if v162 then
					v162:Destroy();
				end;
			end);
		end, 
		OnHit = function(_, v164) --[[ Line: 907 ]] --[[ Name: OnHit ]]
			-- upvalues: v12 (copy)
			local l_Highlight_4 = Instance.new("Highlight");
			l_Highlight_4.DepthMode = Enum.HighlightDepthMode.Occluded;
			l_Highlight_4.OutlineTransparency = 0;
			l_Highlight_4.FillTransparency = 0.5;
			l_Highlight_4.Adornee = v164;
			l_Highlight_4.Parent = v164;
			table.insert(v12, l_Highlight_4);
			task.delay(2.5, function() --[[ Line: 917 ]]
				-- upvalues: v12 (ref), l_Highlight_4 (copy)
				table.remove(v12, table.find(v12, l_Highlight_4));
				l_Highlight_4:Destroy();
			end);
		end
	}, 
	["Delete Hammer"] = {
		Name = "Delete Hammer", 
		Icon = "rbxassetid://102903994473061", 
		Cooldown = 0, 
		Force = 3000, 
		RagdollDuration = 5, 
		HasParticles = function(v166, v167) --[[ Line: 931 ]] --[[ Name: HasParticles ]]
			local l_Part_4 = Instance.new("Part");
			l_Part_4.CanCollide = false;
			l_Part_4.Size = Vector3.new(1, 1, 1, 0);
			l_Part_4.Anchored = false;
			l_Part_4.Transparency = 1;
			l_Part_4.CFrame = v166.CFrame * CFrame.new(0, 0.4, -3);
			l_Part_4.Parent = workspace;
			local l_WeldConstraint_3 = Instance.new("WeldConstraint");
			l_WeldConstraint_3.Part0 = v166;
			l_WeldConstraint_3.Part1 = l_Part_4;
			l_WeldConstraint_3.Parent = l_Part_4;
			local v170 = v167.Handle.Attachment:Clone();
			v170.Parent = l_Part_4;
			v170.ParticleEmitter:Emit(2);
			task.delay(1, function() --[[ Line: 949 ]]
				-- upvalues: l_Part_4 (copy), l_WeldConstraint_3 (copy), v170 (copy)
				if l_Part_4 then
					l_Part_4:Destroy();
				end;
				if l_WeldConstraint_3 then
					l_WeldConstraint_3:Destroy();
				end;
				if v170 then
					v170:Destroy();
				end;
			end);
		end
	}, 
	["Small Tree"] = {
		Name = "Small Tree", 
		Icon = "rbxassetid://70956898840223", 
		Cooldown = 0.7, 
		Force = 1000, 
		Range = Vector3.new(12, 12, 12, 0), 
		RagdollDuration = 3
	}, 
	["Medium Tree"] = {
		Name = "Medium Tree", 
		Icon = "rbxassetid://117374249944925", 
		Cooldown = 0.7, 
		Force = 1100, 
		Range = Vector3.new(14, 14, 14, 0), 
		RagdollDuration = 3
	}, 
	["Huge Tree"] = {
		Name = "Huge Tree", 
		Icon = "rbxassetid://114915257709192", 
		Cooldown = 0.7, 
		Force = 1200, 
		Range = Vector3.new(16, 16, 16, 0), 
		RagdollDuration = 3
	}, 
	["Rainbow Small Tree"] = {
		Name = "Rainbow Small Tree", 
		Icon = "rbxassetid://136011850681459", 
		Cooldown = 0.7, 
		Force = 1200, 
		Range = Vector3.new(12, 12, 12, 0), 
		RagdollDuration = 3
	}, 
	["Rainbow Medium Tree"] = {
		Name = "Rainbow Medium Tree", 
		Icon = "rbxassetid://83546641619026", 
		Cooldown = 0.7, 
		Force = 1300, 
		Range = Vector3.new(14, 14, 14, 0), 
		RagdollDuration = 3
	}, 
	["Rainbow Huge Tree"] = {
		Name = "Rainbow Huge Tree", 
		Icon = "rbxassetid://119257172353286", 
		Cooldown = 0.7, 
		Force = 1400, 
		Range = Vector3.new(16, 16, 16, 0), 
		RagdollDuration = 3
	}, 
	Bat = {
		Name = "Bat", 
		Icon = "rbxassetid://86735158693802", 
		Cooldown = 0.7, 
		Force = 500, 
		RagdollDuration = 3
	}, 
	Lollipop = {
		Name = "Lollipop", 
		Icon = "rbxassetid://95336128645462", 
		Cooldown = 0.7, 
		Force = 800, 
		RagdollDuration = 3, 
		OnHit = function(v171, v172) --[[ Line: 1034 ]] --[[ Name: OnHit ]]
			-- upvalues: v6 (copy)
			local function v179(v173) --[[ Line: 1035 ]] --[[ Name: ApplyCandyEffect ]]
				for _, v175 in v173:GetChildren() do
					if v175:IsA("BasePart") then
						for _, v177 in script.Effect:GetChildren() do
							local v178 = v177:Clone();
							v178.Parent = v175;
							task.delay(5, function() --[[ Line: 1044 ]]
								-- upvalues: v178 (copy)
								v178:Destroy();
							end);
						end;
					end;
				end;
			end;
			local l_Humanoid_6 = v172:FindFirstChildOfClass("Humanoid");
			local l_HumanoidRootPart_7 = v172:FindFirstChild("HumanoidRootPart");
			if not l_Humanoid_6 or not l_HumanoidRootPart_7 then
				return;
			else
				local v182 = script.BillboardPart.BillboardGui:Clone();
				v182.Parent = l_HumanoidRootPart_7;
				v179(v172);
				v171:SetAttribute("DivideSpeed", true);
				task.delay(5, function() --[[ Line: 1063 ]]
					-- upvalues: v171 (copy), v182 (copy)
					v171:SetAttribute("DivideSpeed", nil);
					v182:Destroy();
				end);
				v6:RemoteEvent("UseItem"):FireClient(v171, "CandyEffect", 5);
				return;
			end;
		end
	}, 
	["Candy Cane"] = {
		Name = "Candy Cane", 
		Icon = "rbxassetid://19250774", 
		Cooldown = 0.4, 
		Force = 500, 
		RagdollDuration = 3
	}, 
	["Gummy Bear"] = {
		Name = "Gummy Bear", 
		Icon = "rbxassetid://81350787786383", 
		Cooldown = 0.7, 
		Force = 750, 
		RagdollDuration = 3, 
		OnHit = function(v183, v184) --[[ Line: 1089 ]] --[[ Name: OnHit ]]
			-- upvalues: v7 (copy), v8 (copy), v18 (ref), v19 (ref), v20 (ref), v21 (ref)
			if v7(("TurnedToGummy/%*/Server"):format(v183.Name), v8:GetInstant("GummyBearStickCooldown", 6.5)) then
				return;
			else
				local l_GummyBear_0 = v18:FindFirstChild("GummyBear");
				if not l_GummyBear_0 then
					return;
				elseif not v19:FindFirstChild("GummyController") then
					return;
				elseif v183:GetAttribute("Web") then
					return;
				else
					local l_HumanoidRootPart_8 = v184:FindFirstChild("HumanoidRootPart");
					if not l_HumanoidRootPart_8 then
						return;
					else
						local l_Humanoid_7 = v184:FindFirstChildWhichIsA("Humanoid");
						if not l_Humanoid_7 then
							return;
						else
							v184:PivotTo(CFrame.new(v184:GetPivot().Position + Vector3.new(0, 2, 0, 0)));
							v184:SetAttribute("SpeedAllowance", v8:GetInstant("GummyBearSpeedAllowance", 120));
							task.wait(v8:GetInstant("GummyBearHitWaitTime", 0.65));
							v183:SetAttribute("RagdollEndTime", 0);
							local v188 = v20.GummyBear:Clone();
							v188.Parent = l_HumanoidRootPart_8;
							v188:Play();
							local l_Tool_0 = v184:FindFirstChildOfClass("Tool");
							v183:SetAttribute("Web", true);
							v183:SetAttribute("BlockTools", true);
							v21:CancelSteal(v183);
							l_Humanoid_7.PlatformStand = true;
							l_Humanoid_7:UnequipTools();
							local l_WeldConstraint_4 = Instance.new("WeldConstraint");
							l_WeldConstraint_4.Part0 = l_HumanoidRootPart_8;
							local v191 = l_GummyBear_0:Clone();
							v191:PivotTo(v184:GetPivot());
							v191.Color = BrickColor.random().Color;
							v191.Parent = workspace;
							for _, v193 in v191:GetDescendants() do
								if v193:IsA("BasePart") then
									v193:SetNetworkOwner(v183);
								end;
							end;
							l_WeldConstraint_4.Part1 = v191;
							l_WeldConstraint_4.Parent = v191;
							v184:SetAttribute("InGummy", true);
							v183:SetAttribute("NoMouseLockOffset", true);
							task.delay(v8:GetInstant("GummyBearDuration", 3), function() --[[ Line: 1162 ]]
								-- upvalues: v188 (copy), v191 (copy), l_Humanoid_7 (copy), v183 (copy), v184 (copy), l_Tool_0 (copy), v21 (ref)
								v188:Destroy();
								v191:Destroy();
								l_Humanoid_7.PlatformStand = false;
								v183:SetAttribute("Web", nil);
								v183:SetAttribute("BlockTools", nil);
								v184:SetAttribute("SpeedAllowance", nil);
								v184:SetAttribute("InGummy", nil);
								v183:SetAttribute("NoMouseLockOffset", nil);
								if l_Tool_0 and l_Tool_0.Parent == v183.Backpack and not v21:IsStealing(v183) and l_Humanoid_7.Health > 0 then
									l_Humanoid_7:EquipTool(l_Tool_0);
								end;
							end);
							return;
						end;
					end;
				end;
			end;
		end
	}, 
	["Dev Slap"] = {
		Name = "Dev Slap", 
		Icon = "", 
		Cooldown = 0.7, 
		Force = 5000, 
		Range = Vector3.new(25, 25, 25, 0), 
		RagdollDuration = 5, 
		HasHighlight = true
	}
};