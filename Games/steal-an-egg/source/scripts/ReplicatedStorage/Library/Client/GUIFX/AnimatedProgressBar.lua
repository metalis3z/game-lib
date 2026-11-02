-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2) --[[ Line: 6 | Upvalues: Asserts (copy), RunService (copy) ]]
	Asserts.GuiObject(p1)
	Asserts.optional.number(p2)

	local Size = p1.Size
	local v1 = 0

	p1:GetAttributeChangedSignal("TargetFill"):Connect(function() --[[ Line: 13 | Upvalues: v1 (ref), p1 (copy), Asserts (ref), Size (copy) ]]
		v1 = p1:GetAttribute("TargetFill")
		Asserts.number(v1)

		if not (v1 < p1.Size.X.Scale) then
			return
		end

		p1.Size = UDim2.new(v1, Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
	end)

	local v2 = p2 or 10
	local v3 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 23 | Upvalues: p1 (copy), v1 (ref), v2 (copy), Size (copy) ]]
		local Scale = p1.Size.X.Scale

		if not (math.abs(Scale - v1) >= 0.01) then
			return
		end

		p1.Size = UDim2.new(Scale + (v1 - Scale) * (1 - math.exp(-v2 * p12)), Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
	end)

	return function() --[[ Line: 35 | Upvalues: v3 (copy) ]]
		v3:Disconnect()
	end
end