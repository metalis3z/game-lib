-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = script.Blur:Clone()
function v1.Activate(p3)
	-- upvalues: (copy) v_u_2
	v_u_2.Size = 100
	game:GetService("TweenService"):Create(v_u_2, TweenInfo.new(0.5), {
		["Size"] = p3 * 5
	}):Play()
	v_u_2.Parent = game:GetService("Lighting")
end
function v1.Clear(_)
	-- upvalues: (copy) v_u_2
	game:GetService("TweenService"):Create(v_u_2, TweenInfo.new(0.5), {
		["Size"] = 0
	}):Play()
	task.delay(0.5, function()
		-- upvalues: (ref) v_u_2
		v_u_2.Parent = nil
	end)
end
return v1