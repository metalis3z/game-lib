-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local EmitDescendants = require(ReplicatedStorage.Library.Functions.EmitDescendants)
local Functions = require(ReplicatedStorage.Library.Functions)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local t = {
	{
		Duration = 0.22,
		Height = 2.6,
		ImpactScale = 0.92,
		PeakScale = 1.12,
		PitchDegrees = -6,
		RollDegrees = 5
	},
	{
		Duration = 0.18,
		Height = 1.65,
		ImpactScale = 0.96,
		PeakScale = 1.08,
		PitchDegrees = 4,
		RollDegrees = -3
	},
	{
		Duration = 0.15,
		Height = 0.9,
		ImpactScale = 0.985,
		PeakScale = 1.04,
		PitchDegrees = -2,
		RollDegrees = 1.5
	}
}
local t2 = {}

local function getEmitFuseContainer(p1, p2) --[[ getEmitFuseContainer | Line: 55 ]]
	local EmitFuse = p2:FindFirstChild("EmitFuse")

	if EmitFuse then
		return EmitFuse
	end

	return p1:FindFirstChild("EmitFuse")
end

function t2.Emit(p1, p2) --[[ Emit | Line: 65 | Upvalues: Asserts (copy), EmitDescendants (copy) ]]
	Asserts.Model(p1)
	Asserts.BasePart(p2)

	local EmitFuse = p2:FindFirstChild("EmitFuse")
	local v1 = EmitFuse or p1:FindFirstChild("EmitFuse")

	if v1 then
		EmitDescendants(v1)
	end
end
function t2.PlayBounce(p1, p2) --[[ PlayBounce | Line: 77 | Upvalues: Asserts (copy), t (copy), RenderStepped (copy), Functions (copy) ]]
	Asserts.Model(p1)
	Asserts.func(p2)

	local v1 = p1:GetPivot()
	local v2 = p1:GetScale()

	for i, v in ipairs(t) do
		local v3 = false

		RenderStepped(function(p12, p22) --[[ Line: 87 | Upvalues: p2 (copy), p1 (copy), v1 (copy), v2 (copy), v3 (ref), Functions (ref), v (copy) ]]
			if not p2() then
				p1:PivotTo(v1)
				p1:ScaleTo(v2)
				v3 = true

				return true
			end

			local v12, v22, v32, v4

			if p22 < 0.34 then
				local v5 = Functions.Easing(math.min(p22 / 0.34, 1), Enum.EasingStyle.Back, Enum.EasingDirection.Out)

				v12 = v.Height * v5
				v22 = v2 + (v.PeakScale - v2) * v5
				v32 = v.PitchDegrees * v5
				v4 = v.RollDegrees * v5
			else
				local v6 = 1 - Functions.Easing(math.max(p22 - 0.34, 0) / 0.66, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)

				v12 = v.Height * v6
				v32 = v.PitchDegrees * v6
				v4 = v.RollDegrees * v6

				local v7 = math.max(p22 - 0.34, 0) / 0.66

				v22 = if v7 < 0.55 then v.PeakScale + (v.ImpactScale - v.PeakScale) * Functions.Easing(v7 / 0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In) else v.ImpactScale + (v2 - v.ImpactScale) * Functions.Easing((v7 - 0.55) / 0.45, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
			end

			p1:ScaleTo(v22)
			p1:PivotTo(v1 * CFrame.new(0, v12, 0) * CFrame.Angles(math.rad(v32), 0, (math.rad(v4))))

			return false
		end, v.Duration, true):Wait()
		p1:ScaleTo(v2)
		p1:PivotTo(v1)

		if v3 then
			return false
		end
	end

	return true
end
function t2.Play(p1, p2, p3) --[[ Play | Line: 151 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.Model(p1)
	Asserts.BasePart(p2)
	Asserts.func(p3)

	if t2.PlayBounce(p1, p3) then
		t2.Emit(p1, p2)

		return true
	end

	return false
end

return t2