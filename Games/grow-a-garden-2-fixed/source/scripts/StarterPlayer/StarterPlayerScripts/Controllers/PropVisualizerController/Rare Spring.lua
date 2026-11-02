--credit to prince games studio
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)

return function(p1) --[[ Line: 6 | Upvalues: Networking (copy), TweenService (copy), v1 (copy), Players (copy) ]]
	local v12 = p1:GetAttribute("PropId")
	local Launcher = p1.Build.Launcher
	local Base = p1.Build.Base
	local SpringConstraint = Base.SpringConstraint
	local SFX = Launcher.SFX

	p1:SetAttribute("Debounce", true)
	Networking.Spring.SpringFire.OnClientEvent:Connect(function(p12) --[[ Line: 13 | Upvalues: v12 (copy), p1 (copy), Launcher (copy), SpringConstraint (copy), SFX (copy) ]]
		if p12 == v12 then
			p1:SetAttribute("Debounce", false)
			Launcher.Anchored = false
			SpringConstraint.MinLength = 1
			SpringConstraint.MaxLength = 7
			SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			SFX.Playing = true
		end
	end)
	Networking.Spring.SpringReload.OnClientEvent:Connect(function(p12) --[[ Line: 22 | Upvalues: v12 (copy), TweenService (ref), SpringConstraint (copy), v1 (ref), Launcher (copy), Base (copy), p1 (copy) ]]
		if p12 == v12 then
			local v13 = TweenService:Create(SpringConstraint, v1, {
				MaxLength = 3
			})

			v13:Play()
			game.Debris:AddItem(v13, v1.Time)
			task.wait(v1.Time)
			SpringConstraint.MinLength = 1
			Launcher.CFrame = Base.CFrame + Vector3.new(0, 2, 0)
			Launcher.Anchored = true
			p1:SetAttribute("Debounce", true)
		end
	end)
	Launcher.Touched:Connect(function(p12) --[[ Line: 33 | Upvalues: p1 (copy), Players (ref), Networking (ref), v12 (copy) ]]
		if not p1:GetAttribute("Debounce") then
			return
		end

		local v1 = if p12 then p12.Parent else p12
		local v2 = v1 and v1:FindFirstChild("Humanoid")
		local v3 = if v1 then v1.PrimaryPart else v1

		if not (v2 and v3) then
			return
		end

		if Players:GetPlayerFromCharacter(v1) == Players.LocalPlayer then
			p1:SetAttribute("Debounce", false)

			local BodyVelocity = Instance.new("BodyVelocity")

			BodyVelocity.MaxForce = Vector3.new(0, 9000, 0)
			BodyVelocity.Velocity = Vector3.new(0, 9000, 0)
			BodyVelocity.P = 10000
			BodyVelocity.Parent = v3
			game.Debris:AddItem(BodyVelocity, 0.25)
			v2.PlatformStand = true
			Networking.Spring.SpringFire:Fire(v12)
			task.delay(math.random(2, 3), function() --[[ Line: 52 | Upvalues: v2 (copy) ]]
				v2.PlatformStand = false
			end)
		end
	end)
end