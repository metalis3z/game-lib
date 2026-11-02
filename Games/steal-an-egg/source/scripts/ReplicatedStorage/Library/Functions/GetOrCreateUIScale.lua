-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 10 | Upvalues: Asserts (copy) ]]
	Asserts.GuiObject(p1)

	local v1 = p1:FindFirstChildWhichIsA("UIScale")

	if v1 then
		return v1
	end

	local UIScale = Instance.new("UIScale")

	UIScale.Parent = p1

	return UIScale
end