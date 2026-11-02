local PrintTable = require(game.ReplicatedStorage.Utilities.PrintTable)
PrintTable({})

local CameraUtil = require(game.ReplicatedStorage.Utilities.CameraUtil)



local Instance = require(game.ReplicatedStorage.Utilities.PrintTable)
Instance.new("Part",{
	Name = "Bob",
	CanCollide = false,
	Anchored = true,
	Parent = workspace
})


local os = require(game.ReplicatedStorage.Utilities.GetDate)
local date = os.date()
print(date.year)




--//////MISC UTILITIES\\\\\\--








--turn snow blocks into mesh
for _,obj in ipairs(workspace:GetChildren()) do
	
	if obj.Name == "IceSnow" and obj:IsA("BasePart") and obj.Size.X ~= .2 then
		local part = obj
		local scale = part.Size * 5
		part.FormFactor = "Custom"
		part.Size = Vector3.new(.2,.2,.2)
		local mesh = Instance.new("BlockMesh",part)
		mesh.Scale = scale	
	end
	
end

