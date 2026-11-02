-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved soon!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-12-08 12:49:47
-- Luau version 6, Types version 3
-- Time taken: 0.001605 seconds

local tbl = {}
for i = 1, 4 do
	if script.Parent:FindFirstChild("Blood"..i) then
		tbl[i] = game:GetService("TweenService"):Create(script.Parent["Blood"..i], TweenInfo.new(2, Enum.EasingStyle.Exponential), {
			Position = ({Vector3.new(0, 0, 2.59999), Vector3.new(2.59999, 0, 0), Vector3.new(0, 0, -2.5999), Vector3.new(-2.5999, 0, 0)})[i];
		})
		tbl[i]:Play()
	end
end
script.Parent.Weld.C1 = CFrame.new(0, 0, 0)
script.Parent.Smear.Enabled = true
local var7_upvr = CFrame.new(0, 2, 2) * CFrame.Angles(1.3089969389957472, 0, 0)
game:GetService("RunService").Stepped:Connect(function(arg1, arg2) -- Line 22
	--[[ Upvalues[1]:
		[1]: var7_upvr (readonly)
	]]
	local Weld = script.Parent.Weld
	Weld.C1 *= CFrame.Angles(0, math.rad(700 * arg2), 0)
	script.Parent.Weld.C0 = script.Parent.Weld.C0:Lerp(var7_upvr, 0.1)
end)
if script.Parent:GetAttribute("Charge") < 4 then
	for i_2 = 4, script.Parent:GetAttribute("Charge") + 1, -1 do
		if script.Parent:FindFirstChild("Blood"..i_2) then
			script.Parent["Blood"..i_2]:Destroy()
		end
	end
end
script.Parent:GetAttributeChangedSignal("Charge"):Connect(function() -- Line 37
	script.Parent["Blood"..(script.Parent:GetAttribute("Charge") + 1)]:Destroy()
	if script.Parent:GetAttribute("Charge") == 0 then
		script.Parent.Smear.Enabled = false
	end
end)