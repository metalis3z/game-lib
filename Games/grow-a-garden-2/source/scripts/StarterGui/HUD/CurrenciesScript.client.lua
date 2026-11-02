--credit to quartz games studio
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerStateClient = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("PlayerStateClient"))
local NumberUtils = require(game.ReplicatedStorage.SharedModules.NumberUtils)
local leaderstats = LocalPlayer:WaitForChild("leaderstats")

repeat
	task.wait()
until LocalPlayer:HasTag("DataLoaded")

local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local v2 = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local UserInputService = game:GetService("UserInputService")

local function fadeElements(p1, p2, p3) --[[ fadeElements | Line: 23 | Upvalues: TweenService (copy) ]]
	local t = {}
	local TextLabel = p1:FindFirstChild("TextLabel")

	if not TextLabel then
		return t
	end

	t[#t + 1] = TweenService:Create(TextLabel, p2, p3.text or {})

	local UIStroke = TextLabel:FindFirstChild("UIStroke")

	if UIStroke then
		t[#t + 1] = TweenService:Create(UIStroke, p2, p3.stroke or {})
	end

	local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

	if TextLabel2 then
		t[#t + 1] = TweenService:Create(TextLabel2, p2, p3.text or {})

		local UIStroke2 = TextLabel2:FindFirstChild("UIStroke")

		if UIStroke2 then
			t[#t + 1] = TweenService:Create(UIStroke2, p2, p3.stroke or {})
		end
	end

	local CoinIcon = p1:FindFirstChild("CoinIcon")

	if CoinIcon and p3.icon then
		t[#t + 1] = TweenService:Create(CoinIcon, p2, p3.icon)
	end

	return t
end

local function showDeltaPopup(p1, p2, p3) --[[ showDeltaPopup | Line: 47 | Upvalues: NumberUtils (copy), fadeElements (copy), v4 (copy), TweenService (copy), v2 (copy), v3 (copy) ]]
	local DeltaPopup = p1:Clone()

	DeltaPopup.FriendButton.Visible = false
	DeltaPopup.Name = "DeltaPopup"
	DeltaPopup.Parent = script.Parent
	DeltaPopup.Position = p1.Position - UDim2.fromOffset(0, 30)
	DeltaPopup.Size = p1.Size
	DeltaPopup.ZIndex = p1.ZIndex + 1

	for v1, v22 in { "Target", "Goal" } do
		local v32 = DeltaPopup:FindFirstChild(v22)

		if v32 then
			v32:Destroy()
		end
	end

	local v42 = if p2 > 0 then true else false
	local v6 = (if v42 then "+" else "") .. NumberUtils.Abbreviate((math.round(p2))) .. p3
	local TextLabel = DeltaPopup:FindFirstChild("TextLabel")

	if TextLabel then
		TextLabel.Text = v6
		TextLabel.TextTransparency = 1

		local UIStroke = TextLabel:FindFirstChild("UIStroke")

		if UIStroke then
			UIStroke.Transparency = 1
		end

		if not v42 then
			TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)

			if UIStroke then
				UIStroke.Color = Color3.fromRGB(180, 40, 40)
			end
		end

		local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

		if TextLabel2 then
			TextLabel2.Text = v6
			TextLabel2.TextTransparency = 1

			local UIStroke2 = TextLabel2:FindFirstChild("UIStroke")

			if UIStroke2 then
				UIStroke2.Transparency = 1
			end

			if not v42 then
				TextLabel2.TextColor3 = Color3.fromRGB(255, 85, 85)

				if UIStroke2 then
					UIStroke2.Color = Color3.fromRGB(180, 40, 40)
				end

				local UIGradient = TextLabel2:FindFirstChild("UIGradient")

				if UIGradient then
					UIGradient:Destroy()
				end
			end
		end
	end

	local CoinIcon = DeltaPopup:FindFirstChild("CoinIcon")

	if CoinIcon then
		CoinIcon.ImageTransparency = 1
	end

	for v7, v8 in fadeElements(DeltaPopup, v4, {
		text = {
			TextTransparency = 0
		},
		stroke = {
			Transparency = 0
		},
		icon = {
			ImageTransparency = 0
		}
	}) do
		v8:Play()
	end

	TweenService:Create(DeltaPopup, v2, {
		Position = DeltaPopup.Position - UDim2.fromOffset(0, 50)
	}):Play()
	task.delay(0.4, function() --[[ Line: 103 | Upvalues: fadeElements (ref), DeltaPopup (copy), v3 (ref) ]]
		for v1, v2 in fadeElements(DeltaPopup, v3, {
			text = {
				TextTransparency = 1
			},
			stroke = {
				Transparency = 1
			},
			icon = {
				ImageTransparency = 1
			}
		}) do
			v2:Play()
		end

		task.delay(0.9, function() --[[ Line: 110 | Upvalues: DeltaPopup (ref) ]]
			DeltaPopup:Destroy()
		end)
	end)
end

for v6, v7 in {
	{
		stat = "Sheckles",
		frame = "CoinsCounter",
		suffix = "\194\162"
	},
	{
		-- MODDED: contador de la moneda interna Fake Robux (vive bajo el Player)
		stat = "FakeRobux",
		frame = "FakeRobuxCounter",
		suffix = ""
	}
} do
	local v5
	local v8 = leaderstats:WaitForChild(v7.stat, 5) or LocalPlayer:WaitForChild(v7.stat, 5)
	local v9 = script.Parent.Currencies:WaitForChild(v7.frame)
	local Goal = v9:WaitForChild("Goal")
	local Target = v9:WaitForChild("Target")
	local TextLabel = v9:WaitForChild("TextLabel")
	local TextLabel2 = TextLabel:WaitForChild("TextLabel")
	local v10 = v8.Value
	local v11 = false

	local function updateText() --[[ updateText | Line: 124 | Upvalues: Target (copy), v11 (ref), NumberUtils (copy), v7 (copy), TextLabel (copy), TextLabel2 (copy) ]]
		local v2 = math.round(Target.Value)
		local v3, v4

		if v11 then
			local v5 = NumberUtils.FormatWithCommas(v2)

			if v5 then
				v3 = v5
			else
				v4 = NumberUtils.Abbreviate(v2)
				v3 = v4
			end
		else
			v4 = NumberUtils.Abbreviate(v2)
			v3 = v4
		end

		local v6 = v3 .. v7.suffix

		TextLabel.Text = v6
		TextLabel2.Text = v6
	end

	if UserInputService.TouchEnabled == false and UserInputService.KeyboardEnabled == true then
		v9.Active = true
		v9.MouseEnter:Connect(function() --[[ Line: 133 | Upvalues: v11 (ref), Target (copy), NumberUtils (copy), v7 (copy), TextLabel (copy), TextLabel2 (copy) ]]
			v11 = true

			local v2 = math.round(Target.Value)
			local v3, v4

			if v11 then
				local v5 = NumberUtils.FormatWithCommas(v2)

				if v5 then
					v3 = v5
				else
					v4 = NumberUtils.Abbreviate(v2)
					v3 = v4
				end
			else
				v4 = NumberUtils.Abbreviate(v2)
				v3 = v4
			end

			local v6 = v3 .. v7.suffix

			TextLabel.Text = v6
			TextLabel2.Text = v6
		end)
		v9.MouseLeave:Connect(function() --[[ Line: 137 | Upvalues: v11 (ref), Target (copy), NumberUtils (copy), v7 (copy), TextLabel (copy), TextLabel2 (copy) ]]
			v11 = false

			local v2 = math.round(Target.Value)
			local v3, v4

			if v11 then
				local v5 = NumberUtils.FormatWithCommas(v2)

				if v5 then
					v3 = v5
				else
					v4 = NumberUtils.Abbreviate(v2)
					v3 = v4
				end
			else
				v4 = NumberUtils.Abbreviate(v2)
				v3 = v4
			end

			local v6 = v3 .. v7.suffix

			TextLabel.Text = v6
			TextLabel2.Text = v6
		end)
	end

	Target:GetPropertyChangedSignal("Value"):Connect(updateText)
	v8:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 145 | Upvalues: v8 (copy), v10 (ref), Goal (copy), TweenService (copy), Target (copy), v1 (copy), showDeltaPopup (copy), v9 (copy), v7 (copy) ]]
		local v12 = v8.Value
		local v2 = v12 - v10

		Goal.Value = v12
		TweenService:Create(Target, v1, {
			Value = Goal.Value
		}):Play()

		if v2 ~= 0 then
			showDeltaPopup(v9, v2, v7.suffix)
		end

		v10 = v12
	end)
	Goal.Value = v8.Value
	Target.Value = v8.Value

	local v13 = math.round(Target.Value)
	local v14

	if v11 then
		local v15 = NumberUtils.FormatWithCommas(v13)

		if v15 then
			v5 = v15
		else
			v14 = NumberUtils.Abbreviate(v13)
			v5 = v14
		end
	else
		v14 = NumberUtils.Abbreviate(v13)
		v5 = v14
	end

	local v16 = v5 .. v7.suffix

	TextLabel.Text = v16
	TextLabel2.Text = v16
end

local v17 = PlayerStateClient:WaitForLocalReplica(30)

if not v17 then
	return
end

local TokensCounter = script.Parent.Currencies:WaitForChild("TokensCounter")
local Goal = TokensCounter:WaitForChild("Goal")
local Target = TokensCounter:WaitForChild("Target")
local TextLabel = TokensCounter:WaitForChild("TextLabel")
local TextLabel2 = TextLabel:WaitForChild("TextLabel")
local v18 = v17.Data.Tokens or 0
local v19 = false

local function updateText() --[[ updateText | Line: 173 | Upvalues: Target (copy), v19 (ref), NumberUtils (copy), TextLabel (copy), TextLabel2 (copy) ]]
	local v2 = math.round(Target.Value)
	local v3 = v19 and NumberUtils.FormatWithCommas(v2) or NumberUtils.Abbreviate(v2)

	TextLabel.Text = v3
	TextLabel2.Text = v3
end

if UserInputService.TouchEnabled == false and UserInputService.KeyboardEnabled == true then
	TokensCounter.MouseEnter:Connect(function() --[[ Line: 183 | Upvalues: v19 (ref), Target (copy), NumberUtils (copy), TextLabel (copy), TextLabel2 (copy) ]]
		v19 = true

		local v2 = math.round(Target.Value)
		local v3 = v19 and NumberUtils.FormatWithCommas(v2) or NumberUtils.Abbreviate(v2)

		TextLabel.Text = v3
		TextLabel2.Text = v3
	end)
	TokensCounter.MouseLeave:Connect(function() --[[ Line: 187 | Upvalues: v19 (ref), Target (copy), NumberUtils (copy), TextLabel (copy), TextLabel2 (copy) ]]
		v19 = false

		local v2 = math.round(Target.Value)
		local v3 = v19 and NumberUtils.FormatWithCommas(v2) or NumberUtils.Abbreviate(v2)

		TextLabel.Text = v3
		TextLabel2.Text = v3
	end)
end

Target:GetPropertyChangedSignal("Value"):Connect(updateText)
v17:OnSet({ "Tokens" }, function(p1, p2) --[[ Line: 195 | Upvalues: v18 (ref), Goal (copy), TweenService (copy), Target (copy), v1 (copy), showDeltaPopup (copy), TokensCounter (copy) ]]
	local v12 = tonumber(p1) or 0
	local v3 = v12 - (tonumber(p2) or v18)

	Goal.Value = v12
	TweenService:Create(Target, v1, {
		Value = Goal.Value
	}):Play()

	if v3 ~= 0 then
		showDeltaPopup(TokensCounter, v3, "")
	end

	v18 = v12
end)
Goal.Value = v18
Target.Value = v18

local v21 = math.round(Target.Value)
local v22 = v19 and NumberUtils.FormatWithCommas(v21) or NumberUtils.Abbreviate(v21)

TextLabel.Text = v22
TextLabel2.Text = v22