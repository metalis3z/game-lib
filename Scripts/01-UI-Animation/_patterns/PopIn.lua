--[[
	PopIn  (ModuleScript)
	Open / close windows with a UIScale "pop" (grow with Back-out, shrink with Back-in),
	optional CanvasGroup fade, background blur and camera FOV punch.

	Derived from techniques in:
	  - smash-egg-for-animals WindowOpenFx      (open from 80% scale in 0.18 s Back-out, keep the window's own UIScale value)
	  - drill-and-mine FrameAnimator            (open Back-out 0.22 s, close Quad-in at 40% of the time, blur + FOV while open)
	  - animal-hospital-modded UITweening       (grow from tiny with Back-out + FOV 65 -> 75 on close, toggle debounce)
	  - punching-simulator Wheel                (blur Size 20 + FOV 80 while a window is open)

	Usage (LocalScript):
		local PopIn = require(game.ReplicatedStorage.UI.PopIn)

		shopButton.Activated:Connect(function()
			PopIn.toggle(shopFrame, { blur = 16, fov = 62 })
		end)
		closeButton.Activated:Connect(function()
			PopIn.close(shopFrame)
		end)

		-- only one window open at a time:
		PopIn.open(shopFrame, { exclusiveGroup = "MainWindows" })

	Notes:
	  * Works on any GuiObject. If it is a CanvasGroup, GroupTransparency is faded too.
	  * The resting UIScale value is remembered (attribute PopInBase), so quick re-opens during a
	    close animation never leave the window at a wrong size.
]]

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local PopIn = {}

local DEFAULTS = {
	startScale = 0.8,
	closeScale = 0.85,
	openInfo = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	closeInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
	fadeInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	blur = nil, -- number: BlurEffect.Size while open (nil = no blur)
	fov = nil, -- number: camera FieldOfView while open (nil = leave camera alone)
	backdropInfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
	exclusiveGroup = nil, -- string: opening a window closes other open windows in the same group
}

local tokens = setmetatable({}, { __mode = "k" }) -- [GuiObject] = number (latest animation id)
local groups = {} -- [groupName] = { [GuiObject] = true }
local openCount = 0
local savedFov: number? = nil
local blurEffect: BlurEffect? = nil

local function merge(opts)
	local o = {}
	for k, v in pairs(DEFAULTS) do
		o[k] = v
	end
	if opts then
		for k, v in pairs(opts) do
			o[k] = v
		end
	end
	return o
end

local function getScale(gui: GuiObject): UIScale
	local scale = gui:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Name = "PopInScale"
		scale.Parent = gui
	end
	if gui:GetAttribute("PopInBase") == nil then
		gui:SetAttribute("PopInBase", scale.Scale)
	end
	return scale
end

local function nextToken(gui)
	local t = (tokens[gui] or 0) + 1
	tokens[gui] = t
	return t
end

local function setBackdrop(o, opening: boolean)
	if o.blur then
		if not blurEffect or not blurEffect.Parent then
			blurEffect = Instance.new("BlurEffect")
			blurEffect.Name = "PopInBlur"
			blurEffect.Size = 0
			blurEffect.Parent = Lighting
		end
		local blur = blurEffect :: BlurEffect
		blur.Enabled = true
		local tw = TweenService:Create(blur, o.backdropInfo, { Size = opening and o.blur or 0 })
		tw.Completed:Once(function(state)
			-- a disabled blur costs nothing; an enabled one at Size 0 can still cost a full-screen pass
			if state == Enum.PlaybackState.Completed and not opening and openCount == 0 then
				blur.Enabled = false
			end
		end)
		tw:Play()
	end
	if o.fov then
		local camera = workspace.CurrentCamera
		if camera then
			if opening and savedFov == nil then
				savedFov = camera.FieldOfView
			end
			local target = opening and o.fov or (savedFov or 70)
			TweenService:Create(camera, o.backdropInfo, { FieldOfView = target }):Play()
			if not opening and openCount == 0 then
				savedFov = nil
			end
		end
	end
end

function PopIn.isOpen(gui: GuiObject): boolean
	return gui.Visible and gui:GetAttribute("PopInOpen") == true
end

-- Opens the window. Returns the scale tween (already playing).
function PopIn.open(gui: GuiObject, opts)
	local o = merge(opts)
	if o.exclusiveGroup then
		groups[o.exclusiveGroup] = groups[o.exclusiveGroup] or {}
		for other in pairs(groups[o.exclusiveGroup]) do
			if other ~= gui and PopIn.isOpen(other) then
				PopIn.close(other, opts)
			end
		end
		groups[o.exclusiveGroup][gui] = true
	end

	local scale = getScale(gui)
	local base = gui:GetAttribute("PopInBase") or 1
	nextToken(gui)

	if not PopIn.isOpen(gui) then
		openCount += 1
		setBackdrop(o, true)
	end
	gui:SetAttribute("PopInOpen", true)
	gui.Visible = true
	scale.Scale = base * o.startScale

	if gui:IsA("CanvasGroup") then
		gui.GroupTransparency = 1
		TweenService:Create(gui, o.fadeInfo, { GroupTransparency = 0 }):Play()
	end

	local tw = TweenService:Create(scale, o.openInfo, { Scale = base })
	tw:Play()
	return tw
end

-- Closes the window (Visible = false at the end). Returns the scale tween.
function PopIn.close(gui: GuiObject, opts)
	local o = merge(opts)
	if not PopIn.isOpen(gui) then
		gui.Visible = false
		return nil
	end
	local scale = getScale(gui)
	local base = gui:GetAttribute("PopInBase") or 1
	local token = nextToken(gui)

	gui:SetAttribute("PopInOpen", false)
	openCount = math.max(0, openCount - 1)
	if openCount == 0 then
		setBackdrop(o, false) -- keep blur/FOV while another PopIn window is still open
	end

	if gui:IsA("CanvasGroup") then
		TweenService:Create(gui, o.closeInfo, { GroupTransparency = 1 }):Play()
	end

	local tw = TweenService:Create(scale, o.closeInfo, { Scale = base * o.closeScale })
	tw.Completed:Once(function()
		-- ignore if the window was re-opened while this close was still playing
		if tokens[gui] == token then
			gui.Visible = false
			scale.Scale = base
			if gui:IsA("CanvasGroup") then
				gui.GroupTransparency = 0
			end
		end
	end)
	tw:Play()
	return tw
end

function PopIn.toggle(gui: GuiObject, opts)
	if PopIn.isOpen(gui) then
		return PopIn.close(gui, opts)
	end
	return PopIn.open(gui, opts)
end

-- One-shot "boing" for anything already visible (a reward card, a badge...).
function PopIn.bounce(gui: GuiObject, amount: number?, info: TweenInfo?)
	local scale = getScale(gui)
	local base = gui:GetAttribute("PopInBase") or 1
	scale.Scale = base * (amount or 1.15)
	local tw = TweenService:Create(scale, info or TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = base })
	tw:Play()
	return tw
end

return PopIn
