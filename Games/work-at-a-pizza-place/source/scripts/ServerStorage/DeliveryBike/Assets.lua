--Made by Luckymaxer

BaseUrl = "http://www.roblox.com/asset/?id="

RbxUtility = LoadLibrary("RbxUtility")
Create = RbxUtility.Create

BasePart = Create("Part"){
	Material = Enum.Material.Plastic,
	Shape = Enum.PartType.Block,
	TopSurface = Enum.SurfaceType.Smooth,
	BottomSurface = Enum.SurfaceType.Smooth,
	FormFactor = Enum.FormFactor.Custom,
	Size = Vector3.new(0.2, 0.2, 0.2),
	Anchored = false,
	CanCollide = true,
	Locked = true
}

MeshData = {
	Meshes = {
		Body = 168119200,
		Wheel = 168119240
	},
	TextureId = 168119260
}

function CreateVehicle()

	local ExhaustSmoke = {}
	local Lights = {}
	local Sparkles = {}

	local Body = BasePart:Clone()
	Body.Name = "Body"
	Body.Size = Vector3.new(1, 5.5, 6)
	local BodyMesh = Create("SpecialMesh"){
		MeshType = Enum.MeshType.FileMesh,
		MeshId = MeshData.Meshes.Body,
		TextureId = MeshData.TextureId,
		Scale = Vector3.new(1.25, 1.25, 1.25),
		VertexColor = Vector3.new(1, 1, 1),
		Offset = Vector3.new(0, 0, 0),
		Parent = Body
	}
	
	local BaseWheel = BasePart:Clone()
	BaseWheel.Size = Vector3.new(0.5, 1, 1)
	BaseWheel.CanCollide = false
	local WheelMesh = Create("SpecialMesh"){
		MeshType = Enum.MeshType.FileMesh,
		MeshId = "",
		TextureId = MeshData.TextureId,
		Scale = Vector3.new(1.25, 1.25, 1.25),
		VertexColor = Vector3.new(1, 1, 1),
		Offset = Vector3.new(0, 0, 0),
		Parent = BaseWheel,
	}

	local BaseFrontWheel = BaseWheel:Clone()
	BaseFrontWheel.Name = "FrontWheel"
	BaseFrontWheel.Mesh.MeshId = MeshData.Meshes.Wheel
	
	local BaseBackWheel = BaseWheel:Clone()
	BaseBackWheel.Name = "BackWheel"
	BaseBackWheel.Mesh.MeshId = MeshData.Meshes.Wheel

	local BaseSmokePart = BasePart:Clone()
	BaseSmokePart.Name = "SmokePart"
	BaseSmokePart.Transparency = 1
	local BaseExhaustSmoke = Create("Smoke"){
		Name = "ExhaustSmoke",
		Size = 0.1,
		RiseVelocity = 0.01,
		Color = Color3.new((127 / 255), (127 / 255), (127 / 255)),
		Enabled = true,
		Parent = BaseSmokePart,
	}

	local BaseLightPart = BasePart:Clone()
	BaseLightPart.Name = "LightPart"
	BaseLightPart.Transparency = 1
	local Light = Create("SpotLight"){
		Name = "Light",
		Brightness = 50,
		Angle = 45,
		Color = Color3.new(255 / 255, 252 / 255, 153 / 255),
		Range = 20,
		Shadows = false,
		Enabled = false,
		Parent = BaseLightPart,
	}
			
	local FrontWheel = BaseFrontWheel:Clone()
	FrontWheel.Parent = Body
	
	local FrontMotor = Create("Motor6D"){
		Name = "FrontMotor",
		Part0 = Body,
		Part1 = FrontWheel,
		C0 = CFrame.new(0, -2.05, -2.2) * CFrame.Angles(0, (math.pi / 2), 0),
		C1 = CFrame.new() * CFrame.Angles(0, -(math.pi / 2), 0),
		Parent = Body
	}
	
	local BackWheel = BaseBackWheel:Clone()
	BackWheel.Parent = Body
	
	local BackMotor = Create("Motor6D"){
		Name = "BackMotor",
		Part0 = Body,
		Part1 = BackWheel,
		C0 = CFrame.new(0, -2.05, 2) * CFrame.Angles(0, (math.pi / 2), 0),
		C1 = CFrame.new() * CFrame.Angles(0, -(math.pi / 2), 0),
		Parent = Body
	}
	
	local HeadLight = BaseLightPart:Clone()
	HeadLight.Parent = Body
	table.insert(Lights, HeadLight.Light)
	for i, v in pairs(HeadLight:GetChildren()) do
		if v:IsA("Sparkles") then
			table.insert(Sparkles, v)
		end
	end
	
	local LightWeld = Create("Weld"){
		Part0 = Body,
		Part1 = HeadLight,
		C0 = CFrame.new(0, 1.25, -1.9) * CFrame.Angles(0, 0, 0),
		Parent = HeadLight
	}
	
	local ExhaustPipe = BaseSmokePart:Clone()
	ExhaustPipe.Name = "ExhaustPipe"
	ExhaustPipe.Parent = Body
	table.insert(ExhaustSmoke, ExhaustPipe.ExhaustSmoke)
	
	local SmokeWeld = Create("Weld"){
		C0 = CFrame.new(0, 1, -2.7) * CFrame.Angles(0, 0, 0),
		Part0 = ExhaustPipe,
		Part1 = Body,
		Parent = ExhaustPipe
	}

	local Tables = {
		ExhaustSmoke = ExhaustSmoke,
		Lights = Lights,
		Sparkles = Sparkles
	}
	
	return {
		Vehicle = Body,
		Tables = Tables
	}
	
end

for i, v in pairs(MeshData) do
	if type(v) == "table" then
		for ii, vv in pairs(v) do
			if type(vv) == "string" or type(vv) == "number" then
				MeshData[i][ii] = (BaseUrl .. tostring(vv))
			end
		end
	elseif type(v) == "string" or type(v) == "number" then
		MeshData[i] = (BaseUrl .. tostring(v))
	end
end

return {
	BaseUrl = BaseUrl,
	MeshData = MeshData,
	CreateVehicle = CreateVehicle
}