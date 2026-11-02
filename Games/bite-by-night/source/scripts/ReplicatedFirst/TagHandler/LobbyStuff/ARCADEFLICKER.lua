-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = Random.new()
function v1.OnInit(p3)
	-- upvalues: (copy) v_u_2
	script.Sound:Clone().Parent = p3
	p3:SetAttribute("Last", tick())
	p3:SetAttribute("Delay", v_u_2:NextInteger(10, 30))
end
function v1.OnFrame(p_u_4, _)
	-- upvalues: (copy) v_u_2
	if tick() - p_u_4:GetAttribute("Last") >= p_u_4:GetAttribute("Delay") then
		p_u_4:SetAttribute("Last", tick())
		p_u_4:SetAttribute("Delay", v_u_2:NextInteger(10, 30))
		p_u_4.Sound:Play()
		local v_u_5 = p_u_4.Color
		p_u_4.Color = Color3.new()
		local v6 = v_u_2:NextInteger(1, 6)
		task.delay(v6 / 10, function()
			-- upvalues: (copy) p_u_4, (copy) v_u_5
			p_u_4.Color = v_u_5
		end)
	end
end
return v1