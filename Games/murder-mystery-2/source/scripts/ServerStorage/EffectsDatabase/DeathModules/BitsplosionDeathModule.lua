return function(char)
	for _, v in pairs(char:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			local notahead = char.head
			local HeadBlockMesh = Instance.new("BlockMesh",char.notahead)
			char.notahead.BrickColor = BrickColor.new("Really red")
			char.notahead.face:Destroy()
			char.notahead.Anchored = false
			char.notahead.Size = Vector3.new(0.5, 0.5, 0.5)

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

			for i,e in pairs(char:GetChildren()) do
				if e:IsA("Accessory") then
					e:Destroy()


					for i,r in pairs(char:GetChildren()) do
						if r:IsA("BasePart") then
						end
					end
					
					-- CLONES

					local RedClone1 = notahead:Clone()
					local RedClone2 = notahead:Clone()
					local RedClone3 = notahead:Clone()
					local RedClone4 = notahead:Clone()
					local RedClone5 = notahead:Clone()
					local RedClone6 = notahead:Clone()
					local RedClone7 = notahead:Clone()
					local RedClone8 = notahead:Clone()
					
					local YellowClone1 = notahead:Clone()
					local YellowClone2 = notahead:Clone()
					local YellowClone3 = notahead:Clone()
					local YellowClone4 = notahead:Clone()
					local YellowClone5 = notahead:Clone()
					local YellowClone6 = notahead:Clone()
					local YellowClone7 = notahead:Clone()
					local YellowClone8 = notahead:Clone()
					
					local GreenClone1 = notahead:Clone()
					local GreenClone2 = notahead:Clone()
					local GreenClone3 = notahead:Clone()
					local GreenClone4 = notahead:Clone()
					local GreenClone5 = notahead:Clone()
					local GreenClone6 = notahead:Clone()
					local GreenClone7 = notahead:Clone()
					local GreenClone8 = notahead:Clone()
					
					local BlueClone1 = notahead:Clone()
					local BlueClone2 = notahead:Clone()
					local BlueClone3 = notahead:Clone()
					local BlueClone4 = notahead:Clone()
					local BlueClone5 = notahead:Clone()
					local BlueClone6 = notahead:Clone()
					local BlueClone7 = notahead:Clone()
					local BlueClone8 = notahead:Clone()
					
					local PinkClone1 = notahead:Clone()
					local PinkClone2 = notahead:Clone()
					local PinkClone3 = notahead:Clone()
					local PinkClone4 = notahead:Clone()
					local PinkClone5 = notahead:Clone()
					local PinkClone6 = notahead:Clone()
					local PinkClone7 = notahead:Clone()
					local PinkClone8 = notahead:Clone()
					
					-- RED
					
					RedClone1.Parent = char
					RedClone1.Name = "Red"
					
					RedClone2.Parent = char
					RedClone2.Name = "Red"
					
					RedClone3.Parent = char
					RedClone3.Name = "Red"
					
					RedClone4.Parent = char
					RedClone4.Name = "Red"
					
					RedClone5.Parent = char
					RedClone5.Name = "Red"
					
					RedClone6.Parent = char
					RedClone6.Name = "Red"
					
					RedClone7.Parent = char
					RedClone7.Name = "Red"
					
					RedClone8.Parent = char
					RedClone8.Name = "Red"
					
					-- YELLOW
					
					YellowClone1.Parent = char
					YellowClone1.Name = "Yellow"
					YellowClone1.BrickColor = BrickColor.new("New Yeller")

					YellowClone2.Parent = char
					YellowClone2.Name = "Yellow"
					YellowClone2.BrickColor = BrickColor.new("New Yeller")

					YellowClone3.Parent = char
					YellowClone3.Name = "Yellow"
					YellowClone3.BrickColor = BrickColor.new("New Yeller")

					YellowClone4.Parent = char
					YellowClone4.Name = "Yellow"
					YellowClone4.BrickColor = BrickColor.new("New Yeller")

					YellowClone5.Parent = char
					YellowClone5.Name = "Yellow"
					YellowClone5.BrickColor = BrickColor.new("New Yeller")

					YellowClone6.Parent = char
					YellowClone6.Name = "Yellow"
					YellowClone6.BrickColor = BrickColor.new("New Yeller")

					YellowClone7.Parent = char
					YellowClone7.Name = "Yellow"
					YellowClone7.BrickColor = BrickColor.new("New Yeller")

					YellowClone8.Parent = char
					YellowClone8.Name = "Yellow"
					YellowClone8.BrickColor = BrickColor.new("New Yeller")
					
					-- GREEN
					
					GreenClone1.Parent = char
					GreenClone1.Name = "Green"
					GreenClone1.BrickColor = BrickColor.new("Lime green")

					GreenClone2.Parent = char
					GreenClone2.Name = "Green"
					GreenClone2.BrickColor = BrickColor.new("Lime green")

					GreenClone3.Parent = char
					GreenClone3.Name = "Green"
					GreenClone3.BrickColor = BrickColor.new("Lime green")

					GreenClone4.Parent = char
					GreenClone4.Name = "Green"
					GreenClone4.BrickColor = BrickColor.new("Lime green")

					GreenClone5.Parent = char
					GreenClone5.Name = "Green"
					GreenClone5.BrickColor = BrickColor.new("Lime green")

					GreenClone6.Parent = char
					GreenClone6.Name = "Green"
					GreenClone6.BrickColor = BrickColor.new("Lime green")

					GreenClone7.Parent = char
					GreenClone7.Name = "Green"
					GreenClone7.BrickColor = BrickColor.new("Lime green")

					GreenClone8.Parent = char
					GreenClone8.Name = "Green"
					GreenClone8.BrickColor = BrickColor.new("Lime green")
					
					-- BLUE
					
					BlueClone1.Parent = char
					BlueClone1.Name = "Blue"
					BlueClone1.BrickColor = BrickColor.new("Really blue")
					
					BlueClone2.Parent = char
					BlueClone2.Name = "Blue"
					BlueClone2.BrickColor = BrickColor.new("Really blue")
					
					BlueClone3.Parent = char
					BlueClone3.Name = "Blue"
					BlueClone3.BrickColor = BrickColor.new("Really blue")
					
					BlueClone4.Parent = char
					BlueClone4.Name = "Blue"
					BlueClone4.BrickColor = BrickColor.new("Really blue")
					
					BlueClone5.Parent = char
					BlueClone5.Name = "Blue"
					BlueClone5.BrickColor = BrickColor.new("Really blue")
					
					BlueClone6.Parent = char
					BlueClone6.Name = "Blue"
					BlueClone6.BrickColor = BrickColor.new("Really blue")
					
					BlueClone7.Parent = char
					BlueClone7.Name = "Blue"
					BlueClone7.BrickColor = BrickColor.new("Really blue")
					
					BlueClone8.Parent = char
					BlueClone8.Name = "Blue"
					BlueClone8.BrickColor = BrickColor.new("Really blue")
					
					-- PINK
					
					PinkClone1.Parent = char
					PinkClone1.Name = "Pink"
					PinkClone1.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone2.Parent = char
					PinkClone2.Name = "Pink"
					PinkClone2.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone3.Parent = char
					PinkClone3.Name = "Pink"
					PinkClone3.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone4.Parent = char
					PinkClone4.Name = "Pink"
					PinkClone4.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone5.Parent = char
					PinkClone5.Name = "Pink"
					PinkClone5.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone6.Parent = char
					PinkClone6.Name = "Pink"
					PinkClone6.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone7.Parent = char
					PinkClone7.Name = "Pink"
					PinkClone7.BrickColor = BrickColor.new("Hot pink")
					
					PinkClone8.Parent = char
					PinkClone8.Name = "Pink"
					PinkClone8.BrickColor = BrickColor.new("Hot pink")
				end
			end
		end
	end
end
