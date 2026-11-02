-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return function(p1)
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			["Name"] = "+",
			["Perform"] = function(p2, p3)
				return p2 + p3
			end
		},
		{
			["Name"] = "-",
			["Perform"] = function(p4, p5)
				return p4 - p5
			end
		},
		{
			["Name"] = "*",
			["Perform"] = function(p6, p7)
				return p6 * p7
			end
		},
		{
			["Name"] = "/",
			["Perform"] = function(p8, p9)
				return p8 / p9
			end
		},
		{
			["Name"] = "**",
			["Perform"] = function(p10, p11)
				return p10 ^ p11
			end
		},
		{
			["Name"] = "%",
			["Perform"] = function(p12, p13)
				return p12 % p13
			end
		}
	}))
end
