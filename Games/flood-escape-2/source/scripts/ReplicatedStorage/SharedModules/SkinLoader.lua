local SkinScript = {}

SkinScript.doSkin = function(Rig, Skin)
	local skinManager = Skin
	Rig["Body Colors"]:Destroy()
	while Rig.Head:FindFirstChild("Mesh") do
		Rig.Head.Mesh:Destroy()								
	end
	while Rig.Head:FindFirstChild("face") do
		Rig.Head.face:Destroy()								
	end
	while Rig:FindFirstChild("SkinScript") do
		Rig.SkinScript:Destroy()								
	end
	while skinManager:FindFirstChild("R6") do
		for createSkinScript, skinScript in pairs(skinManager.R6:GetChildren()) do
			skinScript.Parent = skinManager
		end
		skinManager.R6:Destroy()								
	end

	local humType = { "R15", "R15Anim", "BodyTypeScale", "BodyProportionScale", "BodyHeightScale", "HeadScale", "IsR15", "BodyDepthScale", "BodyWidthScale", "R15ArtistIntent", "R15Fixed" }
	local children = skinManager:GetChildren()

	for _, mainSkin in ipairs(children) do
		for _, skinName in ipairs(humType) do
			if mainSkin.Name == skinName then
				mainSkin:Destroy()
				break
			end
		end
	end
	for headType, skinHead in pairs(skinManager:GetChildren()) do
		local real = skinHead:Clone()
		if skinHead.Name == "face" or skinHead.Name == "Mesh" then
			real.Parent = Rig.Head
		else
			real.Parent = Rig


			if real:IsA("Accessory") then
				local function attachAccessory(parent, accessory)
					local attachment = accessory.Handle:FindFirstChildOfClass("Attachment")
					local weld = Instance.new("Weld")
					weld.Name = "AccessoryWeld"
					weld.Part0 = accessory.Handle

					if attachment then
						local correspondingAttachment = parent:FindFirstChild(tostring(attachment), true)
						weld.C0 = attachment.CFrame
						weld.C1 = correspondingAttachment.CFrame
						weld.Part1 = correspondingAttachment.Parent
					else
						weld.C1 = CFrame.new(0, parent.Head.Size.Y / 2, 0) * accessory.AttachmentPoint:inverse()
						weld.Part1 = parent.Head
					end

					accessory.Handle.CFrame = weld.Part1.CFrame * weld.C1 * weld.C0:inverse()
					accessory.Parent = parent
					weld.Parent = accessory.Handle
				end

				attachAccessory(Rig, real)
			else
				real.Parent = Rig
			end
		end
	end
	if not Rig.Head:FindFirstChild("face") then
		local face = Instance.new("Decal")
		face.Name = "face"
		face.Texture = "rbxasset://textures/face.png"
		face.Face = "Front"
		face.Parent = Rig.Head
	end
	if not Rig.Head:FindFirstChild("Mesh") then
		local mesh = Instance.new("SpecialMesh")
		mesh.Scale = Vector3.new(1.25, 1.25, 1.25)
		mesh.Parent = Rig.Head
	end
end

return SkinScript