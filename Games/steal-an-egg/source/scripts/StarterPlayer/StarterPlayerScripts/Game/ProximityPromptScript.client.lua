-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t = {
	prompt = nil,
	baseFov = nil,
	tween = nil
}

local function cleanupWildEggTween() --[[ cleanupWildEggTween | Line: 29 | Upvalues: t (copy) ]]
	if not t.tween then
		return
	end

	t.tween:Cancel()
	t.tween = nil
end

local function isWildEggPrompt(p1) --[[ isWildEggPrompt | Line: 36 ]]
	if typeof(p1:GetAttribute("Progress")) ~= "number" then
		return false
	end

	local v1 = p1.Parent

	if not v1 then
		return false
	end

	return v1.Name == "WildAssetEgg"
end

local function applyWildEggZoom(p1, p2) --[[ applyWildEggZoom | Line: 49 | Upvalues: Workspace (copy), t (copy), TweenService (copy), v1 (copy) ]]
	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local v12 = math.clamp(p2, 0, 1)

	if v12 <= 0 then
		if t.prompt ~= p1 or not t.baseFov then
			return
		end

		if t.tween then
			t.tween:Cancel()
			t.tween = nil
		end

		t.tween = TweenService:Create(CurrentCamera, v1, {
			FieldOfView = t.baseFov
		})
		assert(t.tween, "luau")
		t.tween:Play()
		t.prompt = nil
		t.baseFov = nil
	else
		if t.prompt ~= p1 then
			t.prompt = p1
			t.baseFov = CurrentCamera.FieldOfView
		end

		local baseFov = t.baseFov

		if not baseFov then
			return
		end

		local v2 = baseFov + (math.max(40, baseFov - 30) - baseFov) * v12

		if math.abs(CurrentCamera.FieldOfView - v2) < 0.001 then
			return
		end

		local v4

		if not t.tween then
			t.tween = TweenService:Create(CurrentCamera, v1, {
				FieldOfView = v2
			})
			v4 = t.tween
			assert(v4, "luau")
			t.tween:Play()

			return
		end

		t.tween:Cancel()
		t.tween = nil
		t.tween = TweenService:Create(CurrentCamera, v1, {
			FieldOfView = v2
		})
		v4 = t.tween
		assert(v4, "luau")
		t.tween:Play()
	end
end

local t2 = {
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
}
local t3 = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
}
local t4 = {
	["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
	[","] = "rbxasset://textures/ui/Controls/comma.png",
	["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
	["."] = "rbxasset://textures/ui/Controls/period.png",
	[" "] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local t5 = {
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
}

local function getScreenGui() --[[ getScreenGui | Line: 145 | Upvalues: PlayerGui (copy) ]]
	local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

	if ProximityPrompts == nil then
		local ProximityPrompts2 = Instance.new("ScreenGui")

		ProximityPrompts2.Name = "ProximityPrompts"
		ProximityPrompts2.ResetOnSpawn = false
		ProximityPrompts2.Parent = PlayerGui
		ProximityPrompts = ProximityPrompts2
	end

	return ProximityPrompts
end

local function setUpCircularProgressBar(p1) --[[ setUpCircularProgressBar | Line: 156 ]]
	local UIGradient = p1.LeftGradient.ProgressBarImage.UIGradient
	local UIGradient2 = p1.RightGradient.ProgressBarImage.UIGradient

	p1.Progress.Changed:Connect(function(p13) --[[ Line: 161 | Upvalues: UIGradient (copy), UIGradient2 (copy) ]]
		local v1 = math.clamp(p13 * 360, 0, 360)

		UIGradient.Rotation = math.clamp(v1, 180, 360)
		UIGradient2.Rotation = math.clamp(v1, 0, 180)
	end)
end

local function createPrompt(p1, p2, p3) --[[ createPrompt | Line: 168 | Upvalues: TweenService (copy), t2 (copy), UserInputService (copy), t3 (copy), t4 (copy), t5 (copy), LocalPlayer (copy), applyWildEggZoom (copy), Workspace (copy), t (copy), v1 (copy), TextService (copy) ]]
	local t6 = {}
	local t7 = {}
	local t8 = {}
	local list = {}
	local v12 = TweenInfo.new(p1.HoldDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local v2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v3 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v4 = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v5 = nil
	local v6 = p1:GetAttribute("Theme")

	if v6 then
		local v7 = script:FindFirstChild(v6)

		if v7 then
			v5 = v7:Clone()
		end
	end

	if v5 == nil then
		v5 = script.Default:Clone()
	end

	v5.Enabled = true

	local PromptFrame = v5.PromptFrame
	local InputFrame = PromptFrame.InputFrame
	local ActionText = PromptFrame.ActionText
	local ObjectText = PromptFrame.ObjectText
	local BackgroundTransparency = PromptFrame.BackgroundTransparency
	local ImageTransparency = PromptFrame.ImageTransparency

	PromptFrame.BackgroundTransparency = 1
	PromptFrame.ImageTransparency = 1

	local v8 = TweenService

	table.insert(t6, v8:Create(PromptFrame, v2, {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}))

	local v9 = TweenService

	table.insert(t7, v9:Create(PromptFrame, v2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = BackgroundTransparency,
		ImageTransparency = ImageTransparency
	}))

	local v10 = TweenService

	table.insert(t8, v10:Create(PromptFrame, v2, {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.fromScale(0.5, 1)
	}))

	local v11 = TweenService

	table.insert(list, v11:Create(PromptFrame, v2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = BackgroundTransparency,
		ImageTransparency = ImageTransparency
	}))

	local function setupUIStrokeTweens(p1) --[[ setupUIStrokeTweens | Line: 240 | Upvalues: t6 (copy), TweenService (ref), v2 (copy), t7 (copy), t8 (copy), list (copy) ]]
		local Transparency = p1.Transparency

		p1.Transparency = 1
		table.insert(t6, TweenService:Create(p1, v2, {
			Transparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			Transparency = Transparency
		}))
		table.insert(t8, TweenService:Create(p1, v2, {
			Transparency = 1
		}))
		table.insert(list, TweenService:Create(p1, v2, {
			Transparency = Transparency
		}))
	end

	local function setupGUIObjectTweens(p1) --[[ setupGUIObjectTweens | Line: 252 | Upvalues: t6 (copy), TweenService (ref), v2 (copy), t7 (copy), t8 (copy), list (copy) ]]
		local BackgroundTransparency = p1.BackgroundTransparency

		p1.BackgroundTransparency = 1
		table.insert(t6, TweenService:Create(p1, v2, {
			BackgroundTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			BackgroundTransparency = BackgroundTransparency
		}))
		table.insert(t8, TweenService:Create(p1, v2, {
			BackgroundTransparency = 1
		}))
		table.insert(list, TweenService:Create(p1, v2, {
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	local function setupTextLabelTweens(p1) --[[ setupTextLabelTweens | Line: 270 | Upvalues: t6 (copy), TweenService (ref), v2 (copy), t7 (copy), t8 (copy), list (copy) ]]
		local TextTransparency = p1.TextTransparency
		local TextStrokeTransparency = p1.TextStrokeTransparency

		p1.TextTransparency = 1
		p1.TextStrokeTransparency = 1
		table.insert(t6, TweenService:Create(p1, v2, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency
		}))
		table.insert(t8, TweenService:Create(p1, v2, {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}))
		table.insert(list, TweenService:Create(p1, v2, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency
		}))
	end

	local function setupImageLabelTweens(p1) --[[ setupImageLabelTweens | Line: 301 | Upvalues: t6 (copy), TweenService (ref), v2 (copy), t7 (copy), t8 (copy), list (copy) ]]
		local ImageTransparency = p1.ImageTransparency

		p1.ImageTransparency = 1
		table.insert(t6, TweenService:Create(p1, v2, {
			ImageTransparency = 1
		}))
		table.insert(t7, TweenService:Create(p1, v2, {
			ImageTransparency = ImageTransparency
		}))
		table.insert(t8, TweenService:Create(p1, v2, {
			ImageTransparency = 1
		}))
		table.insert(list, TweenService:Create(p1, v2, {
			ImageTransparency = ImageTransparency
		}))
	end

	local function v122(p1) --[[ setupUnexpectedChildTweens | Line: 319 | Upvalues: setupUIStrokeTweens (copy), setupGUIObjectTweens (copy), setupTextLabelTweens (copy), setupImageLabelTweens (copy), v122 (copy) ]]
		if p1:IsA("UIStroke") then
			setupUIStrokeTweens(p1)
		elseif not p1:IsA("UIGradient") and p1:IsA("GuiObject") then
			setupGUIObjectTweens(p1)

			if p1:IsA("TextLabel") then
				setupTextLabelTweens(p1)
			elseif p1:IsA("ImageLabel") then
				setupImageLabelTweens(p1)
			end
		end

		for k, v in pairs(p1:GetChildren()) do
			v122(v)
		end
	end

	local t13 = {
		[InputFrame] = false,
		[ActionText] = true,
		[ObjectText] = true
	}

	for k, v in pairs(PromptFrame:GetChildren()) do
		if t13[v] == nil then
			v122(v)

			continue
		end

		if t13[v] == true then
			for k2, v7 in pairs(v:GetChildren()) do
				v122(v7)
			end
		end
	end

	local Frame = InputFrame.Frame
	local UIScale = Frame.UIScale
	local v14 = TweenService

	table.insert(t6, v14:Create(UIScale, v2, {
		Scale = if p2 == Enum.ProximityPromptInputType.Touch then 1.6 else 1.33
	}))

	local v15 = TweenService

	table.insert(t7, v15:Create(UIScale, v2, {
		Scale = 1
	}))
	setupTextLabelTweens(ActionText)
	setupTextLabelTweens(ObjectText)

	local ButtonFrame = Frame.ButtonFrame;

	(function() --[[ setupButtonFrameTweens | Line: 369 | Upvalues: ButtonFrame (copy), t8 (copy), TweenService (ref), v3 (copy), list (copy) ]]
		table.insert(t8, TweenService:Create(ButtonFrame, v3, {
			BackgroundTransparency = 1,
			ImageTransparency = 1
		}))
		table.insert(list, TweenService:Create(ButtonFrame, v3, {
			BackgroundTransparency = ButtonFrame.BackgroundTransparency,
			ImageTransparency = ButtonFrame.ImageTransparency
		}))

		for k, v in pairs(ButtonFrame:getChildren()) do
			if v:IsA("UIStroke") then
				table.insert(t8, TweenService:Create(v, v3, {
					Transparency = 1
				}))
				table.insert(list, TweenService:Create(v, v3, {
					Transparency = v.Transparency
				}))
			end
		end
	end)()

	local ButtonImage = Frame.ButtonImage
	local ButtonText = Frame.ButtonText
	local ButtonTextImage = Frame.ButtonTextImage

	local function setupButtonTextTweens() --[[ setupButtonTextTweens | Line: 403 | Upvalues: ButtonText (copy), t8 (copy), TweenService (ref), v3 (copy), list (copy) ]]
		local TextTransparency = ButtonText.TextTransparency
		local TextStrokeTransparency = ButtonText.TextStrokeTransparency
		local BackgroundTransparency = ButtonText.BackgroundTransparency

		ButtonText.BackgroundTransparency = 1
		ButtonText.TextStrokeTransparency = 1
		ButtonText.TextTransparency = 1
		table.insert(t8, TweenService:Create(ButtonText, v3, {
			TextTransparency = 1,
			TextStrokeTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(list, TweenService:Create(ButtonText, v3, {
			TextTransparency = TextTransparency,
			TextStrokeTransparency = TextStrokeTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))

		for k, v in pairs(ButtonText:getChildren()) do
			if v:IsA("UIStroke") then
				table.insert(t8, TweenService:Create(v, v3, {
					Transparency = 1
				}))
				table.insert(list, TweenService:Create(v, v3, {
					Transparency = v.Transparency
				}))
			end
		end
	end

	local function setupButtonImageTweens() --[[ setupButtonImageTweens | Line: 440 | Upvalues: ButtonImage (copy), t8 (copy), TweenService (ref), v3 (copy), list (copy) ]]
		local ImageTransparency = ButtonImage.ImageTransparency
		local BackgroundTransparency = ButtonImage.BackgroundTransparency

		ButtonImage.BackgroundTransparency = 1
		ButtonImage.ImageTransparency = 1
		table.insert(t8, TweenService:Create(ButtonImage, v3, {
			ImageTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(list, TweenService:Create(ButtonImage, v3, {
			ImageTransparency = ImageTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	local function setupIconTweens() --[[ setupIconTweens | Line: 458 | Upvalues: ButtonTextImage (copy), t8 (copy), TweenService (ref), v3 (copy), list (copy) ]]
		local BackgroundTransparency = ButtonTextImage.BackgroundTransparency
		local ImageTransparency = ButtonTextImage.ImageTransparency

		ButtonTextImage.BackgroundTransparency = 1
		ButtonTextImage.ImageTransparency = 1
		table.insert(t8, TweenService:Create(ButtonTextImage, v3, {
			ImageTransparency = 1,
			BackgroundTransparency = 1
		}))
		table.insert(list, TweenService:Create(ButtonTextImage, v3, {
			ImageTransparency = ImageTransparency,
			BackgroundTransparency = BackgroundTransparency
		}))
	end

	if p2 == Enum.ProximityPromptInputType.Gamepad then
		if t2[p1.GamepadKeyCode] then
			setupIconTweens()
			ButtonTextImage.Image = t2[p1.GamepadKeyCode]
			ButtonText.Visible = false
			ButtonImage.Visible = false
			ButtonTextImage.Visible = true
		end
	elseif p2 == Enum.ProximityPromptInputType.Touch then
		setupButtonImageTweens()
		ButtonImage.Image = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
		ButtonText.Visible = false
		ButtonTextImage.Visible = false
		ButtonImage.Visible = true
	else
		setupButtonImageTweens()
		ButtonImage.Visible = true

		local v16 = UserInputService:GetStringForKeyCode(p1.KeyboardKeyCode)
		local v17 = t3[p1.KeyboardKeyCode]

		if v17 == nil then
			v17 = t4[v16]
		end

		if v17 == nil then
			local v18 = t5[p1.KeyboardKeyCode]

			if v18 then
				v16 = v18
			end
		end

		if v17 then
			setupIconTweens()
			ButtonTextImage.Image = v17
			ButtonText.Visible = false
			ButtonTextImage.Visible = true
		else
			if v16 == nil or v16 == "" then
				error("ProximityPrompt \'" .. p1.Name .. "\' has an unsupported keycode for rendering UI: " .. tostring(p1.KeyboardKeyCode))
			end

			if string.len(v16) > 2 then
				ButtonText.TextSize = math.round(ButtonText.TextSize * 6 / 7)
			end

			setupButtonTextTweens()
			ButtonText.Text = v16
			ButtonTextImage.Visible = false
			ButtonText.Visible = true
		end
	end

	if p2 == Enum.ProximityPromptInputType.Touch or p1.ClickablePrompt then
		local TextButton = v5.TextButton
		local v22 = false

		TextButton.InputBegan:Connect(function(p12) --[[ Line: 547 | Upvalues: p1 (copy), v22 (ref) ]]
			if p12.UserInputType ~= Enum.UserInputType.Touch and p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			if p12.UserInputState == Enum.UserInputState.Change then
				return
			end

			p1:InputHoldBegin()
			v22 = true
		end)
		TextButton.InputEnded:Connect(function(p12) --[[ Line: 558 | Upvalues: v22 (ref), p1 (copy) ]]
			if p12.UserInputType ~= Enum.UserInputType.Touch and p12.UserInputType ~= Enum.UserInputType.MouseButton1 or not v22 then
				return
			end

			v22 = false
			p1:InputHoldEnd()
		end)
		v5.Active = true
	end

	local v23

	if typeof(p1:GetAttribute("Progress")) == "number" then
		local v24 = p1.Parent

		v23 = if v24 then if v24.Name == "WildAssetEgg" then true else false else false
	else
		v23 = false
	end

	local v25 = nil
	local v26 = nil

	if p1.HoldDuration > 0 then
		local ProgressBar = Frame.ProgressBar
		local UIGradient = ProgressBar.LeftGradient.ProgressBarImage.UIGradient
		local UIGradient2 = ProgressBar.RightGradient.ProgressBarImage.UIGradient

		ProgressBar.Progress.Changed:Connect(function(p13) --[[ Line: 161 | Upvalues: UIGradient (copy), UIGradient2 (copy) ]]
			local v1 = math.clamp(p13 * 360, 0, 360)

			UIGradient.Rotation = math.clamp(v1, 180, 360)
			UIGradient2.Rotation = math.clamp(v1, 0, 180)
		end)

		local v27 = "Progress_" .. LocalPlayer.UserId

		if typeof(p1:GetAttribute("Progress")) == "number" then
			local function syncProgress() --[[ syncProgress | Line: 583 | Upvalues: p1 (copy), v27 (copy), ProgressBar (copy), v23 (copy), applyWildEggZoom (ref) ]]
				local v1 = p1:GetAttribute(v27)

				if typeof(v1) ~= "number" then
					v1 = 0
				end

				ProgressBar.Progress.Value = v1

				if not v23 then
					return
				end

				applyWildEggZoom(p1, v1)
			end

			local v28 = p1:GetAttribute(v27)

			if typeof(v28) ~= "number" then
				v28 = 0
			end

			ProgressBar.Progress.Value = v28

			if v23 then
				applyWildEggZoom(p1, v28)
			end

			v25 = p1:GetAttributeChangedSignal(v27):Connect(syncProgress)

			if v23 then
				v26 = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 599 | Upvalues: p1 (copy), Workspace (ref), t (ref), TweenService (ref), v1 (ref) ]]
					if p2 ~= nil then
						return
					end

					local CurrentCamera = Workspace.CurrentCamera

					if not CurrentCamera then
						return
					end

					if t.prompt ~= p1 or not t.baseFov then
						return
					end

					if t.tween then
						t.tween:Cancel()
						t.tween = nil
					end

					t.tween = TweenService:Create(CurrentCamera, v1, {
						FieldOfView = t.baseFov
					})
					assert(t.tween, "luau")
					t.tween:Play()
					t.prompt = nil
					t.baseFov = nil
				end)
			end
		else
			table.insert(t6, TweenService:Create(ProgressBar.Progress, v12, {
				Value = 1
			}))
			table.insert(t7, TweenService:Create(ProgressBar.Progress, v4, {
				Value = 0
			}))
		end
	end

	local v31, v32

	if p1.HoldDuration > 0 then
		v31 = p1.PromptButtonHoldBegan:Connect(function() --[[ Line: 623 | Upvalues: t6 (copy) ]]
			for i, v in ipairs(t6) do
				v:Play()
			end
		end)
		v32 = p1.PromptButtonHoldEnded:Connect(function() --[[ Line: 629 | Upvalues: t7 (copy) ]]
			for i, v in ipairs(t7) do
				v:Play()
			end
		end)
	else
		v31 = nil
		v32 = nil
	end

	local v33 = p1.Triggered:Connect(function() --[[ Line: 636 | Upvalues: t8 (copy) ]]
		for i, v in ipairs(t8) do
			v:Play()
		end
	end)
	local v34 = p1.TriggerEnded:Connect(function() --[[ Line: 642 | Upvalues: list (copy) ]]
		for i, v in ipairs(list) do
			v:Play()
		end
	end)

	local function getTextBoundsForLabel(p1, p2) --[[ getTextBoundsForLabel | Line: 648 | Upvalues: TextService (ref) ]]
		local GetTextBoundsParams = Instance.new("GetTextBoundsParams")

		GetTextBoundsParams.Font = p1.FontFace
		GetTextBoundsParams.Size = p1.TextSize
		GetTextBoundsParams.Width = 1000

		local v1 = p2 or ""

		if p1.RichText then
			v1 = v1:gsub("<[^>]->", "")
		end

		GetTextBoundsParams.Text = v1

		local v3 = TextService:GetTextBoundsAsync(GetTextBoundsParams)

		GetTextBoundsParams:Destroy()

		return v3
	end

	local function updateUIFromPrompt() --[[ updateUIFromPrompt | Line: 667 | Upvalues: getTextBoundsForLabel (copy), ActionText (copy), p1 (copy), ObjectText (copy), v5 (ref) ]]
		local v4 = if (p1.ActionText == nil or p1.ActionText == "") and (p1.ObjectText == nil or p1.ObjectText == "") then 72 else math.max(getTextBoundsForLabel(ActionText, p1.ActionText).X, getTextBoundsForLabel(ObjectText, p1.ObjectText).X) + 72 + 24

		ActionText.Position = UDim2.new(0.5, 72 - v4 / 2, 0, if p1.ObjectText == nil or p1.ObjectText == "" then 0 else 9)
		ObjectText.Position = UDim2.new(0.5, 72 - v4 / 2, 0, -10)
		ActionText.Text = p1.ActionText
		ObjectText.Text = p1.ObjectText
		ActionText.AutoLocalize = p1.AutoLocalize
		ActionText.RootLocalizationTable = p1.RootLocalizationTable
		ObjectText.AutoLocalize = p1.AutoLocalize
		ObjectText.RootLocalizationTable = p1.RootLocalizationTable
		v5.Size = UDim2.fromOffset(v4, 72)
		v5.SizeOffset = Vector2.new(p1.UIOffset.X / v5.Size.Width.Offset, p1.UIOffset.Y / v5.Size.Height.Offset)
	end

	local v35 = p1.Changed:Connect(updateUIFromPrompt)

	updateUIFromPrompt()
	v5.Adornee = p1.Parent
	v5.Parent = p3

	for i, v in ipairs(list) do
		v:Play()
	end

	return function() --[[ cleanup | Line: 714 | Upvalues: v31 (ref), v32 (ref), v25 (ref), v26 (ref), v33 (ref), v34 (ref), v35 (copy), t8 (copy), v23 (copy), p1 (copy), Workspace (ref), t (ref), TweenService (ref), v1 (ref), v5 (ref) ]]
		if v31 then
			v31:Disconnect()
		end

		if v32 then
			v32:Disconnect()
		end

		if v25 then
			v25:Disconnect()
		end

		if v26 then
			v26:Disconnect()
		end

		v33:Disconnect()
		v34:Disconnect()
		v35:Disconnect()

		for i, v in ipairs(t8) do
			v:Play()
		end

		if v23 then
			local CurrentCamera = Workspace.CurrentCamera

			if CurrentCamera and (t.prompt == p1 and t.baseFov) then
				if t.tween then
					t.tween:Cancel()
					t.tween = nil
				end

				t.tween = TweenService:Create(CurrentCamera, v1, {
					FieldOfView = t.baseFov
				})
				assert(t.tween, "luau")
				t.tween:Play()
				t.prompt = nil
				t.baseFov = nil
			end
		end

		wait(0.2)
		v5.Parent = nil
	end
end

local function onLoad() --[[ onLoad | Line: 751 | Upvalues: ProximityPromptService (copy), PlayerGui (copy), createPrompt (copy) ]]
	ProximityPromptService.PromptShown:Connect(function(p13, p23) --[[ Line: 752 | Upvalues: PlayerGui (ref), createPrompt (ref) ]]
		if p13.Style == Enum.ProximityPromptStyle.Default then
			return
		end

		local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

		if ProximityPrompts == nil then
			local ProximityPrompts2 = Instance.new("ScreenGui")

			ProximityPrompts2.Name = "ProximityPrompts"
			ProximityPrompts2.ResetOnSpawn = false
			ProximityPrompts2.Parent = PlayerGui
			ProximityPrompts = ProximityPrompts2
		end

		local v1 = createPrompt(p13, p23, ProximityPrompts)

		p13.PromptHidden:Wait()
		v1()
	end)
end

ProximityPromptService.PromptShown:Connect(function(p13, p23) --[[ Line: 752 | Upvalues: PlayerGui (copy), createPrompt (copy) ]]
	if p13.Style == Enum.ProximityPromptStyle.Default then
		return
	end

	local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts")

	if ProximityPrompts == nil then
		local ProximityPrompts2 = Instance.new("ScreenGui")

		ProximityPrompts2.Name = "ProximityPrompts"
		ProximityPrompts2.ResetOnSpawn = false
		ProximityPrompts2.Parent = PlayerGui
		ProximityPrompts = ProximityPrompts2
	end

	local v1 = createPrompt(p13, p23, ProximityPrompts)

	p13.PromptHidden:Wait()
	v1()
end)