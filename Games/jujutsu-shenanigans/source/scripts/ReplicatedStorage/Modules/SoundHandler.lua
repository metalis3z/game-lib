--// Services \\--

local Debris = game:GetService('Debris')
local W = game:GetService('Workspace')



--// Module \\--

local module = {}

local ThrownFolder = W.Thrown or W:WaitForChild('Thrown', 5)



--// Module Functions \\--

function module:AddSound(Sound: Sound, SoundParam)
	if not Sound then return end
	
	if typeof(SoundParam) == 'Vector3' then
		Sound = Sound:Clone()
		
		local SoundPart = Instance.new('Attachment')
		SoundPart.Parent = workspace.Terrain
		SoundPart.WorldPosition = SoundParam
		
		Sound.Parent = SoundPart
		Sound:Play()
		
		Debris:AddItem(SoundPart, Sound.TimeLength + 5)
	else
		Sound = Sound:Clone()

		Sound.Parent = SoundParam
		Sound:Play()

		Debris:AddItem(Sound, Sound.TimeLength + 5)
	end
end

return module
