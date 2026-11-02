if game.ReplicatedStorage.GlobalData.Season.Value ~= "Winter" then return end
local SnowEmitters = workspace:WaitForChild("SnowEmitters")
local Tween = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Tween"))
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local SNOWFLAKE_TRANSPARENCY = NumberSequence.new(.3)
local TRANSPARENT = NumberSequence.new(0)
local ORIGINAL_EMITTER_POS_Y = 53
local UNDERGROUND_EMITTER_POS_Y = -27
local isDayTime = game.ReplicatedStorage.GlobalData.TimeOfDay.Value == "Midday"

local function SnowFlakes(show,enabled)
	for _,emitterBlock in ipairs(SnowEmitters:GetChildren()) do
		
		--if time of day changes, disable/enable particles
		if enabled ~= nil then
			emitterBlock.ParticleEmitter.Enabled = enabled
		end
		
		--move emitter position to show/hide
		if show ~= nil then
			if not show then
				emitterBlock.CFrame = CFrame.new(Vector3.new(emitterBlock.Position.X,UNDERGROUND_EMITTER_POS_Y,emitterBlock.Position.Z))
				
			else
				emitterBlock.CFrame = CFrame.new(Vector3.new(emitterBlock.Position.X,ORIGINAL_EMITTER_POS_Y,emitterBlock.Position.Z))
			end
		end
	end
end


for _,emitterBlock in ipairs(SnowEmitters:GetChildren()) do
	emitterBlock.ParticleEmitter.Enabled = true
end

local enabled = true


local positions = {}
local sizes = {}
local names = {}
for i,v in ipairs(game.ReplicatedStorage.IndoorBounds:GetChildren()) do
	positions[i] = v.Position
	sizes[i] = v.Size
	names[i] = v.Name
end



local function RefreshSnowState()
	if isDayTime then
		local cframe = camera.CoordinateFrame
			
		local isIndoors = false
		for i=1,#positions do		
			if cframe.x > positions[i].x - (sizes[i].x/2) then
			if cframe.x < positions[i].x + (sizes[i].x/2) then
			if cframe.z > positions[i].z - (sizes[i].z/2) then
			if cframe.z < positions[i].z + (sizes[i].z/2) then
					
				isIndoors = true
			end
			end
			end
			end
		end
			
		if isIndoors and  enabled then
			enabled = false
			SnowFlakes(false)
				
		elseif not isIndoors and not enabled then
			SnowFlakes(true)
			enabled = true
		end
	elseif enabled then
		enabled = false
		SnowFlakes(false)
	end
end


game.ReplicatedStorage.GlobalData.TimeOfDay.Changed:connect(function(value) 
	if value == "Midday" then
		isDayTime = true
		RefreshSnowState()
		SnowFlakes(nil,true)
	elseif value == "Night" then
		isDayTime = false
		RefreshSnowState()
		SnowFlakes(nil,false)
	end
end)




while true do
	
	RefreshSnowState()
	
	wait(1)
end





































