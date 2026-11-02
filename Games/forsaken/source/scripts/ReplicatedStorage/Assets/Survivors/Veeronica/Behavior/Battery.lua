-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Modules.Util)
require(v2.Modules.Statuses)
local v_u_4 = v_u_1:IsServer()
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v7 = v_u_4
	assert(v7, "is not server")
	assert(p6, "bad character, must be Model")
	local v8 = v_u_5
	local v9 = setmetatable({}, v8)
	v9.Charge = 25
	v9.Callbacks = {}
	v9.__isChargable = true
	v9.__isHealing = false
	v9.__character = p6
	v9:__updateCharge()
	return v9
end
function v_u_5.__callback(p10, p11, ...)
	local v_u_12 = p10.Callbacks[p11]
	if not v_u_12 then
		return false
	end
	local v13, v14 = pcall(function(...)
		-- upvalues: (copy) v_u_12
		return v_u_12(...)
	end, ...)
	if v13 then
		return true, v14
	end
	warn((("Battery failed %*!\n %*"):format(p11, v14)))
	return false
end
function v_u_5.__updateCharge(p15)
	local v16 = p15.Charge / 50 * 100
	local v17 = math.floor(v16)
	p15.__character:SetAttribute("BatteryPercent", v17)
end
function v_u_5.IsHealable(p18, p19)
	if p18.Charge > 0 then
		if p19 then
			if p19.Health < p19.MaxHealth then
				p19 = p19.Health > 0
			else
				p19 = false
			end
		end
	else
		p19 = false
	end
	return p19
end
function v_u_5.DecrementCharge(p20)
	local v21 = p20.Charge - 1
	p20.Charge = math.clamp(v21, 0, 50)
	p20:__updateCharge()
	return p20.Charge
end
function v_u_5.IncrementCharge(p22, p23)
	if p22.Charge >= 50 then
		return p22.Charge
	end
	if p22.__isChargable then
		local v24 = p22.Charge + (p23 or 1)
		p22.Charge = math.clamp(v24, 0, 50)
	end
	p22:__updateCharge()
	p22:__callback("Charged", p23)
	return p22.Charge
end
function v_u_5.StartHealing(p_u_25, p_u_26)
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v_u_27 = p_u_25.__character:FindFirstChildOfClass("Humanoid")
	if v_u_27 then
		if not p_u_25.__isHealing then
			p_u_25.__isHealing = true
			p_u_25.__isChargable = false
			local v_u_28 = false
			local v_u_29 = {}
			p_u_25:__callback("Start")
			local function v_u_32()
				-- upvalues: (ref) v_u_28, (copy) v_u_29, (copy) p_u_25
				if not v_u_28 then
					v_u_28 = true
					for v30, v31 in ipairs(v_u_29) do
						v31:Disconnect()
						v_u_29[v30] = nil
					end
					table.clear(v_u_29)
					p_u_25.__isHealing = false
					p_u_25.__isChargable = true
					p_u_25:__callback("Ended")
				end
			end
			local v_u_33 = 0
			local v34 = v_u_1.Heartbeat
			local function v36(p35)
				-- upvalues: (ref) v_u_33, (ref) v_u_28, (copy) p_u_25, (copy) v_u_27, (ref) v_u_3, (copy) v_u_32, (copy) p_u_26
				v_u_33 = v_u_33 + p35
				if v_u_33 >= 0.25 and not v_u_28 then
					v_u_33 = 0
					if p_u_25:IsHealable(v_u_27) then
						if v_u_3:Heal(v_u_27, 1) then
							p_u_25:DecrementCharge()
							p_u_26(v_u_27.Health, v_u_27.Health - 1)
						else
							v_u_32()
							p_u_25:__callback("Interrupted")
						end
					end
					v_u_32()
					p_u_25:__callback(p_u_25.Charge <= 0 and "Discharged" or "Finished")
				end
			end
			table.insert(v_u_29, v34:Connect(v36))
			local v_u_37 = v_u_27.Health
			local v38 = v_u_27.HealthChanged
			local function v40(p39)
				-- upvalues: (ref) v_u_37, (ref) v_u_28, (copy) p_u_25, (copy) v_u_32
				if p39 < v_u_37 then
					if not v_u_28 then
						p_u_25:__callback("Interrupted")
					end
					v_u_32()
				else
					v_u_37 = p39
				end
			end
			table.insert(v_u_29, v38:Connect(v40))
			local v41 = v_u_27.Died
			table.insert(v_u_29, v41:Once(v_u_32))
		end
	else
		return
	end
end
return v_u_5
