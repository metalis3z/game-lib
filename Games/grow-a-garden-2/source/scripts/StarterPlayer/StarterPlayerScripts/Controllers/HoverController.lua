--credit to leon games studio
local t = {
	StartOrder = 1
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local t2 = {}
local v2 = false
local v3 = false
local v4 = nil
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local t3 = {}

local function CancelActiveTweens() --[[ CancelActiveTweens | Line: 20 | Upvalues: t3 (copy) ]]
	for v1, v2 in t3 do
		v2:Cancel()
	end

	table.clear(t3)
end

local function TweenTransparency(p1, p2) --[[ TweenTransparency | Line: 27 | Upvalues: t3 (copy), TweenService (copy), v5 (copy) ]]
	for v1, v2 in t3 do
		v2:Cancel()
	end

	table.clear(t3)

	local v3 = TweenService:Create(p1, v5, {
		TextTransparency = p2
	})

	v3:Play()
	table.insert(t3, v3)

	local UIStroke = p1:FindFirstChildOfClass("UIStroke")

	if not UIStroke then
		return
	end

	local v52 = TweenService:Create(UIStroke, v5, {
		Transparency = p2
	})

	v52:Play()
	table.insert(t3, v52)
end

local function SetupUI(p1, p2) --[[ SetupUI | Line: 42 | Upvalues: t2 (copy), v2 (ref), v4 (ref) ]]
	if not t2[p1] then
		t2[p1] = p2
		p1:GetAttributeChangedSignal("HoverDescription"):Connect(function() --[[ Line: 47 | Upvalues: t2 (ref), p1 (copy), v2 (ref), v4 (ref) ]]
			t2[p1] = p1:GetAttribute("HoverDescription")

			if not v2 or v4 ~= p1 then
				return
			end

			v4 = p1
		end)
		p1.MouseEnter:Connect(function() --[[ Line: 54 | Upvalues: v4 (ref), p1 (copy), v2 (ref) ]]
			v4 = p1
			v2 = true
		end)
		p1.MouseLeave:Connect(function() --[[ Line: 59 | Upvalues: v4 (ref), p1 (copy), v2 (ref) ]]
			if v4 ~= p1 then
				return
			end

			v2 = false
		end)
		p1.Destroying:Connect(function() --[[ Line: 65 | Upvalues: t2 (ref), p1 (copy), v4 (ref), v2 (ref) ]]
			t2[p1] = nil

			if v4 ~= p1 then
				return
			end

			v2 = false
			v4 = nil
		end)
	end
end

function t.Start(p1) --[[ Start | Line: 74 | Upvalues: LocalPlayer (copy), SetupUI (copy), RunService (copy), v2 (ref), v4 (ref), t2 (copy), v1 (copy), v3 (ref), TweenTransparency (copy) ]]
	local HoverUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HoverUI")

	for v12, v22 in LocalPlayer.PlayerGui:GetDescendants() do
		if v22:GetAttribute("HoverDescription") then
			SetupUI(v22, v22:GetAttribute("HoverDescription"))
		end
	end

	LocalPlayer.PlayerGui.DescendantAdded:Connect(function(p1) --[[ Line: 83 | Upvalues: SetupUI (ref) ]]
		if not p1:GetAttribute("HoverDescription") then
			return
		end

		SetupUI(p1, p1:GetAttribute("HoverDescription"))
	end)

	local v32 = script.Time:Clone()
	local TXT = v32.TXT

	v32.Parent = HoverUI
	RunService.Heartbeat:Connect(function() --[[ Line: 93 | Upvalues: v2 (ref), v4 (ref), t2 (ref), TXT (copy), v32 (copy), v1 (ref), v3 (ref), TweenTransparency (ref) ]]
		if v2 and v4 then
			local v12 = t2[v4] or ""

			TXT.Text = v12
			v32.Text = v12
			v32.Position = UDim2.new(0, v1.X - v32.AbsoluteSize.X / 2, 0, v1.Y)

			if not v3 then
				TweenTransparency(TXT, 0)
				v3 = true
			end
		else
			if not v3 then
				return
			end

			TweenTransparency(TXT, 1)
			v3 = false
		end
	end)
end

return t