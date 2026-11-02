local model = script:WaitForChild("ObjectPointer").Value
local house = script:WaitForChild("HousePointer").Value

local lastSoda = nil
local debounce = false
local bumper = model.Bumper

function GiveSoda(imageID,button)
	pcall(function()
		print((lastSoda.Handle.Position - bumper.Position).magnitude)
	end)
	if not debounce and (not lastSoda or not lastSoda.Parent or lastSoda:FindFirstChild("Handle") == nil or (lastSoda.Handle.Position - bumper.Position).magnitude > 1.5) then
		debounce = true
		local soda = game.ServerStorage.SodaTemplate:clone()
		soda.Parent = workspace
		soda.Handle.CFrame = model.SodaPosition.CFrame
		soda.SodaName.Value = button.Name
		soda.Handle.Mesh.TextureId = "http://www.roblox.com/asset/?id=" .. imageID
		soda.TextureId = button.SG.ImageLabel.Image
		
		lastSoda = soda
		wait(3)
		debounce = false
	end
end


for _,part in ipairs(model:GetChildren()) do
	if part:FindFirstChild("ImageID") then
		part.ClickDetector.MouseClick:connect(function()
			GiveSoda(part.ImageID.Value,part)
		end)
	end
end