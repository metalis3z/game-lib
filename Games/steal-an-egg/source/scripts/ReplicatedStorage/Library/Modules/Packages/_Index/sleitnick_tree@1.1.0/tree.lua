-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function FullNameToPath(p1) --[[ FullNameToPath | Line: 3 ]]
	return p1:GetFullName():gsub("%.", "/")
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t = {
	Find = function(p1, p2, p3) --[[ Find | Line: 35 ]]
		local v1 = p1

		for v2, v3 in p2:split("/") do
			if v3 == "" then
				error(("Invalid path: %*"):format(p2), 2)
			end

			local v4 = v1:FindFirstChild(v3)

			if v4 == nil then
				error(("Failed to find %* in %*"):format(p2, (p1:GetFullName():gsub("%.", "/"))), 2)
			end

			v1 = v4
		end

		if p3 and not v1:IsA(p3) then
			error(("Got class %*; expected to be of type %*"):format(v1.ClassName, p3), 2)
		end

		return v1
	end,
	Exists = function(p1, p2, p3) --[[ Exists | Line: 75 ]]
		local v1 = p1

		for v2, v3 in p2:split("/") do
			if v3 == "" then
				error(("Invalid path: %*"):format(p2), 2)
			end

			local v4 = v1:FindFirstChild(v3)

			if v4 == nil then
				return false
			end

			v1 = v4
		end

		return (not p3 or v1:IsA(p3)) and true or false
	end,
	Get = function(p1, p2, p3) --[[ Get | Line: 110 ]]
		local v1 = p1

		for i, v in ipairs(p2:split("/")) do
			if v == "" then
				error(("Invalid path: %*"):format(p2), 2)
			end

			local v2 = v1:FindFirstChild(v)

			if not v2 then
				return nil
			end

			v1 = v2
		end

		if p3 and not v1:IsA(p3) then
			return nil
		end

		return v1
	end,
	Await = function(p1, p2, p3, p4) --[[ Await | Line: 149 ]]
		local v1 = p1

		for v2, v3 in p2:split("/") do
			if v3 == "" then
				error(("Invalid path: %*"):format(p2), 2)
			end

			local v4 = v1:WaitForChild(v3, p3)

			if v4 == nil then
				error(("Failed to await %* in %* (timeout reached)"):format(p2, (p1:GetFullName():gsub("%.", "/"))), 2)
			end

			v1 = v4
		end

		if p4 and not v1:IsA(p4) then
			error(("Got class %*; expected to be of type %*"):format(v1.ClassName, p4), 2)
		end

		return v1
	end
}

function t.AwaitWithDefaultTimeout(p1, p2, p3, p4) --[[ AwaitWithDefaultTimeout | Line: 178 | Upvalues: t (copy), Constants (copy) ]]
	return t.Await(p1, p2, if p3 then p3 else Constants.STUDIO_YIELD_TIMEOUT, p4)
end

return t