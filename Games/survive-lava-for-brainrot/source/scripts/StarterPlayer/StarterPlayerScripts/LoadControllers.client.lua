-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = script.Parent:WaitForChild("Controllers")
function LoadModules(p2)
	for _, v_u_3 in p2:GetChildren() do
		task.spawn(function()
			-- upvalues: (copy) v_u_3
			local v4 = require(v_u_3)
			if typeof(v4) == "table" and v4.Init then
				v4:Init()
			end
		end)
	end
end
LoadModules(v1)
