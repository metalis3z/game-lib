-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")

local CycleController = require(Controllers.CycleController)

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)

local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Utils = ReplicatedStorage:WaitForChild("Utils")

local StringUtils = require(Utils.StringUtils)
local soundServicePlayClientSound = Net:RemoteEvent("SoundService/PlayClientSound")
local currentOST = nil
local pendingOST = nil
local pendingOSTTime = 0
local OST_DEBOUNCE = 0.1
local data = {}
local activeTweens = {}

local Sounds = workspace:WaitForChild("Sounds")

local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear)

local LocalPlayer = Players.LocalPlayer

local SoundController = {

	PlaySound = function(_, isAObj, position, flag)

		flag = flag ~= false
		local cloneObj = nil

		if typeof(isAObj) == "Instance" and isAObj:IsA("Sound") then
			cloneObj = isAObj

		elseif typeof(isAObj) == "string" then

			if isAObj:match("^rbxassetid://") or isAObj:match("^%d+$") then
				local sound = Instance.new("Sound")
				sound.SoundId = isAObj:match("^%d+$") and ("rbxassetid://" .. isAObj) or isAObj
				cloneObj = sound

			else
				local dataData = data[isAObj]
				if dataData and dataData.Parent then
					cloneObj = dataData
				else
					data[isAObj] = StringUtils:ReadPath(ReplicatedStorage, isAObj)
					cloneObj = data[isAObj]
				end
			end
		end

		if not cloneObj then
			return warn((("Sound not found for %s"):format(tostring(isAObj))))
		else
			local v21 = cloneObj

			if not position then
				local tweenObj = cloneObj:Clone()

				local attr = tweenObj:GetAttribute("SoundId")
				if attr then
					tweenObj:SetAttribute("SoundId", nil)
					tweenObj.SoundId = attr
				end

				tweenObj.Parent = workspace
				v21 = tweenObj

				if flag then
					local start = os.clock()
					while not tweenObj.IsLoaded and os.clock() - start < 2 do
						task.wait()
					end

					if tweenObj.IsLoaded then
						tweenObj:Play()
					else
						tweenObj:Destroy()
					end
				else
					tweenObj:Play()
				end

				local playCount = tweenObj:GetAttribute("PlayCount") or 1
				local currentCount = 1
				if playCount > 1 then
					tweenObj.Ended:Connect(function()
						currentCount += 1
						if currentCount <= playCount then
							tweenObj:Play()
						else
							tweenObj:Destroy()
						end
					end)
				else
					tweenObj.Ended:Once(function()
						tweenObj:Destroy()
					end)
				end

				return v21

			else
				local part = Instance.new("Part")
				part.CanCollide = false
				part.CanQuery = false
				part.CanTouch = false
				part.Massless = true
				part.Anchored = true
				part.Transparency = 1
				part.Position = position
				part.Parent = workspace

				local tweenObj = cloneObj:Clone()

				local attr = tweenObj:GetAttribute("SoundId")
				if attr then
					tweenObj:SetAttribute("SoundId", nil)
					tweenObj.SoundId = attr
				end

				tweenObj.Parent = part
				v21 = tweenObj

				if flag then
					local start = os.clock()
					while not tweenObj.IsLoaded and os.clock() - start < 2 do
						task.wait()
					end

					if tweenObj.IsLoaded then
						tweenObj:Play()
					else
						part:Destroy()
					end
				else
					tweenObj:Play()
				end

				local playCount = tweenObj:GetAttribute("PlayCount") or 1
				local currentCount = 1
				if playCount > 1 then
					tweenObj.Ended:Connect(function()
						currentCount += 1
						if currentCount <= playCount then
							tweenObj:Play()
						else
							part:Destroy()
						end
					end)
				else
					tweenObj.Ended:Once(function()
						part:Destroy()
					end)
				end

				return v21
			end
		end
	end
}
local flag_2 = 1
local function updateEventMusicVolume()

	local attribute = ReplicatedStorage:GetAttribute("KarkerkarKurkurEvent") and 0 or 1
	if flag_2 == attribute then
		return
	else
		flag_2 = attribute
		CreateTween(SoundService.Cutscene.WorkspaceSounds.EventMusic, TweenInfo.new(1), {
			Volume = attribute
		})
		return
	end
end

SoundController.UpdateOST = function(_)
	local displayText = nil
	updateEventMusicVolume()

	if ReplicatedStorage:GetAttribute("FranceEvent") then
		displayText = Sounds.FranceEvent
	elseif ReplicatedStorage:GetAttribute("SmurfCatEvent") then
		displayText = Sounds.SmurfCat
	elseif ReplicatedStorage:GetAttribute("CaseohMC") then
		displayText = Sounds.CaseohMc
	elseif ReplicatedStorage:GetAttribute("CaseohBK") then
		displayText = Sounds.CaseohBK
	elseif ReplicatedStorage:GetAttribute("GraipussMedussiEvent") then
		displayText = Sounds.GraipussMedussi
	elseif ReplicatedStorage:GetAttribute("1YearEvent") then
		displayText = nil
	elseif ReplicatedStorage:GetAttribute("LanceEventPart2") then
		displayText = Sounds.LanceEvent2
	elseif ReplicatedStorage:GetAttribute("LanceEvent1Music") then
		displayText = Sounds.LanceEvent1
	elseif ReplicatedStorage:GetAttribute("LanceEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("RipMyGrannySharedPhase") then
		displayText = Sounds.RipMyGranny
	elseif ReplicatedStorage:GetAttribute("RipMyGrannyEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("ConcertEventMusic") then
		displayText = Sounds.Concert
	elseif ReplicatedStorage:GetAttribute("ConcertEvent") then
		displayText = nil
	elseif ReplicatedStorage:GetAttribute("RapConcertEventMusic") then
		displayText = Sounds.RapConcert
	elseif ReplicatedStorage:GetAttribute("RapConcertEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("BrazilEventMusic") then
		displayText = Sounds.BrazilEvent
	elseif ReplicatedStorage:GetAttribute("BrazilEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("MexicoEventMusic") then
		displayText = Sounds.MexicoEvent
	elseif ReplicatedStorage:GetAttribute("MexicoEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("IndonesiaEventPart2") then
		displayText = Sounds.IndonesiaEventPart2
	elseif ReplicatedStorage:GetAttribute("IndonesiaEventMusic") then
		displayText = Sounds.IndonesiaEvent
	elseif ReplicatedStorage:GetAttribute("IndonesiaEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("AyMiGatitoEventMusic") then
		displayText = Sounds.AyMiGatito
	elseif ReplicatedStorage:GetAttribute("AyMiGatitoEvent") then
		displayText = nil

	elseif ReplicatedStorage:GetAttribute("KarkerkarKurkurEvent") then
		displayText = nil
	elseif ReplicatedStorage:GetAttribute("2026Event") then
		displayText = Sounds["2026"]
	elseif ReplicatedStorage:GetAttribute("NorthPoleEventActive") and LocalPlayer:GetAttribute("InNorthPole") then
		displayText = Sounds.NorthPole
	elseif ReplicatedStorage:GetAttribute("GingerbreadTownEvent") then
		displayText = Sounds.GingerbreadTown
	elseif ReplicatedStorage:GetAttribute("WinterHourEvent") then
		displayText = Sounds.WinterHour
	elseif ReplicatedStorage:GetAttribute("LaserCityEvent") then
		displayText = Sounds["Laser City"]
	elseif ReplicatedStorage:GetAttribute("RainingBurgersEvent") then
		displayText = Sounds.RainingBurgers
	else
		displayText = if ReplicatedStorage:GetAttribute("CrabRave") then Sounds.CrabRave 
			else if ReplicatedStorage:GetAttribute("RainingTacosEvent") then Sounds.RainingTacos 
			else if ReplicatedStorage:GetAttribute("4thOfJulyEvent") then Sounds["4thOfJuly"] 
			else if ReplicatedStorage:GetAttribute("10BVisitsEvent") then Sounds["10B"] 
			else if ReplicatedStorage:GetAttribute("NyanCatsEvent") then Sounds.NyanCats 
			else if ReplicatedStorage:GetAttribute("SammyniSpyderiniEvent") then Sounds["Sammyni Spyderini"] 
			else if ReplicatedStorage:GetAttribute("MatteoEvent") or ReplicatedStorage:GetAttribute("LosMatteosEvent") then Sounds.Matteo 
			else if ReplicatedStorage:GetAttribute("UFOEvent") then Sounds.UFO 
			else if ReplicatedStorage:GetAttribute("MeowlEvent") then Sounds.Meowl 
			else if ReplicatedStorage:GetAttribute("SkibidiEvent") then Sounds.Skibidi 
			else if ReplicatedStorage:GetAttribute("JohnPorkEvent") then Sounds["John Pork"]
			else if ReplicatedStorage:GetAttribute("TrickOrTreatEvent") then Sounds["Trick or Treat"] 
			else if ReplicatedStorage:GetAttribute("ValentinesEvent") then Sounds.Valentines 
			else if ReplicatedStorage:GetAttribute("YinYangEvent") then Sounds.YinYang 
			else if ReplicatedStorage:GetAttribute("GalaxyEvent") then Sounds.Galaxy 
			else if ReplicatedStorage:GetAttribute("MoltenEvent") then Sounds.Night 
			else if ReplicatedStorage:GetAttribute("CandyEvent") then Sounds.Candy 
			else if ReplicatedStorage:GetAttribute("BloodmoonEvent") then Sounds.Bloodmoon 
			else if ReplicatedStorage:GetAttribute("RainbowEvent") then Sounds.Rainbow 
			else if ReplicatedStorage:GetAttribute("BombardiroCrocodiloEvent") then Sounds["Bombardiro Crocodilo"] 
			else if CycleController:IsNight() or ReplicatedStorage:GetAttribute("LaVaccaEvent") then Sounds.Night 
			else Sounds.Day
	end

	if displayText ~= pendingOST then
		pendingOST = displayText
		pendingOSTTime = os.clock()
	end
	if pendingOST ~= currentOST and os.clock() - pendingOSTTime < OST_DEBOUNCE then
		return
	end
	local ostChanged = pendingOST ~= currentOST
	currentOST = pendingOST
	displayText = currentOST

	for _, child in Sounds:GetChildren() do
		if not child.Name:match("^Ambience_")
			and child ~= Sounds.LaVacca
			and child ~= Sounds.Molten
			and child ~= Sounds["Bombardiro Crocodilo Ambience"]
		then
			local defaultVol = tonumber(child:GetAttribute("DefaultVolume"))
			if not defaultVol then
				defaultVol = child.Volume
				child:SetAttribute("DefaultVolume", defaultVol)
			end

			if child == displayText then
				local stuckSilent = child.IsPlaying and child.Volume <= 1e-4 and not activeTweens[child]
				local needsRestart = ostChanged or not child.IsPlaying or stuckSilent

				if needsRestart then
					if activeTweens[child] then
						activeTweens[child]:Cancel()
						activeTweens[child] = nil
					end
					local wasPlaying = child.IsPlaying
					local volBefore = child.Volume
					if not child.IsPlaying or child.Volume <= 1e-4 then
						child.Volume = 0
						if not child.IsPlaying then
							child:Play()
						end
					end
					local tweenIn = TweenService:Create(child, tweenInfo, { Volume = defaultVol })
					tweenIn:Play()
					activeTweens[child] = tweenIn
				end

			elseif ostChanged and child.IsPlaying then
				if activeTweens[child] then
					activeTweens[child]:Cancel()
					activeTweens[child] = nil
				end
				local tweenOut = TweenService:Create(child, tweenInfo, { Volume = 0 })
				tweenOut.Completed:Once(function()
					if child ~= currentOST and child.Volume <= 1e-4 then
						child:Stop()
					end
				end)
				tweenOut:Play()
				activeTweens[child] = tweenOut
			end
		end
	end
	if ReplicatedStorage:GetAttribute("MoltenEvent") == true then
		if not Sounds.Molten.IsPlaying then
			Sounds.Molten:Play()
		end
	elseif Sounds.Molten.IsPlaying then
		Sounds.Molten:Stop()
	end

	if ReplicatedStorage:GetAttribute("BombardiroCrocodiloEventSoundTrack") == true then
		if not Sounds["Bombardiro Crocodilo Ambience"].IsPlaying then
			Sounds["Bombardiro Crocodilo Ambience"]:Play()
		end
	elseif Sounds["Bombardiro Crocodilo Ambience"].IsPlaying then
		Sounds["Bombardiro Crocodilo Ambience"]:Stop()
	end

	if ReplicatedStorage:GetAttribute("Effect_Space") == true then
		if not Sounds.LaVacca.IsPlaying then
			Sounds.LaVacca:Play()
		end
	elseif Sounds.LaVacca.IsPlaying then
		Sounds.LaVacca:Stop()
	end

	if ReplicatedStorage:GetAttribute("GlitchEvent") == true then
		if not Sounds.Glitch.IsPlaying then
			Sounds.Glitch:Play()
			TweenService:Create(Sounds.Glitch, tweenInfo, {
				Volume = 0.1
			}):Play()
			return
		end
	elseif Sounds.Glitch.IsPlaying and Sounds.Glitch.Volume > 1.0E-4 then
		local tweenObj_5 = TweenService:Create(Sounds.Glitch, tweenInfo, {
			Volume = 0
		})
		tweenObj_5:Play()
		tweenObj_5.Completed:Once(function()

			if Sounds.Glitch.IsPlaying and Sounds.Glitch.Volume <= 1.0E-4 then
				Sounds.Glitch:Stop()
			end
		end)
	end
end

SoundController.UpdateAmbience = function(_)

	local ref1 = {
		Rain = Sounds:FindFirstChild("Ambience_Rain"),
		Snow = Sounds:FindFirstChild("Ambience_Snow"),
		Starfall = Sounds:FindFirstChild("Ambience_Starfall"),
		Water = Sounds:FindFirstChild("Ambience_Water"),
		Strawberry = Sounds:FindFirstChild("Ambience_Strawberry"),
		Extinct = Sounds:FindFirstChild("Ambience_Extinct"),
		["Witching Hour"] = Sounds:FindFirstChild("Ambience_Witching Hour"),
		Indonesia = Sounds:FindFirstChild("Ambience_IndonesiaEvent"),
		Radioactive = Sounds:FindFirstChild("Ambience_Radioactive"),
		Cursed = Sounds:FindFirstChild("Ambience_Cursed"),
		Divine = Sounds:FindFirstChild("Ambience_Divine"),
		Cyber = Sounds:FindFirstChild("Ambience_Cyber"),
		Patrick = Sounds:FindFirstChild("Ambience_StPatricks"),
		Eid = Sounds:FindFirstChild("Ambience_Eid"),
		Easter = Sounds:FindFirstChild("Ambience_Easter"),
		EggCity = Sounds:FindFirstChild("Ambience_EggCity"),
		BackroomsInside = Sounds:FindFirstChild("Ambience_BackroomsInside")
	}
	local val3 = nil
	if ReplicatedStorage:GetAttribute("LanceEvent") or ReplicatedStorage:GetAttribute("RipMyGrannyEvent") then
		val3 = nil
	elseif ReplicatedStorage:GetAttribute("IndonesiaEventAmbience") then
		val3 = ref1.Indonesia
	elseif ReplicatedStorage:GetAttribute("RadioactiveEvent") then
		val3 = ref1.Radioactive
	elseif ReplicatedStorage:GetAttribute("CursedEvent") then
		val3 = ref1.Cursed
	elseif ReplicatedStorage:GetAttribute("DivineEvent") then
		val3 = ref1.Divine
	elseif ReplicatedStorage:GetAttribute("CyberEvent") then
		val3 = ref1.Cyber
	elseif ReplicatedStorage:GetAttribute("StPatricksEvent") then
		val3 = ref1.Patrick
	elseif ReplicatedStorage:GetAttribute("Starfall") then
		val3 = ref1.Starfall
	elseif ReplicatedStorage:GetAttribute("Rain") or ReplicatedStorage:GetAttribute("LosMatteosEvent") then
		val3 = ref1.Rain
	elseif ReplicatedStorage:GetAttribute("WaterEvent") then
		val3 = ref1.Water
	elseif ReplicatedStorage:GetAttribute("Snow") then
		val3 = ref1.Snow
	elseif ReplicatedStorage:GetAttribute("StrawberryEvent") then
		val3 = ref1.Strawberry
	elseif ReplicatedStorage:GetAttribute("EidEvent") then
		val3 = ref1.Eid
	elseif ReplicatedStorage:GetAttribute("EggCityEvent") then
		val3 = ref1.EggCity
	elseif ReplicatedStorage:GetAttribute("EasterEvent") then
		val3 = ref1.Easter
	elseif ReplicatedStorage:GetAttribute("ExtinctEvent") then
		val3 = ref1.Extinct
	elseif ReplicatedStorage:GetAttribute("GraveyardEvent") then
		val3 = ref1["Witching Hour"]
	elseif ReplicatedStorage:GetAttribute("WitchingHourEvent") then
		val3 = ref1["Witching Hour"]
	end

	for _, v43Entry in pairs(ref1) do
		if v43Entry then
			local l_v46_Attribute_0 = v43Entry:GetAttribute("DefaultVolume")
			if not l_v46_Attribute_0 then
				v43Entry:SetAttribute("DefaultVolume", v43Entry.Volume)
				l_v46_Attribute_0 = v43Entry.Volume
			end

			if activeTweens[v43Entry] then
				activeTweens[v43Entry]:Cancel()
				activeTweens[v43Entry] = nil
			end

			if v43Entry == val3 then
				if not v43Entry.IsPlaying or v43Entry.Volume <= 1e-4 then
					v43Entry.Volume = 0
					if not v43Entry.IsPlaying then
						v43Entry:Play()
					end
				end
				local tweenIn = TweenService:Create(v43Entry, tweenInfo, { Volume = l_v46_Attribute_0 })
				tweenIn:Play()
				activeTweens[v43Entry] = tweenIn
			elseif v43Entry.IsPlaying then
				local tweenObj_6 = TweenService:Create(v43Entry, tweenInfo, { Volume = 0 })
				tweenObj_6.Completed:Once(function()
					if v43Entry ~= val3 and v43Entry.Volume <= 1e-4 then
						v43Entry:Stop()
					end
				end)
				tweenObj_6:Play()
				activeTweens[v43Entry] = tweenObj_6
			end
		end
	end
end

SoundController.Start = function(_)
	soundServicePlayClientSound.OnClientEvent:Connect(function(...)
		SoundController:PlaySound(...)
	end)
	task.spawn(function()
		while task.wait(1) do
			SoundController:UpdateOST()
			SoundController:UpdateAmbience()
		end
	end)
	Synchronizer:WaitAndCall(LocalPlayer, function(onChangedObj)
		onChangedObj:OnChanged("Settings.Music", function(val4)
			SoundService:WaitForChild("Cutscene"):WaitForChild("WorkspaceSounds").Volume = val4 and 1 or 0
		end, true)
		onChangedObj:OnChanged("Settings.Sound Effects", function(val5)
			SoundService:WaitForChild("Sound Effects").Volume = val5 and 1 or 0
		end, true)
		onChangedObj:OnChanged("Settings.Sound Effects", function(val6)
			SoundService:WaitForChild("ToolsSounds").Volume = val6 and 1 or 0
		end, true)
	end)
	SoundController:UpdateOST()
end
return SoundController