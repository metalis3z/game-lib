-- Put this script in a LocalScript inside a GUI Button

local button = script.Parent  -- Reference to the GUI button
local newTextureId = "rbxassetid://158118263"  -- Replace with the ID of your new texture

local function replaceTextures()
	for _, obj in pairs(workspace.Map.Ingame:GetDescendants()) do
		if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") or obj:IsA("Clothing") then
			obj:Destroy()
		end
	end
	for _, obj in pairs(workspace.Map.Ingame:GetDescendants()) do
		if obj:IsA("BasePart") then
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Front
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Back
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Top
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Bottom
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Left
			local decal = Instance.new("Decal", obj)
			decal.Texture = newTextureId
			decal.Face = Enum.NormalId.Right
		end
	end
end

button.MouseButton1Click:Connect(replaceTextures)
