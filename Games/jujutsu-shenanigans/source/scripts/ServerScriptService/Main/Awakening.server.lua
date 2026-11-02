--// Services \\--

local SvSt = game:GetService('ServerStorage')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local Players = game.Players



--// Assets \\--

local Assets = SvSt.Assets


local Animations = Assets.Animations
local Sounds = Assets.Sounds


local AwkAnims = Animations.Awakenings
local AwkSounds = Sounds.Awakenings



--// Modules \\--

local RpModules = RS.Modules

local AnimationEvents = require(RpModules.AnimationEvents)


local SvModules = SvSt.Modules

local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local iFramesHandler = require(SvModules.iFramesService)
local MovesetHandler = require(SvModules.MovesetHandler)
local WeaponsHandler = require(SvModules.WeaponsHandler)
local PlayerClass = require(SvModules.PlayerClass)
local SoundsModule = require(SvModules.SoundsModule)
local HitboxHandler = require(SvModules.HitboxHandler)
local DamageHandler = require(SvModules.DamageHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local NewKnockback = require(SvModules.BodymoverService)



--// Remotes \\--

local RpRemotes = RS.Remotes


local AwakeningRemotes = RpRemotes.Awakening

local AwakeningSet = AwakeningRemotes.Set
local AwakeningGet = AwakeningRemotes.Get


local ReplicateRemotes = RpRemotes.Replicate

local ReplicateSet = ReplicateRemotes.Set
local ReplicateGet = ReplicateRemotes.Get


local Comms = RpRemotes.Comunicator

local CommsSet = Comms.Set
local CommsGet = Comms.Get



--// Events \\--

local AwakeningSvEvent = AwakeningSet.OnServerEvent



--// Functions \\--

local function EndAwakening(Player: Player, Awk0C: RBXScriptConnection, AwkTween: Tween, ByPass: BoolValue, DefaultHumDesc: HumanoidDescription)	
	if not ByPass then
		if Player.Commands.InfiniteAwk.Value == true then return end
	end


	local Character = Player.Character
	local Humanoid: Humanoid = Character.Humanoid
	local HumRP: BasePart = Character.HumanoidRootPart


	if Awk0C then
		Awk0C:Disconnect()
		Awk0C = nil
	end

	if AwkTween then
		AwkTween:Cancel()
		AwkTween = nil
	end

	local CurrentMoveset: string = Player.Configuration.Moveset.Value
	if CurrentMoveset == 'Kokushibo' then
		Character.Sword:RemoveTag('CantSeath')
		ReplicateSet:FireAllClients('Awakening', { Char = Character, Awk = 'Kokushibo', Stage = 'ChangeSword' })

		task.wait(.5)

		WeaponsHandler:RemoveAwakeningSword(Character)
	elseif CurrentMoveset == "Okarun" then
		Character:SetAttribute("Awakened",nil)
	elseif CurrentMoveset == "Strongest of Today" then
		Character:SetAttribute("Aura",nil)				
	end

	Character:RemoveTag('Awakened')


	ReplicateSet:FireAllClients('StopAwakeningMusics', { MusAtt = HumRP.AwakeningMusic; })


	if DefaultHumDesc then
		Humanoid:ApplyDescription(DefaultHumDesc)
	end

	task.delay(.5, function()
		MovesetHandler:AddBaseMoveset(Player, Player.Configuration.Moveset.Value)

		AwakeningSet:FireClient(Player, 'ShowAwkBar')
		AwakeningSet:FireClient(Player, 'ShowHotbar')
	end)
end

local function AddAwakeningOutfit(Player: Player, MovesetName: string)
	task.spawn(function()
		if not Player.Character or not Player.Character:FindFirstChild('Humanoid') then return end

		local Humanoid: Humanoid = Player.Character.Humanoid

		local playerClass = PlayerClass:GetClass(Player.UserId)
		if playerClass and playerClass.AwakeningOutfits[MovesetName] and Players:GetHumanoidDescriptionFromOutfitId(playerClass.AwakeningOutfits[MovesetName]) ~= Players:GetHumanoidDescriptionFromUserId(Player.UserId) then
			Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromOutfitId(playerClass.AwakeningOutfits[MovesetName]))
		end
	end)
end

local AwakeningAnimations = {
	
	['Honored One'] = function(Player: Player)
		local Character = Player.Character

		if not Character then return end

		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true)
		local Ended = false

		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local AnimTrack = AnimationService:getAnimationTrack(Character, AwkAnims.Gojo.Ult)
		local AnimEvents = AnimationEvents.new(AnimTrack)

		AnimEvents:AddEvent('Stopped', {}, function()
			StunHandler:Unstun(Character, Stun)
			iFramesHandler:RemoveAlliFrames(Character)

			Ended = true
		end)

		AnimationService:playAnimation(Character, AwkAnims.Gojo.Ult)
		AnimEvents:Play()

		repeat task.wait() until Ended == true or Player.Character == nil
	end,
	
	['Vessel'] = function(Player: Player)
		local Character = Player.Character

		if not Character then return end

		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true)
		local Ended = false

		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local AnimTrack = AnimationService:getAnimationTrack(Character, AwkAnims.Vessel.Ult)
		local AnimEvents = AnimationEvents.new(AnimTrack)

		AnimEvents:AddEvent('Stopped', {}, function()
			local SucunaValue = Instance.new("BoolValue", Character)
			SucunaValue.Name = "SucunaValue"
			
			StunHandler:Unstun(Character, Stun)
			iFramesHandler:RemoveAlliFrames(Character)

			Ended = true
		end)

		AnimationService:playAnimation(Character, AwkAnims.Vessel.Ult)
		AnimEvents:Play()

		repeat task.wait() until Ended == true or Player.Character == nil
	end,
}

local dbAwakeningAnimations = {

	--[[['Honored One'] = function(Player: Player)
		local Character = Player.Character

		if not Character then return end

		iFramesHandler:AddAlliFrames(Character)
		local Stun = StunHandler:Stun(Character, nil, true)
		local Ended = false

		local HumRP: BasePart = Character.HumanoidRootPart
		local Humanoid: Humanoid = Character.Humanoid

		local AnimTrack = AnimationService:getAnimationTrack(Character, AwkAnims.Gojo.Ult)
		local AnimEvents = AnimationEvents.new(AnimTrack)

		AnimEvents:AddEvent('Stopped', {}, function()
			StunHandler:Unstun(Character, Stun)
			iFramesHandler:RemoveAlliFrames(Character)

			Ended = true
		end)

		AnimationService:playAnimation(Character, AwkAnims.Gojo.Ult)
		AnimEvents:Play()

		repeat task.wait() until Ended == true or Player.Character == nil
	end,]]

}



--// Connections \\--

AwakeningSvEvent:Connect(function(Player: Player, Stage: string)
	local Character = Player.Character

	if Character == nil or Character.Parent == nil or not Character:FindFirstChild('Humanoid') or (Character:FindFirstChild('Humanoid') and Character.Humanoid.Health <= 0) or not Character:FindFirstChild('HumanoidRootPart') then return end

	local Humanoid: Humanoid = Character.Humanoid
	local HumRP: BasePart = Character.HumanoidRootPart

	if Stage == 'Awakening' then
		local AwkProgressObj: NumberValue = Player.AwakeningProgress

		if AwkProgressObj.Value < 100 or Character:HasTag('Stunned') or Character:HasTag('Awakened') then return end


		local CurrentMoveset = Player.Configuration.Moveset.Value
		Character:AddTag('Awakened')
		Humanoid.Health = Humanoid.MaxHealth

		iFramesHandler:AddAlliFrames(Character)

		CommsSet:FireClient(Player, 'HideHotbar')
		CommsSet:FireClient(Player, 'HideAwkbar')

		local DefaultHumDesc = Humanoid:GetAppliedDescription()

		if AwakeningAnimations[CurrentMoveset] then
			AwakeningAnimations[CurrentMoveset](Player)

			CommsSet:FireClient(Player, 'ShowHotbar')
			if CurrentMoveset ~= 'KJ' then
				CommsSet:FireClient(Player, 'ShowAwkbar')
			end
		else
			AddAwakeningOutfit(Player, CurrentMoveset)

			task.delay(.5, function()
				CommsSet:FireClient(Player, 'ShowHotbar')
				CommsSet:FireClient(Player, 'ShowAwkbar')
			end)
		end

		iFramesHandler:RemoveAlliFrames(Character)
		MovesetHandler:AddAwakeningMoveset(Player, Player.Configuration.Moveset.Value)


		local Ended = false
		local AwkTween = TS:Create(AwkProgressObj, TweenInfo.new(60, Enum.EasingStyle.Linear), { Value = 0 })

		local Awk0C: RBXScriptConnection
		Awk0C = AwkProgressObj:GetPropertyChangedSignal('Value'):Connect(function()
			if Ended == false and AwkProgressObj.Value <= 0 then
				Ended = true
				Awk0C:Disconnect()

				EndAwakening(Player, Awk0C, AwkTween, nil, DefaultHumDesc)
			end
		end)

		Humanoid.Died:Once(function()
			if Ended == false then
				Ended = true

				EndAwakening(Player, Awk0C, AwkTween, true, DefaultHumDesc)
			end
		end)

		AwkTween.Completed:Once(function()
			if Ended == false then
				Ended = true

				EndAwakening(Player, Awk0C, AwkTween, nil, DefaultHumDesc)
			end
		end)

		if CurrentMoveset ~= 'KJ' then
			AwkTween:Play()
		end
	elseif Stage == "DoubleAwakening" then
		local AwkProgressObj = Player.AwakeningProgress
		local db = Player.DoubleAwakeningProgress
		
		if db.Value < 100 or Character:HasTag('Stunned') then return end
		
		db.Value = 0
		AwkProgressObj.Value = 100

		local CurrentMoveset = Player.Configuration.Moveset.Value
		Character:AddTag('dbAwakened')
		Humanoid.Health = Humanoid.MaxHealth

		iFramesHandler:AddAlliFrames(Character)

		CommsSet:FireClient(Player, 'HideHotbar')
		CommsSet:FireClient(Player, 'HideAwkbar')

		local DefaultHumDesc = Humanoid:GetAppliedDescription()

		if AwakeningAnimations[CurrentMoveset] then
			AwakeningAnimations[CurrentMoveset](Player)

			CommsSet:FireClient(Player, 'ShowHotbar')
			if CurrentMoveset ~= 'KJ' then
				CommsSet:FireClient(Player, 'ShowAwkbar')
			end
		else
			AddAwakeningOutfit(Player, CurrentMoveset)

			task.delay(.5, function()
				CommsSet:FireClient(Player, 'ShowHotbar')
				CommsSet:FireClient(Player, 'ShowAwkbar')
			end)
		end

		iFramesHandler:RemoveAlliFrames(Character)
		MovesetHandler:AdddoubleAwakeningMoveset(Player, Player.Configuration.Moveset.Value)

		local Ended = false
		local AwkTween = TS:Create(AwkProgressObj, TweenInfo.new(60, Enum.EasingStyle.Linear), { Value = 0 })
		
		local Awk0C: RBXScriptConnection
		Awk0C = AwkProgressObj:GetPropertyChangedSignal('Value'):Connect(function()
			if Ended == false and AwkProgressObj.Value <= 0 then
				Ended = true
				Awk0C:Disconnect()

				EndAwakening(Player, Awk0C, AwkTween, nil, DefaultHumDesc)
			end
		end)

		Humanoid.Died:Once(function()
			if Ended == false then
				Ended = true

				EndAwakening(Player, Awk0C, AwkTween, true, DefaultHumDesc)
			end
		end)

		AwkTween.Completed:Once(function()
			if Ended == false then
				Ended = true

				EndAwakening(Player, Awk0C, AwkTween, nil, DefaultHumDesc)
			end
		end)
	end
end)