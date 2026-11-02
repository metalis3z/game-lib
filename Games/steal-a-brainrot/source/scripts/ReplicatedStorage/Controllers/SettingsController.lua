-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v4 = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v5 = require(l_ReplicatedStorage_0.Packages.TopbarPlus);
local v6 = require(l_ReplicatedStorage_0.Packages.Trove);
local v7 = require(l_ReplicatedStorage_0.Packages.Net);
local v8 = require(l_ReplicatedStorage_0.Classes.AnimatedButton);
local v9 = require(l_ReplicatedStorage_0.Controllers.NotificationController);
local v10 = require(l_ReplicatedStorage_0.Controllers.DuelsMachineController);
local v11 = require(l_ReplicatedStorage_0.Controllers.InterfaceController);
local v12 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v13 = require(l_ReplicatedStorage_0.Shared.Index);
local v14 = require(l_ReplicatedStorage_0.Shared.Updates);
local v15 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v16 = require(l_ReplicatedStorage_0.Datas.Index);
local v17 = v7:RemoteFunction("SettingsService/ToggleSetting");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v20 = v5.new():setImage(110481567543062, "Selected"):setImage(78403024093069, "Deselected"):setOrder(1);
local v21 = {
	Music = 1, 
	["Sound Effects"] = 2, 
	VFX = 3, 
	["Chat Tips"] = 4, 
	["Mobile Shift Lock"] = 5, 
	["Receive Trades from"] = 6, 
	["Receive Duels from"] = 7, 
	["Base Skin"] = 8, 
	["Hide Region"] = 9
};
local v22 = nil;
local l_Settings_0 = l_PlayerGui_0:WaitForChild("Settings").Settings;
local l_ScrollingFrame_0 = l_Settings_0.Content.ScrollingFrame;
local l_Template_0 = l_ScrollingFrame_0.Template;
local l_TemplateBaseSkin_0 = l_ScrollingFrame_0.TemplateBaseSkin;
local l_Close_0 = l_Settings_0.Header.Close;
local v28 = v6.new();
local v29 = {};
local _ = {};
local _ = function() --[[ Line: 66 ]] --[[ Name: GetMutationNames ]]
	-- upvalues: v16 (copy)
	local v31 = {
		"Normal"
	};
	for v32, _ in v16 do
		table.insert(v31, v32);
	end;
	return v31;
end;
local function v93(v35) --[[ Line: 74 ]] --[[ Name: ConstructSettings ]]
	-- upvalues: v4 (copy), l_LocalPlayer_0 (copy), v28 (copy), l_TemplateBaseSkin_0 (copy), l_ScrollingFrame_0 (copy), v16 (copy), v13 (copy), v8 (copy), v17 (copy), v9 (copy), v12 (copy), v21 (copy), l_Template_0 (copy), v10 (copy), v15 (copy), l_UserInputService_0 (copy)
	local v36 = v4:Get(l_LocalPlayer_0);
	v28:Clean();
	for v37, v38 in v35 do
		if v37 == "Base Skin" then
			local v39 = v28:Clone(l_TemplateBaseSkin_0);
			v39.Name = v37;
			v39.Function.Text = v37;
			v39.Button.DropDown.AnchorPoint = Vector2.new(0.5, 0);
			v39.Button.DropDown.Position = UDim2.fromScale(0.5, 1.2);
			v39.Button.DropDown.Size = UDim2.fromScale(1.221, 0);
			v39.Button.DropDown.AutomaticSize = Enum.AutomaticSize.Y;
			local v40 = {};
			local v41 = {};
			local function _(v42) --[[ Line: 96 ]] --[[ Name: calculateCanvasSize ]]
				-- upvalues: l_ScrollingFrame_0 (ref), v39 (copy), v40 (copy)
				local l_Y_0 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
				local v44 = if v39.Button.DropDown.Visible then (#v40 + 1) * ((v42 or v39.Button.AbsoluteSize).Y + 8) else 0;
				return UDim2.fromOffset(0, l_Y_0 + v44);
			end;
			local v46 = {
				"Normal"
			};
			for v47, _ in v16 do
				table.insert(v46, v47);
			end;
			for _, v50 in v46 do
				if v50 ~= v38 then
					local v51 = v16[v50];
					local v52 = v16[v50] and v16[v50].DisableAutomaticSkin;
					local v53 = v50 == "Normal" or v13:IsComplete(l_LocalPlayer_0, v50) and not v52 or v36 and v36:Get((("UnlockedBaseSkins.%*"):format(v50)));
					if v53 or v51.ShowInSettings ~= false then
						local v54 = v28:Clone(v39.Button.DropDown.Template);
						table.insert(v40, v54);
						v54.Name = v50;
						v54.Text.RichText = v51 and v51.UseRichTextInSettings or false;
						v54.Text.Text = v51 and (v51.UseRichTextInSettings and v51.DisplayWithRichText or v51.DisplayText) or v50;
						v54.Locked.Visible = not v53;
						v54.BackgroundColor3 = v50 ~= "Normal" and v51.MainColor or Color3.new(0.490196, 0.435294, 0.435294);
						v54.UIStroke.Color = v50 ~= "Normal" and (if v51.Palettes then v51.Palettes[1][2] else v51.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
						v54.Text.UIStroke.Color = v50 ~= "Normal" and (if v51.Palettes then v51.Palettes[1][2] else v51.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
						if v53 then
							local v55 = v8.new(v54);
							v28:Add(v55);
							v55:Animate();
							v28:Add(v55.OnActivated:Connect(function() --[[ Line: 134 ]]
								-- upvalues: l_ScrollingFrame_0 (ref), v39 (copy), v40 (copy), v17 (ref), v37 (copy), v50 (copy), v9 (ref), v12 (ref)
								l_ScrollingFrame_0.CanvasSize = UDim2.new(0, 0, 0, 0);
								local l_DropDown_0 = v39.Button.DropDown;
								if l_DropDown_0.Visible then
									l_DropDown_0.Visible = not l_DropDown_0.Visible;
									v39.Button.Polygon.Rotation = l_DropDown_0.Visible and 180 or 0;
									local l_l_ScrollingFrame_0_0 = l_ScrollingFrame_0;
									local l_Y_1 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
									local v59 = if v39.Button.DropDown.Visible then (#v40 + 1) * (v39.Button.AbsoluteSize.Y + 8) else 0;
									l_l_ScrollingFrame_0_0.CanvasSize = UDim2.fromOffset(0, l_Y_1 + v59);
									l_ScrollingFrame_0.CanvasPosition = l_DropDown_0.Visible and Vector2.new(0, l_ScrollingFrame_0.AbsoluteCanvasSize.Y - l_ScrollingFrame_0.AbsoluteSize.Y) or Vector2.new(0, 0);
								end;
								local v60, v61 = v17:InvokeServer(v37, v50);
								if not v60 then
									v9:Error(v61);
									v12:PlaySound("Sounds.Sfx.Error");
								end;
							end));
							table.insert(v41, v55);
						end;
						v54.LayoutOrder = v50 ~= "Normal" and v16[v50].Order or 1;
						v54.Visible = true;
						v54.Parent = v39.Button.DropDown;
					end;
				end;
			end;
			local function v71() --[[ Line: 161 ]] --[[ Name: updateScaling ]]
				-- upvalues: v39 (copy), v40 (copy), v41 (copy), l_ScrollingFrame_0 (ref)
				local l_AbsoluteSize_0 = v39.Button.AbsoluteSize;
				local v63 = UDim2.fromOffset(l_AbsoluteSize_0.X, l_AbsoluteSize_0.Y);
				for _, v65 in v40 do
					v65.Size = v63;
				end;
				for _, v67 in v41 do
					v67.DefaultSize = v63;
				end;
				local l_l_ScrollingFrame_0_1 = l_ScrollingFrame_0;
				local l_Y_2 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
				local v70 = if v39.Button.DropDown.Visible then (#v40 + 1) * ((l_AbsoluteSize_0 or v39.Button.AbsoluteSize).Y + 8) else 0;
				l_l_ScrollingFrame_0_1.CanvasSize = UDim2.fromOffset(0, l_Y_2 + v70);
			end;
			v28:Add(v39.Button:GetPropertyChangedSignal("AbsoluteSize"):Connect(v71));
			v28:Add(v39.Button.DropDown:GetPropertyChangedSignal("Visible"):Connect(v71));
			v28:Add(task.spawn(v71));
			local v72 = v16[v38];
			local l_Button_0 = v39.Button;
			l_Button_0.Text.RichText = v72 and v72.UseRichTextInSettings or false;
			l_Button_0.Text.Text = v72 and (v72.UseRichTextInSettings and v72.DisplayWithRichText or v72.DisplayText) or v38;
			l_Button_0.BackgroundColor3 = v38 ~= "Normal" and v72 and v72.MainColor or Color3.new(0.490196, 0.435294, 0.435294);
			l_Button_0.UIStroke.Color = v38 ~= "Normal" and v72 and (if v72.Palettes then v72.Palettes[1][1] else v72.MainColor) or Color3.new(0.490196, 0.435294, 0.435294);
			v46 = v8.new(l_Button_0);
			v28:Add(v46);
			v28:Add(v46.OnActivated:Connect(function() --[[ Line: 191 ]]
				-- upvalues: l_Button_0 (copy), l_ScrollingFrame_0 (ref), v39 (copy), v40 (copy)
				local l_DropDown_1 = l_Button_0.DropDown;
				l_DropDown_1.Visible = not l_DropDown_1.Visible;
				l_Button_0.Polygon.Rotation = l_DropDown_1.Visible and 180 or 0;
				local l_l_ScrollingFrame_0_2 = l_ScrollingFrame_0;
				local l_Y_3 = l_ScrollingFrame_0.UIListLayout.AbsoluteContentSize.Y;
				local v77 = if v39.Button.DropDown.Visible then (#v40 + 1) * (v39.Button.AbsoluteSize.Y + 8) else 0;
				l_l_ScrollingFrame_0_2.CanvasSize = UDim2.fromOffset(0, l_Y_3 + v77);
				l_ScrollingFrame_0.CanvasPosition = l_DropDown_1.Visible and Vector2.new(0, l_ScrollingFrame_0.AbsoluteCanvasSize.Y - l_ScrollingFrame_0.AbsoluteSize.Y) or Vector2.new(0, 0);
			end));
			v39.LayoutOrder = v21[v37];
			v39.Visible = true;
			v39.Parent = l_ScrollingFrame_0;
		elseif v37 == "Receive Duels from" or v37 == "Receive Trades from" then
			local v78 = v28:Clone(l_Template_0);
			v78.Name = v37;
			v78.Function.Text = v37;
			local v79 = if v38 == "Everyone" then Color3.fromRGB(12, 119, 60) else if v38 == "Friends" then Color3.fromRGB(255, 149, 0) else Color3.fromRGB(245, 56, 56);
			local v80 = if v38 == "Everyone" then Color3.fromRGB(2, 56, 0) else if v38 == "Friends" then Color3.fromRGB(190, 111, 0) else Color3.fromRGB(177, 0, 0);
			local l_Button_1 = v78.Buttons.Button;
			l_Button_1.Text.Text = v38;
			l_Button_1.BackgroundColor3 = v79;
			l_Button_1.UIStroke.Color = v80;
			l_Button_1.Text.UIStroke.Color = v80;
			local v82 = v8.new(l_Button_1);
			v28:Add(v82);
			v82:Animate();
			v28:Add(v82.OnActivated:Connect(function() --[[ Line: 225 ]]
				-- upvalues: v38 (copy), v17 (ref), v37 (copy), v9 (ref), v12 (ref)
				local v83 = v38 == "Everyone" and "Friends" or v38 == "Friends" and "No one" or "Everyone";
				local v84, v85 = v17:InvokeServer(v37, v83);
				if not v84 then
					v9:Error(v85);
					v12:PlaySound("Sounds.Sfx.Error");
				end;
			end));
			local v86 = v37 ~= "Receive Duels from" or v10:IsEnabled();
			v78.LayoutOrder = v21[v37];
			v78.Visible = not v15.IsNewPlayersServer() and v86;
			v78.Parent = l_ScrollingFrame_0;
		elseif v37 ~= "Receive Gifts from" then
			local v87 = v28:Clone(l_Template_0);
			v87.Name = v37;
			v87.Function.Text = v37;
			local l_Button_2 = v87.Buttons.Button;
			l_Button_2.Text.Text = v38 and "On" or "Off";
			l_Button_2.BackgroundColor3 = v38 and Color3.new(0.0470588, 0.466667, 0.235294) or Color3.new(0.490196, 0.435294, 0.435294);
			l_Button_2.UIStroke.Color = v38 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863);
			l_Button_2.Text.UIStroke.Color = v38 and Color3.new(0.00784314, 0.219608, 0) or Color3.new(0.403922, 0.356863, 0.356863);
			local v89 = v8.new(l_Button_2);
			v28:Add(v89);
			v89:Animate();
			v28:Add(v89.OnActivated:Connect(function() --[[ Line: 262 ]]
				-- upvalues: v17 (ref), v37 (copy), v9 (ref), v12 (ref)
				local v90, v91 = v17:InvokeServer(v37);
				if not v90 then
					v9:Error(v91);
					v12:PlaySound("Sounds.Sfx.Error");
				end;
			end));
			local v92 = true;
			if v37 == "Mobile Shift Lock" then
				v92 = l_UserInputService_0.PreferredInput == Enum.PreferredInput.Touch;
			end;
			v87.LayoutOrder = v21[v37];
			v87.Visible = v92;
			v87.Parent = l_ScrollingFrame_0;
		end;
	end;
end;
v29.Start = function(_) --[[ Line: 281 ]] --[[ Name: Start ]]
	-- upvalues: v22 (ref), v11 (copy), l_Settings_0 (copy), l_Close_0 (copy), v20 (copy), v4 (copy), l_LocalPlayer_0 (copy), v93 (copy), l_UserInputService_0 (copy), v14 (copy), v13 (copy)
	local v95 = nil;
	v22 = v11:Register("Settings", l_Settings_0, "TopQuint");
	v22:AttachCloseButton(l_Close_0);
	v22:Close();
	v20.selected:Connect(function() --[[ Line: 289 ]]
		-- upvalues: v11 (ref)
		v11:SetState("Settings", true);
	end);
	v20.deselected:Connect(function() --[[ Line: 293 ]]
		-- upvalues: v11 (ref)
		v11:SetState("Settings", false);
	end);
	v4:WaitAndCall(l_LocalPlayer_0, function(v96) --[[ Line: 297 ]]
		-- upvalues: v22 (ref), v93 (ref), v95 (ref), l_UserInputService_0 (ref), v20 (ref), v14 (ref), v13 (ref), l_LocalPlayer_0 (ref)
		local function _() --[[ Line: 298 ]] --[[ Name: tryConstruct ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end;
		l_UserInputService_0:GetPropertyChangedSignal("PreferredInput"):Connect(function() --[[ Line: 306 ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end);
		v22.OnOpen:Connect(function() --[[ Line: 310 ]]
			-- upvalues: v95 (ref), v93 (ref), v96 (copy), v20 (ref)
			if v95 then
				task.spawn(v93, v96:Get("Settings"));
				v95 = nil;
			end;
			v20:select();
		end);
		v22.OnClose:Connect(function() --[[ Line: 319 ]]
			-- upvalues: v20 (ref)
			v20:deselect();
		end);
		local v98 = v96:Get("Settings");
		v96:OnDictionaryInserted("UnlockedBaseSkins", function() --[[ Line: 325 ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end);
		v96:OnDictionaryRemoved("UnlockedBaseSkins", function() --[[ Line: 329 ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end);
		v14.OnUpdateEnabled:Connect(function() --[[ Line: 333 ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end);
		v14.OnUpdateDisabled:Connect(function() --[[ Line: 337 ]]
			-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			if v22:IsOpened() then
				task.spawn(v93, v96:Get("Settings"));
				return;
			else
				v95 = true;
				return;
			end;
		end);
		for v99, _ in v98 do
			v96:OnChanged(("Settings.%*"):format(v99), function(_) --[[ Line: 342 ]]
				-- upvalues: v22 (ref), v93 (ref), v96 (copy), v95 (ref)
				if v22:IsOpened() then
					task.spawn(v93, v96:Get("Settings"));
					return;
				else
					v95 = true;
					return;
				end;
			end);
		end;
		local v102 = {};
		local v103 = {
			"Strawberry", 
			"Meowl",
			"John Pork",
			"Skibidi", 
			"Headless",
			"Smurf"
		};
		v96:OnChanged("AnimalAddedOrRemoved", function() --[[ Line: 350 ]]
			-- upvalues: v103 (copy), v13 (ref), l_LocalPlayer_0 (ref), v102 (copy), v22 (ref), v93 (ref), v96 (copy), v95 (ref)
			local v104 = false;
			for _, v106 in v103 do
				local v107 = v13:IsComplete(l_LocalPlayer_0, v106);
				if v102[v106] ~= v107 then
					v102[v106] = v107;
					v104 = true;
				end;
			end;
			if v104 then
				if v22:IsOpened() then
					task.spawn(v93, v96:Get("Settings"));
					return;
				else
					v95 = true;
				end;
			end;
		end);
		if v22:IsOpened() then
			task.spawn(v93, v96:Get("Settings"));
			return;
		else
			v95 = true;
			return;
		end;
	end);
end;
return v29;