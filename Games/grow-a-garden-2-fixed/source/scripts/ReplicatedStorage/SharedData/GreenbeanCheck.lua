--credit to quartz games studio
local GreenbeanHumanoidDescription = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("GreenbeanHumanoidDescription")
local t = {
	IsGreenbeanDescription = function(p1) --[[ IsGreenbeanDescription | Line: 13 | Upvalues: GreenbeanHumanoidDescription (copy) ]]
		if not p1 then
			return false
		end

		local v1 = string.split(p1.HatAccessory, ",")

		for v2, v3 in string.split(GreenbeanHumanoidDescription.HatAccessory, ",") do
			if not table.find(v1, v3) then
				return false
			end
		end

		return p1.LeftArmColor == GreenbeanHumanoidDescription.LeftArmColor and (p1.LeftLegColor == GreenbeanHumanoidDescription.LeftLegColor and (p1.RightArmColor == GreenbeanHumanoidDescription.RightArmColor and (p1.RightLegColor == GreenbeanHumanoidDescription.RightLegColor and p1.TorsoColor == GreenbeanHumanoidDescription.TorsoColor)))
	end
}

function t.IsCharacterGreenbean(p1) --[[ IsCharacterGreenbean | Line: 39 | Upvalues: t (copy) ]]
	if not p1 then
		return false
	end

	if p1:GetAttribute("AppliedGreenbean") then
		return true
	end

	local Humanoid = p1:FindFirstChildOfClass("Humanoid")

	if Humanoid then
		return t.IsGreenbeanDescription(Humanoid:GetAppliedDescription())
	end

	return false
end

return t