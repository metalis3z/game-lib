local module = {}

local SoundsModule = require(game.ReplicatedStorage.Modules.Sounds)
local UtilModule = require(game.ReplicatedStorage.Modules.Util)
local HitboxModule = require(game.ReplicatedStorage.Modules.Hitboxes)
local StatusModule = require(game.ReplicatedStorage.Modules.Statuses)

module.Slash = function(_, Actor)
	if game["Run Service"]:IsServer() then
		Actor.AbilitiesDisabled = true
		task.delay(Actor.Config.SlashWindup, function()
			local SlashHitbox = {
				["Size"] = Vector3.new(7, 2, 7),
				["CFrameOffset"] = CFrame.new(0, 0, -2.5),
				["Damage"] = Actor.Config.SlashDamage,
				["Time"] = 0.1,
				["Knockback"] = 2,
				["HitMultiple"] = false,
				["ExecuteOnKill"] = true,
				["Connections"] = {
					["Hit"] = function(hitPlayer)
						UtilModule:CreateSpeedMultiplier(hitPlayer, 1.5, "HitSpeedBonus", 1.25)
						SoundsModule:Play(Actor.Config.Sounds.Hit, {
							["Parent"] = Actor.Rig.PrimaryPart,
							["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
							["Volume"] = 0.25
						})
					end
				}
			}
			HitboxModule:CreateHitbox(Actor.Player, SlashHitbox)
		end)
		task.delay(1.25, function()
			Actor.AbilitiesDisabled = false
		end)
	elseif game["Run Service"]:IsClient() then
		Actor.Animations.Slash:Play(0.025)
	end
end

return module
