-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local l_GuiService_0 = game:GetService("GuiService");
local l_PerkService_0 = require(game.ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("PerkService"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v5 = nil;
local v6 = nil;
local v7 = nil;
local v8 = nil;
local v9 = nil;
local function _() --[[ Line: 15 ]] --[[ Name: resetPerks ]]
	if workspace:FindFirstChild("Footsteps") then
		workspace:FindFirstChild("Footsteps"):Destroy();
	end;
	_G.Sleight = false;
	_G.Ninja = false;
	_G.Haste = false;
end;
local function v19(v11) --[[ Line: 24 ]] --[[ Name: onPerkAdded ]]
	-- upvalues: l_PerkService_0 (copy), l_GuiService_0 (copy), v9 (ref), v7 (ref), v6 (ref), v8 (ref), v5 (ref)
	local l_l_PerkService_0_PerkInfo_0 = l_PerkService_0:GetPerkInfo(v11.Name);
	local l_PerkButton_0 = l_PerkService_0.PerkButton;
	while l_PerkButton_0 == nil do
		l_PerkButton_0 = l_PerkService_0.PerkButton;
		task.wait(0.1);
	end;
	l_PerkButton_0.ControlText.Text = l_l_PerkService_0_PerkInfo_0.DisplayName;
	l_PerkButton_0.ControlIcon.Image = l_l_PerkService_0_PerkInfo_0.Image;
	if l_PerkButton_0:FindFirstChild("PassiveLabel") then
		l_PerkButton_0.PassiveLabel.Visible = l_l_PerkService_0_PerkInfo_0.Passive == true;
	end;
	if l_PerkButton_0:FindFirstChild("UIGradient") then
		l_PerkButton_0.UIGradient.Enabled = l_l_PerkService_0_PerkInfo_0.Passive ~= true;
	end;
	if l_PerkButton_0:FindFirstChild("Keybind") then
		l_PerkButton_0.Keybind.Visible = l_l_PerkService_0_PerkInfo_0.Passive ~= true;
	end;
	if v11.Name == "FakeGun" and l_GuiService_0:IsTenFootInterface() then
		l_PerkButton_0.Keybind.Visible = true;
	end;
	l_PerkButton_0.Charges.Visible = l_l_PerkService_0_PerkInfo_0.Charges ~= nil;
	l_PerkButton_0.ControlIcon.ImageColor3 = Color3.fromRGB(255, 255, 255);
	local v14 = nil;
	v14 = v11.AncestryChanged:Connect(function() --[[ Line: 58 ]]
		-- upvalues: v11 (copy), v14 (ref), v9 (ref), l_PerkButton_0 (ref), l_PerkService_0 (ref)
		if not v11:IsDescendantOf(game) then
			v14:Disconnect();
			v9 = nil;
			l_PerkButton_0.Visible = false;
			l_PerkService_0.PerkIsActive = false;
			if workspace:FindFirstChild("Footsteps") then
				workspace:FindFirstChild("Footsteps"):Destroy();
			end;
			_G.Sleight = false;
			_G.Ninja = false;
			_G.Haste = false;
		end;
	end);
	local function v15() --[[ Line: 68 ]] --[[ Name: updatePerk ]]
		-- upvalues: v7 (ref), v11 (copy), v6 (ref), v8 (ref)
		v7 = v11:GetAttribute("ActiveTime");
		v6 = v11:GetAttribute("Cooldown");
		v8 = v11:GetAttribute("Charges");
	end;
	local function v17() --[[ Line: 74 ]] --[[ Name: updateCharges ]]
		-- upvalues: v11 (copy), l_PerkButton_0 (ref), v7 (ref), v6 (ref), v8 (ref)
		local l_v11_Attribute_0 = v11:GetAttribute("Charges");
		if not l_v11_Attribute_0 then
			return;
		else
			l_PerkButton_0.Charges.Text = "(" .. l_v11_Attribute_0 .. ")";
			if l_v11_Attribute_0 <= 0 then
				l_PerkButton_0.ControlIcon.ImageColor3 = Color3.fromRGB(90, 90, 90);
			end;
			v7 = v11:GetAttribute("ActiveTime");
			v6 = v11:GetAttribute("Cooldown");
			v8 = v11:GetAttribute("Charges");
			return;
		end;
	end;
	v11:GetAttributeChangedSignal("ActiveTime"):Connect(v15);
	v11:GetAttributeChangedSignal("Cooldown"):Connect(v15);
	v11:GetAttributeChangedSignal("LastUse"):Connect(function() --[[ Line: 88 ]]
		-- upvalues: v5 (ref)
		v5 = os.clock();
	end);
	v11:GetAttributeChangedSignal("Charges"):Connect(v17);
	local l_v11_Attribute_1 = v11:GetAttribute("Charges");
	if l_v11_Attribute_1 then
		l_PerkButton_0.Charges.Text = "(" .. l_v11_Attribute_1 .. ")";
		if l_v11_Attribute_1 <= 0 then
			l_PerkButton_0.ControlIcon.ImageColor3 = Color3.fromRGB(90, 90, 90);
		end;
		v7 = v11:GetAttribute("ActiveTime");
		v6 = v11:GetAttribute("Cooldown");
		v8 = v11:GetAttribute("Charges");
	end;
	v7 = v11:GetAttribute("ActiveTime");
	v6 = v11:GetAttribute("Cooldown");
	v8 = v11:GetAttribute("Charges");
	v5 = -100;
	v9 = v11;
	l_PerkButton_0.Visible = true;
	l_PerkService_0.PerkIsActive = true;
end;
local function v21(v20) --[[ Line: 102 ]] --[[ Name: onPlayerGuiChildAdded ]]
	-- upvalues: v19 (copy)
	if v20:HasTag("Perk") then
		v19(v20);
	end;
end;
local function v25(_) --[[ Line: 108 ]] --[[ Name: onPreSimulation ]]
	-- upvalues: v9 (ref), l_PerkService_0 (copy), v5 (ref), v7 (ref), v6 (ref), v8 (ref)
	if not v9 then
		return;
	elseif not l_PerkService_0.PerkButton then
		return;
	elseif not l_PerkService_0.PerkButton.Visible then
		return;
	else
		local v23 = os.clock() - v5;
		if v7 and v23 < v7 then
			l_PerkService_0.PerkButton.Cooldown.Text = math.ceil(v7 - v23);
			l_PerkService_0.PerkButton.Cooldown.Visible = true;
			l_PerkService_0.PerkButton.Cooldown.TextColor3 = Color3.fromRGB(50, 200, 50);
			l_PerkService_0.PerkButton.Cooldown.BackgroundTransparency = 1;
			l_PerkService_0.PerkButton.AutoButtonColor = false;
			return;
		elseif v6 and v23 < v6 then
			local v24 = math.ceil(v6 - v23);
			l_PerkService_0.PerkButton.Cooldown.Text = v24;
			l_PerkService_0.PerkButton.Cooldown.Visible = true;
			l_PerkService_0.PerkButton.Cooldown.TextColor3 = Color3.fromRGB(200, 200, 200);
			l_PerkService_0.PerkButton.Cooldown.BackgroundTransparency = 0.5;
			l_PerkService_0.PerkButton.AutoButtonColor = false;
			return;
		else
			if v8 and v8 <= 0 then
				l_PerkService_0.PerkButton.AutoButtonColor = false;
			else
				l_PerkService_0.PerkButton.AutoButtonColor = not v9:GetAttribute("Passive");
			end;
			l_PerkService_0.PerkButton.Cooldown.Visible = false;
			return;
		end;
	end;
end;
(function() --[[ Line: 158 ]] --[[ Name: onInitialize ]]
	-- upvalues: l_LocalPlayer_0 (copy), v19 (copy), l_RunService_0 (copy), v25 (copy), l_PlayerGui_0 (copy), v21 (copy)
	if workspace:FindFirstChild("Footsteps") then
		workspace:FindFirstChild("Footsteps"):Destroy();
	end;
	_G.Sleight = false;
	_G.Ninja = false;
	_G.Haste = false;
	l_LocalPlayer_0.CharacterAdded:Connect(function(v26) --[[ Line: 160 ]]
		-- upvalues: v19 (ref)
		if workspace:FindFirstChild("Footsteps") then
			workspace:FindFirstChild("Footsteps"):Destroy();
		end;
		_G.Sleight = false;
		_G.Ninja = false;
		_G.Haste = false;
		v26.ChildAdded:Connect(function(v27) --[[ Line: 162 ]]
			-- upvalues: v19 (ref)
			if v27:HasTag("Perk") then
				v19(v27);
			end;
		end);
	end);
	l_RunService_0.PreSimulation:Connect(v25);
	l_PlayerGui_0.ChildAdded:Connect(v21);
end)();