-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v4 = {
	["Name"] = "math",
	["Aliases"] = {},
	["Description"] = "Perform a math operation on 2 values.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = {
		"alias \"+|Perform an addition.\" math + $1{number|Number} $2{number|Number}",
		"alias \"-|Perform a subtraction.\" math - $1{number|Number} $2{number|Number}",
		"alias \"*|Perform a multiplication.\" math * $1{number|Number} $2{number|Number}",
		"alias \"/|Perform a division.\" math / $1{number|Number} $2{number|Number}",
		"alias \"**|Perform an exponentiation.\" math ** $1{number|Number} $2{number|Number}",
		"alias \"%|Perform a modulus.\" math % $1{number|Number} $2{number|Number}"
	},
	["Args"] = {
		{
			["Type"] = "mathOperator",
			["Name"] = "Operation",
			["Description"] = "A math operation."
		},
		{
			["Type"] = "number",
			["Name"] = "Value",
			["Description"] = "A number value."
		},
		{
			["Type"] = "number",
			["Name"] = "Value",
			["Description"] = "A number value."
		}
	},
	["ClientRun"] = function(_, p1, p2, p3)
		return p1.Perform(p2, p3)
	end
}
return v4
