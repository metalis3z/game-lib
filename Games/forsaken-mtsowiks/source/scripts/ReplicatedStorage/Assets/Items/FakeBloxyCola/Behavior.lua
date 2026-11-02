-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("RunService")
local v_u_3 = v2:IsClient()
local v_u_4 = v2:IsServer()
function v_u_1.Created(_) end
function v_u_1.Destroyed(p5)
	-- upvalues: (copy) v_u_1
	v_u_1.Unequipped(p5)
end
function v_u_1.Equipped(_) end
function v_u_1.Unequipped(p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v7 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[p6.Player]
	if v7 and v_u_4 then
		v7:ChangeExpression("Default")
	end
	if p6.SpeedMultiplier then
		p6.SpeedMultiplier:Destroy()
		p6.SpeedMultiplier = nil
	end
	if v_u_3 then
		require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "BloxyColaItem", false)
	end
	p6.Cooldown = nil
	if p6.Threads and not p6.Completed then
		for _, v8 in pairs(p6.Threads) do
			task.cancel(v8)
		end
		p6.Threads = nil
	end
	if p6.SFX then
		p6.SFX:Destroy()
		p6.SFX = nil
	end
end
function v_u_1.Activated(p_u_9)
	if p_u_9.Threads then
		return
	else
		p_u_9.Cooldown = true
		if game["Run Service"]:IsServer() then
			local v10 = require(game.ReplicatedStorage.Modules.Sounds)
			local v11 = p_u_9.Config.Sounds.Drinking
			local v12 = {}
			local v13 = p_u_9.Player.Character
			if v13 then
				v13 = p_u_9.Player.Character:FindFirstChild("Head")
			end
			v12.Parent = v13
			p_u_9.SFX = v10:Play(v11, v12)
			p_u_9.Threads = { task.delay(1, function()
					-- upvalues: (copy) p_u_9
					local v14 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[p_u_9.Player]
					if v14 then
						v14:ChangeExpression("Drinking", 1.2)
					end
				end), task.delay(p_u_9.Config.DrinkTime, function()
					-- upvalues: (copy) p_u_9
					p_u_9.Completed = true
					require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(p_u_9.Player, "Hallucination", {
						["Level"] = 1,
						["Stackable"] = true,
						["Hidden"] = false
					})
					p_u_9:Destroy()
				end) }
		elseif game["Run Service"]:IsClient() then
			p_u_9.Animations.Activated2:Play()
			if not p_u_9.SpeedMultiplier then
				p_u_9.SpeedMultiplier = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(p_u_9.Player, p_u_9.Config.DrinkSpeedMultiplier, "BloxyColaItem", p_u_9.Config.DrinkTime)
			end
			require(game.ReplicatedStorage.Modules.Network):FireConnection("DisableSprinting", "BloxyColaItem", true)
		end
	end
end
function v_u_1.Deactivated(_) end
return v_u_1
