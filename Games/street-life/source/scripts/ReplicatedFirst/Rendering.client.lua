_G.RenderDistance = 350 

local Settings = {
	MobileRenderDistance = 550,
	UnloadAll = true;
}

local Player = game:FindService('Players').LocalPlayer
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RS_Chunks = ReplicatedStorage:FindFirstChild('Chunks')

if not RS_Chunks then
	local Folder = Instance.new('Folder', ReplicatedStorage)
	Folder.Name = 'Chunks'
	RS_Chunks = Folder
end

local Positions = {}
local function EditChunk(Chunk, Argument)
	if Argument == true then
		for _,v in next, Chunk:GetChildren() do
			if v.Name ~= 'Handler' then
				if v:IsA('BasePart') or v:IsA('Model') then
					v.Parent = RS_Chunks[Chunk.Name]
				end
			end
		end
	elseif Argument == false then
		for _,v in next, Chunk:GetChildren() do
			for _,v in ipairs(RS_Chunks[Chunk.Name]:GetChildren()) do
				v.Parent = Chunk
			end
		end
	end
end

Player.CharacterAdded:Connect(function()
	if Positions[1] ~= nil then return end
	for _,v in next, workspace:WaitForChild('Chunks'):GetChildren() do 
		if v:WaitForChild('Handler') then
			table.insert(Positions, v:FindFirstChild('Handler'))
			local Model = Instance.new('Model', RS_Chunks)
			Model.Name = v.Name
		end
	end
end)

repeat task.wait() until Player.Character and Positions[#workspace:WaitForChild('Chunks'):GetChildren()] ~= nil
if Settings.UnloadAll then
	for _,v in next, Positions do
		EditChunk(v.Parent, true)
	end
end

task.wait(10)
while task.wait(0.2) do
	local HumanoidRootPart = Player.Character:FindFirstChild('HumanoidRootPart')
	if HumanoidRootPart then
		for _,v in next, Positions do
			local Chunk, ChunkPosition = v.Parent, v.Position
			if _G.RenderDistance then
				if game:GetService('UserInputService').TouchEnabled then
					if (ChunkPosition - HumanoidRootPart.Position).Magnitude <= Settings.MobileRenderDistance then
						EditChunk(Chunk, false)
					else
						EditChunk(Chunk, true)
					end
				else
					if (ChunkPosition - HumanoidRootPart.Position).Magnitude <= _G.RenderDistance then
						EditChunk(Chunk, false)
					else
						EditChunk(Chunk, true)
					end
				end
			end
		end
	end
end
