-- Generated from map/lighting.rbxm by _tools/rbxm2lua.luau
-- Lighting pack: for _, o in require(this)() do o.Parent = game.Lighting end (Lighting properties are in Environment.lua)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("Folder", nil, "Map")
		I[2] = new("Part", I[1], "Baseplate", { Anchored = true, BackSurface = Enum.SurfaceType.Studs, BottomSurface = Enum.SurfaceType.Studs, CFrame = CFrame.new(0, 26.70718, 0), CanQuery = false, Color = Color3.fromRGB(99, 95, 98), EnableFluidForces = false, FrontSurface = Enum.SurfaceType.Studs, LeftSurface = Enum.SurfaceType.Studs, Locked = true, RightSurface = Enum.SurfaceType.Studs, Size = Vector3.new(812, 20, 812) })
		I[3] = new("Model", I[1], "Brick Wall")
			I[4] = new("Part", I[3], "Brick Wall", { Anchored = true, CFrame = CFrame.new(8.2322693, 45.3493652, -17.3174896), Color = Color3.fromRGB(86, 36, 36), Material = Enum.Material.Brick, Size = Vector3.new(1, 17.2843666, 27.1258221), TopSurface = Enum.SurfaceType.Smooth })
		I[5] = new("SpawnLocation", I[1], "SpawnLocation", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-48.2384338, 36.4482422, -20.4111633), Size = Vector3.new(12, 0.2647247, 12), TopSurface = Enum.SurfaceType.Smooth })
	I[6] = new("Sky", nil, "Sky", { SkyboxBackContent = Content.fromUri("rbxassetid://600830446"), SkyboxDownContent = Content.fromUri("rbxassetid://600831635"), SkyboxFrontContent = Content.fromUri("rbxassetid://600832720"), SkyboxLeftContent = Content.fromUri("rbxassetid://600886090"), SkyboxRightContent = Content.fromUri("rbxassetid://600833862"), SkyboxUpContent = Content.fromUri("rbxassetid://600835177") })
	return { I[1], I[6] }
end

return build
