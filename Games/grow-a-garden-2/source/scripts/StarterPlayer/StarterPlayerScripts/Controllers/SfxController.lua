--credit to leon games studio
local t = {
	StartOrder = 6
}
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local SoundService = game:GetService("SoundService")

Players.LocalPlayer:WaitForChild("PlayerGui")

local Click = SoundService.SFX.Click
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local t2 = {}

local function GetCachedSfx(p1) --[[ GetCachedSfx | Line: 16 | Upvalues: t2 (copy), SoundService (copy) ]]
	local v1 = t2[p1]

	if v1 and v1.Parent then
		return v1
	end

	for v2, v3 in SoundService.SFX:GetDescendants() do
		if v3:IsA("Sound") and v3.Name == p1 then
			t2[p1] = v3

			return v3
		end
	end

	return nil
end

function t.Init(p1) --[[ Init | Line: 29 | Upvalues: Networking (copy), GetCachedSfx (copy), SoundService (copy) ]]
	Networking.SFX.PlaySound.OnClientEvent:Connect(function(p1) --[[ Line: 30 | Upvalues: GetCachedSfx (ref), SoundService (ref) ]]
		local v1 = GetCachedSfx(p1)

		if v1 then
			local TemporarySFX = v1:Clone()

			TemporarySFX.Name = "TemporarySFX"
			TemporarySFX.Parent = SoundService
			TemporarySFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			TemporarySFX:Play()
			TemporarySFX.Ended:Once(function() --[[ Line: 38 | Upvalues: TemporarySFX (copy) ]]
				TemporarySFX:Destroy()
			end)
		end
	end)
	Networking.SFX.PlaySoundVolume.OnClientEvent:Connect(function(p1, p2) --[[ Line: 43 | Upvalues: GetCachedSfx (ref), SoundService (ref) ]]
		local v1 = GetCachedSfx(p1)

		if v1 then
			local TemporarySFX = v1:Clone()

			TemporarySFX.Name = "TemporarySFX"
			TemporarySFX.Parent = SoundService
			TemporarySFX.Volume = p2
			TemporarySFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			TemporarySFX:Play()
			TemporarySFX.Ended:Once(function() --[[ Line: 52 | Upvalues: TemporarySFX (copy) ]]
				TemporarySFX:Destroy()
			end)
		end
	end)
	Networking.SFX.LocationSFX.OnClientEvent:Connect(function(p1, p2) --[[ Line: 57 | Upvalues: GetCachedSfx (ref) ]]
		local v1 = GetCachedSfx(p2)

		if v1 then
			local Part = Instance.new("Part")

			Part.Size = Vector3.new(1, 1, 1)
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Transparency = 1
			Part.Position = p1
			Part.Parent = workspace

			local LocationSFX = v1:Clone()

			LocationSFX.Name = "LocationSFX"
			LocationSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			LocationSFX.RollOffMode = Enum.RollOffMode.InverseTapered
			LocationSFX.RollOffMinDistance = 10
			LocationSFX.RollOffMaxDistance = 80
			LocationSFX.Parent = Part
			LocationSFX:Play()
			LocationSFX.Ended:Once(function() --[[ Line: 80 | Upvalues: Part (copy) ]]
				Part:Destroy()
			end)
		end
	end)
end
function t.SetupButton(p1, p2) --[[ SetupButton | Line: 86 | Upvalues: CollectionService (copy) ]]
	if not (p2:IsA("TextButton") or p2:IsA("ImageButton")) then
		return
	end

	if CollectionService:HasTag(p2, "ClickSFX") then
		p2.MouseButton1Click:Connect(function() --[[ Line: 90 | Upvalues: p1 (copy) ]]
			p1:PlayClickSound()
		end)
	end
end
function t.PlayClickSound(p1) --[[ PlayClickSound | Line: 95 | Upvalues: Click (copy) ]]
	Click.TimePosition = 0
	Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	Click:Play()
end
function t.PlaySFX(p1, p2) --[[ PlaySFX | Line: 101 | Upvalues: GetCachedSfx (copy) ]]
	local v1 = GetCachedSfx(p2)

	if not v1 then
		return
	end

	v1.TimePosition = 0
	v1.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	v1:Play()
end

return t