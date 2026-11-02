local debounce = false
local l__TweenService__1 = game:GetService("TweenService");
local SeekMoving = game:GetService("ServerScriptService").Server.Assets.Entities.SeekMoving:Clone()

script.Parent.Parent.RoomStart.Touched:Connect(function()
	task.wait(0.512)
	SeekMoving:PivotTo(script.Parent.Parent.SeekNewPos.CFrame * CFrame.new(0, -60, 0))
	SeekMoving.Parent = game.Workspace
	SeekMoving.SeekLoading.Value = true
	SeekMoving.AssetControl.Enabled = true
	script.Parent.Parent.RoomStart.CanTouch = false
end)

local variant = math.random(1, 6)

if game.Workspace.CurrentRooms:GetAttribute("Seek2Mode", true) then
	script.Parent.Parent.VariantSeek2.Value = 1
else
	script.Parent.Parent.VariantSeek.Value = variant
end

function SeekTrigger(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)

	if player then
		if not debounce then
			local room = script.Parent.Parent
			debounce = true
			SeekMoving:PivotTo(script.Parent.Parent.SeekNewPos.CFrame)
			SeekMoving.Fire:Fire()
			if game.Workspace.CurrentRooms:GetAttribute("Seek2Mode", true) then
				script.Parent.Parent.VariantSeek2.Parent = workspace.CurrentRooms
			else
				script.Parent.Parent.VariantSeek.Parent = workspace.CurrentRooms
			end
			script.Parent.Parent.Door.Hidden.Generation.Enabled = true
			game.ReplicatedStorage.GameData.ChaseInSession.Value = true
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					if v.Character.Humanoid.Health == 0 then

					else
						v.Character.HumanoidRootPart.Anchored = true
						l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
							Ambient = Color3.new(0.243137, 0, 0)
						}):Play();
						l__TweenService__1:Create(game:GetService("Lighting").Sanity, TweenInfo.new(16, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
							Saturation = 0.2
						}):Play();
						game.ReplicatedStorage.EntityInfo.TriggerSeek:FireClient(v)
					end
				end 
			end
			require(game.ReplicatedStorage.ClientModules.EntityModules.Seek).tease(room, 45, 25, true)
			wait(8.2)
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					if v.Character.Humanoid.Health == 0 then
						
					else
						v.Character.PrimaryPart.CFrame = script.Parent.Parent.Lobby.CFrame
						v.Character.HumanoidRootPart.Anchored = false
						v.Character.Humanoid:SetAttribute("SpeedBoost", 4)
						game.ReplicatedStorage.ClientBricks.SeekChase:FireClient(v)
					end 
				end
			end
		end
	end
end

script.Parent.Touched:Connect(function(hit)
	SeekTrigger(hit)
end)