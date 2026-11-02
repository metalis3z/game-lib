-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	InitializeTool = function(p1) --[[ InitializeTool | Line: 18 | Upvalues: Asserts (copy) ]]
		Asserts.Tool(p1)

		if typeof((p1:GetAttribute("CooldownEndTime"))) ~= "number" then
			p1:SetAttribute("CooldownEndTime", 0)
		end

		if typeof((p1:GetAttribute("CooldownDuration"))) ~= "number" then
			p1:SetAttribute("CooldownDuration", 0)
		end

		if typeof((p1:GetAttribute("CooldownActive"))) == "boolean" then
			return
		end

		p1:SetAttribute("CooldownActive", false)
	end,
	StartCooldown = function(p1, p2) --[[ StartCooldown | Line: 37 | Upvalues: Asserts (copy) ]]
		Asserts.Tool(p1)
		Asserts.finite(p2)
		Asserts.cond(p2 >= 0)

		local v2 = workspace:GetServerTimeNow() + p2

		p1:SetAttribute("CooldownDuration", p2)
		p1:SetAttribute("CooldownEndTime", v2)
		p1:SetAttribute("CooldownActive", true)
		task.delay(p2, function() --[[ Line: 49 | Upvalues: p1 (copy), v2 (copy) ]]
			if not p1 or (not p1.Parent or p1:GetAttribute("CooldownEndTime") ~= v2) then
				return
			end

			p1:SetAttribute("CooldownActive", false)
			p1:SetAttribute("CooldownDuration", 0)
			p1:SetAttribute("CooldownEndTime", 0)
		end)
	end,
	IsOnCooldown = function(p1) --[[ IsOnCooldown | Line: 58 | Upvalues: Asserts (copy) ]]
		Asserts.Tool(p1)

		if not p1:GetAttribute("CooldownActive") then
			return false
		end

		local v1 = p1:GetAttribute("CooldownEndTime")

		if not v1 or type(v1) ~= "number" then
			return false
		end

		return workspace:GetServerTimeNow() < v1
	end
}

function t.GetRemainingCooldown(p1) --[[ GetRemainingCooldown | Line: 74 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Tool(p1)

	if not t.IsOnCooldown(p1) then
		return 0
	end

	local v1 = p1:GetAttribute("CooldownEndTime")

	if v1 and type(v1) == "number" then
		return math.max(0, v1 - workspace:GetServerTimeNow())
	end

	return 0
end
function t.ClearCooldown(p1) --[[ ClearCooldown | Line: 89 | Upvalues: Asserts (copy) ]]
	Asserts.Tool(p1)
	p1:SetAttribute("CooldownActive", false)
	p1:SetAttribute("CooldownDuration", 0)
	p1:SetAttribute("CooldownEndTime", 0)
end

return t