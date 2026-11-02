--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(v1.Shared.EventTypes)
local v2 = {}
require(v1.Packages.Net)
local v3 = require(v1.Packages.Trove)
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Packages.CreateTween)
local v_u_6 = require(script.Parent.Parent)
local v_u_7 = script.Name
local v_u_8 = v3.new()
function v2.OnStart(_)
	-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_4, (copy) v_u_5
	local v9 = v_u_6:GetActiveEventData(v_u_7)
	assert(v9)
	v_u_8:Add(v_u_4.observeTag("SammyBaseStep", function(p10)
		-- upvalues: (ref) v_u_5
		local v11 = p10:GetAttribute("Index") or 0
		local v12 = p10.Position
		local v13 = p10.Position
		local v14 = -(v11 % 1 * 2 - 1) * 2
		p10.Position = v13 + Vector3.new(v14, 0, 0)
		v_u_5(p10, TweenInfo.new(0.5), {
			["Transparency"] = 0,
			["Position"] = v12
		})
		return nil
	end))
	v_u_8:Add(v_u_4.observeTag("HideInSammysBase", function(p_u_15)
		local v_u_16 = p_u_15.Parent
		p_u_15.Parent = script
		return function()
			-- upvalues: (copy) p_u_15, (copy) v_u_16
			pcall(function()
				-- upvalues: (ref) p_u_15, (ref) v_u_16
				p_u_15.Parent = v_u_16
			end)
		end
	end, { workspace, script }))
end
function v2.OnStop(_)
	-- upvalues: (copy) v_u_8
	v_u_8:Destroy()
end
function v2.OnLoad(_) end
return v2
