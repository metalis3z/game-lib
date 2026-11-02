-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Library.Modules.Packages.Promise)
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2, p3, p4) --[[ Line: 14 | Upvalues: Asserts (copy), Promise (copy) ]]
	Asserts.func(p1)
	Asserts.optional.number(p2)
	Asserts.optional.number(p3)
	Asserts.optional.number(p4)
	assert(if p3 == nil == (if p4 == nil then true else false) then true else false, "Retry delay minimum and maximum must be provided together")

	local v4 = p2 or 5
	local v5 = Random.new()

	return Promise.new(function(p12, p2) --[[ Line: 32 | Upvalues: v4 (copy), p3 (copy), p4 (copy), v5 (copy), p1 (copy) ]]
		local v1 = nil

		for i = 1, v4 do
			if i > 1 and (p3 ~= nil and p4 ~= nil) then
				local v2 = 2 ^ (i - 2)

				task.wait((v5:NextNumber(p3 * v2, p4 * v2)))
			end

			local v42 = table.pack(pcall(p1))

			if v42[1] == true then
				return p12(table.unpack(v42, 2))
			end

			if i > 1 and p3 == nil then
				task.wait(2 ^ (i - 1))
			end

			v1 = v42[2]
		end

		return p2((("Too many retries. Last error: %*"):format(v1)))
	end)
end