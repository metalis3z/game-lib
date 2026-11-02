
local EventFolder = game.ReplicatedStorage.JumpscareEvents
local chasedEvent = EventFolder.ChasedEvent
local Dummy = script.Parent.Parent.Parent
local animation = script.Parent.JumpscareAnim
local sound = script.Parent.Jumpscare
sound.Parent = script.Parent.Parent
debounce = false

script.Parent.Parent.Touched:Connect(function(IsAPlayer)
	if debounce == false then
		if IsAPlayer.Parent:FindFirstChild("Humanoid") and game.Players:GetPlayerFromCharacter(IsAPlayer.Parent) then
			local animKill = Dummy:FindFirstChildOfClass("Humanoid"):LoadAnimation(animation)
			animKill:Play()
			
			
			sound:Play()
			debounce = true
			local player = game.Players:GetPlayerFromCharacter(IsAPlayer.Parent)
			chasedEvent:FireClient(player, Dummy)
			EventFolder.HideSelf:FireClient(player)
			script.Parent.Parent.Anchored = true
			wait(0.75)
			
			IsAPlayer.Parent.Humanoid.Health = 0
			wait(1)
			
			script.Parent.Parent.Anchored = false
			debounce = false
	    end
	end
end)