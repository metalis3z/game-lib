-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Audio = require(ReplicatedStorage.Library.Audio)
local Generator = require(script.Generator)
local PathFinder = require(script.PathFinder)
local Settings = require(script.Settings)
local defaultButtonColor = Settings.defaultButtonColor
local Assets = script.Assets
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local v2 = 0
local t = {
	Line = {
		updown = { Assets.VerticalLine },
		leftright = { Assets.HorizontalLine },
		downright = { Assets.HalfLineDown, Assets.HalfLineRight },
		downleft = { Assets.HalfLineDown, Assets.HalfLineLeft },
		upright = { Assets.HalfLineUp, Assets.HalfLineRight },
		upleft = { Assets.HalfLineUp, Assets.HalfLineLeft },
		up = { Assets.HalfLineUp },
		down = { Assets.HalfLineDown },
		left = { Assets.HalfLineLeft },
		right = { Assets.HalfLineRight }
	},
	Circle = {
		up = { Assets.HalfLineUp, Assets.Circle },
		down = { Assets.HalfLineDown, Assets.Circle },
		left = { Assets.HalfLineLeft, Assets.Circle },
		right = { Assets.HalfLineRight, Assets.Circle },
		none = { Assets.Circle }
	}
}
local t2 = {}

t2.__index = t2

local function getDirection(p1, p2, p3, p4) --[[ getDirection | Line: 166 ]]
	if p3 < p1 then
		return "up"
	end

	if p1 < p3 then
		return "down"
	end

	if p4 < p2 then
		return "left"
	end

	if p2 < p4 then
		return "right"
	end

	return nil
end

local function resolveSettings(p1) --[[ resolveSettings | Line: 180 | Upvalues: Settings (copy) ]]
	local v1

	if p1 and p1.Modifiers then
		v1 = {}
		v1.NumberSkip = if p1.Modifiers.NumberSkip == nil then Settings.Modifiers.NumberSkip else p1.Modifiers.NumberSkip
		v1.AllowBadColors = if p1.Modifiers.AllowBadColors == nil then Settings.Modifiers.AllowBadColors else p1.Modifiers.AllowBadColors
	else
		v1 = {
			NumberSkip = Settings.Modifiers.NumberSkip,
			AllowBadColors = Settings.Modifiers.AllowBadColors
		}
	end

	local t = {}

	t.Colors = if p1 and p1.Colors ~= nil then p1.Colors else Settings.Colors
	t.DefaultGridSize = if p1 and p1.DefaultGridSize ~= nil then p1.DefaultGridSize else Settings.DefaultGridSize
	t.MustFillEntireGrid = if p1 and p1.MustFillEntireGrid ~= nil then p1.MustFillEntireGrid else Settings.MustFillEntireGrid
	t.BackgroundTransparency = if p1 and p1.BackgroundTransparency ~= nil then p1.BackgroundTransparency else Settings.BackgroundTransparency
	t.ButtonTransparency = if p1 and p1.ButtonTransparency ~= nil then p1.ButtonTransparency else Settings.ButtonTransparency
	t.PathFinderLengthLimit = if p1 and p1.PathFinderLengthLimit ~= nil then p1.PathFinderLengthLimit else Settings.PathFinderLengthLimit
	t.DefaultUIScaling = if p1 and p1.DefaultUIScaling ~= nil then p1.DefaultUIScaling else Settings.DefaultUIScaling
	t.DynamicUIScaling = if p1 and p1.DynamicUIScaling ~= nil then p1.DynamicUIScaling else Settings.DynamicUIScaling
	t.Modifiers = v1
	t.ConnectToTargetIfNearby = if p1 and p1.ConnectToTargetIfNearby ~= nil then p1.ConnectToTargetIfNearby else Settings.ConnectToTargetIfNearby
	t.defaultButtonColor = if p1 and p1.defaultButtonColor ~= nil then p1.defaultButtonColor else Settings.defaultButtonColor
	t.showNumbers = if p1 and p1.showNumbers ~= nil then p1.showNumbers else Settings.showNumbers

	return t
end

local function shuffleTable(p1) --[[ shuffleTable | Line: 229 ]]
	local v1 = table.clone(p1)

	for i = #v1, 2, -1 do
		local v2 = math.random(i)
		local v4 = v1[i]

		v1[i] = v1[v2]
		v1[v2] = v4
	end

	return v1
end

local function isNeighbour(p1, p2, p3, p4) --[[ isNeighbour | Line: 240 ]]
	if p3 == p1 - 1 and p4 == p2 then
		return "up"
	end

	if p3 == p1 + 1 and p4 == p2 then
		return "down"
	end

	if p3 == p1 and p4 == p2 - 1 then
		return "left"
	end

	if p3 == p1 and p4 == p2 + 1 then
		return "right"
	end

	return nil
end

local function removeAfterCoordinates(p1, p2, p3) --[[ removeAfterCoordinates | Line: 254 ]]
	local v1 = nil

	for i, v in ipairs(p1) do
		if v.row == p2 and v.col == p3 then
			v1 = i

			break
		end
	end

	if not v1 then
		return
	end

	for i = #p1, v1 + 1, -1 do
		table.remove(p1, i)
	end
end

local function sameLocation(p1, p2) --[[ sameLocation | Line: 271 ]]
	return if p1.row == p2.row then p1.col == p2.col else false
end

local function setConnection(p1, p2) --[[ setConnection | Line: 275 ]]
	if p2 == "up" then
		p1.up = true

		return
	end

	if p2 == "down" then
		p1.down = true

		return
	end

	if p2 == "left" then
		p1.left = true
	else
		p1.right = true
	end
end

local function generateColor(p1, p2) --[[ generateColor | Line: 287 ]]
	local count = 0

	local function isValidColor(p12) --[[ isValidColor | Line: 290 | Upvalues: count (ref), p1 (copy) ]]
		local v1 = (p12.R + p12.G + p12.B) / 3

		if v1 < 0.6 or v1 > 0.8 then
			return false
		end

		if not (count <= 500) then
			return true
		end

		for i, v in ipairs(p1) do
			if math.sqrt((v.R * 255 - p12.R * 255) ^ 2 + (v.G * 255 - p12.G * 255) ^ 2 + (v.B * 255 - p12.B * 255) ^ 2) < 75 then
				return false
			end
		end

		return true
	end

	Color3.fromRGB(0, 0, 0)

	local v1

	repeat
		v1 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
		count = count + 1
	until isValidColor(v1) or p2

	return v1
end

local function clearGridFrame(p1) --[[ clearGridFrame | Line: 326 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if not v:IsA("UIGridLayout") then
			v:Destroy()
		end
	end
end

function t2.new(p1, p2, p3) --[[ new | Line: 334 | Upvalues: t2 (copy), resolveSettings (copy), v2 (ref), Settings (copy), shuffleTable (copy) ]]
	local v22 = setmetatable({}, t2)
	local v3 = resolveSettings(p3)

	v2 = v2 + 1
	v22.id = v2
	v22.GUI = p1
	v22.containerFrame = v22.GUI.Container
	v22.gridHolder = v22.containerFrame.GridHolder
	v22.gridFrame = v22.gridHolder.Grid
	v22.gridSize = if p2 then p2 else Settings.DefaultGridSize
	v22.colors = shuffleTable(v3.Colors)
	v22.paths = {}
	v22.targetPairs = {}
	v22.isDrawing = false
	v22.drawingStart = nil
	v22.gameEnded = false
	v22.dragDebounce = {}
	v22.Connections = {}
	v22.Settings = v3
	v22.Solution = {}
	v22.SolutionText = ""
	v22.completedEvent = nil
	v22.skipNumber = nil
	v22.connectDotSoundPlaybackSpeed = 0.8
	v22:Init()

	return v22
end
function t2.Init(p1) --[[ Init | Line: 365 | Upvalues: clearGridFrame (copy), Assets (copy), UserInputService (copy), Generator (copy), generateColor (copy), TweenService (copy) ]]
	clearGridFrame(p1.gridFrame)

	local v1 = 1 / p1.gridSize

	p1.gridFrame.UIGridLayout.CellSize = UDim2.fromScale(v1, v1)
	p1.containerFrame.Size = UDim2.fromScale(0, 0)
	p1.containerFrame.Visible = true
	p1.containerFrame:SetAttribute("ActiveFlowGameId", p1.id)

	for i = 1, p1.gridSize do
		for j = 1, p1.gridSize do
			local v2 = Assets.CellTemplate:Clone()

			v2.Name = i .. "-" .. j
			v2.Parent = p1.gridFrame
			v2.BackgroundTransparency = p1.Settings.ButtonTransparency
			v2.Button.MouseButton1Down:Connect(function() --[[ Line: 380 | Upvalues: p1 (copy), i (copy), j (copy) ]]
				p1:DragBegin(i, j)
			end)
		end
	end

	table.insert(p1.Connections, UserInputService.InputEnded:Connect(function(p12) --[[ Line: 388 | Upvalues: p1 (copy) ]]
		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and (p12.UserInputType ~= Enum.UserInputType.Touch and p12.KeyCode ~= Enum.KeyCode.ButtonA) then
			return
		end

		p1:DragEnd()
	end))
	table.insert(p1.Connections, UserInputService.InputChanged:Connect(function(p12) --[[ Line: 401 | Upvalues: p1 (copy) ]]
		if p12.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		p1:InputChanged(p12.Position)
	end))
	table.insert(p1.Connections, UserInputService.TouchMoved:Connect(function(p12) --[[ Line: 410 | Upvalues: p1 (copy) ]]
		p1:InputChanged(p12.Position)
	end))

	local v3, v4, _, v5 = Generator(p1.gridSize)

	p1.targetPairs = v3
	p1.Solution = v4
	p1.SolutionText = v5

	for k = 1, #p1.targetPairs do
		p1.paths[k] = {}
		p1.dragDebounce[k] = 0

		if not p1.colors[k] then
			table.insert(p1.colors, (generateColor(p1.colors, p1.Settings.Modifiers.AllowBadColors)))
		end
	end

	if p1.Settings.Modifiers.NumberSkip then
		p1.skipNumber = math.random(1, #p1.targetPairs)
	end

	p1:updateGui()
	TweenService:Create(p1.containerFrame, TweenInfo.new(0.45), {
		Size = UDim2.fromScale(0.4, 1)
	}):Play()
end
function t2.DragBeginConsole(p1) --[[ DragBeginConsole | Line: 440 ]] end
function t2.DragBegin(p1, p2, p3) --[[ DragBegin | Line: 442 | Upvalues: removeAfterCoordinates (copy) ]]
	if p1.gameEnded then
		return
	end

	for i, v in ipairs(p1.targetPairs) do
		for i2, v2 in ipairs(v) do
			if v2.row == p2 and v2.col == p3 then
				local v1 = p1.dragDebounce[i]

				assert(v1, "Expected drag debounce for target pair")

				if not (os.clock() - v1 < 0.25) then
					p1.isDrawing = true
					p1.drawingStart = {
						row = p2,
						col = p3,
						color = i
					}
					p1.paths[i] = {
						{
							row = p2,
							col = p3
						}
					}

					local v22 = v[1]
					local v3 = v[2]

					assert(v22 and v3, "Expected pair endpoints")
					p1:CircleEffect(p2, p3)
					p1:CircleEffect(v22.row, v22.col, true)
					p1:CircleEffect(v3.row, v3.col, true)
					p1:DragBeginConsole()
					p1:updateGui()
				end

				return
			end
		end
	end

	for i, v in ipairs(p1.paths) do
		for i2, v2 in ipairs(v) do
			if v2.row == p2 and v2.col == p3 then
				removeAfterCoordinates(v, v2.row, v2.col)
				p1.isDrawing = true

				local v4 = v[1]

				assert(v4, "Expected existing path start")
				p1.drawingStart = {
					row = v4.row,
					col = v4.col,
					color = i
				}
				p1:DragBeginConsole()
				p1:updateGui()

				return
			end
		end
	end
end
function t2.DragEnd(p1) --[[ DragEnd | Line: 508 ]]
	if not p1.isDrawing then
		return
	end

	local drawingStart = p1.drawingStart

	assert(drawingStart, "Expected drawing start while drawing")

	local color = drawingStart.color
	local v1 = p1.paths[color]

	assert(v1, "Expected path for active color")

	if #v1 <= 1 then
		p1.paths[color] = {}
		v1 = p1.paths[color]
	end

	if p1.Settings.ConnectToTargetIfNearby and (#v1 > 1 and v1[#v1]) then
		local v2 = v1[#v1]

		assert(v2, "Expected path tail")

		local v3 = p1.targetPairs[color]

		assert(v3, "Expected target pair for active color")

		local v4 = v3[1]

		assert(v4 and v3[2], "Expected target pair endpoints")

		local v8 = v3[if if drawingStart.row == v4.row then drawingStart.col == v4.col else false then 2 else 1]

		assert(v8, "Expected target cell")

		local v9 = if v2.row == v8.row then if v2.col == v8.col then true else false else false
		local row = v2.row
		local col = v2.col
		local row2 = v8.row
		local col2 = v8.col
		local v10 = if row2 == row - 1 and col2 == col then "up" elseif row2 == row + 1 and col2 == col then "down" elseif row2 == row and col2 == col - 1 then "left" elseif row2 == row and col2 == col + 1 then "right" else nil

		if v9 then
			p1.dragDebounce[color] = os.clock()
		elseif v10 then
			table.insert(p1.paths[color], {
				row = v8.row,
				col = v8.col
			})
			p1.dragDebounce[color] = os.clock()
		end
	end

	p1.isDrawing = false
	p1.drawingStart = nil
	p1:updateGui()
	p1:checkForWin()
end
function t2.GetCellAtMousePosition(p1, p2) --[[ GetCellAtMousePosition | Line: 560 | Upvalues: v1 (copy), LocalPlayer (copy) ]]
	local SelectedObject = game.GuiService.SelectedObject

	if SelectedObject and SelectedObject.Parent then
		for k, v in pairs(p1.gridFrame:GetChildren()) do
			if SelectedObject.Parent == v then
				return v
			end
		end
	end

	local v12 = Vector2.new(v1.X, v1.Y)

	for k, v in pairs((LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(v12.X, v12.Y))) do
		if v.Parent == p1.gridFrame then
			return v
		end
	end

	return nil
end
function t2.InputChanged(p1, p2) --[[ InputChanged | Line: 581 | Upvalues: Audio (copy), removeAfterCoordinates (copy), PathFinder (copy) ]]
	if p1.gameEnded or not p1.isDrawing then
		return
	end

	local v1 = p1:GetCellAtMousePosition(p2)

	if not v1 then
		return
	end

	local v2, v3 = v1.Name:match("(%d+)-(%d+)")

	if not (v2 and v3) then
		return
	end

	local v4 = tonumber(v2)
	local v5 = tonumber(v3)

	if not (v4 and v5) then
		return
	end

	local v6 = p1:getGrid()
	local drawingStart = p1.drawingStart

	assert(drawingStart, "Expected drawing start while drawing")

	local color = drawingStart.color
	local v7 = p1.paths[color]

	assert(v7, "Expected current path for active color")

	local v8 = v7[#v7]
	local v9 = v7[1]

	assert(v8 and v9, "Expected current path endpoints")

	local row = v8.row
	local col = v8.col
	local v10 = if v6[row][col].status == "target" and v6[row][col].color == color then if row == v9.row then if col == v9.col then false else true else true else false
	local v12 = if v6[v4][v5].status == "empty" then true elseif v6[v4][v5].status == "target" then if v6[v4][v5].color == color then true else false else false
	local v13 = false

	for i, v in ipairs(v7) do
		if v.row == v4 and v.col == v5 then
			v13 = true

			break
		end
	end

	if (if v4 == row - 1 and v5 == col then "up" elseif v4 == row + 1 and v5 == col then "down" elseif v4 == row and v5 == col - 1 then "left" elseif v4 == row and v5 == col + 1 then "right" else nil) and (v12 and not (v10 or v13)) then
		table.insert(v7, {
			row = v4,
			col = v5
		})
		p1:updateGui()

		if v6[v4][v5].status ~= "target" then
			return
		end

		p1:CircleEffect(v4, v5)
		Audio.Play(109971761033199, script, p1.connectDotSoundPlaybackSpeed, 1.9)
		p1.connectDotSoundPlaybackSpeed = math.min(p1.connectDotSoundPlaybackSpeed + 0.08, 1.35)
	else
		if v13 then
			removeAfterCoordinates(v7, v4, v5)
			p1:updateGui()

			return
		end

		if not v12 or (v10 or not (p1.Settings.PathFinderLengthLimit > 0)) then
			return
		end

		local v15 = PathFinder.new(v6, v8, {
			row = v4,
			col = v5
		}, p1.Settings.PathFinderLengthLimit)

		if not v15:isPathAvailable() then
			return
		end

		for i, v in ipairs(v15:shortestPath()) do
			table.insert(v7, v)
			p1:updateGui()
		end
	end
end
function t2.getGrid(p1, p2) --[[ getGrid | Line: 682 ]]
	local t = {}

	for i = 1, p1.gridSize do
		t[i] = {}

		for j = 1, p1.gridSize do
			t[i][j] = {
				status = "empty",
				color = nil,
				connections = {}
			}
		end
	end

	if p2 then
		return t
	end

	for i, v in ipairs(p1.paths) do
		if #v > 0 then
			for k = 1, #v do
				local v1 = v[k - 1]
				local v2 = v[k]
				local v3 = v[k + 1]
				local t2 = {}

				assert(v2, "Expected current path cell")

				if v1 then
					local row = v2.row
					local col = v2.col
					local row2 = v1.row
					local col2 = v1.col
					local v4 = if row2 < row then "up" elseif row < row2 then "down" elseif col2 < col then "left" elseif col < col2 then "right" else nil

					if v4 and v4 == "up" then
						t2.up = true
					elseif v4 and v4 == "down" then
						t2.down = true
					elseif v4 and v4 == "left" then
						t2.left = true
					elseif v4 then
						t2.right = true
					end
				end

				if v3 then
					local row = v2.row
					local col = v2.col
					local row2 = v3.row
					local col2 = v3.col
					local v5 = if row2 < row then "up" elseif row < row2 then "down" elseif col2 < col then "left" elseif col < col2 then "right" else nil

					if v5 and v5 == "up" then
						t2.up = true
					elseif v5 and v5 == "down" then
						t2.down = true
					elseif v5 and v5 == "left" then
						t2.left = true
					elseif v5 then
						t2.right = true
					end
				end

				t[v2.row][v2.col].status = "path"
				t[v2.row][v2.col].color = i
				t[v2.row][v2.col].connections = t2
			end
		end
	end

	for i, v in ipairs(p1.targetPairs) do
		for i2, v2 in ipairs(v) do
			t[v2.row][v2.col].status = "target"
			t[v2.row][v2.col].color = i
		end
	end

	return t
end
function t2.updateGui(p1) --[[ updateGui | Line: 742 | Upvalues: TweenService (copy), defaultButtonColor (copy) ]]
	local v1 = p1:getGrid()

	for i = 1, p1.gridSize do
		for j = 1, p1.gridSize do
			local v2
			local v3 = p1.gridFrame:FindFirstChild(i .. "-" .. j)

			if v3 then
				local v4 = v1[i][j]

				if v4.status == "empty" then
					p1:clearAssets(i, j)
					TweenService:Create(v3.Button, TweenInfo.new(0.15), {
						BackgroundColor3 = defaultButtonColor
					}):Play()

					continue
				end

				if v4.status == "target" then
					local color = v4.color

					assert(color, "Expected color index for target cell")
					p1:updateAssets(i, j, "Circle", p1.colors[color], v4.connections)

					local Circle = v3:FindFirstChild("Circle")

					assert(Circle, "Expected circle asset for target cell")

					if p1.Settings.showNumbers then
						v2 = if p1.skipNumber and p1.skipNumber <= color then 1 else 0
						Circle.Number.Text = tostring(color + v2)
						Circle.Number.Visible = true
					else
						Circle.Number.Visible = false
					end

					local v5 = p1.paths[color]

					assert(v5, "Expected path collection for target cell")

					local v6 = false

					for i2, v in ipairs(v5) do
						if v.row == i and v.col == j then
							v6 = true

							break
						end
					end

					if v6 then
						TweenService:Create(v3.Button, TweenInfo.new(0.15), {
							BackgroundColor3 = defaultButtonColor:Lerp(p1.colors[color], 0.3)
						}):Play()

						continue
					end

					TweenService:Create(v3.Button, TweenInfo.new(0.15), {
						BackgroundColor3 = defaultButtonColor
					}):Play()

					continue
				end

				if v4.status == "path" then
					local color = v4.color

					assert(color, "Expected color index for path cell")
					p1:updateAssets(i, j, "Line", p1.colors[color], v4.connections)
					TweenService:Create(v3.Button, TweenInfo.new(0.15), {
						BackgroundColor3 = defaultButtonColor:Lerp(p1.colors[color], 0.3)
					}):Play()
				end
			end
		end
	end
end
function t2.clearAssets(p1, p2, p3) --[[ clearAssets | Line: 807 ]]
	local v1 = p1.gridFrame:FindFirstChild(p2 .. "-" .. p3)

	if not v1 then
		return
	end

	for i, v in ipairs(v1:GetChildren()) do
		if v.Name ~= "Button" and v.Name ~= "Effects" then
			v:Destroy()
		end
	end
end
function t2.updateAssets(p1, p2, p3, p4, p5, p6) --[[ updateAssets | Line: 820 | Upvalues: t (copy) ]]
	local v1 = ""

	if p6.up then
		v1 = v1 .. "up"
	end

	if p6.down then
		v1 = v1 .. "down"
	end

	if p6.left then
		v1 = v1 .. "left"
	end

	if p6.right then
		v1 = v1 .. "right"
	end

	if v1 == "" then
		v1 = "none"
	end

	local v2 = t[p4][v1]
	local v3 = p1.gridFrame:FindFirstChild(p2 .. "-" .. p3)

	if not (v2 and v3) then
		return
	end

	p1:clearAssets(p2, p3)

	for v4, v5 in v2 do
		local v6 = v5:Clone()

		v6.Parent = v3
		v6.BackgroundColor3 = p5
	end
end
function t2.EndGame(p1, p2) --[[ EndGame | Line: 861 | Upvalues: LocalPlayer (copy), TweenService (copy), clearGridFrame (copy) ]]
	p1.gameEnded = true
	p1.isDrawing = false
	p1.drawingStart = nil

	for k, v in pairs(p1.Connections) do
		v:Disconnect()
	end

	p1.Connections = {}

	if p1.completedEvent and p2 ~= nil then
		local completedEvent = p1.completedEvent

		p1.completedEvent = nil
		completedEvent:Fire(if p2 then "finishedPuzzle" else "leaveGenerator")
		completedEvent:Destroy()
	end

	if p2 then
		LocalPlayer:SetAttribute("CompletedGenPuzzle", true)
	else
		task.spawn(function() --[[ Line: 883 | Upvalues: p1 (copy), TweenService (ref), clearGridFrame (ref) ]]
			if p1.containerFrame:GetAttribute("ActiveFlowGameId") == p1.id then
				local v1 = TweenService:Create(p1.containerFrame, TweenInfo.new(0.5), {
					Size = UDim2.new()
				})

				v1.Completed:Once(function() --[[ Line: 891 | Upvalues: p1 (ref), clearGridFrame (ref) ]]
					if not p1.containerFrame.Parent or p1.containerFrame:GetAttribute("ActiveFlowGameId") ~= p1.id then
						return
					end

					p1.containerFrame.Visible = false
					p1.containerFrame:SetAttribute("ActiveFlowGameId", nil)
					clearGridFrame(p1.gridFrame)
				end)
				v1:Play()
			end
		end)
	end
end
function t2.checkForWin(p1) --[[ checkForWin | Line: 905 ]]
	if not p1:checkWin() then
		return
	end

	p1:EndGame(true)
end
function t2.checkWin(p1) --[[ checkWin | Line: 911 ]]
	for i, v in ipairs(p1.targetPairs) do
		local v1 = p1.paths[i]

		assert(v1, "Expected path for win check")

		if #v1 < 2 then
			return false
		end

		local v2 = v[1]
		local v3 = v[2]
		local v4 = v1[1]
		local v5 = v1[#v1]

		assert(if v2 then if v3 then if v4 then v5 else v4 else v3 else v2, "Expected path and target endpoints")

		local v7 = (if v4.row == v2.row then if v4.col == v2.col then true else false else false) and (if v5.row == v3.row then if v5.col == v3.col then true else false else false)

		if not (v7 or (if v4.row == v3.row then v4.col == v3.col else false) and (if v5.row == v2.row then v5.col == v2.col else false)) then
			return false
		end
	end

	if not p1.Settings.MustFillEntireGrid then
		return true
	end

	local count = 0

	for i, v in ipairs(p1.paths) do
		for i2 in ipairs(v) do
			count = count + 1
		end
	end

	return count == p1.gridSize * p1.gridSize
end
function t2.CircleEffect(p1, p2, p3, p4) --[[ CircleEffect | Line: 947 | Upvalues: TweenService (copy), Debris (copy) ]]
	local v1 = p1.gridFrame:FindFirstChild(p2 .. "-" .. p3)

	if not v1 then
		return
	end

	local Circle = v1:FindFirstChild("Circle")

	if not Circle then
		return
	end

	local v2 = Circle:Clone()
	local Number = v2:FindFirstChild("Number")

	if Number then
		Number:Destroy()
	end

	v2.Parent = v1.Effects

	if p4 then
		TweenService:Create(v2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true, 0), {
			Size = UDim2.fromScale(0.8, 0.8)
		}):Play()
		Debris:AddItem(v2, 0.4)
	else
		TweenService:Create(v2, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1)
		}):Play()
		Debris:AddItem(v2, 0.45)
	end
end

return t2