local v_u_1 = game:GetService("SoundService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v5 = v_u_2:WaitForChild("Controllers")
local v_u_6 = require(v5.CycleController)
local v7 = v_u_2:WaitForChild("Packages")
local v8 = require(v7.Net)
local v_u_9 = require(v7.Synchronizer)
local v_u_10 = require(v_u_2.Packages.CreateTween)
local v11 = v_u_2:WaitForChild("Utils")
local v_u_12 = require(v11.StringUtils)
local v_u_13 = v8:RemoteEvent("SoundService/PlayClientSound")
local v_u_14 = {}
local v_u_15 = workspace:WaitForChild("Sounds")
local v_u_16 = TweenInfo.new(3, Enum.EasingStyle.Linear)
local v_u_17 = v4.LocalPlayer
local v_u_30 = {
	["PlaySound"] = function(_, p18, p19, p20)
		local v21 = p20 ~= false
		local v22 = nil
		if typeof(p18) == "Instance" and p18:IsA("Sound") then
			v22 = p18
		elseif typeof(p18) == "string" then
			v22 = v_u_14[p18]
			if not (v22 and v22.Parent) then
				v_u_14[p18] = v_u_12:ReadPath(v_u_2, p18)
				v22 = v_u_14[p18]
			end
		end
		if not v22 then
			return warn((("Sound not found for %*"):format(p18)))
		end
		if not p19 then
			local v_u_23 = v22:Clone()
			v_u_23.Parent = workspace
			local v24
			if v21 then
				local v25 = os.clock()
				v24 = v_u_23
				while not v_u_23.IsLoaded and os.clock() - v25 < 2 do
					task.wait()
				end
				if v_u_23.IsLoaded then
					v_u_23:Play()
				else
					v_u_23:Destroy()
				end
			else
				v_u_23:Play()
				v24 = v_u_23
			end
			v_u_23.Ended:Once(function()
				v_u_23:Destroy()
			end)
			return v24
		end
		local v_u_26 = Instance.new("Part")
		v_u_26.CanCollide = false
		v_u_26.CanQuery = false
		v_u_26.CanTouch = false
		v_u_26.Massless = true
		v_u_26.Anchored = true
		v_u_26.Parent = workspace
		v_u_26.Transparency = 1
		v_u_26.Position = p19
		local v27 = v22:Clone()
		v27.Parent = v_u_26
		local v28
		if v21 then
			local v29 = os.clock()
			v28 = v27
			while not v27.IsLoaded and os.clock() - v29 < 2 do
				task.wait()
			end
			if v27.IsLoaded then
				v27:Play()
			else
				v_u_26:Destroy()
			end
		else
			v27:Play()
			v28 = v27
		end
		v27.Ended:Once(function()
			v_u_26:Destroy()
		end)
		return v28
	end
}
local v_u_31 = 1
local function v_u_33()
	local v32 = v_u_2:GetAttribute("KarkerkarKurkurEvent") and 0 or 1
	if v_u_31 ~= v32 then
		v_u_31 = v32
		v_u_10(v_u_1.Cutscene.WorkspaceSounds.EventMusic, TweenInfo.new(1), {
			["Volume"] = v32
		})
	end
end
function v_u_30.UpdateOST(_)
	v_u_33()
	-- Vérifier le setting Music avant de jouer quoi que ce soit
	local _lp = game:GetService("Players").LocalPlayer
	if _lp then
		local _ok, _sync = pcall(require, game:GetService("ReplicatedStorage").Packages.Synchronizer)
		if _ok and _sync then
			local _ok2, _ch = pcall(_sync.Get, _sync, _lp)
			if _ok2 and _ch then
				local _musicOn = _ch:Get("Settings.Music")
				if _musicOn == false then
					-- Musique désactivée: ne pas jouer de nouvelle OST
					return
				end
			end
		end
	end

	local v34
	if v_u_2:GetAttribute("JulEvent") then
		v34 = v_u_15.Jul
	elseif v_u_2:GetAttribute("ConcertEvent") then
		v34 = v_u_15.Concert
	elseif v_u_2:GetAttribute("RapConcertEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("BrazilEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("LanceEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("MexicoEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("AyMiGatitoEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("WerenoiEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("FranceEventPart2") then
		v34 = v_u_15.FranceEventPart2
	elseif v_u_2:GetAttribute("FranceEvent") or v_u_2:GetAttribute("KarkerkarKurkurEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("2026EventSound") then
		v34 = v_u_15["2026"]
	elseif v_u_2:GetAttribute("NorthPoleEventActive") and v_u_17:GetAttribute("InNorthPole") then
		v_u_15.NorthPole.SoundId = "rbxassetid://107646084688905"
		v34 = v_u_15.NorthPole
	elseif v_u_2:GetAttribute("WinterHourEvent") then
		v_u_15.WinterHour.SoundId = "rbxassetid://101322060187838"
		v34 = v_u_15.WinterHour
	elseif v_u_2:GetAttribute("IndonesiaEvent") then
		v34 = v_u_15.IndonesiaEvent
	elseif v_u_2:GetAttribute("CrabRave") then
		v34 = v_u_15.CrabRave
	elseif v_u_2:GetAttribute("WerenoiEvent") then
		v34 = v_u_15.Werenoi
	elseif v_u_2:GetAttribute("RainingTacosEvent") then
		v34 = v_u_15.RainingTacos
	elseif v_u_2:GetAttribute("4thOfJulyEvent") then
		v34 = v_u_15["4thOfJuly"]
	elseif v_u_2:GetAttribute("10BVisitsEvent") then
		v34 = v_u_15["10B"]
	elseif v_u_2:GetAttribute("NyanCatsEvent") then
		v34 = v_u_15.NyanCats
	elseif v_u_2:GetAttribute("MarioEvent") then
		v34 = v_u_15.Mario
	elseif v_u_2:GetAttribute("SammyniSpyderiniEvent") then
		v34 = v_u_15["Sammyni Spyderini"]
	elseif v_u_2:GetAttribute("MatteoEvent") or v_u_2:GetAttribute("LosMatteosEvent") then
		v34 = v_u_15.Matteo
	elseif v_u_2:GetAttribute("UFOEvent") then
		v34 = v_u_15.UFO
	elseif v_u_2:GetAttribute("MeowlEvent") then
		v34 = v_u_15.Meowl
	elseif v_u_2:GetAttribute("SkibidiEvent") then
		v34 = v_u_15.Skibidi
	elseif v_u_2:GetAttribute("TrickOrTreatEvent") then
		v34 = v_u_15["Trick or Treat"]
	elseif v_u_2:GetAttribute("ValentinesEvent") then
		v34 = v_u_15.Valentines
	elseif v_u_2:GetAttribute("YinYangEvent") then
		v34 = v_u_15.YinYang
	elseif v_u_2:GetAttribute("GalaxyEvent") then
		v34 = v_u_15.Galaxy
	elseif v_u_2:GetAttribute("Elexir") then
		v34 = v_u_15.Elexir
	elseif v_u_2:GetAttribute("JohnPorkEvent") then
		v34 = v_u_15.JohnPork
	elseif v_u_2:GetAttribute("CyberEvent") then
		v34 = nil
	elseif v_u_2:GetAttribute("MoltenEvent") then
		v34 = v_u_15.Night
	elseif v_u_2:GetAttribute("RainingBurgersEvent") then
		v34 = v_u_15.RainingBurger
	elseif v_u_2:GetAttribute("CandyEvent") then
		v34 = v_u_15.Candy
	elseif v_u_2:GetAttribute("BloodmoonEvent") then
		v34 = v_u_15.Bloodmoon
	elseif v_u_2:GetAttribute("RainbowEvent") then
		v34 = v_u_15.Rainbow
	elseif v_u_2:GetAttribute("BombardiroCrocodiloEvent") then
		v34 = v_u_15["Bombardiro Crocodilo"]
	elseif v_u_2:GetAttribute("ItalyEvent") then
		v34 = v_u_15.Italy
	elseif v_u_6:IsNight() or v_u_2:GetAttribute("LaVaccaEvent") then
		v34 = v_u_15.Night
	else
		v34 = v_u_15.Day
	end
	for _, v_u_35 in v_u_15:GetChildren() do
		if not v_u_35.Name:match("^Ambience_")
			and v_u_35 ~= v_u_15.LaVacca
			and v_u_35 ~= v_u_15.Molten
			and v_u_35 ~= v_u_15["Bombardiro Crocodilo Ambience"]
			-- Suppression de l'exclusion de Concert pour qu'il soit contrôlé normalement
			and v_u_35 ~= v_u_15.RapConcert
			and v_u_35 ~= v_u_15.BrazilEvent
			and v_u_35 ~= v_u_15.LanceEvent1
			and v_u_35 ~= v_u_15.LanceEvent2
			and v_u_35 ~= v_u_15.MexicoEvent
			and v_u_35 ~= v_u_15.FranceEvent
			and v_u_35 ~= v_u_15.AyMiGatito
		then
			local v36 = v_u_35:GetAttribute("DefaultVolume")
			if not v36 then
				v_u_35:SetAttribute("DefaultVolume", v_u_35.Volume)
				v36 = v_u_35.Volume
			end
			if v_u_35 == v34 then
				if not v_u_35.IsPlaying then
					v_u_35.Volume = 0
					v_u_3:Create(v_u_35, v_u_16, {
						["Volume"] = v36
					}):Play()
					v_u_35:Play()
				end
			elseif v_u_35.IsPlaying then
				local v37 = v_u_3:Create(v_u_35, v_u_16, {
					["Volume"] = 0
				})
				v37.Completed:Once(function()
					v_u_35:Stop()
				end)
				v37:Play()
			end
		end
	end
	if v_u_2:GetAttribute("MoltenEvent") == true then
		if not v_u_15.Molten.IsPlaying then
			v_u_15.Molten:Play()
		end
	elseif v_u_15.Molten.IsPlaying then
		v_u_15.Molten:Stop()
	end
	if v_u_2:GetAttribute("BombardiroCrocodiloEventSoundTrack") == true then
		if not v_u_15["Bombardiro Crocodilo Ambience"].IsPlaying then
			v_u_15["Bombardiro Crocodilo Ambience"]:Play()
		end
	elseif v_u_15["Bombardiro Crocodilo Ambience"].IsPlaying then
		v_u_15["Bombardiro Crocodilo Ambience"]:Stop()
	end
	if v_u_2:GetAttribute("Effect_Space") == true then
		if not v_u_15.LaVacca.IsPlaying then
			v_u_15.LaVacca:Play()
		end
	elseif v_u_15.LaVacca.IsPlaying then
		v_u_15.LaVacca:Stop()
	end
	if v_u_2:GetAttribute("GlitchEvent") == true then
		if not v_u_15.Glitch.IsPlaying then
			v_u_15.Glitch:Play()
			v_u_3:Create(v_u_15.Glitch, v_u_16, {
				["Volume"] = 0.1
			}):Play()
			return
		end
	elseif v_u_15.Glitch.IsPlaying and v_u_15.Glitch.Volume > 0.0001 then
		local v38 = v_u_3:Create(v_u_15.Glitch, v_u_16, {
			["Volume"] = 0
		})
		v38:Play()
		v38.Completed:Once(function()
			if v_u_15.Glitch.IsPlaying and v_u_15.Glitch.Volume <= 0.0001 then
				v_u_15.Glitch:Stop()
			end
		end)
	end
end
function v_u_30.UpdateAmbience(_)
	local v39 = {
		["Rain"] = v_u_15:FindFirstChild("Ambience_Rain"),
		["Snow"] = v_u_15:FindFirstChild("Ambience_Snow"),
		["Starfall"] = v_u_15:FindFirstChild("Ambience_Starfall"),
		["Water"] = v_u_15:FindFirstChild("Ambience_Water"),
		["Strawberry"] = v_u_15:FindFirstChild("Ambience_Strawberry"),
		["Extinct"] = v_u_15:FindFirstChild("Ambience_Extinct"),
		["Witching Hour"] = v_u_15:FindFirstChild("Ambience_Witching Hour"),
		["France"] = v_u_15:FindFirstChild("Ambience_FranceEvent"),
		["Radioactive"] = v_u_15:FindFirstChild("Ambience_Radioactive"),
		["Cursed"] = v_u_15:FindFirstChild("Ambience_Cursed"),
		["Divine"] = v_u_15:FindFirstChild("Ambience_Divine"),
		["Cyber"] = v_u_15:FindFirstChild("Ambience_Cyber")
	}
	local v40 = nil
	if v_u_2:GetAttribute("LanceEvent") then
		v40 = nil
	elseif v_u_2:GetAttribute("CyberEvent") then
		v40 = v39.Cyber
	elseif v_u_2:GetAttribute("FranceEventAmbience") then
		v40 = v39.France
	elseif v_u_2:GetAttribute("RadioactiveEvent") then
		v40 = v39.Radioactive
	elseif v_u_2:GetAttribute("CursedEvent") then
		v40 = v39.Cursed
	elseif v_u_2:GetAttribute("DivineEvent") then
		v40 = v39.Divine
	elseif v_u_2:GetAttribute("Starfall") then
		v40 = v39.Starfall
	elseif v_u_2:GetAttribute("Rain") or v_u_2:GetAttribute("LosMatteosEvent") then
		v40 = v39.Rain
	elseif v_u_2:GetAttribute("WaterEvent") then
		v40 = v39.Water
	elseif v_u_2:GetAttribute("Snow") then
		v40 = v39.Snow
	elseif v_u_2:GetAttribute("StrawberryEvent") then
		v40 = v39.Strawberry
	elseif v_u_2:GetAttribute("ExtinctEvent") then
		v40 = v39.Extinct
	elseif v_u_2:GetAttribute("GraveyardEvent") then
		v40 = v39["Witching Hour"]
	elseif v_u_2:GetAttribute("WitchingHourEvent") then
		v40 = v39["Witching Hour"]
	end
	for _, v_u_41 in pairs(v39) do
		if v_u_41 then
			local v42 = v_u_41:GetAttribute("DefaultVolume")
			if not v42 then
				v_u_41:SetAttribute("DefaultVolume", v_u_41.Volume)
				v42 = v_u_41.Volume
			end
			if v_u_41 == v40 then
				if not v_u_41.IsPlaying then
					v_u_41.Volume = 0
					v_u_41:Play()
					v_u_3:Create(v_u_41, v_u_16, {
						["Volume"] = v42
					}):Play()
				end
			elseif v_u_41.IsPlaying then
				local v43 = v_u_3:Create(v_u_41, v_u_16, {
					["Volume"] = 0
				})
				v43.Completed:Once(function()
					v_u_41:Stop()
				end)
				v43:Play()
			end
		end
	end
end
function v_u_30.Start(_)
	v_u_13.OnClientEvent:Connect(function(...)
		v_u_30:PlaySound(...)
	end)
	task.spawn(function()
		while task.wait(1) do
			v_u_30:UpdateOST()
			v_u_30:UpdateAmbience()
		end
	end)
	v_u_9:WaitAndCall(v_u_17, function(p44)
		-- FIX Music: contrôle direct des sons workspace.Sounds
		local function applyMusicSetting(enabled)
			-- Gérer uniquement les SoundGroups (pas workspace.Sounds)
			local wsg = v_u_1:FindFirstChild("Cutscene") and v_u_1.Cutscene:FindFirstChild("WorkspaceSounds")
			if wsg then
				wsg.Volume = enabled and 1 or 0
				local em = wsg:FindFirstChild("EventMusic")
				if em then em.Volume = enabled and 1 or 0 end
				local km = wsg:FindFirstChild("KarkerMusic")
				if km then km.Volume = enabled and 1 or 0 end
			end
		end
		p44:OnChanged("Settings.Music", function(p45)
			applyMusicSetting(p45)
		end, true)

		-- FIX Sound Effects: contrôle SoundGroups + sons SFX dans ReplicatedStorage
		local function applySfxSetting(enabled)
			local vol = enabled and 1 or 0
			-- SoundGroups SFX et Tools
			local sfxGroup = v_u_1:FindFirstChild("Sound Effects")
			if sfxGroup then sfxGroup.Volume = vol end
			local toolsGroup = v_u_1:FindFirstChild("ToolsSounds")
			if toolsGroup then toolsGroup.Volume = vol end
			-- Sons SFX dans ReplicatedStorage.Sounds.Sfx
			local sfxFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Sounds")
			local function setSfxVolume(parent)
				for _, s in ipairs(parent:GetChildren()) do
					if s:IsA("Sound") then
						local dv = s:GetAttribute("DefaultVolume")
						if not dv then s:SetAttribute("DefaultVolume", s.Volume) dv = s.Volume end
						s.Volume = enabled and dv or 0
					elseif s:IsA("Folder") or s:IsA("Configuration") then
						setSfxVolume(s)
					end
				end
			end
			if sfxFolder then setSfxVolume(sfxFolder) end
		end
		p44:OnChanged("Settings.Sound Effects", function(p46)
			applySfxSetting(p46)
		end, true)
	end)
end
return v_u_30