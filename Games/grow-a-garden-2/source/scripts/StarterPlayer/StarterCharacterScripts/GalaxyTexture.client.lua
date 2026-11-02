--credit to prince games studio
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local t = {}

local function addTexture(p1) --[[ addTexture | Line: 26 | Upvalues: t (copy) ]]
	if not p1:IsA("Texture") then
		return
	end

	local v1 = p1.Parent

	if v1 and v1:IsA("BasePart") then
		t[p1] = {
			driftU = 0,
			driftV = 0,
			part = v1
		}
	end
end

local function removeTexture(p1) --[[ removeTexture | Line: 33 | Upvalues: t (copy) ]]
	if not p1:IsA("Texture") then
		return
	end

	t[p1] = nil
end

for v1, v2 in CollectionService:GetTagged("GalaxyTexture") do
	addTexture(v2)
end

CollectionService:GetInstanceAddedSignal("GalaxyTexture"):Connect(addTexture)
CollectionService:GetInstanceRemovedSignal("GalaxyTexture"):Connect(removeTexture)

local function faceUV(p1, p2) --[[ faceUV | Line: 47 ]]
	if p2 == Enum.NormalId.Top or p2 == Enum.NormalId.Bottom then
		return p1.X, p1.Z
	end

	if p2 == Enum.NormalId.Right or p2 == Enum.NormalId.Left then
		return p1.Z, p1.Y
	end

	return p1.X, p1.Y
end

local v3 = 0

RunService.RenderStepped:Connect(function(p1) --[[ Line: 60 | Upvalues: v3 (ref), Workspace (copy), t (copy) ]]
	v3 = v3 + p1

	if v3 < 0.05 then
		return
	end

	local v1 = v3

	v3 = 0

	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return
	end

	local Position = CurrentCamera.CFrame.Position

	for v4, v5 in t do
		local v2, v32
		local part = v5.part
		local v6 = Position - part.Position

		if not (v6.Magnitude < 0.0001) then
			local v7 = part.CFrame:VectorToObjectSpace(v6.Unit)
			local Face = v4.Face

			if Face == Enum.NormalId.Top or Face == Enum.NormalId.Bottom then
				v2 = v7.X
				v32 = v7.Z
			else
				v2 = if Face == Enum.NormalId.Right or Face == Enum.NormalId.Left then v7.Z else v7.X
				v32 = v7.Y
			end

			v5.driftU = v5.driftU + v1 * 0.05
			v5.driftV = v5.driftV + v1 * 0.25
			v4.OffsetStudsU = v2 * 2 + v5.driftU
			v4.OffsetStudsV = v32 * 2 + v5.driftV
		end
	end
end)