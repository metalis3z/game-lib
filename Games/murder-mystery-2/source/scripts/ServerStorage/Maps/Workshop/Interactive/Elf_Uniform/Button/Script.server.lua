local debounce = false
local overlaytextureid = 41794780

local nottodestroy = {
	["ElfLeftArm"] = true;
	["ElfRightArm"] = true;
	["ElfTorso"] = true;
	["ElfRightLeg"] = true;
	["ElfLeftLeg"] = true;
	["ElfHat"] = true;
	["Elf Ears"] = true;
}

local function onTouched(toucher)
	if toucher.Parent:FindFirstChildOfClass("Humanoid") and not debounce then
		if not toucher.Parent:FindFirstChild("HasMorphed") then
		debounce = true
		local character = toucher.Parent
		local CheckerValue = Instance.new("BoolValue",character)
		CheckerValue.Name = "HasMorphed"
		CheckerValue.Value = true
		
		for i,charmeshes in pairs(character:GetChildren()) do
			if charmeshes:IsA("CharacterMesh") and not nottodestroy[charmeshes.Name] then
				charmeshes:Destroy()
			end
		end
		
		for i,clothing in pairs(character:GetChildren()) do
			if clothing:IsA("Shirt") or clothing:IsA("Pants") or clothing:IsA("ShirtGraphic") or clothing:IsA("Accessory") and not nottodestroy[clothing.Name]  then
				clothing:Destroy()
			end
		end
			
			local knifedisplay = character:FindFirstChild("KnifeDisplay")
			if knifedisplay then
				knifedisplay.Transparency = 1
				for i,effects in pairs(knifedisplay:GetDescendants()) do
					if effects:IsA("ParticleEmitter") or effects:IsA("BillboardGui") or effects:IsA("Fire") then
						effects.Enabled = false
					end
				end
				for i,chroma in pairs(knifedisplay:GetDescendants()) do
					if chroma:IsA("Decal") then
						chroma:Destroy()
					end
				end
			end
			
			local radiodisplay = character:FindFirstChild("Radio")
			if radiodisplay then
				radiodisplay.Transparency = 1
			end
			
			local gundisplay = character:FindFirstChild("GunDisplay")
			if gundisplay then
				gundisplay.Transparency = 1
			end
		
		local head = character:FindFirstChild("Head")
		if head then
			local headmesh = head:FindFirstChild("Mesh")
			if headmesh then
				headmesh:Destroy()
				wait()
				script.Mesh:Clone().Parent = head
			end
			local face = head:FindFirstChildOfClass("Decal")
			if face then
				face.Texture = "rbxasset://textures//face.png"	
			end
		end
		
			local elfears = script["Elf Ears"]:Clone()
			local elfhat = script.ElfHat:Clone()
			elfhat.Handle.Anchored = false
			elfears.Handle.Anchored = false
			elfears.Parent = character
			elfhat.Parent = character
			local ElfLeftArm = Instance.new("CharacterMesh",character)
			ElfLeftArm.Name = "ElfLeftArm"
			ElfLeftArm.BodyPart = Enum.BodyPart.LeftArm
			ElfLeftArm.MeshId = 41794495
			ElfLeftArm.OverlayTextureId = overlaytextureid
			
			local ElfRightArm = Instance.new("CharacterMesh",character)
			ElfRightArm.Name = "ElfRightArm"
			ElfRightArm.BodyPart = Enum.BodyPart.RightArm
			ElfRightArm.MeshId = 41794664
			ElfRightArm.OverlayTextureId = overlaytextureid
			
			local ElfTorso = Instance.new("CharacterMesh",character)
			ElfTorso.Name = "ElfTorso"
			ElfTorso.BodyPart = Enum.BodyPart.Torso
			ElfTorso.MeshId = 41794594
			ElfTorso.OverlayTextureId = overlaytextureid
			
			local ElfLeftLeg = Instance.new("CharacterMesh",character)
			ElfLeftLeg.Name = "ElfLeftLeg"
			ElfLeftLeg.BodyPart = Enum.BodyPart.LeftLeg
			ElfLeftLeg.MeshId = 41794561
			ElfLeftLeg.OverlayTextureId = overlaytextureid
			
			local ElfRightLeg = Instance.new("CharacterMesh",character)
			ElfRightLeg.Name = "ElfRightLeg"
			ElfRightLeg.BodyPart = Enum.BodyPart.RightLeg
			ElfRightLeg.MeshId = 41794691
			ElfRightLeg.OverlayTextureId = overlaytextureid
			wait(2)
			debounce = false
		end
	end
end

script.Parent.Touched:Connect(onTouched)