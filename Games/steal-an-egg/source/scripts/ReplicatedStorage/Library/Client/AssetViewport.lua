-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetModels = require(ReplicatedStorage.Library.Modules.AssetModels)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Directory = Assets.Directory
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local Unit = (Vector3.new(-1, 0, -1)).Unit
local v1 = Log.new()
local t = {}

local function setupCamera(p1, p2, p3, p4, p5, p6) --[[ setupCamera | Line: 30 | Upvalues: BBFromModelVisibleOnly (copy), Unit (copy) ]]
	local v1 = p4 or 0.8
	local v2 = p5 or 0.5
	local v3 = p6 or 0.5

	assert(v1, "luau")
	assert(v2, "luau")
	assert(v3, "luau")

	local v4, v5 = BBFromModelVisibleOnly(p2)
	local v6 = math.max(v5.X, v5.Y, v5.Z)
	local v8 = v6 * 0.5 / math.tan((math.rad(p3 * 0.5))) * v1
	local v10 = v4.Position + Vector3.new(0, (v3 - 0.5) * v5.Y, 0)
	local Position2 = (v4 * CFrame.new(Unit * (v8 + v6 * v2))).Position

	p1.CFrame = CFrame.new(Position2, v10)
end

local function attachModel(p1, p2, p3, p4) --[[ attachModel | Line: 54 | Upvalues: Trove (copy), t (copy), setupCamera (copy) ]]
	local v1 = Trove.new()

	v1:Add(p2)

	if p4 then
		local WorldModel = Instance.new("WorldModel")

		WorldModel.Parent = p3
		v1:Add(WorldModel)
		p2.Parent = WorldModel

		local v2 = t.PlayIdleAnimation(p1, p2)

		if v2 ~= nil then
			v1:Add(v2)
		end
	else
		p2.Parent = p3
	end

	local Camera = Instance.new("Camera")

	Camera.FieldOfView = 50
	Camera.Parent = p3
	p3.CurrentCamera = Camera
	v1:Add(Camera)
	setupCamera(Camera, p2, 60, 0.75, 0.7, 0.35)
	v1:AttachToInstance(p3)

	return v1, Camera, p2
end

function t.Create(p1) --[[ Create | Line: 91 | Upvalues: Asserts (copy) ]]
	Asserts.GuiObject(p1)

	local AssetViewport = Instance.new("ViewportFrame")

	AssetViewport.Name = "AssetViewport"
	AssetViewport.AnchorPoint = Vector2.new(0.5, 0.5)
	AssetViewport.BackgroundTransparency = 1
	AssetViewport.Position = UDim2.fromScale(0.5, 0.5)
	AssetViewport.Size = UDim2.fromScale(1, 1)
	AssetViewport.ZIndex = p1.ZIndex + 1
	AssetViewport.Parent = p1
	AssetViewport.LightColor = Color3.fromRGB(300, 300, 300)
	AssetViewport.Ambient = Color3.fromRGB(300, 300, 300)

	return AssetViewport
end
function t.GetOrbitCFrame(p1, p2, p3, p4) --[[ GetOrbitCFrame | Line: 107 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p1)
	Asserts.Vector3(p2)
	Asserts.number(p3)
	Asserts.number(p4)

	local v1 = CFrame.new(p2):ToObjectSpace(p1)

	return CFrame.lookAt((CFrame.new(p2) * CFrame.Angles(p4, p3, 0) * v1).Position, p2)
end
function t.SetCameraOrbit(p1, p2, p3, p4, p5) --[[ SetCameraOrbit | Line: 118 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Instance(p1)
	p1.CFrame = t.GetOrbitCFrame(p2, p3, p4, p5)
end
function t.SetLocalCameraOrbit(p1, p2, p3, p4, p5, p6, p7) --[[ SetLocalCameraOrbit | Line: 129 | Upvalues: Asserts (copy) ]]
	Asserts.Instance(p1)
	Asserts.CFrame(p2)
	Asserts.Vector3(p3)
	Asserts.number(p4)
	Asserts.number(p5)
	Asserts.number(p6)
	Asserts.number(p7)

	local v1 = CFrame.Angles(0, p6, 0):VectorToWorldSpace((Vector3.new(0, 0, -p4)))

	p1.CFrame = CFrame.lookAt(p3 + p2:VectorToWorldSpace(v1 + Vector3.new(0, p5 + math.tan(p7) * p4, 0)), p3, p2.UpVector)
end
function t.PlayIdleAnimation(p1, p2) --[[ PlayIdleAnimation | Line: 152 | Upvalues: Asserts (copy), Directory (copy) ]]
	Asserts.string(p1)
	Asserts.Model(p2)

	local Idle = Directory[p1].Animations.Idle
	local v1 = p2:FindFirstChildWhichIsA("Animator", true)

	if Idle == nil or v1 == nil then 
		return nil
	end

	local v2 = v1:LoadAnimation(Idle)

	v2.Looped = true
	v2:Play(0)

	return v2
end
function t.AttachOnViewport(p1, p2, p3) --[[ AttachOnViewport | Line: 169 | Upvalues: AssetModels (copy), v1 (copy), Trove (copy), attachModel (copy) ]]
	local v12 = AssetModels.GetAssetModelIfReplicated(p1)

	if v12 then
		return attachModel(p1, v12:Clone(), p2, p3)
	end

	v1:AtWarning():Log("Asset not found in model folder", {
		AssetId = p1
	})

	return Trove.new(), nil, nil
end
function t.AttachItemDataOnViewport(p1, p2, p3, p4) --[[ AttachItemDataOnViewport | Line: 184 | Upvalues: AssetItem (copy), Asserts (copy), ItemDisplay (copy), attachModel (copy) ]]
	assert(AssetItem.AssetItemData(p1))
	Asserts.Instance(p2)
	Asserts.number(p3)

	local v1 = table.clone(p1)

	v1.Scale = 1

	local v3, v4, v5 = attachModel(p1.Category, ItemDisplay.CreateActiveModel(nil, v1, true, true), p2, p4)

	ItemDisplay.ApplyModelScale(v5, p1.Category, p3)

	return v3, v4, v5
end

return t