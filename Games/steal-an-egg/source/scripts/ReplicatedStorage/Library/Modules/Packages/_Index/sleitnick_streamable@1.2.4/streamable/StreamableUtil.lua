-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Trove = require(script.Parent.Parent.Trove)

require(script.Parent.Streamable)

return {
	Compound = function(p1, p2) --[[ Compound | Line: 47 | Upvalues: Trove (copy) ]]
		local v1 = Trove.new()
		local v2 = Trove.new()
		local v3 = false

		local function Check() --[[ Check | Line: 51 | Upvalues: v3 (ref), p1 (copy), p2 (copy), v2 (copy) ]]
			if v3 then
				return
			end

			for k, v in pairs(p1) do
				if not v.Instance then
					return
				end
			end

			v3 = true
			p2(p1, v2)
		end

		local function Cleanup() --[[ Cleanup | Line: 63 | Upvalues: v3 (ref), v2 (copy) ]]
			if v3 then
				v3 = false
				v2:Clean()
			end
		end

		for k, v in pairs(p1) do
			v1:Add(v:Observe(function(p12, p22) --[[ Line: 71 | Upvalues: v3 (ref), p1 (copy), p2 (copy), v2 (copy), Cleanup (copy) ]]
				if not v3 then
					for k, v in pairs(p1) do
						if not v.Instance then
							p22:Add(Cleanup)

							return
						end
					end

					v3 = true
					p2(p1, v2)
				end

				p22:Add(Cleanup)
			end))
		end

		v1:Add(Cleanup)

		return v1
	end
}