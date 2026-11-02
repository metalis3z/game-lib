-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return {
	["new"] = function()
		return setmetatable({}, {
			["__index"] = function(p1, p2)
				local v3 = rawget(p1, "TotalString")
				if not v3 then
					rawset(p1, "TotalString", p2)
					return p1
				end
				local v4 = ("%*/%*"):format(v3, p2)
				rawset(p1, "TotalString", v4)
				return p1
			end,
			["__tostring"] = function(p5)
				return rawget(p5, "TotalString")
			end
		})
	end
}
