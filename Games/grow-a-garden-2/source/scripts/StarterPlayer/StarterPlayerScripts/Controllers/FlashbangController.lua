--credit to quartz games studio
local t = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local t2 = {}
local t3 = {}

local function isCooldownActive(p1) --[[ isCooldownActive | Line: 24 ]]
	local v1 = p1:GetAttribute("CooldownEnd")

	if typeof(v1) == "number" and os.clock() < v1 then
		return true, v1
	end

	return false, nil
end

local function recordOriginal(p1, p2) --[[ recordOriginal | Line: 32 ]]
	if p1.Originals[p2] ~= nil then
		return
	end

	p1.Originals[p2] = p2.Transparency
end

local function tweenPart(p1, p2, p3) --[[ tweenPart | Line: 38 | Upvalues: TweenService (copy) ]]
	TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
		Transparency = p2
	}):Play()
end

local function applyCooldownVisual(p1, p2) --[[ applyCooldownVisual | Line: 43 | Upvalues: tweenPart (copy) ]]
	for v1, v2 in p1:GetDescendants() do
		if v2:IsA("BasePart") then
			if p2.Originals[v2] == nil then
				p2.Originals[v2] = v2.Transparency
			end

			tweenPart(v2, 1, 0)
		end
	end
end

local function restoreOriginals(p1) --[[ restoreOriginals | Line: 52 | Upvalues: tweenPart (copy) ]]
	for v1, v2 in p1.Originals do
		if v1.Parent then
			tweenPart(v1, v2, 0)
		end
	end
end

local function endCooldown(p1) --[[ endCooldown | Line: 60 | Upvalues: t2 (copy), restoreOriginals (copy) ]]
	local v1 = t2[p1]

	if not (v1 and v1.Active) then
		return
	end

	v1.Active = false

	if v1.ReleaseTask then
		v1.ReleaseTask = nil
	end

	restoreOriginals(v1)
end

local function v1(p1, p2) --[[ scheduleRelease | Line: 70 | Upvalues: t2 (copy), v1 (copy), restoreOriginals (copy) ]]
	local v12 = t2[p1]

	if not v12 then
		return
	end

	if v12.ReleaseTask then
		v12.ReleaseTask = nil
	end

	v12.ReleaseTask = task.delay(p2 - os.clock(), function() --[[ Line: 80 | Upvalues: p1 (copy), v1 (ref), t2 (ref), restoreOriginals (ref) ]]
		local v12 = p1:GetAttribute("CooldownEnd")

		if typeof(v12) == "number" and os.clock() < v12 then
			v1(p1, v12)

			return
		end

		local v2 = t2[p1]

		if not v2 then
			return
		end

		if not v2.Active then
			return
		end

		v2.Active = false

		if v2.ReleaseTask then
			v2.ReleaseTask = nil
		end

		restoreOriginals(v2)
	end)
end

local function startCooldown(p1, p2) --[[ startCooldown | Line: 91 | Upvalues: t2 (copy), applyCooldownVisual (copy), v1 (copy) ]]
	local v12 = t2[p1]

	if v12 then
		applyCooldownVisual(p1, v12)
		v12.Active = true
		v1(p1, p2)
	end
end

local function disposeTracker(p1) --[[ disposeTracker | Line: 100 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	if v1.AttributeConn then
		v1.AttributeConn:Disconnect()
	end

	if v1.DescendantConn then
		v1.DescendantConn:Disconnect()
	end

	if v1.AncestryConn then
		v1.AncestryConn:Disconnect()
	end

	v1.ReleaseTask = nil
	t2[p1] = nil
end

local function ensureTracker(p1) --[[ ensureTracker | Line: 111 | Upvalues: t2 (copy), applyCooldownVisual (copy), v1 (copy), restoreOriginals (copy), tweenPart (copy) ]]
	local v12 = t2[p1]

	if v12 then
		return v12
	end

	local t = {
		Active = false,
		Originals = {}
	}

	t2[p1] = t
	t.AttributeConn = p1:GetAttributeChangedSignal("CooldownEnd"):Connect(function() --[[ Line: 121 | Upvalues: p1 (copy), t2 (ref), applyCooldownVisual (ref), v1 (ref), restoreOriginals (ref) ]]
		local v12 = p1:GetAttribute("CooldownEnd")
		local v2, v3

		if typeof(v12) == "number" and os.clock() < v12 then
			v2 = true
			v3 = v12
		else
			v2 = false
			v3 = nil
		end

		if v2 and v3 then
			local v4 = p1
			local v5 = t2[v4]

			if v5 then
				applyCooldownVisual(v4, v5)
				v5.Active = true
				v1(v4, v3)
			end
		else
			local v6 = t2[p1]

			if not v6 then
				return
			end

			if not v6.Active then
				return
			end

			v6.Active = false

			if v6.ReleaseTask then
				v6.ReleaseTask = nil
			end

			restoreOriginals(v6)
		end
	end)
	t.DescendantConn = p1.DescendantAdded:Connect(function(p1) --[[ Line: 131 | Upvalues: t (copy), tweenPart (ref) ]]
		if not t.Active then
			return
		end

		if not p1:IsA("BasePart") then
			return
		end

		local v1 = t

		if v1.Originals[p1] == nil then
			v1.Originals[p1] = p1.Transparency
		end

		tweenPart(p1, 1, 0)
	end)
	t.AncestryConn = p1.AncestryChanged:Connect(function() --[[ Line: 138 | Upvalues: p1 (copy), t2 (ref) ]]
		if p1:IsDescendantOf(game) then
			return
		end

		local v1 = p1
		local v2 = t2[v1]

		if not v2 then
			return
		end

		if v2.AttributeConn then
			v2.AttributeConn:Disconnect()
		end

		if v2.DescendantConn then
			v2.DescendantConn:Disconnect()
		end

		if v2.AncestryConn then
			v2.AncestryConn:Disconnect()
		end

		v2.ReleaseTask = nil
		t2[v1] = nil
	end)

	local v2 = p1:GetAttribute("CooldownEnd")
	local v3, v4

	if typeof(v2) == "number" and os.clock() < v2 then
		v3 = true
		v4 = v2
	else
		v3 = false
		v4 = nil
	end

	if not (v3 and v4) then
		return t
	end

	local v5 = t2[p1]

	if not v5 then
		return t
	end

	applyCooldownVisual(p1, v5)
	v5.Active = true
	v1(p1, v4)

	return t
end

local function bindTool(p1) --[[ bindTool | Line: 154 | Upvalues: ensureTracker (copy), t3 (copy) ]]
	if not p1:IsA("Tool") then
		return
	end

	if not p1:GetAttribute("Flashbang") then
		return
	end

	ensureTracker(p1)

	if t3[p1] then
		return
	end

	t3[p1] = p1.Activated:Connect(function() --[[ Line: 161 | Upvalues: p1 (copy) ]]
		local v1 = p1:GetAttribute("CooldownEnd")

		if not (typeof(v1) == "number" and os.clock() < v1) then
			p1:SetAttribute("CooldownEnd", os.clock() + 15)
		end
	end)
end

local function watchContainer(p1) --[[ watchContainer | Line: 170 | Upvalues: bindTool (copy) ]]
	for v1, v2 in p1:GetChildren() do
		if v2:IsA("Tool") then
			bindTool(v2)
		end
	end

	p1.ChildAdded:Connect(function(p1) --[[ Line: 176 | Upvalues: bindTool (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		bindTool(p1)
	end)
end

function t.Init(p1) --[[ Init | Line: 183 ]] end
function t.Start(p1) --[[ Start | Line: 185 | Upvalues: LocalPlayer (copy), watchContainer (copy) ]]
	watchContainer((LocalPlayer:WaitForChild("Backpack")))

	if LocalPlayer.Character then
		watchContainer(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 192 | Upvalues: watchContainer (ref) ]]
		watchContainer(p1)
	end)
end

return t