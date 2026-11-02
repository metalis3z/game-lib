-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {}
v_u_1.__index = v_u_1
v_u_1.ClassName = "Game"
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("UserInputService")
game:GetService("SoundService")
local v_u_6 = game:GetService("TweenService")
require("@self/Types")
local v_u_7 = require("@self/Snake")
local v_u_8 = require("@self/Keybinds")
local v_u_9 = require(v2:WaitForChild("Modules"):WaitForChild("Maid"))
local v_u_10 = v3.LocalPlayer
local v_u_11 = v_u_10.PlayerGui
local v_u_12 = script:WaitForChild("Assets")
local v_u_13 = v_u_12:WaitForChild("FruitTemplate")
local v_u_14 = v_u_12:WaitForChild("SnakeHeadTemplate")
local v_u_15 = v_u_12:WaitForChild("SnakeBodyTemplate")
local v_u_16 = v_u_12:WaitForChild("SnakeGUI")
local v_u_17 = v_u_12:WaitForChild("Sounds")
Color3.fromRGB(68, 255, 0)
function v_u_1.new()
	-- upvalues: (copy) v_u_1, (copy) v_u_9, (copy) v_u_7, (copy) v_u_16, (copy) v_u_11, (copy) v_u_12, (copy) v_u_17, (copy) v_u_10, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_8
	local v18 = v_u_1
	local v_u_19 = setmetatable({}, v18)
	v_u_19.Maid = v_u_9.new()
	v_u_19.GridSize = 12
	v_u_19.UpdateRate = 0.2
	v_u_19.Score = 0
	v_u_19.Sounds = {}
	v_u_19.GameOver = false
	v_u_19.AssetSave = {
		["Snake"] = {},
		["Fruits"] = {}
	}
	v_u_19.Snake = v_u_7.new()
	v_u_19.Maid:Mark(v_u_19.Snake)
	v_u_19.Gui = v_u_16:Clone()
	v_u_19.Maid:Mark(v_u_19.Gui)
	v_u_19.Gui.Parent = v_u_11
	local v20 = v_u_19.Snake.Positions
	local v21 = Vector2.new
	local v22 = v_u_19.GridSize / 2
	local v23 = math.floor(v22)
	local v24 = v_u_19.GridSize / 2
	v20[1] = v21(v23, (math.floor(v24)))
	local v25 = {}
	local v26 = Vector2.new
	local v27 = v_u_19.GridSize * 0.75
	local v28 = math.floor(v27)
	local v29 = v_u_19.GridSize * 0.75
	v25[1] = {v26(v28, (math.floor(v29)))}
	v_u_19.FruitPositions = v25
	v_u_19._tileSize = 1 / v_u_19.GridSize
	v_u_19._RNG = Random.new()
	for v30 = 0, v_u_19.GridSize - 1 do
		for v31 = 0, v_u_19.GridSize - 1 do
			local v32 = Vector2.new(v30, v31)
			if (v30 + v31) % 2 == 1 then
				local v33 = v_u_12:FindFirstChild("Tile"):Clone()
				v33.Size = UDim2.fromScale(v_u_19._tileSize, v_u_19._tileSize)
				v33.Position = UDim2.fromScale(v_u_19._tileSize * v32.X, v_u_19._tileSize * v32.Y)
				v33.Parent = v_u_19.Gui.Holder.GameContainer
			end
		end
	end
	local v_u_34 = v_u_17.Music:Clone()
	v_u_19.Maid:Mark(v_u_34)
	v_u_19.Sounds.Music = v_u_34
	v_u_34.Parent = v_u_19.Gui
	v_u_34:Play()
	local v35 = v_u_17.Eat:Clone()
	v_u_19.Maid:Mark(v35)
	v_u_19.Sounds.Eat = v35
	v35.Parent = v_u_19.Gui
	local v36 = v_u_17.Death:Clone()
	v_u_19.Maid:Mark(v36)
	v_u_19.Sounds.Death = v36
	v36.Parent = v_u_19.Gui
	local v37 = v_u_17.Step:Clone()
	v_u_19.Maid:Mark(v37)
	v_u_19.Sounds.Step = v37
	v37.Parent = v_u_19.Gui
	local v38 = v_u_17.Win:Clone()
	v_u_19.Maid:Mark(v38)
	v_u_19.Sounds.Win = v38
	v38.Parent = v_u_19.Gui
	v_u_10:SetAttribute("Mouselocked", false)
	v_u_10:SetAttribute("CanMouselock", false)
	local v_u_39 = 0
	v_u_19.Maid:Mark(v_u_4.RenderStepped:Connect(function()
		-- upvalues: (ref) v_u_39, (copy) v_u_19, (copy) v_u_34, (ref) v_u_6, (ref) v_u_4
		if tick() - v_u_39 < v_u_19.UpdateRate or v_u_19.GameOver then
			return
		else
			v_u_39 = tick()
			v_u_19:Frame()
			if v_u_19:CheckForDeath() then
				v_u_19.GameOver = true
				v_u_34:Stop()
				v_u_19.Sounds.Death:Play()
				v_u_19.Gui.Holder.GameOverText.Visible = true
				local v_u_40 = Instance.new("NumberValue")
				v_u_19.Maid:Mark(v_u_40)
				v_u_40.Value = 0.03
				v_u_6:Create(v_u_40, TweenInfo.new(0.4), {
					["Value"] = 0
				}):Play()
				local v41 = v_u_4.RenderStepped:Connect(function()
					-- upvalues: (ref) v_u_19, (copy) v_u_40
					v_u_19.Gui.Holder.GameOverText.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(v_u_19._RNG:NextInteger(-10, 10) / 10 * v_u_40.Value, v_u_19._RNG:NextInteger(-10, 10) / 10 * v_u_40.Value)
				end)
				task.delay(0.41, v41.Disconnect, v41)
				v_u_19.Maid:Mark(v41)
			else
				if v_u_19.Snake.Length == v_u_19.GridSize * v_u_19.GridSize - 1 then
					v_u_19.Sounds.Win:Play()
					v_u_19.GameOver = true
					v_u_34:Stop()
				end
				v_u_19:Render()
			end
		end
	end))
	v_u_19.Maid:Mark(v_u_5.InputBegan:Connect(function(p42, p43)
		-- upvalues: (ref) v_u_8, (copy) v_u_19
		if not p43 and v_u_8.Keycodes[p42.KeyCode] then
			v_u_19.Snake:AttemptToSetMoveDirection(v_u_8.Keycodes[p42.KeyCode])
		end
	end))
	v_u_19.Maid:Mark(v_u_5.TouchSwipe:Connect(function(p44)
		-- upvalues: (ref) v_u_8, (copy) v_u_19
		if v_u_8.Gestures[p44] then
			v_u_19.Snake:AttemptToSetMoveDirection(v_u_8.Gestures[p44])
		end
	end))
	return v_u_19
end
function v_u_1.SpawnFruit(p45)
	if not p45.GameOver then
		local v46 = {}
		for v47 = 0, p45.GridSize - 1 do
			for v48 = 0, p45.GridSize - 1 do
				local v49 = Vector2.new(v47, v48)
				if not table.find(p45.Snake.Positions, v49) then
					table.insert(v46, v49)
				end
			end
		end
		p45._RNG:Shuffle(v46)
		p45.FruitPositions = {}
		local v50 = p45.FruitPositions
		local v51 = v46[1]
		table.insert(v50, v51)
		local v52 = p45.FruitPositions
		local v53 = v46[2]
		table.insert(v52, v53)
		local v54 = p45.FruitPositions
		local v55 = v46[3]
		table.insert(v54, v55)
	end
end
function v_u_1.Frame(p56)
	p56.Sounds.Step:Play()
	p56.Snake:MoveForward()
	p56.Snake:UpdateDirection()



	local FruitPosition = p56.FruitPositions	
	if not FruitPosition then
		return
	elseif typeof(FruitPosition) == 'table' and typeof(FruitPosition[1]) == 'table' then
		FruitPosition = FruitPosition[1]
	end
	
	local SnakePosition = p56.Snake.Positions[1]
	if not SnakePosition then
		return
	end
	
	local v57 = table.find(FruitPosition, SnakePosition)
	if v57 then
		table.remove(p56.FruitPositions, v57)
		p56.Sounds.Eat:Play()
		p56.Snake:EatFruit()
		if #p56.FruitPositions <= 0 then
			p56:SpawnFruit()
		end
		p56:IncrementScore()
	end
end
function v_u_1.CheckForDeath(p58)
	local v59 = p58.Snake.Positions[1]
	return (v59.X < 0 or (v59.Y < 0 or (v59.X > p58.GridSize - 1 or v59.Y > p58.GridSize - 1))) and true or (table.find(p58.Snake.Positions, v59, 2) and true or false)
end
function v_u_1.Render(p60)
	-- upvalues: (copy) v_u_14, (copy) v_u_15, (copy) v_u_13
	for _, v61 in p60.AssetSave.Fruits do
		v61.Visible = false
	end
	for v62, v63 in p60.Snake.Positions do
		local v64
		if p60.AssetSave.Snake[v62] then
			v64 = p60.AssetSave.Snake[v62]
			game:GetService("TweenService"):Create(v64, TweenInfo.new(p60.UpdateRate, Enum.EasingStyle.Linear), {
				["Position"] = UDim2.fromScale(p60._tileSize * v63.X, p60._tileSize * v63.Y)
			}):Play()
		else
			v64 = v62 == 1 and v_u_14:Clone() or v_u_15:Clone()
			p60.AssetSave.Snake[v62] = v64
			v64.Position = UDim2.fromScale(p60._tileSize * v63.X, p60._tileSize * v63.Y)
		end
		v64.Size = UDim2.fromScale(p60._tileSize, p60._tileSize)
		v64.Parent = p60.Gui.Holder.GameContainer.SnakeParts
	end
	
	for v65, v66 in p60.FruitPositions do
		if typeof(v66) == 'table' then
			v66 = v66[1]
		end
		
		local v67
		if p60.AssetSave.Fruits[v65] then
			v67 = p60.AssetSave.Fruits[v65]
		else
			v67 = v_u_13:Clone()
			p60.AssetSave.Fruits[v65] = v67
		end
		
		v67.Visible = true
		v67.Size = UDim2.fromScale(p60._tileSize, p60._tileSize)
		v67.Position = UDim2.fromScale(p60._tileSize * v66.X, p60._tileSize * v66.Y)
		v67.Parent = p60.Gui.Holder.GameContainer.SnakeParts
	end
end
function v_u_1.IncrementScore(p68)
	p68.Score = p68.Score + p68.Snake.Length
	local v69 = p68.Gui.Holder.InfoContainer["3Score"]
	local v70 = p68.Score
	v69.Text = tostring(v70)
end
function v_u_1.Destroy(p71)
	-- upvalues: (copy) v_u_10
	if p71.Maid then
		p71.Maid:Sweep()
		p71.Maid:Destroy()
	end
	v_u_10:SetAttribute("CanMouselock", true)
	setmetatable(p71, nil)
	table.clear(p71)
end
return v_u_1