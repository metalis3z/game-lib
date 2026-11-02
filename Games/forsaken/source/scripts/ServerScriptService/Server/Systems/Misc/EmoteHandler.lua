local module = {
	CurrentEmotes = {}
}

local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
local Util = require(game.ReplicatedStorage.Modules.Util)
local Actors = require(game.ReplicatedStorage.Modules.Actors)
local Emotes = game.ReplicatedStorage.Assets:FindFirstChild('Emotes');
local EmoteSyncRadius = 10
local defaultEmote = {
	["DisplayName"] = "Wave",
	["Description"] = "haiii :D :D",
	["Credits"] = "Made By: ROBLOX",
	["RenderImage"] = "rbxassetid://132063131763271",
	["Price"] = 50,
	["AssetID"] = "rbxassetid://128777973",
	["SFX"] = "rbxassetid://154865749"
}

module.StopEmote = function(Player: Player, ForceStop)
	local Character = Player.Character 
	if not Character then 
		return
	end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end
	local Emote = module.CurrentEmotes[Character]
	if not Emote then
		return
	end
	if Emote.Config and Emote.Config.Uncancellable and (not ForceStop) then
		return
	end
	local Actor = Actors.CurrentActors[Player]
	Character:SetAttribute("UsingAnimations", nil)
	if Actor then
		Actor:ChangeExpression("Happy", 0)
		Actor:DisableAbilities("Emoting", false)
	end

	if Character:FindFirstChild("SpeedMultipliers") and Character.SpeedMultipliers:FindFirstChild("Emoting") then
		Character.SpeedMultipliers.Emoting:Destroy()
	end
	if Emote.Connections then
		for _, v : RBXScriptConnection in pairs(Emote.Connections) do
			v:Disconnect()
		end
	end
	task.spawn(function()
		repeat task.wait() until Humanoid.Parent == nil or Humanoid.Jump == false
		if Emote.JumpPower then
			Humanoid.JumpPower = Emote.JumpPower
		end
		if Emote.JumpHeight then
			Humanoid.JumpHeight = Emote.JumpHeight
		end
	end)
	if Emote.Config and Emote.Config.AutoWalk then
		Network:FireClientConnection(Player, "EmoteAutoWalk", "REMOTE_EVENT", false)
	end
	if Emote.Config then
		if Emote.Config.Destroyed then
			Emote.Config.Destroyed(Emote.Data)
		end
		if Emote.Config.DestroyedServer then
			Emote.Config.DestroyedServer(Emote.Data)
		end
	end
	
	if Emote.Animation then Emote.Animation:Stop(0) end
	if Emote.Sound then Emote.Sound:Destroy() end
	
	module.CurrentEmotes[Character] = nil
end

module.PlayEmote = function(Player: Player, EmoteType, EmoteName: string)
	local Actor = Actors.CurrentActors[Player]
	if not EmoteName then
		return
	end
	local Class = Actor and Actor.Config and Actor.Config.Class or "Survivalist"
	
	local FoundEmote = Emotes:FindFirstChild(EmoteName)
	local RequiredEmote
	if Actor and Actor.Config and Actor.Config.Emotes then
		RequiredEmote = EmoteType == "Voicelines" and Actor.Config.Emotes.Voicelines and Actor.Config.Emotes.Voicelines[EmoteName] or Actor.Config.Emotes.Animations and Actor.Config.Emotes.Animations[EmoteName] or Actor.Config.Emotes[EmoteName] or game.ReplicatedStorage.Assets.Emotes:FindFirstChild(EmoteName) and require(game.ReplicatedStorage.Assets.Emotes:FindFirstChild(EmoteName)) or defaultEmote
	end
	
	if not RequiredEmote then
		if not FoundEmote then
			return
		end
		RequiredEmote = require(FoundEmote);
	end
	
	if not RequiredEmote then
		return
	end
	
	local Character : Model = Actor and Actor.Rig or Player.Character 
	if not Character then 
		return
	end
	
	if module.CurrentEmotes[Character] then return end
	
	local Humanoid = Character:FindFirstChildOfClass('Humanoid')
	if not Humanoid then 
		return
	end
	
	local CreatedFunction = RequiredEmote.Created
	local CreatedServerFunction = RequiredEmote.CreatedServer
	if EmoteType == "Animations" then
		local timePositionAudio
		local timePositionAnim
		module.StopEmote(Player, true)
		task.wait()
		
		local SFX = typeof(RequiredEmote.SFX) == 'table' and (RequiredEmote.SFX[1] and RequiredEmote.SFX[math.random(1, #RequiredEmote.SFX)] or RequiredEmote.SFX[Class]) or RequiredEmote.SFX or ""
		local AnimID = typeof(RequiredEmote.AssetID) == 'table' and (RequiredEmote.AssetID[1] and RequiredEmote.AssetID[math.random(1, #RequiredEmote.AssetID)] or RequiredEmote.AssetID[Class]) or RequiredEmote.AssetID or ""
		local SFXPro = RequiredEmote.SFXProperties
		local CreatedAudio = Instance.new('Sound')
		local walkSpeed = Actor and Actor.Speed or 12
		local Speed = RequiredEmote.Speed and RequiredEmote.Speed/walkSpeed or 0
		
		if SFXPro then 
			for Index, Value in SFXPro do 
				CreatedAudio[Index] = Value
			end
		end
		
		CreatedAudio.Name = EmoteName
		CreatedAudio.SoundId = SFX
		CreatedAudio.Parent = Character.PrimaryPart
		
		local NewAnimation = Instance.new('Animation')
		NewAnimation.AnimationId = AnimID
		local Animator = Humanoid:FindFirstChildOfClass('Animator') or Humanoid
		local LoadedTrack : AnimationTrack = Animator:LoadAnimation(NewAnimation)
		
		local emoteData = {Character = Character}
		if CreatedFunction then
			CreatedFunction(emoteData)
		end
		if CreatedServerFunction then
			CreatedServerFunction(emoteData)
		end
		
		local multiplier = Util:CreateSpeedMultiplier(Player, Speed, "Emoting")
		if Player:FindFirstChild("PlayerData") and Player.PlayerData:FindFirstChild("Settings") and Player.PlayerData.Settings:FindFirstChild("EmoteSyncing", true) and Player.PlayerData.Settings:FindFirstChild("EmoteSyncing", true).Value == true and (RequiredEmote.SyncAnim or RequiredEmote.SyncMusic) then
			local closeCharacters = {}
			for _, v : Humanoid in pairs(workspace:GetDescendants()) do
				if v:IsA("Humanoid") and v.Health > 0 and v.Parent:IsA("Model") and v.Parent.PrimaryPart and (v.Parent.PrimaryPart.Position-Character.PrimaryPart.Position).Magnitude <= EmoteSyncRadius then
					table.insert(closeCharacters, {Player = v.Parent, Distance = (v.Parent.PrimaryPart.Position-Character.PrimaryPart.Position).Magnitude})
				end
			end
			table.sort(closeCharacters, function(a, b)
				return a.Distance <= b.Distance
			end)
			if closeCharacters then
				for _, plr in ipairs(closeCharacters) do
					local char : Model = plr.Player
					if char == Character then
						continue
					end
					if not char then
						continue
					end
					local targetPlayer = game.Players:GetPlayerFromCharacter(char)
					if targetPlayer and targetPlayer:FindFirstChild("PlayerData") and targetPlayer.PlayerData:FindFirstChild("Settings") and targetPlayer.PlayerData.Settings:FindFirstChild("EmoteSyncing", true) and targetPlayer.PlayerData.Settings:FindFirstChild("EmoteSyncing", true).Value == false then
						continue
					end
					local foundMatch = false
					if RequiredEmote.SyncAnim then
						local hum = char:FindFirstChildOfClass("Humanoid")
						if not hum then
							continue
						end
						local animator = hum:FindFirstChildOfClass("Animator") or hum
						for _, track : AnimationTrack in pairs(animator and animator:GetPlayingAnimationTracks() or hum:GetPlayingAnimationTracks()) do
							if track.Animation.AnimationId == AnimID then
								timePositionAnim = track.TimePosition
								foundMatch = true
								break
							else
							end
						end
						local matchingMusic = char.PrimaryPart:FindFirstChild(EmoteName)
						if matchingMusic and matchingMusic:IsA("Sound") then
							timePositionAudio = matchingMusic.TimePosition
							foundMatch = true
						end
					elseif RequiredEmote.SyncMusic then
						local matchingMusic = char.PrimaryPart:FindFirstChild(EmoteName)
						if matchingMusic and matchingMusic:IsA("Sound") then
							timePositionAudio = matchingMusic.TimePosition
							foundMatch = true
						end
					end
					if foundMatch then
						break
					end
				end
			end
		end
		CreatedAudio:Play()
		LoadedTrack:Play(0)
		if timePositionAnim then
			LoadedTrack.TimePosition = timePositionAnim
		end
		if timePositionAudio then
			CreatedAudio.TimePosition = timePositionAudio
		end
		if Actor then
			Actor:ChangeExpression("Happy")
		end
		local stoppedConnection
		stoppedConnection = LoadedTrack.Stopped:Connect(function()
			task.wait()
			if stoppedConnection.Connected then
				module.StopEmote(Player, true)
			end
		end)
		
		Humanoid.Parent:SetAttribute("UsingAnimations", true)
		if Actor then
			Actor:DisableAbilities("Emoting", true)
		end
		task.wait()
		local oldJumpPower = Humanoid.JumpPower
		local oldJumpHeight = Humanoid.JumpHeight
		Humanoid.JumpPower = 0
		Humanoid.JumpHeight = 0
		local jumpConnection
		jumpConnection = Humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
			if jumpConnection.Connected then
				module.StopEmote(Player)
			end
		end)
		local previousHealth = Humanoid.Health
		local healthConnection
		healthConnection = Humanoid.HealthChanged:Connect(function(health)
			if health < previousHealth and healthConnection.Connected then
				module.StopEmote(Player, true)
			else
				previousHealth = health
			end
		end)

		CreatedAudio.Stopped:Connect(function()
			CreatedAudio:Destroy()
		end)

		if RequiredEmote.AutoWalk then
			Network:FireClientConnection(Player, "EmoteAutoWalk", "REMOTE_EVENT", true)
		end

		module.CurrentEmotes[Character] = {
			Name = EmoteName,
			Config = RequiredEmote,
			Data = emoteData,
			JumpPower = oldJumpPower,
			JumpHeight = oldJumpHeight,
			Animation = LoadedTrack,
			Sound = CreatedAudio,
			Connections = {
				jumpConnection,
				healthConnection,
				stoppedConnection
			}
		}
	elseif EmoteType == "Voicelines" then
		local Voiceline = RequiredEmote.Voiceline
		require(game.ReplicatedStorage.Modules.Sounds):PlayVoiceline(Actor, Voiceline, {
			Priority = 50
		})

		if CreatedFunction then
			CreatedFunction({Character = Character})
		end
		if CreatedServerFunction then
			CreatedServerFunction({Character = Character})
		end
	else
		warn("[EMOTEHANDLER] "..tostring(EmoteType).." is not a valid emote type.")
	end
end

module.Start = function()
	Network:SetConnection('PlayEmote', 'REMOTE_EVENT', function(...)		
		module.PlayEmote(...)
	end)
	
	Network:SetConnection('StopEmote', 'REMOTE_EVENT', function(...)
		module.StopEmote(...)
	end)
end

return module