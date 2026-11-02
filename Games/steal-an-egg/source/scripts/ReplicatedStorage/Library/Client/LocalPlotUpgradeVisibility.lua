-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)

return {
	Refresh = function(p1, p2) --[[ Refresh | Line: 17 | Upvalues: Asserts (copy), PlotCmds (copy) ]]
		Asserts.string(p1)
		Asserts.optional.boolean(p2)

		local v1 = PlotCmds.GetPlotsFolder()
		local v2 = PlotCmds.GetMySlot()

		if v1 == nil then
			return
		end

		for i, v in ipairs(v1:GetDescendants()) do
			if v.Name == p1 and v.Parent ~= nil then
				local v3 = if v2 == nil or v.Parent.Name ~= tostring(v2) then false elseif p2 == false then false else true

				for i2, v4 in ipairs(v:GetDescendants()) do
					if v4:IsA("BasePart") then
						v4.LocalTransparencyModifier = if v3 then 0 else 1

						continue
					end

					if v4:IsA("SurfaceGui") then
						v4.Enabled = v3

						continue
					end

					if v4:IsA("BillboardGui") then
						if v3 then
							if v4.Name ~= "CanUpgrade" then
								v4.Enabled = true
							end

							continue
						end

						v4.Enabled = false
					end
				end
			end
		end
	end
}