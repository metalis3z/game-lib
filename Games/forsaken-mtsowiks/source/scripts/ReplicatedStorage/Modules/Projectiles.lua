-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("RunService")
local v4 = v1.Modules
local v_u_5 = require(v4:WaitForChild("Actors"))
local v_u_6 = require(v4:WaitForChild("Hitboxes"))
local v_u_7 = require(v4:WaitForChild("Network"))
local v_u_8 = require(v4:WaitForChild("Util"))
local v_u_9 = {
	["Lifetime"] = 10,
	["Gravity"] = 0,
	["CastRadius"] = 0,
	["Callbacks"] = {}
}
v_u_9.__index = v_u_9
local function v_u_10(...)
	warn((("[Projectiles]: %*"):format((...))))
end
function v_u_9.getPos(p11, p12, p13, p14)
	local v15 = p11 ^ 2
	local v16 = p13 * p11
	return 0.5 * vector.create(0, p14, 0) * v15 + v16 + p12
end
function v_u_9.new(p17)
	-- upvalues: (copy) v_u_3, (copy) v_u_9, (copy) v_u_2, (copy) v_u_10
	local v18 = v_u_3:IsServer()
	assert(v18, "Do not create projectiles on the client.")
	local v19 = v_u_9
	local v20 = setmetatable(p17, v19)
	v20.PreviousCFrame = v20.InitialCFrame
	v20.State = "Idle"
	v20.UUID = v_u_2:GenerateGUID(false)
	v_u_10((("Created projectile %*"):format(v20.UUID)))
	return v20
end
function v_u_9.Launch(p_u_21)
	-- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_3, (copy) v_u_9, (copy) v_u_7
	v_u_10((("Launching projectile %*"):format(p_u_21.UUID)))
	p_u_21.HitboxConfig.CFrame = p_u_21.HitboxConfig.CFrame or function()
		-- upvalues: (copy) p_u_21
		return p_u_21.PreviousCFrame
	end
	p_u_21.HitboxConfig.Time = p_u_21.HitboxConfig.Time or p_u_21.Lifetime
	p_u_21.HitboxConfig.ExecuteOnKill = false
	local v_u_22 = p_u_21.HitboxConfig.Connections
	if v_u_22 then
		v_u_22 = p_u_21.HitboxConfig.Connections.Hit
	end
	if p_u_21.Callbacks.HitHuman then
		p_u_21.HitboxConfig.Connections = p_u_21.HitboxConfig.Connections or {}
		function p_u_21.HitboxConfig.Connections.Hit(...)
			-- upvalues: (copy) v_u_22, (copy) p_u_21
			if v_u_22 then
				v_u_22(...)
			end
			p_u_21:__callback("HitHuman", ...)
			p_u_21:__clientCallback("HitHuman", {
				["character"] = table.pack(...)[1]
			})
		end
	end
	p_u_21.ActiveHitbox = v_u_6:CreateHitbox(p_u_21.Owner, p_u_21.HitboxConfig)
	p_u_21.State = "Running"
	p_u_21.InitialTick = tick()
	p_u_21.Model.Parent = workspace.Map.Ingame
	p_u_21.Heartbeat = v_u_3.Stepped:Connect(function(_)
		-- upvalues: (copy) p_u_21, (ref) v_u_9, (ref) v_u_10
		if not p_u_21 or (not p_u_21.State or (p_u_21.State ~= "Running" or not (p_u_21.ActiveHitbox and (p_u_21.Owner and p_u_21.Owner.Parent)))) then
			p_u_21:Destroy()
			return
		end
		p_u_21:__callback("OnHeartbeat")
		local v23 = p_u_21.InitialCFrame.Position
		local v24 = tick() - p_u_21.InitialTick
		if p_u_21.Lifetime < v24 then
			p_u_21:Destroy()
			return
		end
		local v25 = v_u_9.getPos(v24, v23, p_u_21.InitialVelocity, p_u_21.Gravity)
		local v26, v27, v28 = p_u_21.PreviousCFrame:ToEulerAnglesXYZ()
		local v29 = CFrame.new(v25) * CFrame.Angles(v26, v27, v28)
		if p_u_21.Callbacks.HitOther then
			if not p_u_21.CastParams then
				v_u_10((("Projectile ID %* has no CastParams, but needs to raycast."):format(p_u_21.UUID)))
				--goto l11
				if p_u_21 and (p_u_21.State and p_u_21.State == "Running") then
					p_u_21.PreviousCFrame = v29
				end
			end
			local v30 = p_u_21.CastParams
			local v31 = p_u_21.PreviousCFrame.Position
			local v32 = v29.Position - v31
			while true do
				task.wait()
				local v33
				if p_u_21.CastRadius > 0 then
					v33 = workspace:Spherecast(v31, p_u_21.CastRadius, v32, v30)
				else
					v33 = workspace:Raycast(v31, v32, v30)
				end
				local v34 = true
				local v35, v36
				if v33 then
					v35, v36 = p_u_21:__callback("Validate", v33)
				else
					v35 = nil
					v36 = nil
				end
				local v37
				if v33 then
					v37 = v33.Instance.Parent:FindFirstChild("Humanoid")
				else
					v37 = v33
				end
				if v37 or v33 and (v35 and not v36) then
					v30:AddToFilter(v33.Instance)
					v34 = false
				end
				if v34 then
					if v33 then
						p_u_21:__callback("HitOther", v33)
						p_u_21:__clientCallback("HitOther", {
							["result"] = v33
						})
						v30:AddToFilter(v33.Instance)
						if p_u_21.BreakOnHit then
							p_u_21:Destroy()
							return
						end
					end
					if p_u_21 and (p_u_21.State and p_u_21.State == "Running") then
						p_u_21.PreviousCFrame = v29
					end
					--goto l11
				end
			end
		else
			--::l11::
			if p_u_21 and (p_u_21.State and p_u_21.State == "Running") then
				p_u_21.PreviousCFrame = v29
			end
		end
	end)
	v_u_7:FireAllClientConnection("CreateProjectile", "REMOTE_EVENT", p_u_21:__trim(), workspace:GetServerTimeNow())
	p_u_21:__callback("Started")
end
function v_u_9.Destroy(p38)
	-- upvalues: (copy) v_u_10, (copy) v_u_7
	if p38 and p38.State ~= "Dead" then
		v_u_10((("Destroying projectile %*"):format(p38.UUID or "UUID_NOT_FOUND")))
		p38.State = "Dead"
		if p38.Model then
			p38.Model:Destroy()
		end
		if p38.Heartbeat then
			p38.Heartbeat:Disconnect()
		end
		if p38.ActiveHitbox then
			p38.ActiveHitbox:Cancel()
		end
		v_u_7:FireAllClientConnection("DestroyProjectile", "REMOTE_EVENT", p38.UUID)
		p38:__callback("Ended")
		table.clear(p38)
	end
end
function v_u_9.__getOwnerActor(p39)
	-- upvalues: (copy) v_u_5
	return v_u_5.CurrentActors[p39.Owner]
end
function v_u_9.__callback(p40, p41, ...)
	-- upvalues: (copy) v_u_10
	if not p40.Callbacks[p41] then
		return false
	end
	local v42, v43 = pcall(p40.Callbacks[p41], p40, ...)
	if v42 then
		return true, v43
	end
	v_u_10((("Projectile ID %* failed %*!\n %*"):format(p40.UUID, p41, v43)))
	return false
end
function v_u_9.__clientCallback(p44, p45)
	-- upvalues: (copy) v_u_7
	if p44.ClientCallbackData and p44.ClientCallbackData[p45] then
		v_u_7:FireAllClientConnection("ProjectileEvent", "REMOTE_EVENT", p44.UUID, p45)
	end
end
function v_u_9.__trim(p46)
	-- upvalues: (copy) v_u_8
	local v47 = {}
	for _, v48 in ipairs({
		"UUID",
		"Model",
		"InitialCFrame",
		"InitialVelocity",
		"Gravity"
	}) do
		v47[v48] = p46[v48]
	end
	v47.Callbacks = v_u_8:CopyTable(p46.ClientCallbackData or {})
	return v47
end
return v_u_9
