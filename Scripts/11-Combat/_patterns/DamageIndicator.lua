--!strict
-- Pattern: DamageIndicator (ModuleScript, client)
-- Credit: behaviour copied from rivals-modded (DamageNumbers: numbers that pop, accumulate on the same
-- target while still visible, critical hits in red and bigger) but built from scratch with a
-- BillboardGui so it needs no UI template.
--
-- What it does:
--   DamageIndicator.Show(model, amount, isCritical?, worldPosition?)
--     * spawns a floating number above the target (or at worldPosition), pops it in, floats it up
--       with a little sideways drift and fades it out
--     * hits on the same target within `stackWindow` seconds add to the existing number and re-pop it
--   Fire it from a RemoteEvent the server sends to the attacker after damage is confirmed.
--
-- Usage (LocalScript):
--   local DamageIndicator = require(path.to.DamageIndicator)
--   remote.OnClientEvent:Connect(function(targetModel, amount, crit, pos)
--       DamageIndicator.Show(targetModel, amount, crit, pos)
--   end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local DamageIndicator = {}

DamageIndicator.Color = Color3.fromRGB(255, 255, 255)
DamageIndicator.CriticalColor = Color3.fromRGB(255, 70, 70)
DamageIndicator.StackWindow = 0.6 -- seconds a number stays "open" for more hits
DamageIndicator.Lifetime = 0.9
DamageIndicator.Font = Enum.Font.GothamBlack

type Entry = { gui: BillboardGui, label: TextLabel, scale: UIScale, total: number, crit: boolean, expires: number, token: number }
local open: { [Instance]: Entry } = setmetatable({}, { __mode = "k" }) :: any
local rng = Random.new()

local function anchorPart(model: Instance): BasePart?
	if model:IsA("BasePart") then
		return model
	end
	if model:IsA("Model") then
		return (model:FindFirstChild("Head") or model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart) :: BasePart?
	end
	return nil
end

local function format(n: number): string
	if n >= 1000 then
		return string.format("%.1fk", n / 1000)
	end
	return tostring(math.floor(n + 0.5))
end

local function pop(entry: Entry)
	entry.scale.Scale = if entry.crit then 1.7 else 1.4
	TweenService:Create(entry.scale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = if entry.crit then 1.25 else 1 }):Play()
end

local function create(target: Instance, position: Vector3?): Entry?
	local part = anchorPart(target)
	if not part then
		return nil
	end
	local gui = Instance.new("BillboardGui")
	gui.Name = "DamageIndicator"
	gui.Size = UDim2.fromOffset(120, 50)
	gui.AlwaysOnTop = true
	gui.LightInfluence = 0
	gui.MaxDistance = 150
	if position then
		-- detach from the part so the number stays where the hit landed
		local holder = Instance.new("Attachment")
		holder.WorldPosition = position + Vector3.new(0, 1.5, 0)
		holder.Parent = workspace.Terrain
		gui.Adornee = holder
		gui.Destroying:Once(function()
			holder:Destroy()
		end)
	else
		gui.Adornee = part
		gui.StudsOffsetWorldSpace = Vector3.new(0, 2.5, 0)
	end

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Font = DamageIndicator.Font
	label.TextScaled = true
	label.TextStrokeTransparency = 0.4
	label.Parent = gui

	local scale = Instance.new("UIScale")
	scale.Parent = label

	gui.ResetOnSpawn = false
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") -- a BillboardGui in PlayerGui draws on its Adornee
	return { gui = gui, label = label, scale = scale, total = 0, crit = false, expires = 0, token = 0 }
end

local function scheduleFade(target: Instance, entry: Entry)
	entry.token += 1
	local token = entry.token
	task.delay(DamageIndicator.StackWindow, function()
		if entry.token ~= token then
			return -- another hit re-opened it
		end
		if open[target] == entry then
			open[target] = nil
		end
		local drift = rng:NextNumber(-1.2, 1.2)
		local info = TweenInfo.new(DamageIndicator.Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		TweenService:Create(entry.gui, info, { StudsOffsetWorldSpace = entry.gui.StudsOffsetWorldSpace + Vector3.new(drift, 2.2, 0) }):Play()
		TweenService:Create(entry.label, info, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
		TweenService:Create(entry.scale, info, { Scale = 0.6 }):Play()
		Debris:AddItem(entry.gui, DamageIndicator.Lifetime + 0.05)
	end)
end

function DamageIndicator.Show(target: Instance, amount: number, isCritical: boolean?, position: Vector3?)
	if amount <= 0 then
		return
	end
	local entry = open[target]
	if not entry or not entry.gui.Parent then
		entry = create(target, position)
		if not entry then
			return
		end
		open[target] = entry
	end
	local e = entry :: Entry
	e.total += amount
	e.crit = e.crit or isCritical == true
	e.label.Text = format(e.total)
	e.label.TextColor3 = if e.crit then DamageIndicator.CriticalColor else DamageIndicator.Color
	pop(e)
	scheduleFade(target, e)
end

return DamageIndicator
