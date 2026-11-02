--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.
--!nolint
local l__Players__1 = game:GetService("Players");
local v2 = l__Players__1.LocalPlayer;
while v2 == nil do
	l__Players__1.ChildAdded:wait();
	v2 = l__Players__1.LocalPlayer;
end;
local l__PlayerGui__1 = v2:WaitForChild("PlayerGui");
local function u2(p1, p2)
	local v3 = Instance.new("Frame");
	v3.Size = UDim2.fromScale(0.5, 1);
	if p2 then
		local v4 = 0;
	else
		v4 = 0.5;
	end;
	v3.Position = UDim2.fromScale(v4, 0);
	v3.BackgroundTransparency = 1;
	v3.ClipsDescendants = true;
	v3.Parent = p1;
	local v5 = Instance.new("ImageLabel");
	v5.BackgroundTransparency = 1;
	v5.Size = UDim2.fromScale(2, 1);
	if p2 then
		local v6 = 0;
	else
		v6 = -1;
	end;
	v5.Position = UDim2.fromScale(v6, 0);
	v5.Image = "rbxasset://textures/ui/Controls/RadialFill.png";
	v5.Parent = v3;
	local v7 = Instance.new("UIGradient");
	v7.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) });
	if p2 then
		local v8 = 180;
	else
		v8 = 0;
	end;
	v7.Rotation = v8;
	v7.Parent = v5;
	return v7;
end;
local l__TweenService__3 = game:GetService("TweenService");
local u4 = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png", 
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png", 
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png", 
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png", 
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png", 
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png", 
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png", 
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png", 
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png", 
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS@3x.png", 
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
};
local u5 = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png", 
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png", 
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png", 
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png", 
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
};
local u6 = {
	["'"] = "rbxasset://textures/ui/Controls/apostrophe.png", 
	[","] = "rbxasset://textures/ui/Controls/comma.png", 
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png", 
	["."] = "rbxasset://textures/ui/Controls/period.png", 
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png"
};
local u7 = {
	[Enum.KeyCode.LeftControl] = "Ctrl", 
	[Enum.KeyCode.RightControl] = "Ctrl", 
	[Enum.KeyCode.LeftAlt] = "Alt", 
	[Enum.KeyCode.RightAlt] = "Alt", 
	[Enum.KeyCode.F1] = "F1", 
	[Enum.KeyCode.F2] = "F2", 
	[Enum.KeyCode.F3] = "F3", 
	[Enum.KeyCode.F4] = "F4", 
	[Enum.KeyCode.F5] = "F5", 
	[Enum.KeyCode.F6] = "F6", 
	[Enum.KeyCode.F7] = "F7", 
	[Enum.KeyCode.F8] = "F8", 
	[Enum.KeyCode.F9] = "F9", 
	[Enum.KeyCode.F10] = "F10", 
	[Enum.KeyCode.F11] = "F11", 
	[Enum.KeyCode.F12] = "F12"
};
local function u8()
	local v9 = Instance.new("Frame");
	v9.Name = "CircularProgressBar";
	v9.Size = UDim2.fromOffset(58, 58);
	v9.AnchorPoint = Vector2.new(0.5, 0.5);
	v9.Position = UDim2.fromScale(0.5, 0.5);
	v9.BackgroundTransparency = 1;
	local v10 = Instance.new("NumberValue");
	v10.Name = "Progress";
	v10.Parent = v9;
	local u9 = u2(v9, true);
	local u10 = u2(v9, false);
	v10.Changed:Connect(function(p3)
		local v11 = math.clamp(p3 * 360, 0, 360);
		u9.Rotation = math.clamp(v11, 180, 360);
		u10.Rotation = math.clamp(v11, 0, 180);
	end);
	return v9;
end;
local l__TextService__11 = game:GetService("TextService");
local l__ProximityPromptService__12 = game:GetService("ProximityPromptService");
local function u13(p4, p5, p6)
	local v12 = {};
	local v13 = {};
	local v14 = {};
	local v15 = {};
	local v16 = TweenInfo.new(p4.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
	local v17 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local v18 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local v19 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
	local v20 = Instance.new("BillboardGui");
	v20.Name = "Prompt";
	v20.AlwaysOnTop = true;
	local v21 = Instance.new("Frame");
	v21.Size = UDim2.fromScale(0.5, 1);
	v21.BackgroundTransparency = 1;
	v21.BackgroundColor3 = Color3.new(0.07, 0.07, 0.07);
	v21.Parent = v20;
	Instance.new("UICorner").Parent = v21;
	local v22 = Instance.new("Frame");
	v22.Name = "InputFrame";
	v22.Size = UDim2.fromScale(1, 1);
	v22.BackgroundTransparency = 1;
	v22.SizeConstraint = Enum.SizeConstraint.RelativeYY;
	v22.Parent = v21;
	local v23 = Instance.new("Frame");
	v23.Size = UDim2.fromScale(1, 1);
	v23.Position = UDim2.fromScale(0.5, 0.5);
	v23.AnchorPoint = Vector2.new(0.5, 0.5);
	v23.BackgroundTransparency = 1;
	v23.Parent = v22;
	local v24 = Instance.new("UIScale");
	v24.Parent = v23;
	if p5 == Enum.ProximityPromptInputType.Touch then
		local v25 = 1.6;
	else
		v25 = 1.33;
	end;
	table.insert(v12, l__TweenService__3:Create(v24, v18, {
		Scale = v25
	}));
	table.insert(v13, l__TweenService__3:Create(v24, v18, {
		Scale = 1
	}));
	local v26 = Instance.new("TextLabel");
	v26.Name = "ActionText";
	v26.Size = UDim2.fromScale(1, 1);
	v26.Font = Enum.Font.GothamSemibold;
	v26.TextSize = 19;
	v26.BackgroundTransparency = 1;
	v26.TextTransparency = 1;
	v26.TextColor3 = Color3.new(1, 1, 1);
	v26.TextXAlignment = Enum.TextXAlignment.Left;
	v26.Parent = v21;
	table.insert(v12, l__TweenService__3:Create(v26, v18, {
		TextTransparency = 1
	}));
	table.insert(v13, l__TweenService__3:Create(v26, v18, {
		TextTransparency = 0
	}));
	table.insert(v14, l__TweenService__3:Create(v26, v18, {
		TextTransparency = 1
	}));
	table.insert(v15, l__TweenService__3:Create(v26, v18, {
		TextTransparency = 0
	}));
	local v27 = Instance.new("TextLabel");
	v27.Name = "ObjectText";
	v27.Size = UDim2.fromScale(1, 1);
	v27.Font = Enum.Font.GothamSemibold;
	v27.TextSize = 14;
	v27.BackgroundTransparency = 1;
	v27.TextTransparency = 1;
	v27.TextColor3 = Color3.new(0.7, 0.7, 0.7);
	v27.TextXAlignment = Enum.TextXAlignment.Left;
	v27.Parent = v21;
	table.insert(v12, l__TweenService__3:Create(v27, v18, {
		TextTransparency = 1
	}));
	table.insert(v13, l__TweenService__3:Create(v27, v18, {
		TextTransparency = 0
	}));
	table.insert(v14, l__TweenService__3:Create(v27, v18, {
		TextTransparency = 1
	}));
	table.insert(v15, l__TweenService__3:Create(v27, v18, {
		TextTransparency = 0
	}));
	table.insert(v12, l__TweenService__3:Create(v21, v18, {
		Size = UDim2.fromScale(0.5, 1), 
		BackgroundTransparency = 1
	}));
	table.insert(v13, l__TweenService__3:Create(v21, v18, {
		Size = UDim2.fromScale(1, 1), 
		BackgroundTransparency = 0.2
	}));
	table.insert(v14, l__TweenService__3:Create(v21, v18, {
		Size = UDim2.fromScale(0.5, 1), 
		BackgroundTransparency = 1
	}));
	table.insert(v15, l__TweenService__3:Create(v21, v18, {
		Size = UDim2.fromScale(1, 1), 
		BackgroundTransparency = 0.2
	}));
	local v28 = Instance.new("Frame");
	v28.Name = "RoundFrame";
	v28.Size = UDim2.fromOffset(48, 48);
	v28.AnchorPoint = Vector2.new(0.5, 0.5);
	v28.Position = UDim2.fromScale(0.5, 0.5);
	v28.BackgroundTransparency = 1;
	v28.Parent = v23;
	local v29 = Instance.new("UICorner");
	v29.CornerRadius = UDim.new(0.5, 0);
	v29.Parent = v28;
	table.insert(v14, l__TweenService__3:Create(v28, v19, {
		BackgroundTransparency = 1
	}));
	table.insert(v15, l__TweenService__3:Create(v28, v19, {
		BackgroundTransparency = 0.7
	}));
	if p4.Name ~= "HintPrompt" and p4.Name ~= "MessagePrompt" then
		if p5 == Enum.ProximityPromptInputType.Gamepad then
			if u4[p4.GamepadKeyCode] then
				local v30 = Instance.new("ImageLabel");
				v30.Name = "ButtonImage";
				v30.AnchorPoint = Vector2.new(0.5, 0.5);
				v30.Size = UDim2.fromOffset(24, 24);
				v30.Position = UDim2.fromScale(0.5, 0.5);
				v30.BackgroundTransparency = 1;
				v30.ImageTransparency = 1;
				v30.Image = u4[p4.GamepadKeyCode];
				v30.Parent = v23;
				table.insert(v14, l__TweenService__3:Create(v30, v19, {
					ImageTransparency = 1
				}));
				table.insert(v15, l__TweenService__3:Create(v30, v19, {
					ImageTransparency = 0
				}));
			end;
		elseif p5 == Enum.ProximityPromptInputType.Touch then
			local v31 = Instance.new("ImageLabel");
			v31.Name = "ButtonImage";
			v31.BackgroundTransparency = 1;
			v31.ImageTransparency = 1;
			v31.Size = UDim2.fromOffset(25, 31);
			v31.AnchorPoint = Vector2.new(0.5, 0.5);
			v31.Position = UDim2.fromScale(0.5, 0.5);
			v31.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
			v31.Parent = v23;
			table.insert(v14, l__TweenService__3:Create(v31, v19, {
				ImageTransparency = 1
			}));
			table.insert(v15, l__TweenService__3:Create(v31, v19, {
				ImageTransparency = 0
			}));
		else
			local v32 = Instance.new("ImageLabel");
			v32.Name = "ButtonImage";
			v32.BackgroundTransparency = 1;
			v32.ImageTransparency = 1;
			v32.Size = UDim2.fromOffset(28, 30);
			v32.AnchorPoint = Vector2.new(0.5, 0.5);
			v32.Position = UDim2.fromScale(0.5, 0.5);
			v32.Image = "rbxasset://textures/ui/Controls/key_single.png";
			v32.Parent = v23;
			table.insert(v14, l__TweenService__3:Create(v32, v19, {
				ImageTransparency = 1
			}));
			table.insert(v15, l__TweenService__3:Create(v32, v19, {
				ImageTransparency = 0
			}));
			local v33 = game:GetService("UserInputService"):GetStringForKeyCode(p4.KeyboardKeyCode);
			local v34 = u5[p4.KeyboardKeyCode];
			if v34 == nil then
				v34 = u6[v33];
			end;
			if v34 == nil then
				local v35 = u7[p4.KeyboardKeyCode];
				if v35 then
					v33 = v35;
				end;
			end;
			if v34 then
				local v36 = Instance.new("ImageLabel");
				v36.Name = "ButtonImage";
				v36.AnchorPoint = Vector2.new(0.5, 0.5);
				v36.Size = UDim2.fromOffset(36, 36);
				v36.Position = UDim2.fromScale(0.5, 0.5);
				v36.BackgroundTransparency = 1;
				v36.ImageTransparency = 1;
				v36.Image = v34;
				v36.Parent = v23;
				table.insert(v14, l__TweenService__3:Create(v36, v19, {
					ImageTransparency = 1
				}));
				table.insert(v15, l__TweenService__3:Create(v36, v19, {
					ImageTransparency = 0
				}));
			elseif v33 ~= nil and v33 ~= "" then
				local v37 = Instance.new("TextLabel");
				v37.Name = "ButtonText";
				v37.Position = UDim2.fromOffset(0, -1);
				v37.Size = UDim2.fromScale(1, 1);
				v37.Font = Enum.Font.GothamSemibold;
				v37.TextSize = 14;
				if string.len(v33) > 2 then
					v37.TextSize = 12;
				end;
				v37.BackgroundTransparency = 1;
				v37.TextTransparency = 1;
				v37.TextColor3 = Color3.new(1, 1, 1);
				v37.TextXAlignment = Enum.TextXAlignment.Center;
				v37.Text = v33;
				v37.Parent = v23;
				table.insert(v14, l__TweenService__3:Create(v37, v19, {
					TextTransparency = 1
				}));
				table.insert(v15, l__TweenService__3:Create(v37, v19, {
					TextTransparency = 0
				}));
			else
				error("ProximityPrompt '" .. p4.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(p4.KeyboardKeyCode));
			end;
		end;
	elseif p4.Name == "MessagePrompt" then
		local v38 = Instance.new("ImageLabel");
		v38.Name = "ButtonImage";
		v38.BackgroundTransparency = 1;
		v38.ImageTransparency = 1;
		v38.Size = UDim2.fromOffset(48, 48);
		v38.AnchorPoint = Vector2.new(0.5, 0.5);
		v38.Position = UDim2.fromScale(0.5, 0.5);
		v38.Image = "rbxassetid://7081031939";
		v38.Parent = v23;
		table.insert(v14, l__TweenService__3:Create(v38, v19, {
			ImageTransparency = 1
		}));
		table.insert(v15, l__TweenService__3:Create(v38, v19, {
			ImageTransparency = 0
		}));
	elseif p5 == Enum.ProximityPromptInputType.Gamepad then
		local v39 = Instance.new("ImageLabel");
		v39.Name = "ButtonImage";
		v39.AnchorPoint = Vector2.new(0.5, 0.5);
		v39.Size = UDim2.fromOffset(24, 24);
		v39.Position = UDim2.fromScale(0.5, 0.5);
		v39.BackgroundTransparency = 1;
		v39.ImageTransparency = 1;
		v39.Image = "";
		v39.Parent = v23;
		table.insert(v14, l__TweenService__3:Create(v39, v19, {
			ImageTransparency = 1
		}));
		table.insert(v15, l__TweenService__3:Create(v39, v19, {
			ImageTransparency = 0
		}));
		if p4:GetAttribute("Keybind") == "Keybind" then
			v39.Image = "rbxasset://textures/ui/Controls/xboxLS@3x.png";
		end;
	elseif p5 == Enum.ProximityPromptInputType.Touch then
		local v40 = Instance.new("ImageLabel");
		v40.Name = "ButtonImage";
		v40.BackgroundTransparency = 1;
		v40.ImageTransparency = 1;
		v40.Size = UDim2.fromOffset(25, 31);
		v40.AnchorPoint = Vector2.new(0.5, 0.5);
		v40.Position = UDim2.fromScale(0.5, 0.5);
		v40.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png";
		v40.Parent = v23;
		if p4:GetAttribute("Keybind") == "Keybind" then
			v40.Image = "rbxassetid://5272475782";
		end;
		table.insert(v14, l__TweenService__3:Create(v40, v19, {
			ImageTransparency = 1
		}));
		table.insert(v15, l__TweenService__3:Create(v40, v19, {
			ImageTransparency = 0
		}));
	else
		local v41 = Instance.new("ImageLabel");
		v41.Name = "ButtonImage";
		v41.BackgroundTransparency = 1;
		v41.ImageTransparency = 1;
		v41.Size = UDim2.fromOffset(28, 30);
		v41.AnchorPoint = Vector2.new(0.5, 0.5);
		v41.Position = UDim2.fromScale(0.5, 0.5);
		v41.Image = "rbxasset://textures/ui/Controls/key_single.png";
		v41.Parent = v23;
		table.insert(v14, l__TweenService__3:Create(v41, v19, {
			ImageTransparency = 1
		}));
		table.insert(v15, l__TweenService__3:Create(v41, v19, {
			ImageTransparency = 0
		}));
		local v42 = "Bruh";
		if p4:GetAttribute("Keybind") == "Crouch" then
			v42 = "C";
		end;
		local v43 = nil;
		if v43 == nil then
			v43 = u6[v42];
		end;
		if v43 then
			local v44 = Instance.new("ImageLabel");
			v44.Name = "ButtonImage";
			v44.AnchorPoint = Vector2.new(0.5, 0.5);
			v44.Size = UDim2.fromOffset(36, 36);
			v44.Position = UDim2.fromScale(0.5, 0.5);
			v44.BackgroundTransparency = 1;
			v44.ImageTransparency = 1;
			v44.Image = v43;
			v44.Parent = v23;
			table.insert(v14, l__TweenService__3:Create(v44, v19, {
				ImageTransparency = 1
			}));
			table.insert(v15, l__TweenService__3:Create(v44, v19, {
				ImageTransparency = 0
			}));
		elseif v42 ~= nil and v42 ~= "" then
			local v45 = Instance.new("TextLabel");
			v45.Name = "ButtonText";
			v45.Position = UDim2.fromOffset(0, -1);
			v45.Size = UDim2.fromScale(1, 1);
			v45.Font = Enum.Font.GothamSemibold;
			v45.TextSize = 14;
			if string.len(v42) > 2 then
				v45.TextSize = 12;
			end;
			v45.BackgroundTransparency = 1;
			v45.TextTransparency = 1;
			v45.TextColor3 = Color3.new(1, 1, 1);
			v45.TextXAlignment = Enum.TextXAlignment.Center;
			v45.Text = v42;
			v45.Parent = v23;
			table.insert(v14, l__TweenService__3:Create(v45, v19, {
				TextTransparency = 1
			}));
			table.insert(v15, l__TweenService__3:Create(v45, v19, {
				TextTransparency = 0
			}));
		else
			error("ProximityPrompt '" .. p4.Name .. "' has an unsupported keycode for rendering UI: " .. tostring(p4.KeyboardKeyCode));
		end;
	end;
	if p5 == Enum.ProximityPromptInputType.Touch or p4.ClickablePrompt then
		local v46 = Instance.new("TextButton");
		v46.BackgroundTransparency = 1;
		v46.TextTransparency = 1;
		v46.Size = UDim2.fromScale(1, 1);
		v46.Parent = v20;
		local u14 = false;
		v46.InputBegan:Connect(function(p7)
			if (p7.UserInputType == Enum.UserInputType.Touch or p7.UserInputType == Enum.UserInputType.MouseButton1) and p7.UserInputState ~= Enum.UserInputState.Change then
				p4:InputHoldBegin();
				u14 = true;
			end;
		end);
		v46.InputEnded:Connect(function(p8)
			if (p8.UserInputType == Enum.UserInputType.Touch or p8.UserInputType == Enum.UserInputType.MouseButton1) and u14 then
				u14 = false;
				p4:InputHoldEnd();
			end;
		end);
		v20.Active = true;
	end;
	if p4.HoldDuration > 0 then
		local v47 = u8();
		v47.Parent = v23;
		table.insert(v12, l__TweenService__3:Create(v47.Progress, v16, {
			Value = 1
		}));
		table.insert(v13, l__TweenService__3:Create(v47.Progress, v17, {
			Value = 0
		}));
	end;
	local v48 = nil;
	local v49 = nil;
	if p4.HoldDuration > 0 then
		v48 = p4.PromptButtonHoldBegan:Connect(function()
			local v50, v51, v52 = ipairs(v12);
			while true do
				v50(v51, v52);
				if not v50 then
					break;
				end;
				v52 = v50;
				v51:Play();			
			end;
		end);
		v49 = p4.PromptButtonHoldEnded:Connect(function()
			local v53, v54, v55 = ipairs(v13);
			while true do
				v53(v54, v55);
				if not v53 then
					break;
				end;
				v55 = v53;
				v54:Play();			
			end;
		end);
	end;
	local v56 = p4.Triggered:Connect(function()
		local v57, v58, v59 = ipairs(v14);
		while true do
			v57(v58, v59);
			if not v57 then
				break;
			end;
			v59 = v57;
			v58:Play();		
		end;
	end);
	local v60 = p4.TriggerEnded:Connect(function()
		local v61, v62, v63 = ipairs(v15);
		while true do
			v61(v62, v63);
			if not v61 then
				break;
			end;
			v63 = v61;
			v62:Play();		
		end;
	end);
	local function v64()
		local v65 = math.max(l__TextService__11:GetTextSize(p4.ActionText, 19, Enum.Font.GothamSemibold, Vector2.new(1000, 1000)).X, l__TextService__11:GetTextSize(p4.ObjectText, 14, Enum.Font.GothamSemibold, Vector2.new(1000, 1000)).X);
		local v66 = 72;
		if p4.ActionText ~= nil and p4.ActionText ~= "" or p4.ObjectText ~= nil and p4.ObjectText ~= "" then
			v66 = v65 + 72 + 24;
		end;
		local v67 = 0;
		if p4.ObjectText ~= nil and p4.ObjectText ~= "" then
			v67 = 9;
		end;
		v26.Position = UDim2.new(0.5, 72 - v66 / 2, 0, v67);
		v27.Position = UDim2.new(0.5, 72 - v66 / 2, 0, -10);
		v26.Text = p4.ActionText;
		v27.Text = p4.ObjectText;
		v26.AutoLocalize = p4.AutoLocalize;
		v26.RootLocalizationTable = p4.RootLocalizationTable;
		v27.AutoLocalize = p4.AutoLocalize;
		v27.RootLocalizationTable = p4.RootLocalizationTable;
		v20.Size = UDim2.fromOffset(v66, 72);
		v20.SizeOffset = Vector2.new(p4.UIOffset.X / v20.Size.Width.Offset, p4.UIOffset.Y / v20.Size.Height.Offset);
	end;
	local v68 = p4.Changed:Connect(v64);
	v64();
	v20.Adornee = p4.Parent;
	v20.Parent = p6;
	local v69, v70, v71 = ipairs(v15);
	while true do
		v69(v70, v71);
		if not v69 then
			break;
		end;
		v71 = v69;
		v70:Play();	
	end;
	return function()
		if v48 then
			v48:Disconnect();
		end;
		if v49 then
			v49:Disconnect();
		end;
		v56:Disconnect();
		v60:Disconnect();
		v68:Disconnect();
		local v72, v73, v74 = ipairs(v14);
		while true do
			v72(v73, v74);
			if not v72 then
				break;
			end;
			v74 = v72;
			v73:Play();		
		end;
		wait(0.2);
		v20.Parent = nil;
	end;
end;
l__ProximityPromptService__12.PromptShown:Connect(function(p9, p10)
	if p9.Style == Enum.ProximityPromptStyle.Default then
		return;
	end;
	local v75 = l__PlayerGui__1:FindFirstChild("ProximityPrompts");
	if v75 == nil then
		v75 = Instance.new("ScreenGui");
		v75.Name = "ProximityPrompts";
		v75.ResetOnSpawn = false;
		v75.Parent = l__PlayerGui__1;
	end;
	local v76 = u13(p9, p10, v75);
	p9.PromptHidden:Wait();
	v76();
end);
