local t = {}
local Lib = require(game.ReplicatedStorage.Lib)
local StarterGui = game:GetService("StarterGui")

game:GetService("UserInputService")

local v1 = Lib.UI.Get("Minigame")
local v2 = false
local v3 = Random.new()
local v4 = 0
local v5 = 0
local v6 = 0
local v7 = 0
local v8 = 0
local v9 = TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true)

local function PassSkillCheck(p1) --[[ PassSkillCheck | Line: 20 | Upvalues: v8 (ref), v3 (copy), v1 (copy), Lib (copy) ]]
	v8 = if p1 then math.max(0, v8 - v3:NextInteger(2, 8)) else math.min(100, v8 + v3:NextInteger(2, 8))
	v1.text.Text = v8 .. "%"
	v1.text.Rotation = v3:NextInteger(-30, 30)
	v1.text.TextColor3 = Color3.new(0/255, 255/255, 0/255)
	Lib.TS:Create(v1.text, TweenInfo.new(0.5), {
		Rotation = 0,
		TextColor3 = Color3.new(255/255, 255/255, 255/255)
	}):Play()
end

local function FailedSkillCheck(p1) --[[ FailedSkillCheck | Line: 34 ]] end

local function SpawnCircle(p1, p2, p3) --[[ SpawnCircle | Line: 69 | Upvalues: v1 (copy), Lib (copy), v3 (copy), v9 (copy), PassSkillCheck (copy) ]]
	local Size = v1.Folder.Template.Size

	if Lib.IsTouch then
		Size = UDim2.new(Size.X.Scale * 1.25, Size.X.Offset, Size.Y.Scale * 1.25, Size.Y.Offset)
	end

	local v12

	if p1 or v3:NextInteger(1, 4) ~= 1 then
		v12 = false
	else
		p1, v12 = v1.Folder.Danger:Clone(), true
	end

	local v32 = p1 or v1.Folder.Template:Clone()

	v32.Size = UDim2.new(0, 0, 0, 0)
	v32.Position = p2 or UDim2.new(v3:NextNumber(0, 1), 0, v3:NextNumber(0, 1), 0)
	v32.Parent = v1.Frame
	v32.Visible = true
	Lib.TS:Create(v32, v9, {
		Size = Size
	}):Play()

	local v5 = nil

	Lib.Buttons.OnActivate({ v32 }, function() --[[ Line: 88 | Upvalues: v5 (ref), v1 (ref), v32 (copy), Lib (ref), p3 (copy), v12 (ref), PassSkillCheck (ref) ]]
		if v5 then
			return
		end

		v5 = true

		local v13 = v1.Folder.Empty:Clone()

		v13.Size = v32.Size
		v13.Position = v32.Position
		v13.Visible = true
		v13.Parent = v1.Frame
		Lib.TS:Create(v13, TweenInfo.new(0.5), {
			Size = UDim2.new(v13.Size.X.Scale * 1.65, 0, v13.Size.Y.Scale * 1.65, 0)
		}):Play()
		Lib.TS:Create(v13.UIStroke, TweenInfo.new(0.5), {
			Transparency = 1
		}):Play()

		if not p3 then
			PassSkillCheck(v12)
			v32.BackgroundColor3 = Color3.new(0/255, 255/255, 0/255)
			v32.Size = UDim2.new(v32.Size.X.Scale * 0.975, 0, v32.Size.X.Scale * 0.975, 0)
			Lib.TS:Create(v32, TweenInfo.new(0.1), {
				Size = UDim2.new(v32.Size.X.Scale / 0.975, 0, v32.Size.X.Scale / 0.975, 0)
			}):Play()
			task.wait(0.1)
			v32:Destroy()
			task.wait(0.5)
			v13:Destroy()

			return
		end

		task.spawn(p3, v12)
		PassSkillCheck(v12)
		v32.BackgroundColor3 = Color3.new(0/255, 255/255, 0/255)
		v32.Size = UDim2.new(v32.Size.X.Scale * 0.975, 0, v32.Size.X.Scale * 0.975, 0)
		Lib.TS:Create(v32, TweenInfo.new(0.1), {
			Size = UDim2.new(v32.Size.X.Scale / 0.975, 0, v32.Size.X.Scale / 0.975, 0)
		}):Play()
		task.wait(0.1)
		v32:Destroy()
		task.wait(0.5)
		v13:Destroy()
	end)
	task.delay(1.25, function() --[[ Line: 120 | Upvalues: v5 (ref), Lib (ref), v32 (copy), p3 (copy) ]]
		if v5 or not Lib.CS:HasTag(game.Players.LocalPlayer, "InMinigame") then
			return
		end

		if not (v32 and v32.Parent) then
			return
		end

		Lib.TS:Create(v32, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
			BackgroundTransparency = 1
		}):Play()
		Lib.TS:Create(v32.UIStroke, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
			Transparency = 1
		}):Play()
		task.wait(0.75)

		local _ = v5 or not Lib.CS:HasTag(game.Players.LocalPlayer, "InMinigame")
	end)
end

local function UsingGamepad() --[[ UsingGamepad | Line: 136 ]]
	local find = string.find
	local UserInputService = game:GetService("UserInputService")

	return find(tostring(UserInputService:GetLastInputType()), "Gamepad") ~= nil
end

local function StartMinigame(p1) --[[ StartMinigame | Line: 141 | Upvalues: Lib (copy), v4 (ref), v5 (ref), v8 (ref), v1 (copy), StarterGui (copy), v6 (ref), v7 (ref), v2 (ref), v3 (copy), SpawnCircle (copy) ]]
	if not Lib.IsConsole then
		local find = string.find
		local UserInputService = game:GetService("UserInputService")

		if not (if find(tostring(UserInputService:GetLastInputType()), "Gamepad") == nil then false else true) then
			print("MINIGAME STARTED")
			v4 = 0
			v5 = 0
			v8 = 0
			v1.text.Text = v8 .. "%"
			Lib.CS:AddTag(game.Players.LocalPlayer, "InMinigame")
			print("MinigameStarted")
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
			v6 = 1
			v7 = 0
			v1.UnlockMouse.Visible = not Lib.IsTouch
			v1.UnlockMouse.Modal = not Lib.IsTouch

			while Lib.CS:HasTag(game.Players.LocalPlayer, "InMinigame") and v8 < 100 do
				v2 = true
				v4 = 0
				task.wait(1)

				if v8 < 100 then
					v8 = math.max(0, v8 - 1)
				end

				v1.text.Text = v8 .. "%"

				if v5 >= 3 then
					break
				end

				for i = 1, v3:NextInteger(1, 3) do
					SpawnCircle(nil, nil, p1)
				end
			end

			v2 = false
			v1.UnlockMouse.Visible = false
			v1.UnlockMouse.Modal = false
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not Lib.IsTouch)
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
			print("MinigameEnd")

			for i, v in ipairs(v1.Frame:GetChildren()) do
				v:Destroy()
			end

			v1.text.Text = ""
			Lib.CS:RemoveTag(game.Players.LocalPlayer, "InMinigame")
			Lib.HeartMinigameComplete(if v5 < 3 then v8 >= 100 else false)

			return
		end
	end

	Lib.CS:AddTag(game.Players.LocalPlayer, "InMinigame")
	task.wait(0.6)

	if not Lib.CS:HasTag(game.Players.LocalPlayer, "InMinigame") then
		return
	end

	Lib.HeartMinigameComplete(true)
end

t.StartMinigame = StartMinigame
Lib.Inject("StartCircleMinigame", StartMinigame)
function t.EndMinigame() --[[ Line: 212 | Upvalues: Lib (copy) ]]
	Lib.CS:RemoveTag(game.Players.LocalPlayer, "InMinigame")
end
Lib.Inject("EndCircleMinigame", t.EndMinigame)
Lib.Network:BindEvents({})

return t