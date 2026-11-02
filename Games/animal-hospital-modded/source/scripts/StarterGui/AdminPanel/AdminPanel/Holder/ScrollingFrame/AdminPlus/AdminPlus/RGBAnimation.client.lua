-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local v1 = script.Parent
local UIStroke = v1:FindFirstChild("UIStroke")

if UIStroke then
	UIStroke.Color = Color3.new(0/255, 0/255, 0/255)
end

local RainbowGradient = v1:FindFirstChild("RainbowGradient")

if not RainbowGradient then
	RainbowGradient = Instance.new("UIGradient")
	RainbowGradient.Name = "RainbowGradient"
	RainbowGradient.Parent = v1
end

local AdminPanel = script:FindFirstAncestor("AdminPanel")
local v2 = 0
local v3 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 37 | Upvalues: AdminPanel (copy), v2 (ref), RainbowGradient (ref) ]]
	if AdminPanel and not AdminPanel.Visible then
		return
	end

	v2 = v2 + p1 / 3

	if v2 >= 1 then
		v2 = v2 - 1
	end

	RainbowGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromHSV((v2 + 0) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.17, Color3.fromHSV((v2 + 0.17) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.33, Color3.fromHSV((v2 + 0.33) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.5, Color3.fromHSV((v2 + 0.5) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.67, Color3.fromHSV((v2 + 0.67) % 1, 1, 1)),
		ColorSequenceKeypoint.new(0.83, Color3.fromHSV((v2 + 0.83) % 1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.fromHSV((v2 + 1) % 1, 1, 1))
	})
end)

script.AncestryChanged:Connect(function() --[[ Line: 65 | Upvalues: v3 (ref) ]]
	if script:IsDescendantOf(game) then
		return
	end

	v3:Disconnect()
end)