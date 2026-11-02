-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local Library = ReplicatedStorage:WaitForChild("Library")
local Tween = require(Library.Functions.Tween)
local Variables = require(Library.Variables)
local GUI = require(Library.Client.GUI)
local Audio = require(Library.Audio)
local GetHolder = require(script.Parent.GetHolder)
local Types = require(script.Types)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local AddCurrencyScreen = ReplicatedStorage.Assets.UI.AddCurrencyScreen
local tbl = {
	Money = {
		Resolve = function() --[[ Resolve | Line: 36 | Upvalues: GUI (copy) ]]
			local Money = GUI.Money().Bottom.Money

			return Money, Money
		end,
		SpawnSound = {
			SoundId = "rbxassetid://133581886462636",
			Data = {
				Volume = 1.2
			}
		}
	}
}

if Constants.IS_STUDIO then
	for k in pairs(tbl) do
		local v1 = Types.AvailableCurrencyWidgetsTypes(k)

		assert(v1, (("Unregistered currency widget type: %*"):format(k)))
	end
end

local v3 = Random.new()
local t = {}
local t2 = {}
local v4 = 0
local t3 = { "rbxassetid://130670569123609", "rbxassetid://94335578821857" }
local t4 = {}

local function resolveWidget(p1) --[[ resolveWidget | Line: 74 | Upvalues: tbl (copy) ]]
	local v3 = assert(tbl[p1], (("Currency widget not found for type: %*"):format(p1)))
	local v4, v5 = v3.Resolve()

	return v3, v4, v5 or v4
end

local function taskStarted() --[[ taskStarted | Line: 80 | Upvalues: v4 (ref) ]]
	v4 = v4 + 1
end

local function taskFinished() --[[ taskFinished | Line: 84 | Upvalues: v4 (ref) ]]
	v4 = v4 - 1
end

local function getTextKey(p1, p2) --[[ getTextKey | Line: 88 ]]
	if p2 and p2.MergeKey then
		return p2.MergeKey
	end

	return p1
end

local function formatAdditiveText(p1, p2) --[[ formatAdditiveText | Line: 92 | Upvalues: Simple (copy) ]]
	if p2 and p2.TextOverride then
		return p2.TextOverride
	end

	return "$" .. Simple.FormatCompact(p1, ".")
end

local function AddCurrencyText(p1, p2, p3, p4, p5) --[[ AddCurrencyText | Line: 100 | Upvalues: v4 (ref), tbl (copy), t (copy), t2 (copy), AddCurrencyScreen (copy), Audio (copy), GetHolder (copy), Simple (copy), ContentProvider (copy), t3 (copy), v3 (copy), t4 (copy), RunService (copy), Tween (copy) ]]
	v4 = v4 + 1

	local v32 = assert(tbl[p1], (("Currency widget not found for type: %*"):format(p1)))
	local v42, _ = v32.Resolve()
	local v5, v6, v7

	if p5 and p5.MergeKey then
		v5 = p5.MergeKey
		v6 = v42
		v7 = v32
	else
		v6 = v42
		v5 = p1
		v7 = v32
	end

	local v8 = t[v5]
	local v9 = t2[v5] or 0

	if v8 then
		v8:Destroy()
		t[v5] = nil

		if not (p5 and p5.TextOverride) then
			p2 = p2 + v9
		end
	end

	local v10 = AddCurrencyScreen.Amount:Clone()

	t[v5] = v10
	t2[v5] = p2
	v10.AnchorPoint = Vector2.new(0.5, 0.5)

	local Label = v10.Label
	local UIScale = v10:FindFirstChild("UIScale")
	local UIStroke = Label:FindFirstChild("UIStroke")

	UIScale.Scale = 0.9

	local SpawnSound = v7.SpawnSound

	if SpawnSound then
		Audio.PlayFromSoundFile(SpawnSound, script)
	end

	v10.Parent = GetHolder()
	Label.Text = if p5 and p5.TextOverride then p5.TextOverride else "$" .. Simple.FormatCompact(p2, ".")
	Label.TextTransparency = 0

	if UIStroke then
		UIStroke.Transparency = 0
	end

	Label.Visible = true
	v10.Size = UDim2.fromOffset(math.max(math.round(v6.AbsoluteSize.X * 1.35), 180), (math.max(math.round(v6.AbsoluteSize.Y * 0.95), 40)))
	pcall(ContentProvider.PreloadAsync, ContentProvider, t3)

	local CurrentCamera = workspace.CurrentCamera
	local v17 = if CurrentCamera then CurrentCamera.ViewportSize else Vector2.new(1920, 1080)
	local v18 = if p4 then p4 else Vector2.new(v17.X * 0.5 + v3:NextNumber(-260, 260), v17.Y * 0.62 + v3:NextNumber(-140, 140))
	local v19 = t4.GetWidgetIconCenter(p1)
	local v21 = v19 - v18
	local v22 = if v21.X >= 0 then -1 else 1
	local v27 = (v18 + v19) / 2 + Vector2.new(v22 * math.max(160, math.abs(v21.X) * 0.35), -math.max(140, math.abs(v21.Y) * 0.35))

	local function quadBezier(p1, p2, p3, p4) --[[ quadBezier | Line: 171 ]]
		local v1 = 1 - p4

		return p1 * (v1 * v1) + p2 * (v1 * 2 * p4) + p3 * (p4 * p4)
	end

	local v28 = tick()
	local v29 = 0

	while v29 < 1 and v10.Parent do
		local v31 = math.min((tick() - v28) / 1.9, 1)
		local v322 = 1 - v31
		local v33 = v18 * (v322 * v322) + v27 * (v322 * 2 * v31) + v19 * (v31 * v31)
		local v34 = math.clamp((v31 - 0.8) / 0.2, 0, 1)

		v10.Position = UDim2.fromOffset(v33.X, v33.Y)
		UIScale.Scale = math.sin(v31 * math.pi) * 0.18 + 0.9
		Label.TextTransparency = v34

		if UIStroke then
			UIStroke.Transparency = v34
		end

		RunService.RenderStepped:Wait()
		v29 = v31
	end

	if t[v5] == v10 then
		t[v5] = nil
		t2[v5] = 0
	end

	if v10.Parent then
		v10:Destroy()
	end

	local v37, v38 = assert(tbl[p1], (("Currency widget not found for type: %*"):format(p1))).Resolve()
	local v39 = v38 or v37
	local UIScale2 = v39:FindFirstChildOfClass("UIScale")

	if not UIScale2 then
		local UIScale3 = Instance.new("UIScale")

		UIScale3.Parent = v39
		UIScale2 = UIScale3
	end

	UIScale2.Scale = 1.5
	Tween(UIScale2, {
		Scale = 1
	}, { 0.05, "Sine", "Out" })
	v4 = v4 - 1
end

function t4.GetWidgetIconCenter(p1) --[[ GetWidgetIconCenter | Line: 235 | Upvalues: tbl (copy) ]]
	local v3, v4 = assert(tbl[p1], (("Currency widget not found for type: %*"):format(p1))).Resolve()
	local v5 = v4 or v3

	return v5.AbsolutePosition + v5.AbsoluteSize / 2
end
function t4.GetOrbAnimationTime() --[[ GetOrbAnimationTime | Line: 240 ]]
	return 1.9
end
function t4.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 244 | Upvalues: Variables (copy), AddCurrencyText (copy), v4 (ref) ]]
	if p2 <= 0 then
		return
	end

	local v1 = p4
	local v2 = p5
	local v3, v42

	if typeof(p3) == "table" then
		v3 = p3
		v42 = p3.NumOrbs

		if p3.LowVolumeSound ~= nil then
			v1 = p3.LowVolumeSound
		end

		if p3.OverrideStarPosition ~= nil then
			v2 = p3.OverrideStarPosition
		end
	else
		v42 = p3
		v3 = nil
	end

	local v5 = Variables.Locks.AddScreenCurrency:ObtainLock()
	local v6 = math.min(v42 or 5, p2)
	local v7 = if p2 >= 70 then 0.025 elseif p2 >= 40 then 0.035 elseif p2 >= 20 then 0.055 else 0.1
	local v8 = p2 / v6
	local v9 = if v6 >= 10 then 3 else 1

	task.spawn(function() --[[ Line: 284 | Upvalues: v6 (copy), v9 (copy), AddCurrencyText (ref), p1 (copy), v8 (copy), v1 (ref), v2 (ref), v3 (ref), v7 (copy) ]]
		for i = 1, math.max(1, v6 - v9) do
			task.spawn(AddCurrencyText, p1, v8, v1, v2, if i == 1 then v3 else nil)
			task.wait(v7)
		end
	end)
	task.spawn(function() --[[ Line: 297 | Upvalues: v4 (ref), v5 (copy) ]]
		repeat
			task.wait()
		until v4 == 0

		v5()
	end)
end

return t4