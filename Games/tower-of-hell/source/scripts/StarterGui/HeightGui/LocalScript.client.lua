local replicatedStorage = game:GetService("ReplicatedStorage")

local tower = workspace:FindFirstChild("Tower")
if not tower then return end

function createSectionFrames(towerHeight)
	for _, child in pairs(script.Parent.Frame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	local reversedSections = {}
	for _ , section in pairs(tower:GetChildren()) do
		table.insert(reversedSections, 1, section)
	end
	
	for _, section in pairs(reversedSections) do
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, section.Height.Value/towerHeight, 0)
		frame.Name = section.Name
		frame.BorderSizePixel = 0
		frame.BackgroundColor3 = section.PrimaryPart.Color
		frame.Parent = script.Parent.Frame
	end
end

createSectionFrames(tonumber(replicatedStorage.TowerHeight.Value))

replicatedStorage.HeightEvent.OnClientEvent:Connect(function(towerHeight)
	createSectionFrames(tonumber(towerHeight))
end)