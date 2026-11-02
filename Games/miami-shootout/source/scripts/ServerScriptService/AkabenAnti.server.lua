-- akaben's anti exploit

local HttpService = game:GetService("HttpService")
local Gun = game.ServerStorage
local Request = game.ReplicatedStorage.Request

-- for everythingK to edit
local pban = false
local banPlayerForExploiting = false
local kickPlayerForExploiting = false
local killPlayerForExploiting = true

local bannedTable = {}

local datastore = game:GetService("DataStoreService")
local bans = datastore:GetDataStore("exploiters")

game.Players.PlayerAdded:Connect(function(p)
	if bans:GetAsync(p.UserId) then
		p:Kick("You are banned from the game.")
	end
	if table.find(bannedTable,p.UserId) then
		p:Kick("You are banned from the server.")
	end
end)

function punishExploiter(p)
	
	warn(p.UserId.. " gettin punished")
	
	if killPlayerForExploiting then
		p.Character.Backpack:ClearAllChildren()
		for i,v in pairs(p.Character:GetChildren()) do
			if v:IsA("Tool") then
				v:Destroy()
			end
		end
		p.Character.Humanoid.Health = 0
	end
	
	if banPlayerForExploiting then
		
		if pban == true then
			bans:SetAsync(p.UserId,true)
		else
			table.insert(bannedTable,p.UserId)
		end
		
		p:Kick("You are banned.")
		
	elseif kickPlayerForExploiting then
		p:Kick("You have been kicked.")
	end
	
	if not killPlayerForExploiting and not kickPlayerForExploiting and not banPlayerForExploiting then
		warn("Exploiter detected "..p.Name.. " "..p.UserId.. ", was not punished due to config not punishing exploiters.")
	end
	
end

function CompareTables(arr1, arr2)
	for i, v in pairs(arr1) do
		if (typeof(v) == "table") then
			if typeof(arr2[i]) == "table" then
				if (CompareTables(arr2[i], v) == false) then
					return false
				end
			else
				local matched = true
				for ii, vv in pairs(v) do
					if (vv ~= arr2[i]) then
						matched = false
						break
					end
				end
				if not matched then
					return false
				end
			end
		else
			if (v ~= arr2[i]) then
				return false
			end
		end
	end
	return true
end

function SecureSettings(Player, Tool, GunFolder, HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	if Player and Tool then
		local Folder = GunFolder:FindFirstChild(Tool.Name)
		if Folder then
			local PreNewModule = Folder:FindFirstChild("Setting")
			if PreNewModule then
				local Module = require(PreNewModule)
				
				-- rebuilding data I hate this fe gun kit
				
				local HitEffectData2 = {Module.HitEffectEnabled,Module.HitSoundIDs,Module.HitSoundPitchMin,Module.HitSoundPitchMax,Module.HitSoundVolume,PreNewModule.Parent:FindFirstChild("GunScript_LocalNew"):WaitForChild("HitEffect"),Module.CustomHitEffect}
				local BloodEffectData2 = {Module.BloodEnabled,Module.HitCharSndIDs,Module.HitCharSndPitchMin,Module.HitCharSndPitchMax,Module.HitCharSndVolume,PreNewModule.Parent:FindFirstChild("GunScript_LocalNew"):WaitForChild("BloodEffect")}
				local BulletHoleData2 = {Module.BulletHoleEnabled,Module.BulletHoleSize,Module.BulletHoleTexture,Module.PartColor,Module.BulletHoleVisibleTime,Module.BulletHoleFadeTime}
				local ExplosiveData2 = {Module.ExplosiveEnabled,Module.ExplosionRadius,Module.ExplosionSoundEnabled,Module.ExplosionSoundIDs,Module.ExplosionSoundPitchMin,Module.ExplosionSoundPitchMax,Module.ExplosionSoundVolume,Module.CustomExplosion,PreNewModule.Parent:FindFirstChild("GunScript_LocalNew"):WaitForChild("ExplosionEffect")}
				local BulletData2 = {Module.BulletTracerEnabled,Module.BulletTracerOffset0,Module.BulletTracerOffset1,PreNewModule.Parent:FindFirstChild("GunScript_LocalNew"):WaitForChild("TracerEffect"),Module.BulletParticleEnaled,PreNewModule.Parent:FindFirstChild("GunScript_LocalNew"):WaitForChild("ParticleEffect"),Module.Range,Module.BulletSpeed,Module.DropGravity,Module.WindOffset,Module.BulletSize,Module.BulletColor,Module.BulletTransparency,Module.BulletMaterial,Module.BulletShape,Module.BulletMeshEnabled,Module.BulletMeshID,Module.BulletTextureID,Module.BulletMeshScale}
				local WhizData2 = {Module.WhizSoundEnabled,Module.WhizSoundID,Module.WhizSoundVolume,Module.WhizSoundPitchMin,Module.WhizSoundPitchMax,Module.WhizDistance}
				local BulletLightData2 = {Module.BulletLightEnabled,Module.BulletLightBrightness,Module.BulletLightColor,Module.BulletLightRange,Module.BulletLightShadows}
				
				if (CompareTables(HitEffectData, HitEffectData2) == false) then
					return "exploiter"
				elseif (CompareTables(BloodEffectData, BloodEffectData2) == false) then
					return "exploiter"
				elseif (CompareTables(BulletHoleData, BulletHoleData2) == false) then
					return "exploiter"
				elseif (CompareTables(ExplosiveData, ExplosiveData2) == false) then
					return "exploiter"
				elseif (CompareTables(BulletData, BulletData2) == false) then
					return "exploiter"
				elseif (CompareTables(WhizData, WhizData2) == false) then
					return "exploiter"
				elseif (CompareTables(BulletLightData, BulletLightData2) == false) then
					return "exploiter"
				end
			else
				--[[if KickPlayer then
					Player:Kick("Module is not found. Kicked!")
					warn(Player.Name.." - Module is missing from "..Folder.Name.." folder.")
				else
					warn(Player.Name.." - Potential Exploiter Bypass! Case 1: Missing Module")	
				end]]
				warn(Player.Name.." - Potential Exploiter Bypass! Case 1: Missing Module")
				return false
			end
		else
			warn("There's no existing setting folder.")
			return false	
		end
	else
		warn("Player or tool don't exist.")
		return false
	end
	return true
end

function Validate(Player, Tool, HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	--[[
	local GUID = HttpService:GenerateGUID(false)
	local ReturnedGUID = Request:InvokeClient(Player, GUID)
	if GUID == ReturnedGUID then
		if SecondLayer then
			return "possible_exploiter" --SecureSettings(Player, Tool, ClientModule)
		end
	else
		punishExploiter(Player)
		return false
	end
	return true
	--]]
	
	
	local lightingVerify = SecureSettings(Player, Tool, game.Lighting, HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	local serverStorageVerify = SecureSettings(Player, Tool, game.ServerStorage, HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	
	if lightingVerify == "exploiter" and serverStorageVerify == "exploiter" then
		warn("EXPLOITER CAUGHT "..Player.Name.. " USING "..Tool.Name)
		
		punishExploiter(Player)
	else
		print("ok good")
	end
	
	
end

game.ReplicatedStorage.Val.Event:Connect(function(Player,Tool,HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	
--	print("validating dat data")
	--Validate(Player,Tool,HitEffectData, BloodEffectData, BulletHoleData, ExplosiveData, BulletData, WhizData, BulletLightData)
	
end)