-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Rarities = require(game.ReplicatedStorage.Directory.Rarity).Rarities
local RunService = game:GetService("RunService")

function UpdateRarityUI(p1, p2, p3) --[[ UpdateRarityUI | Line: 4 | Upvalues: Rarities (copy), RunService (copy) ]]
	local v1 = Rarities[p3]

	assert(v1)

	local DisplayName = v1.DisplayName
	local v2 = if p3 == "Exclusive" then true else false

	if v2 then
		DisplayName = DisplayName .. "  \226\152\133"
	end

	p1.title.Text = DisplayName

	local UIGradient = p1.title:FindFirstChildOfClass("UIGradient")
	local UIStroke = p1.title:FindFirstChildOfClass("UIStroke")
	local v3 = if UIStroke then UIStroke:FindFirstChildOfClass("UIGradient") else UIStroke

	if UIGradient then
		UIGradient:Destroy()
	end

	if v3 then
		v3:Destroy()
	end

	local v4 = v1.Gradient:Clone()
	local v5 = v1.Gradient:Clone()

	v4.Parent = p1.title
	v5.Parent = UIStroke

	if not v2 then
		return
	end

	task.spawn(function() --[[ Line: 31 | Upvalues: p1 (copy), v4 (copy), v5 (copy), RunService (ref) ]]
		local v1 = tick()

		task.wait()

		while p1 and p1.Parent do
			local v2 = tick() - v1

			v4.Rotation = 100 + v2 * 100
			v5.Rotation = 100 - v2 * 100
			RunService.RenderStepped:Wait()
		end
	end)
end

return UpdateRarityUI