-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: create, time of decompilation: Sun May  3 10:09:39 2026 ]]
local v1 = game and typeof or require("../test/mock").typeof
local v2 = game and Instance or require("../test/mock").Instance
local defaults = require("./defaults")
local apply = require("./apply")
local flags = require("./flags")
local t1 = {}

setmetatable(t1, {
	__index = function(_, s1: string) --[[ lazy_init ]] -- line: 9
		-- upvalues: v2 (copy), flags (copy), defaults (copy), apply (copy), t1 (copy)
		local function ctor(t2: {[any]: any}) -- line: 10
			-- upvalues: v2 (copy), s1 (copy), flags (copy), defaults (copy), apply (copy)
			local ok, result = pcall(v2.new, s1)

			if not ok then
				error(`invalid class name { s1 }`, 0)
			end

			if flags.defaults then
				local v16 = defaults[s1]

				if v16 then
					for v17, v18 in v16 do
						result[v17] = v18
					end
				end
			end

			return apply(result, t2)
		end

		t1[s1] = ctor

		return ctor
	end
})

return function(p2, t3: {[any]: any}?) --[[ create ]] -- line: 32
	-- upvalues: v1 (copy), t1 (copy), apply (copy)
	if type(p2) ~= "string" and v1(p2) ~= "Instance" then
		error("bad argument #1, expected string or instance, got " .. v1(p2), 0)
	end

	local v12 = type(p2) ~= "string" and function(p3) -- line: 39
		-- upvalues: p2 (copy), apply (copy)
		local clone = p2:Clone()

		if not clone then
			error("attempt to clone a non-archivable instance")
		end

		return apply(clone, p3)
	end or t1[p2]

	if t3 then
		return (v12(t3))
	end

	return v12
end
