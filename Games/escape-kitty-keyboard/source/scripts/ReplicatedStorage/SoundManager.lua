

local v1 = game:GetService("SoundService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2:WaitForChild("Config"))
local u4 = v1:FindFirstChild("GameSounds") or Instance.new("Folder")
u4.Name = "GameSounds"
u4.Parent = v1
local u5 = {}
local v6 = {}
for v7, v8 in pairs(v3.SOUNDS) do
	local v9 = Instance.new("Sound")
	v9.Name = v7
	v9.SoundId = v8.ID
	v9.Volume = v8.Volume or 0.5
	v9.Parent = u4
	u5[v7] = v9
end
function v6.Play(_, p10) 

	local v11 = u5[p10]
	if v11 then
		local u12 = v11:Clone()
		u12.Parent = u4
		u12.PlaybackSpeed = v11.PlaybackSpeed * (math.random(95, 105) / 100)
		u12:Play()
		u12.Ended:Connect(function()

			u12:Destroy()
		end)
	else
		warn("[SoundManager] Son inexistant : " .. tostring(p10))
	end
end
function v6.PlayLevelUp(p13) 
	p13:Play("LEVEL_UP")
end
function v6.PlayRebirth(p14) 
	p14:Play("REBIRTH")
end
function v6.PlayCollect(p15) 
	p15:Play("COLLECT")
end
function v6.PlayWin(p16) 
	p16:Play("WIN")
end
return v6