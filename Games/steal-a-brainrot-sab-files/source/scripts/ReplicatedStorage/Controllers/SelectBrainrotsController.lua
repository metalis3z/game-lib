-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Index = require(ReplicatedStorage.Shared.Index)
local Animals2 = require(ReplicatedStorage.Datas.Animals)
local v14 = Net:RemoteFunction("SettingsService/SetFilterBrainrots")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local color3 = Color3.fromRGB(0, 255, 0)
local color3_2 = Color3.fromRGB(0, 255, 51)
local color3_3 = Color3.fromRGB(0, 0, 0)
local color3_4 = Color3.fromRGB(0, 0, 0)
local t1 = {}
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local function GetBrainrotList()
	local t2 = {}

	for v24 in Animals2 do
		if Index:CanShowInIndex(v24) then
			table.insert(t2, v24)
		end
	end

	table.sort(t2, function(p1, p2)
		local v72 = Animals2[p1].Generation or 0
		local v73 = Animals2[p2].Generation or 0

		if v72 == v73 then
			return p1 < p2
		end

		return v73 < v72
	end)

	return t2
end

function t1.Start(_)
	local SelectBrainrots = PlayerGui:WaitForChild("SelectBrainrots"):WaitForChild("SelectBrainrots")
	local Main = SelectBrainrots.Main
	local Header = Main.Header
	local Close = Header.Close
	local SearchBox = Header.SearchFrame.SearchBox
	local List = Main.Content.Holder.List
	local Template = List.Template
	local UIGridLayout = List.UIGridLayout
	local Buttons = Main:FindFirstChild("Buttons")
	local v35 = Buttons and Buttons:FindFirstChild("Yes")
	local v36 = Buttons and Buttons:FindFirstChild("Cancel")

	if not v35 or not v36 then
		warn("[SelectBrainrots] Confirm/Cancel buttons missing (Main.Buttons.Yes/Cancel) — syncback the UI")
	end

	Template.Visible = false

	local v37 = InterfaceController:Register("SelectBrainrots", SelectBrainrots, "TopQuint")

	v37:AttachCloseButton(Close)
	v37:Close()

	local v38 = Trove.new()
	local t3 = {}
	local t4 = {}
	local s1 = ""
	local t5 = {}
	local v43 = Synchronizer:Wait(LocalPlayer)

	local function applyCardColor(s2: string)
		local v75 = t3[s2]

		if not v75 then
			return
		end

		local v76 = t5[s2] == true

		v75.Card.BackgroundColor3 = if not v76 then color3_3 else color3

		local UIStroke = v75.Card:FindFirstChildWhichIsA("UIStroke")

		if UIStroke then
			UIStroke.Color = if not v76 then color3_4 else color3_2
		end
	end
	local function matchesQuery(s3: string)
		if s1 == "" then
			return true
		end

		local v79 = Animals2[s3]
		local v80 = v79 and v79.DisplayName or s3

		return string.find(string.lower(v80), s1, 1, true) ~= nil
	end
	local function attachViewport(t6: {[any]: any})
		if t6.Attached then
			return
		end

		t6.Attached = Animals:AttachOnViewportWithOptimizations(t6.Index, t6.Viewport, nil, nil)
	end
	local function detachViewport(t7: {[any]: any})
		if not t7.Attached then
			return
		end

		t7.Attached:Destroy()
		t7.Attached = nil
	end

	local n1 = 0
	local n2 = 0
	local n3 = 0
	local zero = Vector2.zero
	local _ = Vector2.zero
	local _ = Vector2.zero
	local n4 = 0
	local u55 = false

	local function updateSize()
		zero = List.AbsoluteSize
		n2 = List.AbsolutePosition.Y + zero.Y

		local CellPadding = UIGridLayout.CellPadding

		n4 = CellPadding.Y.Scale * zero.Y + CellPadding.Y.Offset
	end
	local function updatePosition()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
	end
	local function updateWindowTop()
		n3 = n1 - List.CanvasPosition.Y
		u55 = SelectBrainrots.Visible
	end

	zero = List.AbsoluteSize
	n2 = List.AbsolutePosition.Y + zero.Y

	local CellPadding = UIGridLayout.CellPadding

	n4 = CellPadding.Y.Scale * zero.Y + CellPadding.Y.Offset
	n1 = List.AbsolutePosition.Y
	n2 = List.AbsolutePosition.Y + zero.Y
	n3 = n1 - List.CanvasPosition.Y
	u55 = SelectBrainrots.Visible

	local AbsoluteCellCount = UIGridLayout.AbsoluteCellCount
	local AbsoluteCellSize = UIGridLayout.AbsoluteCellSize

	UIGridLayout:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(function()
		AbsoluteCellCount = UIGridLayout.AbsoluteCellCount
	end)
	UIGridLayout:GetPropertyChangedSignal("AbsoluteCellSize"):Connect(function()
		AbsoluteCellSize = UIGridLayout.AbsoluteCellSize
	end)
	UIGridLayout:GetPropertyChangedSignal("CellPadding"):Connect(updateSize)
	List:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
	List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
		n3 = n1 - List.CanvasPosition.Y
		u55 = SelectBrainrots.Visible
	end)
	List:GetPropertyChangedSignal("CanvasPosition"):Connect(updateWindowTop)
	SelectBrainrots:GetPropertyChangedSignal("Visible"):Connect(function()
		n1 = List.AbsolutePosition.Y
		n2 = List.AbsolutePosition.Y + zero.Y
		zero = List.AbsoluteSize
		n2 = List.AbsolutePosition.Y + zero.Y

		local CellPadding2 = UIGridLayout.CellPadding

		n4 = CellPadding2.Y.Scale * zero.Y + CellPadding2.Y.Offset
		n3 = n1 - List.CanvasPosition.Y
		u55 = SelectBrainrots.Visible
	end)

	local u62 = false

	local function resortGrid()
		if u62 then
			return
		end

		u62 = true
		task.defer(function()
			u62 = false

			local children = List:GetChildren()
			local t8 = {}
			local t9 = {}
			local t10 = {}

			for i = #children, 1, -1 do
				local v134 = children[i]

				if not v134:IsA("GuiObject") or not v134.Visible or v134 == Template then
					table.remove(children, i)
				else
					t9[v134] = v134.Name
					t8[v134] = v134.LayoutOrder
					t10[v134] = i
				end
			end

			table.sort(children, function(p4, p5)
				if t8[p4] == t8[p5] then
					if t9[p4] == t9[p5] then
						return t10[p4] < t10[p5]
					end

					return t9[p4] < t9[p5]
				end

				return t8[p4] < t8[p5]
			end)
			table.clear(t4)

			for v135, v136 in children do
				t4[v136] = v135
			end
		end)
	end

	UIGridLayout:GetPropertyChangedSignal("AbsoluteCellCount"):Connect(resortGrid)
	RunService.Heartbeat:Connect(function()
		debug.profilebegin("SelectBrainrots::Cull")

		local v85 = AbsoluteCellSize.Y * 2

		for _, v87 in t3 do
			local v88 = t4[v87.Card]
			local v89 = false

			if v88 and AbsoluteCellCount.X >= 1 then
				local v90 = math.ceil(v88 / AbsoluteCellCount.X) - 1
				local v91 = n3 + (AbsoluteCellSize.Y + n4) * v90 - n4
				local v92 = v91 + AbsoluteCellSize.Y

				v89 = u55 and (v92 > n1 and v91 < n2 + v85)
			end

			if v89 ~= v87.State then
				v87.State = v89

				if v89 then
					if not v87.Attached then
						v87.Attached = Animals:AttachOnViewportWithOptimizations(v87.Index, v87.Viewport, nil, nil)
					end
				elseif v87.Attached then
					v87.Attached:Destroy()
					v87.Attached = nil
				end
			end
		end

		debug.profileend()
	end)

	local function clearCards()
		for _, v94 in t3 do
			if v94.Attached then
				v94.Attached:Destroy()
				v94.Attached = nil
			end
		end

		table.clear(t3)
		table.clear(t4)
		v38:Clean()
	end
	local function renderList()
		clearCards()
		table.clear(t5)

		local v95 = v43 and v43:Get("TradeFilterBrainrots")

		if typeof(v95) == "table" then
			for v96 in v95 do
				t5[v96] = true
			end
		end

		local n5 = 0

		for _, v99 in GetBrainrotList() do
			n5 += 1

			local v100 = Animals2[v99]
			local clone = v38:Clone(Template)

			clone.Name = v99
			clone.LayoutOrder = n5
			clone.NameLabel.Text = v100 and v100.DisplayName or v99
			clone.MutationLabel.Text = ""
			clone.RarityLabel.Text = v100 and v100.Rarity or ""

			local v102

			if s1 == "" then
				v102 = true
			else
				local v103 = Animals2[v99]
				local v104 = v103 and v103.DisplayName or v99

				v102 = string.find(string.lower(v104), s1, 1, true) ~= nil
			end

			clone.Visible = v102
			t3[v99] = {
				Attached = nil,
				State = nil,
				Card = clone,
				Viewport = clone.ViewportFrame,
				Index = v99
			}

			local v105 = t3[v99]

			if v105 then
				local v106 = t5[v99] == true

				v105.Card.BackgroundColor3 = if not v106 then color3_3 else color3

				local UIStroke = v105.Card:FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					UIStroke.Color = if not v106 then color3_4 else color3_2
				end
			end

			v38:Add(clone.Activated:Connect(function()
				SoundController:PlaySound("Sounds.Sfx.Activated")
				t5[v99] = not t5[v99] or nil

				local v137 = v99
				local v138 = t3[v137]

				if not v138 then
					return
				end

				local v139 = t5[v137] == true

				v138.Card.BackgroundColor3 = if not v139 then color3_3 else color3

				local UIStroke = v138.Card:FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					UIStroke.Color = if not v139 then color3_4 else color3_2
				end
			end))
			clone.Parent = List
		end

		if u62 then
			return
		end

		u62 = true
		task.defer(function()
			u62 = false

			local children = List:GetChildren()
			local t11 = {}
			local t12 = {}
			local t13 = {}

			for i = #children, 1, -1 do
				local v146 = children[i]

				if not v146:IsA("GuiObject") or not v146.Visible or v146 == Template then
					table.remove(children, i)
				else
					t12[v146] = v146.Name
					t11[v146] = v146.LayoutOrder
					t13[v146] = i
				end
			end

			table.sort(children, function(p6, p7)
				if t11[p6] == t11[p7] then
					if t12[p6] == t12[p7] then
						return t13[p6] < t13[p7]
					end

					return t12[p6] < t12[p7]
				end

				return t11[p6] < t11[p7]
			end)
			table.clear(t4)

			for v147, v148 in children do
				t4[v148] = v147
			end
		end)
	end

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		s1 = string.lower(SearchBox.Text)

		for v108, v109 in t3 do
			local Card = v109.Card
			local v111

			if s1 == "" then
				v111 = true
			else
				local v112 = Animals2[v108]
				local v113 = v112 and v112.DisplayName or v108

				v111 = string.find(string.lower(v113), s1, 1, true) ~= nil
			end

			Card.Visible = v111
		end

		if u62 then
			return
		end

		u62 = true
		task.defer(function()
			u62 = false

			local children = List:GetChildren()
			local t14 = {}
			local t15 = {}
			local t16 = {}

			for i = #children, 1, -1 do
				local v154 = children[i]

				if not v154:IsA("GuiObject") or not v154.Visible or v154 == Template then
					table.remove(children, i)
				else
					t15[v154] = v154.Name
					t14[v154] = v154.LayoutOrder
					t16[v154] = i
				end
			end

			table.sort(children, function(p8, p9)
				if t14[p8] == t14[p9] then
					if t15[p8] == t15[p9] then
						return t16[p8] < t16[p9]
					end

					return t15[p8] < t15[p9]
				end

				return t14[p8] < t14[p9]
			end)
			table.clear(t4)

			for v155, v156 in children do
				t4[v156] = v155
			end
		end)
	end)

	local function closePicker()
		InterfaceController:SetState("SelectBrainrots", false)
	end

	if v35 then
		local u67 = false
		local v68 = AnimatedButton.new(v35)

		v68:Animate()
		v68.OnActivated:Connect(function()
			if u67 then
				return
			end

			u67 = true
			SoundController:PlaySound("Sounds.Sfx.Activated")

			local t17 = {}

			for v115, v116 in t5 do
				if v116 then
					table.insert(t17, v115)
				end
			end

			local v117, v118 = v14:InvokeServer(t17)

			if not v117 then
				NotificationController:Error(typeof(v118) ~= "string" and "Failed to save selection" or v118)
				SoundController:PlaySound("Sounds.Sfx.Error")
				u67 = false

				return
			end

			u67 = false
			InterfaceController:SetState("SelectBrainrots", false)
		end)
	end

	if v36 then
		local v69 = AnimatedButton.new(v36)

		v69:Animate()
		v69.OnActivated:Connect(function()
			SoundController:PlaySound("Sounds.Sfx.Activated")
			InterfaceController:SetState("SelectBrainrots", false)
		end)
	end

	v37.OnOpen:Connect(renderList)
	v37.OnClose:Connect(function()
		clearCards()
		task.defer(function()
			if v37:IsOpened() then
				return
			end

			for v157, v158 in InterfaceController:GetInterfaces() do
				if v157 ~= "Hud" and v157 ~= "SelectBrainrots" and v158:IsOpened() then
					return
				end
			end

			InterfaceController:SetState("TradePlayerList", true)
		end)
	end)

	if v43 then
		v43:OnDictionaryInserted("TradeFilterBrainrots", function(_, p11)
			if typeof(p11) == "string" then
				t5[p11] = true

				local v121 = t3[p11]

				if not v121 then
					return
				end

				local v122 = t5[p11] == true

				v121.Card.BackgroundColor3 = if not v122 then color3_3 else color3

				local UIStroke = v121.Card:FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					UIStroke.Color = if not v122 then color3_4 else color3_2
				end
			end
		end)
		v43:OnDictionaryRemoved("TradeFilterBrainrots", function(_, p13)
			if typeof(p13) == "string" then
				t5[p13] = nil

				local v126 = t3[p13]

				if not v126 then
					return
				end

				local v127 = t5[p13] == true

				v126.Card.BackgroundColor3 = if not v127 then color3_3 else color3

				local UIStroke = v126.Card:FindFirstChildWhichIsA("UIStroke")

				if UIStroke then
					UIStroke.Color = if not v127 then color3_4 else color3_2
				end
			end
		end)
	end
end

return t1
