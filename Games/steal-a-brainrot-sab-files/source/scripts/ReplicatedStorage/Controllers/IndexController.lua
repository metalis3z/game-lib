-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Synchronizer = require(Packages.Synchronizer)
local Trove = require(Packages.Trove)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local Animals = require(Datas.Animals)
local Rarities = require(Datas.Rarities)
local Mutations = require(Datas.Mutations)
local Index = require(ReplicatedStorage.Datas.Index)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Animals2 = require(Shared.Animals)
local Index2 = require(Shared.Index)
local Updates = require(Shared.Updates)
local MutationText = require(Shared.MutationText)
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local HoverInfoController = require(Controllers.HoverInfoController)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local LocalPlayer = Players.LocalPlayer
local Index3 = LocalPlayer.PlayerGui:WaitForChild("Index").Index
local Header = Index3.Main.Header
local Close = Header.Close
local SearchBox = Header.SearchFrame.SearchBox
local List = Index3.Main.Content.Holder.List
local Template = List.Template
local Mutations2 = Index3.Main.Mutations
local Template2 = Mutations2.Template
local Progress = Index3.Progress
local Description = Progress.Description
local Bar = Progress.Bar
local Loading = Bar.Loading
local Number = Bar.Number
local t1 = {}
local s1 = "Default"
local v41 = Signal.new()
local s2 = ""
local v43 = Signal.new()
local v44 = Trove.new()
local u45 = nil
local t2 = {}
local u47 = false

local function matchesSearch(s3: string)
	if s2 == "" then
		return true
	end

	local v51 = Animals[s3]
	local v52 = v51 and v51.DisplayName or s3

	return string.find(v52:lower(), s2, 1, true) ~= nil
end
local function Setup()
	if u47 then
		v41:Fire(s1)

		return
	end

	local v53 = Synchronizer:Get(LocalPlayer)

	if not v53 then
		return
	end

	u47 = true

	local _ = Index[s1]
	local List2 = Animals2:GetList("Generation", true)

	for i = 1, #List2 do
		local v57 = List2[i]
		local v58 = Animals[v57]
		local v59 = Rarities[v58.Rarity]

		if Index2:CanShowInIndex(v57) then
			local v60 = List:FindFirstChild(v57)

			if v60 then
				v60.LayoutOrder = i
			else
				local clone = Template:Clone()

				clone.Name = v57
				clone.LayoutOrder = i

				local function refreshVisibility()
					local v106 = Index[s1]
					local v107 = not v106 or (not v106.Index or v106.Index[v57] ~= nil)
					local v108 = clone

					if v107 then
						local v109 = v57

						if s2 == "" then
							v107 = true
						else
							local v110 = Animals[v109]
							local v111 = v110 and v110.DisplayName or v109

							v107 = string.find(v111:lower(), s2, 1, true) ~= nil
						end
					end

					v108.Visible = v107
				end

				local v63 = Index[s1]
				local v64 = not v63 or (not v63.Index or v63.Index[v57] ~= nil)

				if v64 then
					if s2 == "" then
						v64 = true
					else
						local v65 = Animals[v57]
						local v66 = v65 and v65.DisplayName or v57

						v64 = string.find(v66:lower(), s2, 1, true) ~= nil
					end
				end

				clone.Visible = v64
				v41:Connect(refreshVisibility)
				v43:Connect(refreshVisibility)

				local ViewportFrame = clone.ViewportFrame
				local u68 = nil
				local u69 = nil
				local u70 = nil

				clone.NameLabel.Text = v58.DisplayName
				clone.RarityLabel.Text = v58.Rarity

				local v71, v72 = Animals2:AttachOnViewport(v57, ViewportFrame, true, nil, true)

				if v71 then
					t1[ViewportFrame] = {
						state = nil,
						targetParent = clone,
						cellIndex = i
					}
				end

				local function cleanupEffects()
					if u69 then
						v44:Remove(u69)
						u69 = nil
					end

					if u68 then
						v44:Remove(u68)
						u68 = nil
					end

					if u70 then
						u70()
						u70 = nil
					end
				end
				local function update()
					if t1[ViewportFrame] and t1[ViewportFrame].state ~= true then
						t1[ViewportFrame].scheduledUpdate = update

						return
					end

					local v112 = s1 or "Default"

					if not Index[v112] then
						v112 = "Default"
					end

					local v113 = not Index[v112] or Index[v112].IsMutation
					local v114 = v53:Get({
						"Index",
						v57
					})
					local v115 = if not Index[v112] or not Index[v112].CustomIndex then if not v113 then v114 ~= nil and next(v114) ~= nil else v114 ~= nil and v114[v112] or nil else v114 ~= nil and v114[Index[v112].CustomIndex.Name] or nil

					clone.NameLabel.Visible = v115
					ViewportFrame.ImageColor3 = not v115 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)

					if u69 then
						v44:Remove(u69)
						u69 = nil
					end

					if u68 then
						v44:Remove(u68)
						u68 = nil
					end

					if u70 then
						u70()
						u70 = nil
					end

					if v59.GradientPreset then
						clone.RarityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						u70 = v44:Add(Gradients.apply(clone.RarityLabel, v59.GradientPreset))
					else
						clone.RarityLabel.TextColor3 = v59.Color
					end

					local v116 = MutationText.ApplyToLabel(clone.MutationLabel, v112, "Auto")

					if v116 then
						u69 = v44:Add(v116)
					end

					if v72 and v112 ~= "Default" and v115 and v113 then
						u68 = v44:Add(Animals2:ApplyMutation(v72, v57, v112, true))
					end
				end

				v41:Connect(function()
					if u69 then
						v44:Remove(u69)
						u69 = nil
					end

					if u68 then
						v44:Remove(u68)
						u68 = nil
					end

					if u70 then
						u70()
						u70 = nil
					end

					update()
				end)
				v53:OnChanged({
					"Index",
					v57
				}, update, true)
				task.spawn(update)
				HoverInfoController:Add(clone, function()
					return v57, s1
				end)
				clone.Parent = List
			end
		end
	end

	local function update()
		local v117, v118, v119 = Index2:GetIndexAnimals(LocalPlayer, s1)

		assert(v117)
		assert(v118)
		assert(v119)

		local v120 = Index2:IsComplete(LocalPlayer, s1)

		Loading.Size = UDim2.new(math.clamp(v117 / v118, 0, 1), 0, 1, 0)
		Header.Total.Text = `{ v117 }/{ v119 }`

		if v120 then
			Number.Text = "Milestone Completed"
			Number.TextColor3 = Color3.new(0.0588235, 1, 0.32549)
			Loading.BackgroundColor3 = Color3.new(0.490196, 0.941176, 0.439216)

			return
		end

		Number.Text = `{ v117 }/{ v118 }`
		Number.TextColor3 = Color3.new(1, 1, 1)
		Loading.BackgroundColor3 = Color3.new(0.941176, 0.729412, 0.482353)
	end

	v41:Connect(update)
	update()
end

function t2.Start(_)
	u45 = InterfaceController:Register("Index", Index3, "TopQuint")
	u45:AttachCloseButton(Close)
	u45:Close()
	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		s2 = SearchBox.Text:lower()
		v43:Fire(s2)
	end)

	local clone = Template2:Clone()

	clone.Button.TextLabel.Text = "Normal"
	clone.Name = "Default"
	clone.LayoutOrder = 0
	clone.Parent = Mutations2
	clone.Visible = true
	clone.Button.ImageLabel.Image = "rbxassetid://139326264265904"

	local v78 = AnimatedButton.new(clone.Button, clone)

	v78:Animate()
	v78.OnActivated:Connect(function()
		if s1 == clone.Name then
			return
		end

		s1 = clone.Name
		v41:Fire(s1)
	end)

	for v79, v80 in Index do
		local LimitedMutation = v80.LimitedMutation
		local v82 = Index2:GetIndexLimitedTime(v79) or LimitedMutation
		local v83 = v80.IsMutation == true and (v82 ~= nil and v82 < workspace:GetServerTimeNow())

		if Index2:CanProgressIndex(v79) and not v80.DisableIndex and not v80.HideButton then
			local clone2 = Template2:Clone()

			clone2.Name = v79
			clone2.LayoutOrder = if not v82 then v80.Order or 1 else 2000000000 - v82
			clone2.Visible = true
			MutationText.ApplyToLabel(clone2.Button.TextLabel, v79, "Auto")

			local v85 = Mutations[v79] and Mutations[v79].Icon

			clone2.Button.ImageLabel.Image = v85 or "rbxassetid://139326264265904"
			clone2.Parent = Mutations2

			local function isVisible()
				local v121 = not v80.Update or Updates.Methods.IsEnabled(v80.Update)

				return Index2:CanProgressIndex(v79) and v121
			end

			if LimitedMutation and not v83 then
				task.spawn(function()
					local v122 = true

					Updates.OnUpdateEnabled:Connect(function()
						local v153 = clone2
						local v154 = not v80.Update or Updates.Methods.IsEnabled(v80.Update)

						v153.Visible = Index2:CanProgressIndex(v79) and v154
					end)
					Updates.OnUpdateDisabled:Connect(function()
						local v155 = clone2
						local v156 = not v80.Update or Updates.Methods.IsEnabled(v80.Update)

						v155.Visible = Index2:CanProgressIndex(v79) and v156
					end)

					while clone2.Parent == Mutations2 do
						local v123 = (Index2:GetIndexLimitedTime(v79) or LimitedMutation) - workspace:GetServerTimeNow()

						clone2.Button.Timer.Text = TimeUtils:E(v123)
						clone2.Button.Timer.Visible = v123 > 0

						if v123 <= 0 and not v122 then
							v122 = true
							clone2.Button.TextLabel.Position = UDim2.fromScale(0.627, 0.5)
							clone2.Button.TextLabel.Size = UDim2.fromScale(0.596, 0.7)
							clone2.Button.TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)

							local v124 = clone2
							local v125 = not v80.Update or Updates.Methods.IsEnabled(v80.Update)

							v124.Visible = Index2:CanProgressIndex(v79) and v125

							if not Index2:CanProgressIndex(v79) and s1 == v79 then
								s1 = "Default"
								v41:Fire(s1)
							end
						elseif v123 > 0 and v122 then
							v122 = false
							clone2.Button.TextLabel.Position = UDim2.fromScale(0.627, 0.05)
							clone2.Button.TextLabel.Size = UDim2.fromScale(0.596, 0.525)
							clone2.Button.TextLabel.AnchorPoint = Vector2.new(0.5, 0)

							local v126 = clone2
							local v127 = not v80.Update or Updates.Methods.IsEnabled(v80.Update)

							v126.Visible = Index2:CanProgressIndex(v79) and v127
						end

						task.wait(1)
					end
				end)
			end

			local v87 = AnimatedButton.new(clone2.Button, clone2)

			v87:Animate()
			v87.OnActivated:Connect(function()
				if s1 == v79 then
					return
				end

				s1 = v79
				v41:Fire(s1)
			end)
		end
	end

	local n1 = 0
	local n2 = 0
	local n3 = 0
	local zero = Vector2.zero
	local _ = Vector2.zero
	local u93 = nil
	local UIGridLayout = List.UIGridLayout

	local function updateSize()
		zero = List.AbsoluteSize
		n2 = List.AbsolutePosition.Y + zero.Y

		local CellPadding = UIGridLayout.CellPadding

		u93 = CellPadding.Y.Scale * zero.Y + CellPadding.Y.Offset
	end
	local function updatePosition()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
	end

	local u97 = false

	local function updateWindowTop()
		n3 = n1 - List.CanvasPosition.Y
		u97 = Index3.Visible
	end

	zero = List.AbsoluteSize
	n2 = List.AbsolutePosition.Y + zero.Y

	local CellPadding = UIGridLayout.CellPadding

	u93 = CellPadding.Y.Scale * zero.Y + CellPadding.Y.Offset
	n1 = List.AbsolutePosition.Y
	n2 = List.AbsolutePosition.Y + zero.Y
	n3 = n1 - List.CanvasPosition.Y
	u97 = Index3.Visible

	local AbsoluteCellCount = UIGridLayout.AbsoluteCellCount
	local AbsoluteCellSize = UIGridLayout.AbsoluteCellSize

	UIGridLayout:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(function()
		AbsoluteCellCount = UIGridLayout.AbsoluteCellCount
	end)
	UIGridLayout:GetPropertyChangedSignal("AbsoluteCellSize"):Connect(function()
		AbsoluteCellSize = UIGridLayout.AbsoluteCellSize
	end)
	UIGridLayout:GetPropertyChangedSignal("CellPadding"):Connect(function()
		local CellPadding2 = UIGridLayout.CellPadding

		u93 = CellPadding2.Y.Scale * zero.Y + CellPadding2.Y.Offset
	end)
	List:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
	List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
		n3 = n1 - List.CanvasPosition.Y
		u97 = Index3.Visible
	end)
	List:GetPropertyChangedSignal("CanvasPosition"):Connect(updateWindowTop)
	Index3:GetPropertyChangedSignal("Visible"):Connect(function()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
		zero = List.AbsoluteSize
		n2 = List.AbsolutePosition.Y + zero.Y

		local CellPadding3 = UIGridLayout.CellPadding

		u93 = CellPadding3.Y.Scale * zero.Y + CellPadding3.Y.Offset
		n3 = n1 - List.CanvasPosition.Y
		u97 = Index3.Visible
	end)

	local t3 = {}
	local u103 = false

	local function resortGrid()
		if u103 then
			return
		end

		u103 = true
		task.defer(function()
			u103 = false

			local children = List:GetChildren()
			local t4 = {}
			local t5 = {}
			local t6 = {}

			for i = #children, 1, -1 do
				if not children[i]:IsA("GuiObject") or not children[i].Visible then
					table.remove(children, i)
				else
					t5[children[i]] = children[i].Name
					t4[children[i]] = children[i].LayoutOrder
					t6[children[i]] = i
				end
			end

			table.sort(children, function(p2, p3)
				if t4[p2] == t4[p3] then
					if t5[p2] == t5[p3] then
						return t6[p2] < t6[p3]
					end

					return t5[p2] < t5[p3]
				end

				return t4[p2] < t4[p3]
			end)
			table.clear(t3)

			for v162, v163 in children do
				t3[v163] = v162
			end
		end)
	end

	if not u103 then
		u103 = true
		task.defer(function()
			u103 = false

			local children = List:GetChildren()
			local t7 = {}
			local t8 = {}
			local t9 = {}

			for i = #children, 1, -1 do
				if not children[i]:IsA("GuiObject") or not children[i].Visible then
					table.remove(children, i)
				else
					t8[children[i]] = children[i].Name
					t7[children[i]] = children[i].LayoutOrder
					t9[children[i]] = i
				end
			end

			table.sort(children, function(p4, p5)
				if t7[p4] == t7[p5] then
					if t8[p4] == t8[p5] then
						return t9[p4] < t9[p5]
					end

					return t8[p4] < t8[p5]
				end

				return t7[p4] < t7[p5]
			end)
			table.clear(t3)

			for v136, v137 in children do
				t3[v137] = v136
			end
		end)
	end

	List.UIGridLayout:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(resortGrid)
	RunService.Heartbeat:Connect(function()
		debug.profilebegin("Index::Cull")

		local n4 = 0
		local v139 = AbsoluteCellSize.Y * 2

		for v140, v141 in t1 do
			local v142 = t3[v141.targetParent]
			local v143 = false

			if v142 then
				local v144 = math.ceil(v142 / AbsoluteCellCount.X) - 1
				local v145 = n3 + (AbsoluteCellSize.Y + u93) * v144 - u93
				local v146 = v145 + AbsoluteCellSize.Y

				v143 = u97 and (v146 > n1 and v145 < n2 + v139)
			end

			if v143 ~= v141.state then
				v140.Parent = if not v143 then nil else v141.targetParent
				v141.state = v143

				if v141.scheduledUpdate and v143 == true then
					v141.scheduledUpdate()
					v141.scheduledUpdate = nil
				end
			end

			n4 += 1
		end

		debug.profileend()
	end)
	Synchronizer:WaitAndCall(LocalPlayer, function(_)
		u45.OnOpen:Connect(Setup)
		u45.OnClose:Connect(function()
			v44:Clean()
		end)

		if u45:IsOpened() then
			Setup()
		end
	end)
	Updates.OnUpdateEnabled:Connect(function()
		if u45:IsOpened() then
			v41:Fire(s1)
			Setup()
		end
	end)
	Updates.OnUpdateDisabled:Connect(function()
		if u45:IsOpened() then
			Setup()
		end
	end)

	local function updateDescription()
		if not s1 then
			return
		end

		local v148 = Index[s1]
		local v149 = v148 and v148.CompletitionPercent or (s1 ~= "Default" and 1 or 0.75)
		local color3 = Color3.new(1, 1, 1)

		if s1 ~= "Default" and s1 ~= nil and v148 then
			color3 = v148.MainColor
		end

		local v151 = not v148 or not v148.LimitedMutation
		local v152 = if not v148 then `<font color="#{ color3:ToHex() }">{ s1 }</font>` else MutationText.Resolve(s1, "Rich")

		Description.Text = if s1 ~= "Default" then if s1 ~= "Halloween" then `Collect { math.ceil(v149 * 100) }% { v152 } Brainrots for { not v151 and "" or "+0.5x Base Multi and " }a <font color="#{ color3:ToHex() }">{ v152 } Base</font>` else `Collect { math.ceil(v149 * 100) }% { v152 } Brainrots for a <font color="#{ color3:ToHex() }">{ v152 } Base</font>` else `Collect { math.ceil(v149 * 100) }% Normal Brainrots for +0.5x Base Multi`
	end

	v41:Connect(updateDescription)
	updateDescription()
end

return t2
