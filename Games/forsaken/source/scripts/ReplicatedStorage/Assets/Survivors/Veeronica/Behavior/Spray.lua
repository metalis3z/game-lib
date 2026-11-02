-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
if game:GetService("RunService"):IsClient() then
	return 0
end
local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
require(v1.Modules.Sounds)
local v_u_2 = require(v1.Modules.Util)
local v_u_3 = require(v1.Modules.Network)
local v_u_4 = require(v1.Modules.Actors)
require(v1.Modules.Statuses)
local v_u_5 = require(v1.Modules.Misc.Maid)
local v_u_6 = require(v1.Modules.Misc.Zone)
local v_u_7 = require(script.Parent.Utils)
local v_u_8 = {}
local v_u_9 = {}
v_u_9.__index = v_u_9
function v_u_9.getObject(p10)
	-- upvalues: (copy) v_u_8
	return v_u_8[p10]
end
function v_u_9.new(p11, p12, p13)
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_8
	local v14 = v_u_9
	local v_u_15 = setmetatable({}, v14)
	local v16 = v_u_5.new()
	local v_u_17 = Instance.new("Model", workspace.Map.Ingame)
	v_u_17.Name = ("%*Spray"):format(p11.Player.Name)
	v_u_17:SetAttribute("ExecutionsDisabled", true)
	v_u_17:SetAttribute("Team", "Survivors")
	v_u_17:SetAttribute("EntityType", "Entity")
	v_u_17:SetAttribute("HitboxPriority", -1)
	local v18 = Instance.new("Part", v_u_17)
	v18.Name = "Hitbox"
	v18.CanCollide = false
	v18.CanQuery = true
	v18.CanTouch = false
	v18.Anchored = true
	v18.Transparency = 1
	v18.CFrame = p12
	v18.Size = Vector3.new(7, 7, 1.5)
	v18.CollisionGroup = "Survivors"
	v_u_17.PrimaryPart = v18
	local v19 = Instance.new("Humanoid", v_u_17)
	v19.MaxHealth = p11.Config.VandalismHealth
	v19.Health = v19.MaxHealth
	v16:Add(v_u_17)
	v_u_17:AddTag(p11.Tags.Spray)
	v_u_17:SetAttribute("Progression", 1)
	v_u_15.Progression = 1
	v_u_15.Model = v_u_17
	v_u_15.Humanoid = v19
	v_u_15.Player = p11.Player
	v_u_15.Maid = v16
	v_u_15.Surface = p13
	v_u_15.Dead = false
	v_u_15.Complete = false
	local v20 = p11.SprayObjects
	table.insert(v20, v_u_15)
	v_u_8[v_u_15.Model] = v_u_15
	v16:Add(v19.HealthChanged:Connect(function(p21)
		-- upvalues: (copy) v_u_15
		if p21 <= 0 and not v_u_15.Dead then
			v_u_15:Destroy()
		end
	end))
	v16:Add(v_u_17.AncestryChanged:Connect(function()
		-- upvalues: (copy) v_u_15, (copy) v_u_17
		if not (v_u_15.Dead or v_u_17.Parent) then
			v_u_15:Destroy()
		end
	end))
	v16:Add(p13.AncestryChanged:Connect(function(_, p22)
		-- upvalues: (copy) v_u_15
		if not p22 then
			v_u_15:Destroy()
		end
	end))
	v16:Add(p13:GetPropertyChangedSignal("CFrame"):Connect(function()
		-- upvalues: (copy) v_u_15
		v_u_15:Destroy()
	end))
	return v_u_15
end
function v_u_9.ChangeProgression(p23, p24)
	local v25 = p23.Progression + p24
	p23.Progression = math.clamp(v25, 0, 100)
	p23.Model:SetAttribute("Progression", p23.Progression)
	if p23.Progression < 100 then
		if p23.Progression == 0 then
			p23:Destroy(true)
		else
			p23:OnUncompleted()
		end
	else
		if p23.Progression == 100 then
			p23:OnCompleted()
		end
		return
	end
end
function v_u_9.OnCompleted(p26)
	if p26.Complete then
		return
	else
		local v27 = p26:GetActor()
		if v27 then
			if not v27.Meta.CurrentSprayZone then
				p26.Complete = true
				p26.Model:SetAttribute("Completed", true)
				local v28 = 0
				for _, v29 in ipairs(v27.SprayObjects) do
					if v29.Complete then
						v28 = v28 + 1
					end
				end
				local _ = v28 == 3
			end
		else
			return
		end
	end
end
function v_u_9.OnUncompleted(p30)
	if p30.Complete then
		p30.Complete = false
		p30.Model:SetAttribute("Completed", nil)
		p30:DestroyZone(true)
	end
end
function v_u_9.CreateZone(p31)
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_6, (copy) v_u_2
	local v_u_32 = p31:GetActor()
	if v_u_32 then
		local v33 = Instance.new("Model")
		v33.Name = ("%*SprayBounds"):format(v_u_32.Player.Name)
		v33.Parent = workspace.Map.Ingame
		local v34 = {}
		for _, v35 in ipairs(v_u_32.SprayObjects) do
			local v36 = v35.Model.PrimaryPart
			table.insert(v34, v36)
		end
		v_u_7:Generate3DTriangle(v34, v33)
		local v37 = v_u_6.new(v33)
		v37:setAccuracy("High")
		v37:relocate()
		v37.playerEntered:Connect(function(p38)
			-- upvalues: (copy) v_u_32, (ref) v_u_3, (ref) v_u_2
			if p38 == v_u_32.Player then
				if v_u_32.State ~= true then
					v_u_32.State.InZone = true
					v_u_32.Behavior:ZoneCharge(v_u_32, true)
					v_u_3:FireClientConnection(v_u_32.Player, "ReplicateZoneStatus", "REMOTE_EVENT", true)
				end
			else
				if v_u_2:IsPlayerKiller(p38) then
					local v39 = table.find(v_u_32.Meta.CurrentKillers, p38)
					if v39 then
						table.remove(v_u_32.Meta.CurrentKillers, v39)
					end
					v_u_32.Behavior:OnSprayAreaEntered(v_u_32, p38)
					local v40 = v_u_32.Meta.CurrentKillers
					table.insert(v40, p38)
				end
				return
			end
		end)
		v37.playerExited:Connect(function(p41)
			-- upvalues: (copy) v_u_32, (ref) v_u_3, (ref) v_u_2
			if p41 == v_u_32.Player then
				if v_u_32.State ~= false then
					v_u_32.State.InZone = false
					v_u_32.Behavior:ZoneCharge(v_u_32, false)
					v_u_3:FireClientConnection(v_u_32.Player, "ReplicateZoneStatus", "REMOTE_EVENT", false)
				end
			else
				if v_u_2:IsPlayerKiller(p41) then
					local v42 = table.find(v_u_32.Meta.CurrentKillers, p41)
					local v43
					if v42 then
						v43 = table.remove(v_u_32.Meta.CurrentKillers, v42)
					else
						v43 = nil
					end
					v_u_32.Behavior:OnSprayAreaExited(v_u_32, v43)
				end
				return
			end
		end)
		v_u_32.Meta.CurrentSprayZone = v37
		v_u_32.Instances.SprayBoundContainer = v33
		v_u_32.Maid:Add(v37)
		v_u_3:FireClientConnection(v_u_32.Player, ("%*ReplicateSprayAreaAsync"):format(v_u_32.Player.Name), "REMOTE_EVENT", v34)
	end
end
function v_u_9.DestroyZone(p44, _)
	-- upvalues: (copy) v_u_3
	local v45 = p44:GetActor(p44.Player) or {}
	if v45.Meta and v45.Meta.CurrentSprayZone then
		v45.Meta.CurrentSprayZone:Destroy()
		v45.Meta.CurrentSprayZone = nil
		if v45.Instances.SprayBoundContainer then
			v45.Instances.SprayBoundContainer:Destroy()
			v45.Instances.SprayBoundContainer = nil
		end
		if v45.State.InZone then
			v45.State.InZone = false
			v45.Behavior:ZoneCharge(v45, false)
			v_u_3:FireClientConnection(p44.Player, "ReplicateZoneStatus", "REMOTE_EVENT", false)
		end
		for _, v46 in ipairs(v45.Meta.CurrentKillers) do
			v45.Behavior:OnSprayAreaExited(v45, v46)
		end
		table.clear(v45.Meta.CurrentKillers)
		v_u_3:FireClientConnection(v45.Player, ("%*ReplicateRemovedSprayAreaAsync"):format(v45.Player.Name), "REMOTE_EVENT")
	end
end
function v_u_9.GetActor(p47)
	-- upvalues: (copy) v_u_4
	return v_u_4.CurrentActors[p47.Player]
end
function v_u_9.Destroy(p48, p49)
	-- upvalues: (copy) v_u_3
	if not p48.Dead then
		p48.Dead = true
		local v50 = p48:GetActor(p48.Player) or {}
		local v51 = v50.SprayObjects and table.find(v50.SprayObjects, p48)
		if v51 then
			table.remove(v50.SprayObjects, v51)
		end
		p48:DestroyZone(p49)
		if v50.IncrementCharges then
			if not p49 then
				v50:SetCooldownOf("Vandalism", v50.Config.VandalismDestroyedCooldown)
				v50.Behavior:UnequipSpray(v50)
				v_u_3:FireClientConnection(p48.Player, "SprayDestroyed", "REMOTE_EVENT", p48.Model.PrimaryPart.Position)
			end
			v50:IncrementCharges("Vandalism", 1, 3)
		end
		p48.Maid:Destroy()
		table.clear(p48)
	end
end
return v_u_9
