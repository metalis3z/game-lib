--credit to quartz games studio
local Players = game:GetService("Players")
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local RagdollModule = require(game.ReplicatedStorage.ClientModules.RagdollModule)

return function(p1) --[[ Line: 5 | Upvalues: Players (copy), Networking (copy), RagdollModule (copy) ]]
	local v1 = p1:GetAttribute("PropId")
	local isUserId = p1:GetAttribute("UserId") == Players.LocalPlayer.UserId
	local Primary = p1.Primary
	local Open = p1.Build.Open
	local Close = p1.Build.Close
	local Slam = Primary.Slam
	local Open2 = Primary.Open

	p1:SetAttribute("Debounce", true)
	Networking.BearTrap.Closed.OnClientEvent:Connect(function(p12) --[[ Line: 14 | Upvalues: v1 (copy), p1 (copy), Close (copy), Open (copy), Slam (copy) ]]
		if p12 == v1 then
			p1:SetAttribute("Debounce", false)
			Close.Transparency = 0
			Open.Transparency = 1
			Slam.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Slam.TimePosition = 0
			Slam.Playing = true
		end
	end)
	Networking.BearTrap.Reset.OnClientEvent:Connect(function(p12) --[[ Line: 23 | Upvalues: v1 (copy), p1 (copy), Close (copy), Open (copy), Open2 (copy) ]]
		if p12 == v1 then
			p1:SetAttribute("Debounce", true)
			Close.Transparency = 1
			Open.Transparency = 0
			Open2.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			Open2.TimePosition = 0
			Open2.Playing = true
		end
	end)
	Primary.Touched:Connect(function(p12) --[[ Line: 32 | Upvalues: p1 (copy), isUserId (copy), Players (ref), RagdollModule (ref), Networking (ref), v1 (copy), Primary (copy) ]]
		if not p1:GetAttribute("Debounce") then
			return
		end

		if isUserId then
			return
		end

		local v12 = if p12 then p12.Parent else p12

		if (if v12 then Players:GetPlayerFromCharacter(v12) else v12) == Players.LocalPlayer then
			RagdollModule:Ragdoll(v12, 3)
			Networking.BearTrap.BearTrap:Fire(v1, Primary.Position, "Rainbow Bear Trap")
		end
	end)
end