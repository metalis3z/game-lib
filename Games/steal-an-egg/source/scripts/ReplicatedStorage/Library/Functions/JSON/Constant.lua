-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	ESC_MAP = {
		["\\"] = "\\",
		["\""] = "\\\"",
		["/"] = "\\/",
		["\8"] = "\\b",
		["\f"] = "\\f",
		["\n"] = "\\n",
		["\r"] = "\\r",
		["\t"] = "\\t",
		["\7"] = "\\u0007",
		["\11"] = "\\u000b"
	},
	UN_ESC_MAP = {
		b = "\8",
		f = "\f",
		n = "\n",
		r = "\r",
		t = "\t",
		u0007 = "\7",
		u000b = "\11"
	},
	NULL = setmetatable({}, {
		__tostring = function() --[[ Line: 24 ]]
			return "null"
		end
	})
}