local Ragdolls = require(game.ReplicatedStorage.Modules.Ragdolls)
local Util = require(game.ReplicatedStorage.Modules.Util)

local function SummonActor(actorName, actorType, skinName, Player)
	local Actors = require(game.ReplicatedStorage.Modules.Actors)
	local fakePlayer = {
		Name = "NPC", 
		UserId = math.random(-1000000, -10), 
		Character = game.ServerStorage.Assets.Rigs.Default:Clone(),
		DisplayName = "NPC",
		CharacterAppearanceId = Player and Player.UserId or 261
	}
	setmetatable(fakePlayer, {
		__index = function(self, key)
			return nil
		end,
		__tostring = function()
			return "Instance"
		end,
		__call = function(self, ...)
			return nil
		end
	})
	function fakePlayer:IsA(className)
		return className == "Player"
	end
	function fakePlayer:FindFirstChild()
		return
	end
	function fakePlayer:LoadCharacter()
		fakePlayer.Character:Destroy()
	end
	local fakeActor = Actors:CreateActor(fakePlayer, actorType, actorName, skinName)
	fakePlayer.Character.PrimaryPart.CFrame = Player and Player.Character.PrimaryPart.CFrame or CFrame.new(0, 0, 0)
	local success, data = pcall(function()
		local idle = Util:LoadAnimationFromID(fakePlayer.Character, fakeActor.Config.Animations.Idle)
		idle.Looped = true
		idle:Play()
		fakePlayer.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			task.wait(game.Players.RespawnTime)
			fakePlayer.Character:Destroy()
		end)
		fakePlayer.Character:AddTag(Ragdolls.RagdollTag)
	end)
	if (not success) and data then
		warn("[FAKEACTOR] "..tostring(data))
	end
	return fakePlayer, fakeActor
end

return {
	["!actor"] = function(Player, actorName, actorType, quantity, skinName)
		--[[
			THIS COMMAND WAS PARTIALLY TAKEN FROM CODENAME REDUX!!!
		
			Format:
			!actor ActorName ActorType Quantity(Optional) SkinName(Optional)
			Example:
			!actor Noob Survivor 1 FaceLulzNoob
		]]
		
		quantity = tonumber(quantity)
		
		if actorName == "all" then
			local currentActors = 1
			if actorType ~= "Survivor" and actorType ~= "Killer" then return end
			for _, actor : Folder in pairs(game.ReplicatedStorage.Assets[actorType.."s"]:GetChildren()) do
				if require(actor.Config).Exclusive == true then continue end
				task.spawn(SummonActor, actor.Name, actorType, nil, Player)
				if quantity and quantity == currentActors then
					break
				else
					currentActors+=1
				end
			end
			return
		end
		
		for i = 1, quantity or 1 do
			SummonActor(actorName, actorType, skinName, Player)
		end
	end,
	["!kill"] = function(Player, playerType)
		if workspace.Players:FindFirstChild(playerType) then
			for i, v : Instance in ipairs(workspace.Players[playerType]:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
					v:FindFirstChildOfClass("Humanoid").Health = 0
				end
			end 
		end
	end,
}