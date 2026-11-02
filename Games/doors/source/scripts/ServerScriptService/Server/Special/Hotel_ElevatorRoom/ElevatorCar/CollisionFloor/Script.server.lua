local TweenService = game:GetService("TweenService")
local doorTweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut,0,false,0)
local doorModel = script.Parent.Parent

local doorTween2 = TweenService:Create(doorModel.Door, doorTweenInfo, {CFrame = doorModel.DoorTarget.CFrame})
local doorTween3 = TweenService:Create(doorModel.Door1, doorTweenInfo, {CFrame = doorModel.Door1Target.CFrame})

local v3 = 1;

script.Parent.Touched:Connect(function(Hit)
	if script.Parent.Parent:GetAttribute("Activated", true) then
		local PrimaryDoor = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).Door.Door
		PrimaryDoor.Break:Play()
		game.Workspace.Ambience_Unranged:Destroy()
		script.Parent.CanTouch = false
		if Hit.Parent:FindFirstChild("Humanoid") then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v.Character then
					if v.Character.Humanoid.Health > 0 then
						local l__ElevatorCar__1 = script.Parent.Parent.Parent.ElevatorCar
						v.InGameStats.FloorsEscaped.Value = true
						script.Parent.Parent.Door1Target.Transparency = 0
						script.Parent.Parent.DoorTarget.Transparency = 0
						game.ReplicatedStorage.EntityInfo.TriggerElevator1:FireClient(v)
						game.ReplicatedStorage.EntityInfo.CutsceneFollowup:FireClient(v)
						v.InGameStats.FloorsEscaped.Value = true
						v.Character:PivotTo(script.Parent.Parent.Spawns:FindFirstChild("PlayerWeld"..v3).CFrame)
						script.Parent.Parent.Spawns:FindFirstChild("PlayerWeld"..v3).Weld.Part1 = v.Character.HumanoidRootPart
						script.Parent.Parent.Spawns:FindFirstChild("PlayerWeld"..v3).Constraint.Attachment0 = v.Character.HumanoidRootPart.RootAttachment
						v.Character.Humanoid.WalkSpeed = 0
						v3 = v3 + 1
						wait(0.6)
					end
				end
			end
		end
	else
		print("Nice try! Need activate a sharks")
	end
end)