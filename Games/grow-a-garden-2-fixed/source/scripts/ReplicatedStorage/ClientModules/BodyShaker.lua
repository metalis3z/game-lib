--credit to leon games studio
local t = {}
local LocalPlayer = game.Players.LocalPlayer
local t2 = {}

local function ShakeBody(p1) --[[ ShakeBody | Line: 8 | Upvalues: t2 (copy) ]]
	repeat
		task.wait()
	until p1:IsDescendantOf(workspace)

	if p1:GetAttribute("Shaking") then
		return
	end

	p1:SetAttribute("Shaking", true)

	local Torso = p1:WaitForChild("Torso")
	local Neck = Torso:WaitForChild("Neck")
	local v1 = Torso:WaitForChild("Left Shoulder")
	local v2 = Torso:WaitForChild("Right Shoulder")
	local v3 = Torso:WaitForChild("Left Hip")
	local v4 = Torso:WaitForChild("Right Hip")
	local C0 = v1.C0
	local C02 = v2.C0
	local C03 = v3.C0
	local C04 = v4.C0
	local C05 = Neck.C0
	local count = 0

	while p1:IsDescendantOf(workspace) and t2[p1] do
		task.wait(0)
		count = count + 1

		local Angles = CFrame.Angles

		v1.C0 = C0 * Angles(0, math.rad(math.sin(count) * 4), 0)

		local Angles2 = CFrame.Angles

		v2.C0 = C02 * Angles2(0, math.rad(math.sin(count) * -4), 0)

		local Angles3 = CFrame.Angles

		v4.C0 = C04 * Angles3(0, math.rad(math.sin(count) * -4), 0)

		local Angles4 = CFrame.Angles

		v3.C0 = C03 * Angles4(0, math.rad(math.sin(count) * 4), 0)

		local Angles5 = CFrame.Angles

		Neck.C0 = C05 * Angles5(0, 0, (math.rad(math.sin(count) * 4)))
	end

	v1.C0 = C0
	v2.C0 = C02
	v3.C0 = C03
	v4.C0 = C04
	Neck.C0 = C05
	p1:SetAttribute("Shaking", false)
end

function t.EnableShaking(p1) --[[ EnableShaking | Line: 62 | Upvalues: ShakeBody (copy), t2 (copy) ]]
	if p1 then
		task.spawn(function() --[[ Line: 64 | Upvalues: ShakeBody (ref), p1 (copy) ]]
			ShakeBody(p1)
		end)
	end

	t2[p1] = true
end
function t.DisableShaking(p1) --[[ DisableShaking | Line: 72 | Upvalues: t2 (copy) ]]
	t2[p1] = false
end

return t