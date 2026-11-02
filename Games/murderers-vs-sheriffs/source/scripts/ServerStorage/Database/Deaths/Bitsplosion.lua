local function killeffect(rag)
	if rag ~= nil then
		if rag:FindFirstChild("Shirt") then
			rag.Shirt:Destroy()
		end
		if rag:FindFirstChild("Pants") then
			rag.Pants:Destroy()
		end
		local children = rag:GetChildren()
		for c = 1, #children do
			if children[c].ClassName == "Accessory" or children[c].ClassName == "Hat" then
				children[c]:Destroy()
			end
		end
		-- red parts
		local redpart1 = Instance.new("Part",rag)
		redpart1.Name = "Red"
		redpart1.Size = Vector3.new(0.5, 0.5, 0.5)
		redpart1.Material = Enum.Material.SmoothPlastic
		redpart1.BrickColor = BrickColor.new("Really red")
		redpart1.CFrame = rag.UpperTorso.CFrame 
		redpart1.Orientation = Vector3.new(54, 42, 64)

		local redpart2 = Instance.new("Part",rag)
		redpart2.Name = "Red"
		redpart2.Size = Vector3.new(0.5,0.5,0.5)
		redpart2.Material = Enum.Material.SmoothPlastic
		redpart2.BrickColor = BrickColor.new("Really red")
		redpart2.CFrame = rag.UpperTorso.CFrame
		redpart2.Orientation = Vector3.new(53, 64, 24)

		local redpart3 = Instance.new("Part",rag)
		redpart3.Name = "Red"
		redpart3.Size = Vector3.new(0.5,0.5,0.5)
		redpart3.Material = Enum.Material.SmoothPlastic
		redpart3.BrickColor = BrickColor.new("Really red")
		redpart3.CFrame = rag.UpperTorso.CFrame
		redpart3.Orientation = Vector3.new(32, 53, 46)

		local redpart4 = Instance.new("Part",rag)
		redpart4.Name = "Red"
		redpart4.Size = Vector3.new(0.5,0.5,0.5)
		redpart4.Material = Enum.Material.SmoothPlastic
		redpart4.BrickColor = BrickColor.new("Really red")
		redpart4.CFrame = rag.UpperTorso.CFrame
		redpart4.Orientation = Vector3.new(21, 13, 43)

		local redpart5 = Instance.new("Part",rag)
		redpart5.Name = "Red"
		redpart5.Size = Vector3.new(0.5,0.5,0.5)
		redpart5.Material = Enum.Material.SmoothPlastic
		redpart5.BrickColor = BrickColor.new("Really red")
		redpart5.CFrame = rag.UpperTorso.CFrame
		redpart5.Orientation = Vector3.new(34, 24, 24)

		local redpart6 = Instance.new("Part",rag)
		redpart6.Name = "Red"
		redpart6.Size = Vector3.new(0.5,0.5,0.5)
		redpart6.Material = Enum.Material.SmoothPlastic
		redpart6.BrickColor = BrickColor.new("Really red")
		redpart6.CFrame = rag.UpperTorso.CFrame
		redpart6.Orientation = Vector3.new(53, 53, 24)

		local redpart7 = Instance.new("Part",rag)
		redpart7.Name = "Red"
		redpart7.Size = Vector3.new(0.5,0.5,0.5)
		redpart7.Material = Enum.Material.SmoothPlastic
		redpart7.BrickColor = BrickColor.new("Really red")
		redpart7.CFrame = rag.UpperTorso.CFrame
		redpart7.Orientation = Vector3.new(32, 45, 42)

		local redpart8 = Instance.new("Part",rag)
		redpart8.Name = "Red"
		redpart8.Size = Vector3.new(0.5,0.5,0.5)
		redpart8.Material = Enum.Material.SmoothPlastic
		redpart8.BrickColor = BrickColor.new("Really red")
		redpart8.CFrame = rag.UpperTorso.CFrame
		redpart8.Orientation = Vector3.new(32, 53, 24)

		local redpart9 = Instance.new("Part",rag)
		redpart9.Name = "Red"
		redpart9.Size = Vector3.new(0.5,0.5,0.5)
		redpart9.Material = Enum.Material.SmoothPlastic
		redpart9.BrickColor = BrickColor.new("Really red")
		redpart9.CFrame = rag.UpperTorso.CFrame
		redpart9.Orientation = Vector3.new(32, 53, 24)

		local redpart10 = Instance.new("Part",rag)
		redpart10.Name = "Red"
		redpart10.Size = Vector3.new(0.5,0.5,0.5)
		redpart10.Material = Enum.Material.SmoothPlastic
		redpart10.BrickColor = BrickColor.new("Really red")
		redpart10.CFrame = rag.UpperTorso.CFrame
		redpart10.Orientation = Vector3.new(32, 53, 24)

		local redpart11 = Instance.new("Part",rag)
		redpart11.Name = "Red"
		redpart11.Size = Vector3.new(0.5,0.5,0.5)
		redpart11.Material = Enum.Material.SmoothPlastic
		redpart11.BrickColor = BrickColor.new("Really red")
		redpart11.CFrame = rag.UpperTorso.CFrame
		redpart11.Orientation = Vector3.new(32, 53, 24)

		local redpart12 = Instance.new("Part",rag)
		redpart12.Name = "Red"
		redpart12.Size = Vector3.new(0.5,0.5,0.5)
		redpart12.Material = Enum.Material.SmoothPlastic
		redpart12.BrickColor = BrickColor.new("Really red")
		redpart12.CFrame = rag.UpperTorso.CFrame
		redpart12.Orientation = Vector3.new(32, 53, 24)

		local redpart13 = Instance.new("Part",rag)
		redpart13.Name = "Red"
		redpart13.Size = Vector3.new(0.5,0.5,0.5)
		redpart13.Material = Enum.Material.SmoothPlastic
		redpart13.BrickColor = BrickColor.new("Really red")
		redpart13.CFrame = rag.UpperTorso.CFrame
		redpart13.Orientation = Vector3.new(52, 27, 72)

		local redpart14 = Instance.new("Part",rag)
		redpart14.Name = "Red"
		redpart14.Size = Vector3.new(0.5,0.5,0.5)
		redpart14.Material = Enum.Material.SmoothPlastic
		redpart14.BrickColor = BrickColor.new("Really red")
		redpart14.CFrame = rag.UpperTorso.CFrame
		redpart14.Orientation = Vector3.new(52, 26, 42)

		local redpart15 = Instance.new("Part",rag)
		redpart15.Name = "Red"
		redpart15.Size = Vector3.new(0.5,0.5,0.5)
		redpart15.Material = Enum.Material.SmoothPlastic
		redpart15.BrickColor = BrickColor.new("Really red")
		redpart15.CFrame = rag.UpperTorso.CFrame
		redpart15.Orientation = Vector3.new(52, 26, 42)

		-- yellow parts

		local yellowpart1 = Instance.new("Part",rag)
		yellowpart1.Name = "Yellow"
		yellowpart1.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart1.Material = Enum.Material.SmoothPlastic
		yellowpart1.BrickColor = BrickColor.new("New Yeller")
		yellowpart1.CFrame = rag.UpperTorso.CFrame
		yellowpart1.Orientation = Vector3.new(53, 200, 13)

		local yellowpart2 = Instance.new("Part",rag)
		yellowpart2.Name = "Yellow"
		yellowpart2.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart2.Material = Enum.Material.SmoothPlastic
		yellowpart2.BrickColor = BrickColor.new("New Yeller")
		yellowpart2.CFrame = rag.UpperTorso.CFrame
		yellowpart2.Orientation = Vector3.new(42, 45, 89)

		local yellowpart3 = Instance.new("Part",rag)
		yellowpart3.Name = "Yellow"
		yellowpart3.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart3.Material = Enum.Material.SmoothPlastic
		yellowpart3.BrickColor = BrickColor.new("New Yeller")
		yellowpart3.CFrame = rag.UpperTorso.CFrame
		yellowpart3.Orientation = Vector3.new(42, 67, 76)

		local yellowpart4 = Instance.new("Part",rag)
		yellowpart4.Name = "Yellow"
		yellowpart4.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart4.Material = Enum.Material.SmoothPlastic
		yellowpart4.BrickColor = BrickColor.new("New Yeller")
		yellowpart4.CFrame = rag.UpperTorso.CFrame
		yellowpart4.Orientation = Vector3.new(13, 53, 24)

		local yellowpart5 = Instance.new("Part",rag)
		yellowpart5.Name = "Yellow"
		yellowpart5.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart5.Material = Enum.Material.SmoothPlastic
		yellowpart5.BrickColor = BrickColor.new("New Yeller")
		yellowpart5.CFrame = rag.UpperTorso.CFrame
		yellowpart5.Orientation = Vector3.new(63, 24, 57)

		local yellowpart6 = Instance.new("Part",rag)
		yellowpart6.Name = "Yellow"
		yellowpart6.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart6.Material = Enum.Material.SmoothPlastic
		yellowpart6.BrickColor = BrickColor.new("New Yeller")
		yellowpart6.CFrame = rag.UpperTorso.CFrame
		yellowpart6.Orientation = Vector3.new(42, 53, 52)

		local yellowpart7 = Instance.new("Part",rag)
		yellowpart7.Name = "Yellow"
		yellowpart7.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart7.Material = Enum.Material.SmoothPlastic
		yellowpart7.BrickColor = BrickColor.new("New Yeller")
		yellowpart7.CFrame = rag.UpperTorso.CFrame
		yellowpart7.Orientation = Vector3.new(42, 54, 21)

		local yellowpart8 = Instance.new("Part",rag)
		yellowpart8.Name = "Yellow"
		yellowpart8.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart8.Material = Enum.Material.SmoothPlastic
		yellowpart8.BrickColor = BrickColor.new("New Yeller")
		yellowpart8.CFrame = rag.UpperTorso.CFrame
		yellowpart8.Orientation = Vector3.new(42, 54, 21)

		local yellowpart9 = Instance.new("Part",rag)
		yellowpart9.Name = "Yellow"
		yellowpart9.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart9.Material = Enum.Material.SmoothPlastic
		yellowpart9.BrickColor = BrickColor.new("New Yeller")
		yellowpart9.CFrame = rag.UpperTorso.CFrame
		yellowpart9.Orientation = Vector3.new(42, 54, 21)

		local yellowpart10 = Instance.new("Part",rag)
		yellowpart10.Name = "Yellow"
		yellowpart10.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart10.Material = Enum.Material.SmoothPlastic
		yellowpart10.BrickColor = BrickColor.new("New Yeller")
		yellowpart10.CFrame = rag.UpperTorso.CFrame
		yellowpart10.Orientation = Vector3.new(42, 54, 21)

		local yellowpart11 = Instance.new("Part",rag)
		yellowpart11.Name = "Yellow"
		yellowpart11.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart11.Material = Enum.Material.SmoothPlastic
		yellowpart11.BrickColor = BrickColor.new("New Yeller")
		yellowpart11.CFrame = rag.UpperTorso.CFrame
		yellowpart11.Orientation = Vector3.new(42, 54, 21)

		local yellowpart12 = Instance.new("Part",rag)
		yellowpart12.Name = "Yellow"
		yellowpart12.Size = Vector3.new(0.5,0.5,0.5)
		yellowpart12.Material = Enum.Material.SmoothPlastic
		yellowpart12.BrickColor = BrickColor.new("New Yeller")
		yellowpart12.CFrame = rag.UpperTorso.CFrame
		yellowpart12.Orientation = Vector3.new(42, 54, 21)

		-- Blue parts

		local bluepart1 = Instance.new("Part",rag)
		bluepart1.Name = "Blue"
		bluepart1.Size = Vector3.new(0.5,0.5,0.5)
		bluepart1.Material = Enum.Material.SmoothPlastic
		bluepart1.BrickColor = BrickColor.new("Really blue")
		bluepart1.CFrame = rag.UpperTorso.CFrame
		bluepart1.Orientation = Vector3.new(21, 72, 65)

		local bluepart2 = Instance.new("Part",rag)
		bluepart2.Name = "Blue"
		bluepart2.Size = Vector3.new(0.5,0.5,0.5)
		bluepart2.Material = Enum.Material.SmoothPlastic
		bluepart2.BrickColor = BrickColor.new("Really blue")
		bluepart2.CFrame = rag.UpperTorso.CFrame
		bluepart2.Orientation = Vector3.new(64, 52, 13)

		local bluepart3 = Instance.new("Part",rag)
		bluepart3.Name = "Blue"
		bluepart3.Size = Vector3.new(0.5,0.5,0.5)
		bluepart3.Material = Enum.Material.SmoothPlastic
		bluepart3.BrickColor = BrickColor.new("Really blue")
		bluepart3.CFrame = rag.UpperTorso.CFrame
		bluepart3.Orientation = Vector3.new(42, 24, 13)

		local bluepart4 = Instance.new("Part",rag)
		bluepart4.Name = "Blue"
		bluepart4.Size = Vector3.new(0.5,0.5,0.5)
		bluepart4.Material = Enum.Material.SmoothPlastic
		bluepart4.BrickColor = BrickColor.new("Really blue")
		bluepart4.CFrame = rag.UpperTorso.CFrame
		bluepart4.Orientation = Vector3.new(43, 63, 24)

		local bluepart5 = Instance.new("Part",rag)
		bluepart5.Name = "Blue"
		bluepart5.Size = Vector3.new(0.5,0.5,0.5)
		bluepart5.Material = Enum.Material.SmoothPlastic
		bluepart5.BrickColor = BrickColor.new("Really blue")
		bluepart5.CFrame = rag.UpperTorso.CFrame
		bluepart5.Orientation = Vector3.new(64, 24, 25)

		local bluepart6 = Instance.new("Part",rag)
		bluepart6.Name = "Blue"
		bluepart6.Size = Vector3.new(0.5,0.5,0.5)
		bluepart6.Material = Enum.Material.SmoothPlastic
		bluepart6.BrickColor = BrickColor.new("Really blue")
		bluepart6.CFrame = rag.UpperTorso.CFrame
		bluepart6.Orientation = Vector3.new(21, 15, 23)

		local bluepart7 = Instance.new("Part",rag)
		bluepart7.Name = "Blue"
		bluepart7.Size = Vector3.new(0.5,0.5,0.5)
		bluepart7.Material = Enum.Material.SmoothPlastic
		bluepart7.BrickColor = BrickColor.new("Really blue")
		bluepart7.CFrame = rag.UpperTorso.CFrame
		bluepart7.Orientation = Vector3.new(42, 42, 52)

		local bluepart8 = Instance.new("Part",rag)
		bluepart8.Name = "Blue"
		bluepart8.Size = Vector3.new(0.5,0.5,0.5)
		bluepart8.Material = Enum.Material.SmoothPlastic
		bluepart8.BrickColor = BrickColor.new("Really blue")
		bluepart8.CFrame = rag.UpperTorso.CFrame
		bluepart8.Orientation = Vector3.new(35, 57, 31)

		local bluepart9 = Instance.new("Part",rag)
		bluepart9.Name = "Blue"
		bluepart9.Size = Vector3.new(0.5,0.5,0.5)
		bluepart9.Material = Enum.Material.SmoothPlastic
		bluepart9.BrickColor = BrickColor.new("Really blue")
		bluepart9.CFrame = rag.UpperTorso.CFrame
		bluepart9.Orientation = Vector3.new(35, 57, 31)

		local bluepart10 = Instance.new("Part",rag)
		bluepart10.Name = "Blue"
		bluepart10.Size = Vector3.new(0.5,0.5,0.5)
		bluepart10.Material = Enum.Material.SmoothPlastic
		bluepart10.BrickColor = BrickColor.new("Really blue")
		bluepart10.CFrame = rag.UpperTorso.CFrame
		bluepart10.Orientation = Vector3.new(35, 57, 31)

		local bluepart11 = Instance.new("Part",rag)
		bluepart11.Name = "Blue"
		bluepart11.Size = Vector3.new(0.5,0.5,0.5)
		bluepart11.Material = Enum.Material.SmoothPlastic
		bluepart11.BrickColor = BrickColor.new("Really blue")
		bluepart11.CFrame = rag.UpperTorso.CFrame
		bluepart11.Orientation = Vector3.new(35, 57, 31)

		local bluepart12 = Instance.new("Part",rag)
		bluepart12.Name = "Blue"
		bluepart12.Size = Vector3.new(0.5,0.5,0.5)
		bluepart12.Material = Enum.Material.SmoothPlastic
		bluepart12.BrickColor = BrickColor.new("Really blue")
		bluepart12.CFrame = rag.UpperTorso.CFrame
		bluepart12.Orientation = Vector3.new(35, 57, 31)

		local bluepart13= Instance.new("Part",rag)
		bluepart13.Name = "Blue"
		bluepart13.Size = Vector3.new(0.5,0.5,0.5)
		bluepart13.Material = Enum.Material.SmoothPlastic
		bluepart13.BrickColor = BrickColor.new("Really blue")
		bluepart13.CFrame = rag.UpperTorso.CFrame
		bluepart13.Orientation = Vector3.new(47, 53, 23)

		local bluepart14= Instance.new("Part",rag)
		bluepart14.Name = "Blue"
		bluepart14.Size = Vector3.new(0.5,0.5,0.5)
		bluepart14.Material = Enum.Material.SmoothPlastic
		bluepart14.BrickColor = BrickColor.new("Really blue")
		bluepart14.CFrame = rag.UpperTorso.CFrame
		bluepart14.Orientation = Vector3.new(47, 53, 23)

		local bluepart15= Instance.new("Part",rag)
		bluepart15.Name = "Blue"
		bluepart15.Size = Vector3.new(0.5,0.5,0.5)
		bluepart15.Material = Enum.Material.SmoothPlastic
		bluepart15.BrickColor = BrickColor.new("Really blue")
		bluepart15.CFrame = rag.UpperTorso.CFrame
		bluepart15.Orientation = Vector3.new(25, 35, 52)

		-- green parts

		local greenpart1 = Instance.new("Part",rag)
		greenpart1.Name = "Green"
		greenpart1.Size = Vector3.new(0.5,0.5,0.5)
		greenpart1.Material = Enum.Material.SmoothPlastic
		greenpart1.BrickColor = BrickColor.new("Lime green")
		greenpart1.CFrame = rag.UpperTorso.CFrame
		greenpart1.Orientation = Vector3.new(25, 62, 24)

		local greenpart2 = Instance.new("Part",rag)
		greenpart2.Name = "Green"
		greenpart2.Size = Vector3.new(0.5,0.5,0.5)
		greenpart2.Material = Enum.Material.SmoothPlastic
		greenpart2.BrickColor = BrickColor.new("Lime green")
		greenpart2.CFrame = rag.UpperTorso.CFrame
		greenpart2.Orientation = Vector3.new(24, 52, 244)

		local greenpart3 = Instance.new("Part",rag)
		greenpart3.Name = "Green"
		greenpart3.Size = Vector3.new(0.5,0.5,0.5)
		greenpart3.Material = Enum.Material.SmoothPlastic
		greenpart3.BrickColor = BrickColor.new("Lime green")
		greenpart3.CFrame = rag.UpperTorso.CFrame
		greenpart3.Orientation = Vector3.new(34, 21, 42)

		local greenpart4 = Instance.new("Part",rag)
		greenpart4.Name = "Green"
		greenpart4.Size = Vector3.new(0.5,0.5,0.5)
		greenpart4.Material = Enum.Material.SmoothPlastic
		greenpart4.BrickColor = BrickColor.new("Lime green")
		greenpart4.CFrame = rag.UpperTorso.CFrame
		greenpart4.Orientation = Vector3.new(42, 56, 13)

		local greenpart5 = Instance.new("Part",rag)
		greenpart5.Name = "Green"
		greenpart5.Size = Vector3.new(0.5,0.5,0.5)
		greenpart5.Material = Enum.Material.SmoothPlastic
		greenpart5.BrickColor = BrickColor.new("Lime green")
		greenpart5.CFrame = rag.UpperTorso.CFrame
		greenpart5.Orientation = Vector3.new(73, 63, 21)

		local greenpart6 = Instance.new("Part",rag)
		greenpart6.Name = "Green"
		greenpart6.Size = Vector3.new(0.5,0.5,0.5)
		greenpart6.Material = Enum.Material.SmoothPlastic
		greenpart6.BrickColor = BrickColor.new("Lime green")
		greenpart6.CFrame = rag.UpperTorso.CFrame
		greenpart6.Orientation = Vector3.new(31, 35, 51)

		local greenpart7 = Instance.new("Part",rag)
		greenpart7.Name = "Green"
		greenpart7.Size = Vector3.new(0.5,0.5,0.5)
		greenpart7.Material = Enum.Material.SmoothPlastic
		greenpart7.BrickColor = BrickColor.new("Lime green")
		greenpart7.CFrame = rag.UpperTorso.CFrame
		greenpart7.Orientation = Vector3.new(63, 24, 56)

		local greenpart8 = Instance.new("Part",rag)
		greenpart8.Name = "Green"
		greenpart8.Size = Vector3.new(0.5,0.5,0.5)
		greenpart8.Material = Enum.Material.SmoothPlastic
		greenpart8.BrickColor = BrickColor.new("Lime green")
		greenpart8.CFrame = rag.UpperTorso.CFrame
		greenpart8.Orientation = Vector3.new(31, 41, 47)

		local greenpart9 = Instance.new("Part",rag)
		greenpart9.Name = "Green"
		greenpart9.Size = Vector3.new(0.5,0.5,0.5)
		greenpart9.Material = Enum.Material.SmoothPlastic
		greenpart9.BrickColor = BrickColor.new("Lime green")
		greenpart9.CFrame = rag.UpperTorso.CFrame
		greenpart9.Orientation = Vector3.new(31, 41, 47)

		local greenpart10 = Instance.new("Part",rag)
		greenpart10.Name = "Green"
		greenpart10.Size = Vector3.new(0.5,0.5,0.5)
		greenpart10.Material = Enum.Material.SmoothPlastic
		greenpart10.BrickColor = BrickColor.new("Lime green")
		greenpart10.CFrame = rag.UpperTorso.CFrame
		greenpart10.Orientation = Vector3.new(31, 41, 47)

		local greenpart11 = Instance.new("Part",rag)
		greenpart11.Name = "Green"
		greenpart11.Size = Vector3.new(0.5,0.5,0.5)
		greenpart11.Material = Enum.Material.SmoothPlastic
		greenpart11.BrickColor = BrickColor.new("Lime green")
		greenpart11.CFrame = rag.UpperTorso.CFrame
		greenpart11.Orientation = Vector3.new(31, 41, 47)

		local greenpart12 = Instance.new("Part",rag)
		greenpart12.Name = "Green"
		greenpart12.Size = Vector3.new(0.5,0.5,0.5)
		greenpart12.Material = Enum.Material.SmoothPlastic
		greenpart12.BrickColor = BrickColor.new("Lime green")
		greenpart12.CFrame = rag.UpperTorso.CFrame
		greenpart12.Orientation = Vector3.new(31, 41, 47)

		local greenpart13 = Instance.new("Part",rag)
		greenpart13.Name = "Green"
		greenpart13.Size = Vector3.new(0.5,0.5,0.5)
		greenpart13.Material = Enum.Material.SmoothPlastic
		greenpart13.BrickColor = BrickColor.new("Lime green")
		greenpart13.CFrame = rag.UpperTorso.CFrame
		greenpart13.Orientation = Vector3.new(25, 36, 26)

		local greenpart14 = Instance.new("Part",rag)
		greenpart14.Name = "Green"
		greenpart14.Size = Vector3.new(0.5,0.5,0.5)
		greenpart14.Material = Enum.Material.SmoothPlastic
		greenpart14.BrickColor = BrickColor.new("Lime green")
		greenpart14.CFrame = rag.UpperTorso.CFrame
		greenpart14.Orientation = Vector3.new(24, 64, 23)

		local greenpart15 = Instance.new("Part",rag)
		greenpart15.Name = "Green"
		greenpart15.Size = Vector3.new(0.5,0.5,0.5)
		greenpart15.Material = Enum.Material.SmoothPlastic
		greenpart15.BrickColor = BrickColor.new("Lime green")
		greenpart15.CFrame = rag.UpperTorso.CFrame
		greenpart15.Orientation = Vector3.new(24, 64, 37)


		-- pink parts

		local pinkpart1 = Instance.new("Part",rag)
		pinkpart1.Name = "Pink"
		pinkpart1.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart1.Material = Enum.Material.SmoothPlastic
		pinkpart1.BrickColor = BrickColor.new("Hot pink")
		pinkpart1.CFrame = rag.UpperTorso.CFrame
		pinkpart1.Orientation = Vector3.new(52, 52, 45)

		local pinkpart2 = Instance.new("Part",rag)
		pinkpart2.Name = "Pink"
		pinkpart2.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart2.Material = Enum.Material.SmoothPlastic
		pinkpart2.BrickColor = BrickColor.new("Hot pink")
		pinkpart2.CFrame = rag.UpperTorso.CFrame
		pinkpart2.Orientation = Vector3.new(62, 52, 14)

		local pinkpart3 = Instance.new("Part",rag)
		pinkpart3.Name = "Pink"
		pinkpart3.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart3.Material = Enum.Material.SmoothPlastic
		pinkpart3.BrickColor = BrickColor.new("Hot pink")
		pinkpart3.CFrame = rag.UpperTorso.CFrame
		pinkpart3.Orientation = Vector3.new(52, 42, 24)

		local pinkpart4 = Instance.new("Part",rag)
		pinkpart4.Name = "Pink"
		pinkpart4.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart4.Material = Enum.Material.SmoothPlastic
		pinkpart4.BrickColor = BrickColor.new("Hot pink")
		pinkpart4.CFrame = rag.UpperTorso.CFrame
		pinkpart4.Orientation = Vector3.new(52, 42, 24)

		local pinkpart5 = Instance.new("Part",rag)
		pinkpart5.Name = "Pink"
		pinkpart5.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart5.Material = Enum.Material.SmoothPlastic
		pinkpart5.BrickColor = BrickColor.new("Hot pink")
		pinkpart5.CFrame = rag.UpperTorso.CFrame
		pinkpart5.Orientation = Vector3.new(32, 13, 35)

		local pinkpart6 = Instance.new("Part",rag)
		pinkpart6.Name = "Pink"
		pinkpart6.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart6.Material = Enum.Material.SmoothPlastic
		pinkpart6.BrickColor = BrickColor.new("Hot pink")
		pinkpart6.CFrame = rag.UpperTorso.CFrame
		pinkpart6.Orientation = Vector3.new(25, 13, 63)

		local pinkpart7 = Instance.new("Part",rag)
		pinkpart7.Name = "Pink"
		pinkpart7.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart7.Material = Enum.Material.SmoothPlastic
		pinkpart7.BrickColor = BrickColor.new("Hot pink")
		pinkpart7.CFrame = rag.UpperTorso.CFrame
		pinkpart7.Orientation = Vector3.new(13, 42, 52)

		local pinkpart8 = Instance.new("Part",rag)
		pinkpart8.Name = "Pink"
		pinkpart8.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart8.Material = Enum.Material.SmoothPlastic
		pinkpart8.BrickColor = BrickColor.new("Hot pink")
		pinkpart8.CFrame = rag.UpperTorso.CFrame
		pinkpart8.Orientation = Vector3.new(62, 124, 24)

		local pinkpart9 = Instance.new("Part",rag)
		pinkpart9.Name = "Pink"
		pinkpart9.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart9.Material = Enum.Material.SmoothPlastic
		pinkpart9.BrickColor = BrickColor.new("Hot pink")
		pinkpart9.CFrame = rag.UpperTorso.CFrame
		pinkpart9.Orientation = Vector3.new(62, 124, 24)

		local pinkpart10 = Instance.new("Part",rag)
		pinkpart10.Name = "Pink"
		pinkpart10.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart10.Material = Enum.Material.SmoothPlastic
		pinkpart10.BrickColor = BrickColor.new("Hot pink")
		pinkpart10.CFrame = rag.UpperTorso.CFrame
		pinkpart10.Orientation = Vector3.new(62, 124, 24)

		local pinkpart11 = Instance.new("Part",rag)
		pinkpart11.Name = "Pink"
		pinkpart11.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart11.Material = Enum.Material.SmoothPlastic
		pinkpart11.BrickColor = BrickColor.new("Hot pink")
		pinkpart11.CFrame = rag.UpperTorso.CFrame
		pinkpart11.Orientation = Vector3.new(62, 124, 24)

		local pinkpart12 = Instance.new("Part",rag)
		pinkpart12.Name = "Pink"
		pinkpart12.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart12.Material = Enum.Material.SmoothPlastic
		pinkpart12.BrickColor = BrickColor.new("Hot pink")
		pinkpart12.CFrame = rag.UpperTorso.CFrame
		pinkpart12.Orientation = Vector3.new(62, 124, 24)

		local pinkpart13 = Instance.new("Part",rag)
		pinkpart13.Name = "Pink"
		pinkpart13.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart13.Material = Enum.Material.SmoothPlastic
		pinkpart13.BrickColor = BrickColor.new("Hot pink")
		pinkpart13.CFrame = rag.UpperTorso.CFrame
		pinkpart13.Orientation = Vector3.new(47, 36, 36)

		local pinkpart14 = Instance.new("Part",rag)
		pinkpart14.Name = "Pink"
		pinkpart14.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart14.Material = Enum.Material.SmoothPlastic
		pinkpart14.BrickColor = BrickColor.new("Hot pink")
		pinkpart14.CFrame = rag.UpperTorso.CFrame
		pinkpart14.Orientation = Vector3.new(84, 64, 25)

		local pinkpart15 = Instance.new("Part",rag)
		pinkpart15.Name = "Pink"
		pinkpart15.Size = Vector3.new(0.5,0.5,0.5)
		pinkpart15.Material = Enum.Material.SmoothPlastic
		pinkpart15.BrickColor = BrickColor.new("Hot pink")
		pinkpart15.CFrame = rag.UpperTorso.CFrame
		pinkpart15.Orientation = Vector3.new(84, 64, 25)

		rag["LeftFoot"]:Destroy()
		rag["LeftHand"]:Destroy()
		rag["LeftLowerArm"]:Destroy()
		rag["LeftLowerLeg"]:Destroy()
		rag["LeftUpperArm"]:Destroy()
		rag["LeftUpperLeg"]:Destroy()
		rag["LowerTorso"]:Destroy()
		rag["RightFoot"]:Destroy()
		rag["RightHand"]:Destroy()
		rag["RightLowerArm"]:Destroy()
		rag["RightLowerLeg"]:Destroy()
		rag["RightUpperArm"]:Destroy()
		rag["RightUpperLeg"]:Destroy()
		rag["UpperTorso"]:Destroy()
		rag["Head"]:Destroy()
	end
end

return killeffect