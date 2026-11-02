-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(v1.Modules.Network)
local v_u_4 = require(v1.Modules.Projectiles)
local v_u_5 = require(script.CallbackDefinitions)
local v_u_6 = require(v1.Modules.Util)
local v_u_7 = {}
v_u_7.__index = v_u_7
local v_u_8 = {
	["Projectiles"] = {}
}
function v_u_7.__callback(p9, p10, p11)
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	local v12 = p11 or {}
	if p9.Callbacks[p10] then
		for v13, v14 in pairs(p9.Callbacks[p10]) do
			local v15 = v_u_5[v13]
			if v15 then
				local v16 = v_u_6:MergeTables(v14, v12)
				local v17, v18 = pcall(v15, p9, v16)
				if not v17 then
					warn((("[ProjectileInterp]: Projectile ID %* failed %*!\n %*"):format(p9.UUID, v13, v18)))
				end
			else
				warn((("[ProjectileInterp]: No callback for %*!"):format(v13)))
			end
		end
	end
end
function v_u_7.__destroy(p19)
	-- upvalues: (copy) v_u_8
	p19.Running = false
	if p19.Heartbeat then
		p19.Heartbeat:Disconnect()
	end
	if p19.Model then
		p19.Model:Destroy()
	end
	v_u_8.Projectiles[p19.UUID] = nil
	table.clear(p19)
end
function v_u_8.Start(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_4
	v_u_3:SetConnection("CreateProjectile", "REMOTE_EVENT", function(p_u_20, p21)
		-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_2, (ref) v_u_4
		local v_u_22 = tick()
		local v_u_23 = workspace:GetServerTimeNow() - p21
		local v24 = v_u_7
		setmetatable(p_u_20, v24)
		v_u_8.Projectiles[p_u_20.UUID] = p_u_20
		p_u_20.Running = true
		p_u_20.Model:PivotTo(p_u_20.InitialCFrame)
		for _, v25 in ipairs(p_u_20.Model:GetDescendants()) do
			if v25:IsA("BasePart") then
				v25.CanCollide = false
				v25.CanQuery = false
				v25.CanTouch = false
			end
		end
		local v26 = p_u_20.Model
		if v26:IsA("BasePart") then
			v26.CanCollide = false
			v26.CanQuery = false
			v26.CanTouch = false
		end
		p_u_20.Heartbeat = v_u_2.Heartbeat:Connect(function(p27)
			-- upvalues: (copy) p_u_20, (copy) v_u_22, (copy) v_u_23, (ref) v_u_4
			if p_u_20.Model and p_u_20.Model.Parent then
				if p_u_20.Running then
					local v28 = tick() - v_u_22 + v_u_23
					local v29 = v_u_4.getPos(v28, p_u_20.InitialCFrame.Position, p_u_20.InitialVelocity, p_u_20.Gravity)
					local v30, v31, v32 = p_u_20.Model:GetPivot():ToEulerAnglesXYZ()
					p_u_20.Model:PivotTo(CFrame.new(v29) * CFrame.Angles(v30, v31, v32))
					p_u_20:__callback("OnHeartbeat", {
						["delta"] = p27
					})
				end
			else
				p_u_20:__destroy()
				return
			end
		end)
		p_u_20:__callback("Started")
	end)
	v_u_3:SetConnection("DestroyProjectile", "REMOTE_EVENT", function(p33)
		-- upvalues: (ref) v_u_8
		local v34 = v_u_8.Projectiles[p33]
		if v34 then
			v34.Running = false
			v34:__callback("Ended")
			v34:__destroy()
		end
	end)
	v_u_3:SetConnection("ProjectileEvent", "REMOTE_EVENT", function(p35, p36, p37)
		-- upvalues: (ref) v_u_8
		local v38 = v_u_8.Projectiles[p35]
		if v38 then
			v38:__callback(p36, p37)
		end
	end)
end
return v_u_8
