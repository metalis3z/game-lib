-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ContentProvider");
local _ = game:GetService("SoundService");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("StarterGui");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Packages.Serialization);
local v9 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local _ = require(l_ReplicatedStorage_0.Packages.CreateTween);
local _ = require(l_ReplicatedStorage_0.Packages.TopbarPlus);
local v12 = require(l_ReplicatedStorage_0.Packages.Gradients);
local v13 = require(l_ReplicatedStorage_0.Packages.Observers);
local _ = require(l_ReplicatedStorage_0.Packages.FFlags);
local _ = require(l_ReplicatedStorage_0.Packages.Timer);
local v16 = require(l_ReplicatedStorage_0.Packages.Trove);
local v17 = require(l_ReplicatedStorage_0.Packages.Spr);
local v18 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local _ = require(l_ReplicatedStorage_0.Controllers.NewPlayersController);
local v21 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local _ = require(l_ReplicatedStorage_0.Controllers.CharacterController);
local _ = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.PlotController);
local _ = require(l_ReplicatedStorage_0.Utils.NumberUtils);
local _ = require(l_ReplicatedStorage_0.Utils.TimeUtils);
local _ = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local _ = require(l_ReplicatedStorage_0.Shared.Animals);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local v31 = require(l_ReplicatedStorage_0.Shared.Animals);
local v32 = require(l_ReplicatedStorage_0.Shared.Index);
local _ = require(l_ReplicatedStorage_0.Datas.Mutations);
local v34 = require(l_ReplicatedStorage_0.Datas.Rarities);
local v35 = require(l_ReplicatedStorage_0.Datas.Animals);
local v36 = require(l_ReplicatedStorage_0.Datas.Index);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local _ = script.Name;
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v66 = {
	Setup = function(_) --[[ Line: 63 ]] --[[ Name: Setup ]]
		-- upvalues: l_PlayerGui_0 (copy), v21 (copy), v9 (copy), l_LocalPlayer_0 (copy), v35 (copy), v34 (copy), v12 (copy), v31 (copy), v36 (copy), v32 (copy), v17 (copy), v18 (copy)
		local l_ValentinesBase_0 = l_PlayerGui_0:WaitForChild("ValentinesBase").ValentinesBase;
		local _ = l_ValentinesBase_0.Main.Content.Base;
		local l_Close_0 = l_ValentinesBase_0.Main.Header.Close;
		l_ValentinesBase_0.Visible = false;
		local v45 = v21:Register("ValentinesBase", l_ValentinesBase_0, "TopQuint");
		v45:AttachCloseButton(l_Close_0);
		v45:Close();
		local v46 = v9:Wait(l_LocalPlayer_0);
		if not v46 then
			return;
		else
			local function v51(v47, v48) --[[ Line: 80 ]] --[[ Name: renderBrainrotAtFrame ]]
				-- upvalues: v35 (ref), v34 (ref), v12 (ref), v31 (ref)
				local v49 = v35[v48];
				if not v49 then
					return;
				else
					local v50 = v34[v49.Rarity];
					v47.Title.Text = v48;
					v47.RarityLabel.Text = v49.Rarity;
					if v50.GradientPreset then
						v47.RarityLabel.TextColor3 = Color3.new(1, 1, 1);
						v12.apply(v47.RarityLabel, v50.GradientPreset);
					else
						v47.RarityLabel.TextColor3 = v50.Color;
					end;
					v47.Visible = true;
					v31:AttachOnViewportWithOptimizations(v48, v47.ViewportFrame);
					return;
				end;
			end;
			local l_v31_List_0 = v31:GetList("Generation", true);
			local v53 = assert(v36.Valentines.Index);
			for v54 = 1, #l_v31_List_0 do
				local v55 = l_v31_List_0[v54];
				if v53[v55] and v35[v55] then
					local v56 = l_ValentinesBase_0.Main.Content.Holder.List.Template:Clone();
					v56.LayoutOrder = v54;
					v51(v56, v55);
					v56.Visible = true;
					local l_ViewportFrame_0 = v56.ViewportFrame;
					local function v60() --[[ Line: 122 ]] --[[ Name: update ]]
						-- upvalues: v46 (copy), v55 (copy), v56 (copy), l_ViewportFrame_0 (copy)
						local v58 = v46:Get({
							"Index", 
							v55
						});
						local v59 = v58 ~= nil and v58.Valentines or nil;
						v56.Title.Visible = v59;
						l_ViewportFrame_0.ImageColor3 = not v59 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
					end;
					v46:OnChanged({
						"Index", 
						v55
					}, v60, true);
					task.spawn(v60);
					v56.Parent = l_ValentinesBase_0.Main.Content.Holder.List;
				end;
			end;
			local function v65() --[[ Line: 136 ]] --[[ Name: update ]]
				-- upvalues: v32 (ref), l_LocalPlayer_0 (ref), l_ValentinesBase_0 (copy), v46 (copy), v17 (ref)
				local l_v32_IndexAnimals_0, v62, v63 = v32:GetIndexAnimals(l_LocalPlayer_0, "Valentines");
				assert(l_v32_IndexAnimals_0, v62, v63);
				local _ = v32:IsComplete(l_LocalPlayer_0, "Valentines");
				l_ValentinesBase_0.Main.Content.Base.AmountLabel.Text = ("%*/%*"):format(l_v32_IndexAnimals_0, v62);
				l_ValentinesBase_0.Main.Content.Base.Claim.Label.Text = v46:Get("UnlockedBaseSkins.Valentines") and "Claimed" or "Claim";
				v17.target(l_ValentinesBase_0.Main.Content.Base.Claim, 1, 5, {
					BackgroundColor3 = if not (v62 <= l_v32_IndexAnimals_0) or v46:Get("UnlockedBaseSkins.Valentines") then Color3.fromRGB(112, 112, 112) else Color3.fromRGB(81, 158, 86)
				});
			end;
			l_ValentinesBase_0.Main.Content.Base.Claim.Activated:Connect(function() --[[ Line: 150 ]]
				-- upvalues: v18 (ref)
				v18:RemoteEvent("ValentinesBase/Claim"):FireServer();
			end);
			v46:OnChanged("AnimalAddedOrRemoved", v65);
			v46:OnDictionaryInserted("UnlockedBaseSkins", v65);
			v46:OnDictionaryRemoved("UnlockedBaseSkins", v65);
			v65();
			return;
		end;
	end
};
local v67 = v16.new();
v66.OnStart = function(_) --[[ Line: 161 ]] --[[ Name: OnStart ]]

end;
v66.OnStop = function(_) --[[ Line: 164 ]] --[[ Name: OnStop ]]
	-- upvalues: v67 (copy)
	v67:Clean();
end;
v66.OnLoad = function(v70) --[[ Line: 168 ]] --[[ Name: OnLoad ]]
	-- upvalues: v13 (copy), l_RunService_0 (copy), l_TweenService_0 (copy), v9 (copy), l_LocalPlayer_0 (copy), v21 (copy)
	task.spawn(v70.Setup, v70);
	v13.observeTag("ValentinesBaseMotor", function(v71) --[[ Line: 171 ]]
		-- upvalues: l_RunService_0 (ref), l_TweenService_0 (ref)
		local v72 = os.clock() + 15;
		local v73 = nil;
		local v74 = nil;
		local v75 = os.clock();
		local v87 = l_RunService_0.PostSimulation:Connect(function() --[[ Line: 184 ]]
			-- upvalues: v71 (copy), v72 (ref), v74 (ref), v75 (ref), l_TweenService_0 (ref), v73 (ref)
			local v76 = os.clock();
			v71.Transform = CFrame.new(0, math.sin(v76 * 2) * 0.25, 0);
			if v72 < v76 then
				v74 = 0;
				v72 = v76 + 15;
			elseif v74 ~= nil then
				local v77 = v76 - v75;
				v74 = v74 + v77;
				local v78 = v74 / 2;
				local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v78, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
				local l_v71_0 = v71;
				l_v71_0.Transform = l_v71_0.Transform * CFrame.Angles(0, l_l_TweenService_0_Value_0 * 3 * 3.141592653589793 * 2, 0);
				if v78 > 0.75 and not v73 then
					v73 = 0;
				end;
				if v74 >= 2 then
					v74 = nil;
				end;
			end;
			if v73 ~= nil then
				v73 = v73 + (v76 - v75);
				local v81 = nil;
				v81 = if v74 ~= nil then math.clamp((v74 / 2 - 0.5) / 0.5, 0, 1) else 1 - math.clamp(v73 / 2, 0, 1);
				local v82 = v76 * 14;
				local v83 = 0.04 * v81;
				local v84 = 0.025 * v81;
				local v85 = CFrame.new(math.noise(v82, 0, 0) * v83, math.noise(0, v82, 0) * v83, 0) * CFrame.Angles(math.noise(v82, v82, 0) * v84, 0, math.noise(0, v82, v82) * v84);
				local l_v71_1 = v71;
				l_v71_1.Transform = l_v71_1.Transform * v85;
				if v74 == nil and v73 >= 2 then
					v73 = nil;
				end;
			end;
			v75 = v76;
		end);
		return function() --[[ Line: 248 ]]
			-- upvalues: v87 (copy), v71 (copy)
			v87:Disconnect();
			v71.Transform = CFrame.identity;
		end;
	end);
	v13.observeTag("ValentinesBasePrompt", function(v88) --[[ Line: 254 ]]
		-- upvalues: v9 (ref), l_LocalPlayer_0 (ref), v21 (ref)
		local v89 = v88.Triggered:Connect(function() --[[ Line: 255 ]]
			-- upvalues: v9 (ref), l_LocalPlayer_0 (ref), v21 (ref)
			if not v9:Get(l_LocalPlayer_0) then
				return;
			else
				v21:Toggle("ValentinesBase");
				return;
			end;
		end);
		return function() --[[ Line: 264 ]]
			-- upvalues: v89 (copy)
			v89:Disconnect();
		end;
	end);
end;
return v66;