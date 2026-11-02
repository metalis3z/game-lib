-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return {
	Get = function(p1, p2) --[[ Get | Line: 16 | Upvalues: Asserts (copy) ]]
		Asserts.BasePart(p1)
		Asserts.string(p2)

		for i, v in ipairs(p1:GetChildren()) do
			if v:IsA("SurfaceGui") then
				local v1 = v:FindFirstChild(p2, true)

				if v1 ~= nil and v1:IsA("GuiButton") then
					return v1
				end
			end
		end

		return nil
	end
}