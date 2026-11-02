-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local GetHolder = require(script.Parent.GetHolder)
local Pulse = ReplicatedStorage.Assets.UI.OTHER.Shockwave.Pulse

return function(p1, p2, p3, p4) --[[ Line: 21 | Upvalues: Pulse (copy), GetHolder (copy), Tween (copy), RunService (copy) ]]
	local v1 = Pulse:Clone()
	local v2 = p2 or 1
	local v3 = p3 or 0
	local v4 = 15 * (p4 or 1)

	v1.UIScale.Scale = 0
	v1.Size = UDim2.fromOffset(p1.AbsoluteSize.X, p1.AbsoluteSize.Y)
	v1.Position = UDim2.new(0, p1.AbsolutePosition.X + p1.AbsoluteSize.X / 2, 0, p1.AbsolutePosition.Y + p1.AbsoluteSize.Y / 2)
	v1.Parent = GetHolder()
	task.spawn(function() --[[ Line: 43 | Upvalues: v1 (copy), v3 (copy), Tween (ref), v2 (copy), v4 (copy) ]]
		v1.ImageTransparency = v3
		Tween(v1, {
			ImageTransparency = 1
		}, { v2, "Sine", "Out" })
		Tween(v1.UIScale, {
			Scale = v4
		}, { v2, "Sine", "Out" }).Completed:Wait()
		v1:Destroy()
	end)
	task.spawn(function() --[[ Line: 62 | Upvalues: v1 (copy), p1 (copy), RunService (ref) ]]
		while v1.Parent do
			v1.Position = UDim2.new(0, p1.AbsolutePosition.X + p1.AbsoluteSize.X / 2, 0, p1.AbsolutePosition.Y + p1.AbsoluteSize.Y / 2)
			RunService.RenderStepped:Wait()
		end
	end)

	return v1
end