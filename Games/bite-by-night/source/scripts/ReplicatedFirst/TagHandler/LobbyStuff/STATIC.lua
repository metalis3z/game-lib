-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = Random.new()
function v1.OnInit(p3, _)
	p3:SetAttribute("last", tick())
end
function v1.OnFrame(p4, _)
	-- upvalues: (copy) v_u_2
	if tick() - p4:GetAttribute("last") >= 0.01 then
		p4.ImageRectOffset = Vector2.new(v_u_2:NextInteger(0, 50), v_u_2:NextInteger(0, 200))
	end
end
return v1