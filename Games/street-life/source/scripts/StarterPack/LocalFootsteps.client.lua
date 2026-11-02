if not game:IsLoaded() then game.Loaded:Wait() end

task.wait(5)

local sounds = game:GetService('SoundService')
local runtime = game:GetService('RunService')
script:WaitForChild('FootstepSounds').Parent = sounds
local materials = sounds:WaitForChild('FootstepSounds')
local plr = game.Players.LocalPlayer
repeat wait() until plr.Character
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char.HumanoidRootPart
local hum = char.Humanoid
local walking

hum.Running:connect(function(speed)
	if speed > hum.WalkSpeed/9 then
		walking = true
	else
		walking = false
	end
end)

function getMaterial()
	local floormat = hum.FloorMaterial
	if not floormat then floormat = 'Air' end
	local matstring = string.split(tostring(floormat),'Enum.Material.')[2]
	local material = matstring
	if floormat == 'Air' then floormat = nil end
	return material
end

local lastmat
runtime.Heartbeat:connect(function()
	if walking then
		local material = getMaterial()
		if material ~= nil then
			if material ~= lastmat and lastmat ~= nil then
				materials[lastmat].Playing = false
			end
			if material then
				pcall(function()
					if materials[material] then
						local materialSound = materials[material]
						materialSound.PlaybackSpeed = hum.WalkSpeed/12
						materialSound.Playing = true
						lastmat = material
					end
				end)
			end
		end
	else
		for _,sound in pairs(materials:GetChildren()) do
			sound.Playing = false
		end
	end
	task.wait(.001)
end)