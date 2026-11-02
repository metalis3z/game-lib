return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			local notahead = char.head
			
			notahead.face:Destroy()
			
			notahead.Mesh.TextureId = "rbxassetid://156292409"
			notahead.Mesh.MeshId = "rbxassetid://156292343"
			
			for i,e in pairs(char:GetChildren()) do
				if e:IsA("Accessory") then
					e:Destroy()
				end
			end
			
			local LeftLowerArm = char:WaitForChild("LeftLowerArm")
			LeftLowerArm:Destroy()
			local LeftUpperArm = char:WaitForChild("LeftUpperArm")
			LeftUpperArm:Destroy()
			local LeftHand = char:WaitForChild("LeftHand")
			LeftHand:Destroy()
			local RightLowerArm = char:WaitForChild("RightLowerArm")
			RightLowerArm:Destroy()
			local RightUpperArm = char:WaitForChild("RightUpperArm")
			RightUpperArm:Destroy()
			local RightHand = char:WaitForChild("RightHand")
			RightHand:Destroy()
			local LeftLowerLeg = char:WaitForChild("LeftLowerLeg")
			LeftLowerLeg:Destroy()
			local LeftUpperLeg = char:WaitForChild("LeftUpperLeg")
			LeftUpperLeg:Destroy()
			local LeftFoot = char:WaitForChild("LeftFoot")
			LeftFoot:Destroy()
			local RightLowerLeg = char:WaitForChild("RightLowerLeg")
			RightLowerLeg:Destroy()
			local RightUpperLeg = char:WaitForChild("RightUpperLeg")
			RightUpperLeg:Destroy()
			local RightFoot = char:WaitForChild("RightFoot")
			RightFoot:Destroy()
			local UpperTorso = char:WaitForChild("UpperTorso")
			UpperTorso:Destroy()
			local LowerTorso = char:WaitForChild("LowerTorso")
			LowerTorso:Destroy()
			
			for i,r in pairs(char:GetChildren()) do
				if r:IsA("BasePart") then
				end
			end
			
			local CogClone1 = notahead:Clone()
			local CogClone2 = notahead:Clone()
			local CogClone3 = notahead:Clone()
			local CogClone4 = notahead:Clone()
			local CogClone5 = notahead:Clone()
			local CogClone6 = notahead:Clone()
			local CogClone7 = notahead:Clone()
			local CogClone8 = notahead:Clone()
			local CogClone9 = notahead:Clone()
			local CogClone10 = notahead:Clone()
			local CogClone11 = notahead:Clone()
			
			CogClone1.Parent = char
			CogClone1.Name = "Cog1"
			
			CogClone2.Parent = char
			CogClone2.Name = "Cog2"
			
			CogClone3.Parent = char
			CogClone3.Name = "Cog3"
			
			CogClone4.Parent = char
			CogClone4.Name = "Cog4"
			
			CogClone5.Parent = char
			CogClone5.Name = "Cog5"
			
			CogClone6.Parent = char
			CogClone6.Name = "Cog6"
			
			CogClone7.Parent = char
			CogClone7.Name = "Cog7"
			
			CogClone8.Parent = char
			CogClone8.Name = "Cog8"
			
			CogClone9.Parent = char
			CogClone9.Name = "Cog9"
			
			CogClone10.Parent = char
			CogClone10.Name = "Cog10"
			
			CogClone11.Parent = char
			CogClone11.Name = "Cog11"
		end
	end
end