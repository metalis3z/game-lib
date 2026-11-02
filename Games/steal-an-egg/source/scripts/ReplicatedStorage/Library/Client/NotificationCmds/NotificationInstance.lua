-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tween = require(game.ReplicatedStorage.Library.Functions.Tween)
local DeepCopyUnsafe = require(game.ReplicatedStorage.Library.Functions.DeepCopyUnsafe)
local Easing = require(game.ReplicatedStorage.Library.Functions.Easing)
local GUI = require(game.ReplicatedStorage.Library.Client.GUI)
local Variables = require(game.ReplicatedStorage.Library.Variables)
local Signal = require(game.ReplicatedStorage.Library.Signal)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local t2 = {
	Loading = true,
	InProgress = true,
	RoundEnd = true
}
local t3 = {
	Locations = {
		Top = 1,
		Bottom = 2,
		Right = 3,
		Left = 4,
		Message = 5
	}
}
local t4 = {
	top = {},
	bottom = {},
	message = {}
}
local t5 = {
	Time = 3,
	Force = false,
	DelayInRound = false,
	PreventDuplicateText = false
}
local v1 = GUI.Notifications()
local Top = v1:WaitForChild("Top")
local v2 = nil
local LocalPlayer = Players.LocalPlayer
local v3 = false

local function refreshLocalPlayerRoundParticipation(p1) --[[ refreshLocalPlayerRoundParticipation | Line: 61 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"

	if p1 ~= nil then
		v3 = p1

		return
	end

	local v2 = LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil

	v3 = if v2 then v1 ~= "Waiting" else v2
end

local function shouldDelayNotificationInRound(p1) --[[ shouldDelayNotificationInRound | Line: 72 | Upvalues: LocalPlayer (copy), v3 (ref), t2 (copy) ]]
	if not p1.config.DelayInRound then
		return false
	end

	return v3 and t2[LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"] == true
end

local tbl = {
	[t3.Locations.Bottom] = {
		maxVisible = 3,
		queue = t4.bottom,
		active = {},
		parentGui = v1:WaitForChild("Bottom")
	},
	[t3.Locations.Message] = {
		maxVisible = 3,
		queue = t4.message,
		active = {},
		parentGui = v1:WaitForChild("MessageTop")
	}
}

local function getQueueForLocation(p1) --[[ getQueueForLocation | Line: 104 | Upvalues: t3 (copy), t4 (copy) ]]
	return p1.location == t3.Locations.Top and t4.top or (p1.location == t3.Locations.Bottom and t4.bottom or (if p1.location == t3.Locations.Message then t4.message or nil else nil))
end

local function matchesDuplicateKey(p1, p2) --[[ matchesDuplicateKey | Line: 111 ]]
	return p1.config.DuplicateKey == p2
end

local function hasDuplicateNotification(p1) --[[ hasDuplicateNotification | Line: 115 | Upvalues: v2 (ref), t4 (copy), tbl (copy) ]]
	if p1 == nil then
		return false
	end

	if v2 ~= nil and v2.config.DuplicateKey == p1 then
		return true
	end

	for k, v in pairs(t4) do
		for i, v3 in ipairs(v) do
			if v3.config.DuplicateKey == p1 then
				return true
			end
		end
	end

	for k, v in pairs(tbl) do
		for i, v3 in ipairs(v.active) do
			if v3.config.DuplicateKey == p1 then
				return true
			end
		end
	end

	return false
end

local function addToQueue(p1) --[[ addToQueue | Line: 143 | Upvalues: Variables (copy), hasDuplicateNotification (copy), t3 (copy), t4 (copy) ]]
	if Variables.Locks.DisableNotifications:IsLocked() and not p1.config.Force then
		return
	end

	if hasDuplicateNotification(p1.config.DuplicateKey) then
		return
	end

	local v2 = assert(p1.location == t3.Locations.Top and t4.top or (p1.location == t3.Locations.Bottom and t4.bottom or (if p1.location == t3.Locations.Message then t4.message or nil else nil)))

	if t4.top == v2 and #v2 >= 6 then
		return
	end

	if (t4.bottom == v2 or t4.message == v2) and #v2 >= 20 then
		return
	end

	table.insert(v2, p1)
end

local function popNextRenderableNotification(p1) --[[ popNextRenderableNotification | Line: 168 | Upvalues: LocalPlayer (copy), v3 (ref), t2 (copy) ]]
	for i, v in ipairs(p1) do
		local v1

		v1 = if v.config.DelayInRound then v3 and (if t2[LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"] == true then true else false) else false

		if not v1 then
			return table.remove(p1, i)
		end
	end

	return nil
end

local function handleTopNotifications() --[[ handleTopNotifications | Line: 178 | Upvalues: t4 (copy), RunService (copy), v2 (ref), popNextRenderableNotification (copy), Variables (copy), Top (copy), Tween (copy) ]]
	local top = t4.top
	local v1 = nil

	RunService.RenderStepped:Connect(function() --[[ Line: 182 | Upvalues: top (copy), v2 (ref), popNextRenderableNotification (ref), v1 (ref), Variables (ref), Top (ref), Tween (ref) ]]
		if #top == 0 or v2 ~= nil then
			return
		end

		local v12 = popNextRenderableNotification(top)

		if not v12 then
			return
		end

		if v1 and math.abs(v1 - workspace:GetServerTimeNow()) < 0.5 then
			table.insert(top, 1, v12)

			return
		end

		v1 = workspace:GetServerTimeNow()
		Variables.HideProgressUI = true
		v2 = v12
		v2.created = tick()

		local v4 = UDim2.new(0.5, 0, 0, -Top.AbsoluteSize.Y - 40)

		Top.Position = v4
		v2.frame.Parent = Top
		Top.Visible = true
		Tween(Top, {
			Position = UDim2.fromScale(0.5, 0)
		}, { 0.65, "Sine", "Out" })

		for i, v in ipairs(v2.started) do
			task.spawn(v, v2.frame)
		end

		task.delay(v2.config.Time, function() --[[ Line: 221 | Upvalues: v2 (ref), Tween (ref), Top (ref), v4 (copy), top (ref), Variables (ref) ]]
			local v1 = v2

			Tween(Top, {
				Position = v4
			}, { 0.35, "Quad", "Out" }).Completed:Connect(function() --[[ Line: 229 | Upvalues: v2 (ref), Top (ref), v1 (copy), top (ref), Variables (ref) ]]
				v2 = nil
				Top.Visible = false

				if v1 then
					for i, v in ipairs(v1.completed) do
						task.spawn(v, v1.frame)
					end

					v1.frame:Destroy()
				end

				Variables.HideProgressUI = not (#top <= 0)
			end)
		end)
	end)
end

local function fadeOutNotification(p1, p2) --[[ fadeOutNotification | Line: 251 | Upvalues: Easing (copy), RunService (copy) ]]
	local v1 = assert(p1:FindFirstChildOfClass("UIGradient"))

	v1.Rotation = 45

	local v2 = tick()
	local v3 = if p2 then 0.1 else 0.35

	repeat
		if not (p1 and p1.Parent) then
			break
		end

		local v5 = math.clamp((tick() - v2) / v3, 0, 1)

		v1.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, Easing(v5, "Sine", "InOut")), NumberSequenceKeypoint.new(1 - v5 * 0.99, Easing(v5, "Sine", "Out")), NumberSequenceKeypoint.new(1, Easing(v5, "Sine", "Out")) })
		RunService.RenderStepped:Wait()
	until not (v5 < 1)
end

local function startInlineHandler(p1) --[[ startInlineHandler | Line: 272 | Upvalues: RunService (copy), fadeOutNotification (copy), popNextRenderableNotification (copy), Tween (copy) ]]
	local queue = p1.queue
	local maxVisible = p1.maxVisible
	local v1 = 0
	local v2 = nil
	local active = p1.active
	local parentGui = p1.parentGui

	RunService.RenderStepped:Connect(function() --[[ Line: 280 | Upvalues: active (copy), fadeOutNotification (ref), maxVisible (copy), v2 (ref), popNextRenderableNotification (ref), queue (copy), v1 (ref), parentGui (copy), Tween (ref) ]]
		local v12 = tick()

		for i = #active, 1, -1 do
			local v22 = v12 - active[i].created > active[i].config.Time

			if v22 and not active[i].tweening then
				active[i].tweening = true

				local v3 = active[i]

				task.spawn(function() --[[ Line: 307 | Upvalues: fadeOutNotification (ref), v3 (copy), active (ref) ]]
					fadeOutNotification(v3.frame)

					for i2, v in ipairs(v3.completed) do
						task.spawn(v, v3.frame)
					end

					v3.frame:Destroy()

					for i2, v in ipairs(active) do
						if v3 == v then
							table.remove(active, i2)
						end
					end
				end)
			end
		end

		while #active < maxVisible do
			if v2 and not (math.abs(v2 - workspace:GetServerTimeNow()) >= 0.1) then
				break
			end

			local v52 = popNextRenderableNotification(queue)

			if not v52 then
				break
			end

			v2 = workspace:GetServerTimeNow()
			v1 = v1 + 1
			v52.created = tick()
			table.insert(active, v52)

			local v7 = v52.frame:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")

			v7.Parent = v52.frame
			v7.Scale = 1.35
			Instance.new("UIGradient").Parent = v52.frame
			v52.frame.AnchorPoint = Vector2.new(0.5, 0.5)
			v52.frame.LayoutOrder = v1
			v52.frame.Parent = parentGui
			Tween(v7, {
				Scale = 1
			}, { 0.35, "Back", "Out" })

			for i2, v in ipairs(v52.started) do
				task.spawn(v, v52.frame)
			end
		end
	end)
end

local v4 = t.interface({
	Time = t.optional(t.number),
	Force = t.optional(t.boolean),
	DelayInRound = t.optional(t.boolean),
	PreventDuplicateText = t.optional(t.boolean),
	DuplicateKey = t.optional(t.string)
})

function t3.new(p1, p2, p3, p4, p5) --[[ new | Line: 393 | Upvalues: DeepCopyUnsafe (copy), t5 (copy), v4 (copy), t3 (copy), addToQueue (copy) ]]
	local v1 = DeepCopyUnsafe(t5)
	local v2, v3

	if typeof(p4) == "function" then
		v2 = {}
		v3 = p4
	else
		v2 = if p4 then p4 else {}
		v3 = p5
	end

	assert(v4(v2))

	for k, v in pairs(v2) do
		v1[k] = v
	end

	local t = {
		created = nil,
		location = p1,
		frame = p2,
		config = v1
	}
	local t2 = {}

	t2[1] = if p3 then p3 else function() --[[ Line: 422 ]] end
	t.started = t2

	local t4 = {}

	t4[1] = if v3 then v3 else function() --[[ Line: 423 ]] end
	t.completed = t4

	local v8 = setmetatable(t, {
		__index = t3
	})

	addToQueue(v8)

	return v8
end
function t3.HasCurrentTopNotification() --[[ HasCurrentTopNotification | Line: 433 | Upvalues: v2 (ref) ]]
	return v2 ~= nil
end
function t3.GetBottomRenders() --[[ GetBottomRenders | Line: 437 | Upvalues: tbl (copy), t3 (copy) ]]
	return tbl[t3.Locations.Bottom].active
end
task.spawn(handleTopNotifications)

for k, v in pairs(tbl) do
	local queue = v.queue
	local maxVisible = v.maxVisible
	local v5 = 0
	local v6 = nil
	local active = v.active
	local parentGui = v.parentGui

	RunService.RenderStepped:Connect(function() --[[ Line: 280 | Upvalues: active (copy), fadeOutNotification (copy), maxVisible (copy), v6 (ref), popNextRenderableNotification (copy), queue (copy), v5 (ref), parentGui (copy), Tween (copy) ]]
		local v12 = tick()

		for i = #active, 1, -1 do
			local v22 = v12 - active[i].created > active[i].config.Time

			if v22 and not active[i].tweening then
				active[i].tweening = true

				local v3 = active[i]

				task.spawn(function() --[[ Line: 307 | Upvalues: fadeOutNotification (ref), v3 (copy), active (ref) ]]
					fadeOutNotification(v3.frame)

					for i2, v in ipairs(v3.completed) do
						task.spawn(v, v3.frame)
					end

					v3.frame:Destroy()

					for i2, v in ipairs(active) do
						if v3 == v then
							table.remove(active, i2)
						end
					end
				end)
			end
		end

		while #active < maxVisible do
			if v6 and not (math.abs(v6 - workspace:GetServerTimeNow()) >= 0.1) then
				break
			end

			local v52 = popNextRenderableNotification(queue)

			if not v52 then
				break
			end

			v6 = workspace:GetServerTimeNow()
			v5 = v5 + 1
			v52.created = tick()
			table.insert(active, v52)

			local v7 = v52.frame:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")

			v7.Parent = v52.frame
			v7.Scale = 1.35
			Instance.new("UIGradient").Parent = v52.frame
			v52.frame.AnchorPoint = Vector2.new(0.5, 0.5)
			v52.frame.LayoutOrder = v5
			v52.frame.Parent = parentGui
			Tween(v7, {
				Scale = 1
			}, { 0.35, "Back", "Out" })

			for i2, v in ipairs(v52.started) do
				task.spawn(v, v52.frame)
			end
		end
	end)
end

local v7 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
local v8 = if LocalPlayer:GetAttribute("MurderMysteryRole") == nil then false else true

v3 = if v8 then v7 ~= "Waiting" else v8
LocalPlayer:GetAttributeChangedSignal("MurderMysteryRoundState"):Connect(function() --[[ Line: 447 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	if (LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting") == "Waiting" then
		local _ = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"

		v3 = false

		return
	end

	local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
	local v2 = LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil

	v3 = if v2 then v1 ~= "Waiting" else v2
end)
LocalPlayer:GetAttributeChangedSignal("MurderMysteryRole"):Connect(function() --[[ Line: 456 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
	local v2 = LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil

	v3 = if v2 then v1 ~= "Waiting" else v2
end)
Network.Fired(Constants.NETWORK_MAP.MurderMystery.ROUND_STATE_CHANGED):Connect(function(p1) --[[ Line: 459 | Upvalues: LocalPlayer (copy), v3 (ref) ]]
	if typeof(p1) ~= "table" then
		return
	end

	local isParticipant = p1.isParticipant

	if typeof(isParticipant) == "boolean" then
		local v1 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"

		if isParticipant ~= nil then
			v3 = isParticipant

			return
		end

		local v2 = LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil

		v3 = if v2 then v1 ~= "Waiting" else v2
	else
		local v4 = LocalPlayer:GetAttribute("MurderMysteryRoundState") or "Waiting"
		local v5 = LocalPlayer:GetAttribute("MurderMysteryRole") ~= nil

		v3 = if v5 then v4 ~= "Waiting" else v5
	end
end)
Signal.Invoked("Notifications: Has Queue").OnInvoke = function() --[[ Line: 473 | Upvalues: v2 (ref), t4 (copy) ]]
	return if v2 == nil then #t4.top > 0 else true
end

return t3