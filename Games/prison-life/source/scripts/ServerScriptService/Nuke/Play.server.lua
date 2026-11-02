local ison = false
local ButtonNuke = game.Workspace:WaitForChild("ButtonNuke")

local GamePassService = game:GetService('MarketplaceService')
local GamePassIdObject = ButtonNuke:WaitForChild("GamePassId")

local NukeConfig = game.ReplicatedStorage:WaitForChild("NukeConfig")
local launchedValue = NukeConfig:WaitForChild("NukeLunchedTimes")
local arming = NukeConfig:WaitForChild("ArmingNukeTime")
local timer = NukeConfig:WaitForChild("Timer")

local DoorsValue = NukeConfig:WaitForChild("Doors2")
local OpenCframePart = DoorsValue:WaitForChild("OpenPartColor")
local OpenRoof = DoorsValue:WaitForChild("OpenRoof")

local Doors = NukeConfig:WaitForChild("Doors")

local Helicopter = NukeConfig:WaitForChild("BlackHawk")

local Nuke1 = NukeConfig:WaitForChild("JailbreakNuke")
local Nuke2 = NukeConfig:WaitForChild("JailbreakNuke2")

local Launcher = game.Workspace:WaitForChild("launcher")

local IsLauched = NukeConfig:WaitForChild("IsLaunched")

local Sound = ButtonNuke.Button.Sound

local cctv = game.Workspace:WaitForChild("cctv")
local Sounds = game.Workspace:WaitForChild("Sound")

local Explotion = NukeConfig:WaitForChild("explosion")

local ShowGui = NukeConfig:WaitForChild("ShowGui")

local Cam = game.ReplicatedStorage:WaitForChild("HomeConfig"):WaitForChild("Camera")

game.Players.PlayerAdded:Connect(function(player)
	local bv = Instance.new("BoolValue", player)
	bv.Name = "Survive"
	bv.Value = false

	player.CharacterAdded:Connect(function(character)
		local hum = character.Humanoid

		hum.Seated:Connect(function(IsSeated, whoPart)
			if IsSeated == true and whoPart.Name == "HelicopterSeat" then
				bv.Value = true
			else
				bv.Value = false
			end
		end)

		hum.Died:Connect(function()
			if player.Team == game.Teams.Survivors then
				player.Team = game.Teams.NoSurvivors
			end
		end)
	end)
end)


ButtonNuke.Button.ClickDetector.MouseClick:Connect(function(player)
	if GamePassService:UserOwnsGamePassAsync(player.userId, GamePassIdObject.Value) then
		Sound:Play()
		
		if ison== false then
			ison = true
			
			IsLauched.Value = true
			
			ButtonNuke.Button.error:Play()

			cctv.Parterror.Decal.Transparency = 0
			cctv.errorpart2.Decal.Transparency = 0
			cctv.errorpart3.Decal.Transparency = 0
			cctv.errorpart3.Decal.Transparency = 0
			cctv.errorpart4.Decal.Transparency = 0
			cctv.errorpart5.Decal.Transparency = 0

			ButtonNuke.Base.Sound:Stop()

			wait(ButtonNuke.Button.error.TimeLength)
			
			--timer
			ShowGui:FireAllClients()
			
			timer.Value = 88
			
			spawn(function()
				while timer.Value ~= 0 do
					timer.Value = timer.Value -1

					wait(1)
				end
			end)
						
			--game.ReplicatedStorage.nukeisarmed.Value = false

			launchedValue.Value = launchedValue.Value +1

			local team = Instance.new("Team")
			team.Parent = game.Teams
			team.TeamColor = BrickColor.new("Black")
			team.Name = "NoSurvivors"

			local team2 = Instance.new("Team")
			team2.Parent = game.Teams
			team2.TeamColor = BrickColor.new("Brick yellow")
			team2.Name = "Survivors"

			for x,d in pairs(game.Players:GetChildren()) do
				d.Team = game.Teams.Survivors
				d.PlayerGui.Home.hud.Visible = false
			end

			game.Workspace.Doors:Destroy()

			game.ReplicatedStorage.nuke.Value = true

			game.Workspace.EmergencyLight1.Base.Alarm3:Play()
			game.Workspace.EmergencyLight2.Base.TacticalNukeAlarm:Play()
			game.Workspace.EmergencyLight4.Base.Alarm2:Play()
			ButtonNuke.Button.alarm:Play()
			Sounds.BoomingA:Play()

			game.Workspace.EmergencyLight4.Toggle.Value = true
			game.Workspace.EmergencyLight3.Toggle.Value = true
			game.Workspace.EmergencyLight2.Toggle.Value = true
			game.Workspace.EmergencyLight1.Toggle.Value = true
			game.Workspace.EmergencyLight.Toggle.Value = true

			local helicopter = Helicopter:Clone()
			helicopter.Parent = game.Workspace


			local nuke = Launcher:WaitForChild("JailbreakNuke")

			OpenCframePart.Value = true

			OpenRoof.Value = true
			wait(11)

			nuke.MeshPart1.RocketLaunching:Play()

			wait(20)
			nuke.Part.Fire.Enabled = true

			for i = 1, 1100 do
				nuke:SetPrimaryPartCFrame(nuke:GetPrimaryPartCFrame() * CFrame.new(0,0,-0.4))
				wait()
			end
			nuke:Destroy()

			OpenRoof.Value = false
			------------------------------------------------------------------------explode-----------------------------------------------------------------------
			wait(21)

			--game.ReplicatedStorage.nuke.Value = false

			helicopter.Preset.TopRotor.istrue.Value = true

			Sounds.BoomingA:Stop()
			Sounds.Countdown.TimePosition = 3 
			Sounds.Countdown:Play()

			local nuke2 = Nuke2:Clone()
			nuke2.Parent = game.Workspace

			nuke2.MeshPart1.PlaneCrash:Play()

			Sounds.booms.Sound:Play()

			for i = 1, 250 do
				nuke2:SetPrimaryPartCFrame(nuke2:GetPrimaryPartCFrame() * CFrame.new(0,2,0))
				wait()
			end

			nuke2:Destroy()


			local explode = Explotion:Clone()
			explode.Parent = game.Workspace

			Sounds.booms.BOOM:Play()
			Sounds.booms.explode:Play()
			wait(1)
			Sounds.booms.mvmbombexplode:Play()
			
			for i = 1, 500 do
				local nuke3 = game.Workspace.explosion.nuke
				local ring = game.Workspace.explosion.Ring

				nuke3.Size = Vector3.new(nuke3.Size.X+2.5)
				ring.Size = Vector3.new(ring.Size.X+5, ring.Size.Y+0.5, ring.Size.Z+5)

				wait()
			end
			
			for x,d in pairs(game.Players:GetChildren()) do
				if d.Team == team2 then
					if d:WaitForChild("Survive").Value == false then
						d.Team = team
						d.Character.Humanoid.Health = 0
					else
						d.leaderstats.Coins.Value = d.leaderstats.Coins.Value+10000 
					end
				end
			end
			
			wait(1)

			Sounds.booms.Sound:Stop()

			game.Workspace.EmergencyLight4.Toggle.Value = false
			game.Workspace.EmergencyLight3.Toggle.Value = false
			game.Workspace.EmergencyLight2.Toggle.Value = false
			game.Workspace.EmergencyLight1.Toggle.Value = false
			game.Workspace.EmergencyLight.Toggle.Value = false

			game.Workspace.EmergencyLight1.Base.Alarm3:Stop()
			game.Workspace.EmergencyLight2.Base.TacticalNukeAlarm:Stop()
			game.Workspace.EmergencyLight4.Base.Alarm2:Stop()

			ButtonNuke.Button.alarm:Stop()

			ButtonNuke.Base.Sound:Play()

			wait(10)

			--game.ReplicatedStorage.openframenuketeam.Value = true

			explode:Destroy()
			helicopter:Destroy()

			team:Destroy()
			team2:Destroy()
			
			for x,d in pairs(game.Players:GetChildren()) do
				if d.Team == team2 then					
					local alltp = game.Workspace.tpnukes:GetChildren()
					local tprandom = alltp[math.random(1,#alltp)]

					d.Character.Torso.CFrame = CFrame.new(tprandom.Position)
				end
				
				spawn(function()
					d.isintro.Value = true

					d.TeamColor = BrickColor.new("Medium stone grey")

					wait(0.5)
					d:LoadCharacter()
				end)
			end
			
			
			local newDoors = Doors:Clone()
			newDoors.Parent = game.Workspace

			cctv.Parterror.Decal.Transparency = 1
			cctv.errorpart2.Decal.Transparency = 1
			cctv.errorpart3.Decal.Transparency = 1
			cctv.errorpart3.Decal.Transparency = 1
			cctv.errorpart4.Decal.Transparency = 1
			cctv.errorpart5.Decal.Transparency = 1
			
			
			IsLauched.Value = false
			
			arming.Value = 600
			
			while arming.Value ~= 0 do
				arming.Value = arming.Value -1
				
				wait(1)
			end
			
			local anuke = Nuke1:Clone()
			anuke.Parent = Launcher
			
			OpenCframePart.Value = false
			
			ison = false
		end
	else
		GamePassService:PromptGamePassPurchase(player, GamePassIdObject.Value)
	end
end)