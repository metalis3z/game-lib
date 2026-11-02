-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Velocity Script Decompiler
local serverScriptService = game:GetService("ServerScriptService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local networking = require(replicatedStorage.Modules.Network)
local util = require(replicatedStorage.Modules.Util)
local behavior = {}
local RNG = Random.new()

local abilities = {
	["Wall"] = {
		["Name"] = "Brickwall",
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://92684920526319",
		["Callback"] = function(p9, p10)
			if typeof(p10) == "table" and p10.Cancelled then
				util:CreateWarning("BuildermanWarning", p10.Reason or "Unknown error")
			else
				local speedMultiplier = util:CreateSpeedMultiplier(p9.Rig, 1, "BuildingWall")
				local v12 = p9.Config.WallConfig.AbilityLength
				tweenService:Create(speedMultiplier, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Value"] = 0.001
				}):Play()
				p9.Animations.Trowel:Play(0.25)
				networking:FireConnection("DisableSprinting", "BuildingWall", true)
				game.Debris:AddItem(speedMultiplier, v12)
				task.delay(v12 - 0.25, function()
					tweenService:Create(speedMultiplier, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Value"] = 1
					}):Play()
					task.wait(0.25)
					networking:FireConnection("DisableSprinting", "BuildingWall", false)
				end)
			end
		end
	},
	["Book"] = {
		["Name"] = "Healing Tome",
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://138551459297915",
		["Callback"] = function(p13, p14)
			-- upvalues: (copy) util, (copy) networking, (copy) tweenService
			if typeof(p14) == "table" and p14.Cancelled then
				util:CreateWarning("BuildermanWarning", p14.Reason or "Unknown error")
			else
				local v15 = util:CreateSpeedMultiplier(p13.Rig, 0.4, "ReadingBook")
				local v16 = p13.Config.BookConfig.AbilityLength
				local v17 = p13.Animations.Spell
				v17:Play(0.1)
				networking:FireConnection("DisableSprinting", "ReadingBook", true)
				local v18 = p13.Rig:WaitForChild("Result", v16 + 0.5)
				v17:Stop(0.5)
				tweenService:Create(v15, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Value"] = 1
				}):Play()
				task.delay(0.3, function()
					-- upvalues: (ref) networking
					networking:FireConnection("DisableSprinting", "ReadingBook", false)
				end)
				if v18 then
					local _ = v18.Value
					v18:Destroy()
				end
			end
		end
	},
	["Scan"] = {
		["Name"] = "Viral Scan",
		["LayoutOrder"] = 3,
		["KeybindType"] = "AltAbility3",
		["Icon"] = "rbxassetid://80516621656060",
		["Callback"] = function(p_u_19)
			p_u_19.Animations.Scan:Play(0.1)
			game.Debris:AddItem(util:CreateSpeedMultiplier(p_u_19.Rig, 0.8, "Scanning"), p_u_19.Config.ScanLength)

			task.delay(0.25, function()
				local v_u_20 = util:CreateFOVMultiplier(p_u_19.Rig, 1, "Scanning")
				local scanTime = p_u_19.Config.ScanTime
				tweenService:Create(v_u_20, TweenInfo.new(0.25), {
					["Value"] = 0.95
				}):Play()
				task.delay(0.25, function()
					tweenService:Create(v_u_20, TweenInfo.new(2), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_20, 2)
				end)

				local injuredSurvivors = {}
				for _, survivor in pairs(workspace.Players.Survivors:GetChildren()) do
					if survivor ~= p_u_19.Rig and util:IsAlive(survivor) then
						local replicatedStorage4 = survivor.Humanoid
						if replicatedStorage4.Health < replicatedStorage4.MaxHealth then
							local survivorData = { survivor, replicatedStorage4.Health / replicatedStorage4.MaxHealth }
							table.insert(injuredSurvivors, survivorData)
						end
					end
				end

				for index, value in pairs(injuredSurvivors) do
					local replicatedStorage8 = Color3.new(1, 0.2, 0.2):Lerp(Color3.new(0.2, 1, 0.2), value[2])
					local v_u_29 = script.Ind:Clone()
					local v30 = v_u_29.Perc
					local v31 = value[2] * 100
					local v32 = math.round(v31)
					v30.Text = tostring(v32) .. "%"
					v_u_29.Parent = value[1].PrimaryPart
					game.Debris:AddItem(v_u_29, scanTime)
					tweenService:Create(v_u_29.Perc, TweenInfo.new(0.25), {
						["TextTransparency"] = 0
					}):Play()
					tweenService:Create(v_u_29.BG, TweenInfo.new(0.25), {
						["ImageTransparency"] = 0.3
					}):Play()
					util:RevealPlayerAura(value[1], scanTime, replicatedStorage8)
					task.delay(scanTime - 1, function()
						-- upvalues: (copy) v_u_29, (ref) tweenService
						if v_u_29.Parent then
							tweenService:Create(v_u_29.Perc, TweenInfo.new(1), {
								["TextTransparency"] = 1
							}):Play()
							tweenService:Create(v_u_29.BG, TweenInfo.new(1), {
								["ImageTransparency"] = 1
							}):Play()
						end
					end)
					injuredSurvivors[index] = v_u_29
				end

				while true do
					if not task.wait(0.1) then
						return
					end
					for v33 = #injuredSurvivors, 1, -1 do
						local v34 = injuredSurvivors[v33]
						if v34.Parent then
							v34.Perc.Rotation = RNG:NextInteger(-2, 2)
							v34.BG.Rotation = RNG:NextInteger(0, 360)
						else
							table.remove(injuredSurvivors, v33)
							if #injuredSurvivors == 0 then
								break
							end
						end
					end
				end
			end)
		end
	}
}

behavior.Abilities = abilities
for name, data in pairs(behavior.Abilities) do
	local callback = data.Callback
	behavior.Abilities[name].Callback = function(...)
		-- upvalues: (copy) runService, (copy) serverScriptService, (copy) tweenService6, (copy) tweenService8
		if runService:IsServer() then
			return require(script.ServerAbilities):UseAbility(name, ...)
		end
		if callback then
			return callback(...)
		end
	end
end

return behavior