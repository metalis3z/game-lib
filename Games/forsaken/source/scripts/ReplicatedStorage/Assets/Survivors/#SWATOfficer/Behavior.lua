-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Util)
local v_u_3 = require(game.ReplicatedStorage.Modules.Sounds)
require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_4 = require(game.ReplicatedStorage.Modules.Statuses)
local v21 = {
	["Flashbang"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_5, _)
			-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
			if game["Run Service"]:IsServer() then
				p_u_5.AbilitiesDisabled = true
				p_u_5.Rig.Flashbang.Transparency = 0
				task.delay(0.4, function()
					-- upvalues: (ref) v_u_3, (copy) p_u_5, (ref) v_u_4, (ref) v_u_2
					v_u_3:Play(p_u_5.Config.Sounds.FlashbangThrown, {
						["Parent"] = p_u_5.Rig.PrimaryPart,
						["Volume"] = 1
					})
					local v_u_6 = p_u_5.Rig.Flashbang:Clone()
					v_u_6.FlashbangJoint:Destroy()
					v_u_6.CollisionGroup = "Items"
					v_u_6.CanCollide = true
					v_u_6.AssemblyLinearVelocity = (p_u_5.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * p_u_5.Config.FlashbangThrowForce
					v_u_6.Parent = workspace.Map.Ingame
					v_u_6:SetNetworkOwner(p_u_5.Player)
					p_u_5.Rig.Flashbang.Transparency = 1
					task.delay(p_u_5.Config.FlashbangFuseDuration, function()
						-- upvalues: (copy) v_u_6, (ref) p_u_5, (ref) v_u_4, (ref) v_u_2
						for _ = 1, 10 do
							local v7 = Instance.new("PointLight")
							v7.Brightness = 60
							v7.Range = 40
							v7.Parent = v_u_6
							game.Debris:AddItem(v_u_6, 0.1)
						end
						v_u_6.Transparency = 0.975
						game.Debris:AddItem(v_u_6, 2)
						local function v_u_13(p8)
							-- upvalues: (ref) p_u_5, (ref) v_u_4
							local v9 = p8.Parent
							if tostring(v9) ~= "Survivors" or p8 == p_u_5.Rig then
								local v_u_10 = p_u_5.Config.FlashbangSmokeVFX:Clone()
								v_u_10.Parent = p8:FindFirstChild("Head")
								v_u_10.CFrame = v_u_10.Parent and v_u_10.Parent.CFrame or CFrame.new()
								local v11 = Instance.new("WeldConstraint")
								v11.Parent = v_u_10
								v11.Part1 = v_u_10
								v11.Part0 = p8:FindFirstChild("Head")
								task.delay(p_u_5.Config.FlashbangBlindnessDuration, function()
									-- upvalues: (copy) v_u_10
									game.Debris:AddItem(v_u_10, 2)
									for _, v12 in pairs(v_u_10:GetDescendants()) do
										if v12:IsA("ParticleEmitter") then
											v12.Enabled = false
										end
									end
								end)
								v_u_4:ApplyStatus(p8, "Blindness", {
									["Level"] = 4,
									["Duration"] = p_u_5.Config.FlashbangBlindnessDuration,
									["Instant"] = true,
									["Flash"] = true
								})
							end
						end
						local v_u_14 = v_u_2:GetClosestPlayerFromPosition(v_u_6.Position, {
							["MaxDistance"] = p_u_5.Config.FlashbangRadius,
							["PlayerSelection"] = "All",
							["ReturnTable"] = true
						}) or {}
						for _, v15 in pairs(v_u_14) do
							if v15.Player then
								v_u_13(v15.Player)
							end
						end
						local v16 = workspace.Players.Killers:GetChildren()
						local v17 = p_u_5.Rig
						table.insert(v16, v17)
						for _, v_u_18 in pairs(v16) do
							local v_u_19 = game.Players:GetPlayerFromCharacter(v_u_18)
							if v_u_19 then
								task.spawn(function()
									-- upvalues: (copy) v_u_14, (copy) v_u_18, (copy) v_u_19, (ref) v_u_6, (copy) v_u_13
									for _, v20 in pairs(v_u_14) do
										if v_u_18 == v20.Player then
											return
										end
									end
									if require(game.ReplicatedStorage.Modules.Network):FireClientConnection(v_u_19, "IsOnScreen", "REMOTE_FUNCTION", v_u_6) then
										v_u_13(v_u_18)
									end
								end)
							end
						end
					end)
				end)
				task.delay(2, function()
					-- upvalues: (copy) p_u_5
					p_u_5.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_5.Animations.ThrowFlashbang:Play()
			end
		end
	}
}
v1.Abilities = v21
function v1.GetRig(_, p22)
	local v23 = script:GetChildren()
	local v24 = v23[math.random(1, #v23)]
	if v24 then
		p22.PlayerType = v24.Name
		return v24:Clone()
	end
end
function v1.Created(_, p_u_25)
	if game["Run Service"]:IsServer() then
		task.spawn(function()
			-- upvalues: (copy) p_u_25
			local v26 = {
				["Standard"] = {
					["Health"] = 100,
					["GunType"] = "AssaultRifle",
					["Speed"] = 12
				},
				["Brute"] = {
					["Health"] = 150,
					["GunType"] = "AssaultRifle",
					["Speed"] = 9
				},
				["Strategic"] = {
					["Health"] = 75,
					["GunType"] = "Glock",
					["Speed"] = 14
				}
			}
			local v27 = v26[p_u_25.PlayerType] or v26.Standard
			p_u_25.Rig.Humanoid.MaxHealth = v27.Health
			p_u_25.Rig.Humanoid.Health = v27.Health
			p_u_25.Rig.Humanoid.WalkSpeed = v27.Speed
			p_u_25.Rig.Humanoid:SetAttribute("BaseSpeed", v27.Speed)
			local v28 = { v27.GunType, "Medkit" }
			for _, v29 in pairs(v28) do
				local v30 = require(game.ReplicatedStorage.Modules.Items):CreateItem(v29)
				if v30 then
					local v31 = v30.Item
					local v32 = p_u_25.Player
					if v32 then
						v32 = p_u_25.Player:FindFirstChild("Backpack")
					end
					v31.Parent = v32
					if not v30.Item.Parent then
						v30:Destroy()
					end
				end
			end
		end)
	end
end
return v1
