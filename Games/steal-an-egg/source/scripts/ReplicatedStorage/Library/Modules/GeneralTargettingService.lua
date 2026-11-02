-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GetMouseToWorld = require(ReplicatedStorage.Library.Functions.GetMouseToWorld)
local Arrows = script:WaitForChild("Arrows")
local Attachment1 = Arrows.Attachment1
local Attachment2 = Arrows.Attachment2
local t = {
	Handler = nil,
	CurrentTarget = nil,
	LastHover = nil
}
local t2 = {}
local Highlight = Instance.new("Highlight")

Highlight.FillTransparency = 1

local function resetState() --[[ resetState | Line: 22 | Upvalues: t (copy), Highlight (copy), Arrows (copy) ]]
	t.LastHover = nil
	t.CurrentTarget = nil
	t.Handler = nil
	Highlight.Parent = nil
	Arrows.Parent = script
end

local v1 = false

local function confirmTarget() --[[ confirmTarget | Line: 32 | Upvalues: v1 (ref), t (copy), Highlight (copy), Arrows (copy) ]]
	if v1 then
		return
	end

	local Handler = t.Handler

	if not Handler then
		return
	end

	Handler.OnUnhover(t.LastHover)

	if t.CurrentTarget then
		Handler.OnConfirm(t.CurrentTarget)
	else
		Handler.OnCancelled()
	end

	t.LastHover = nil
	t.CurrentTarget = nil
	t.Handler = nil
	Highlight.Parent = nil
	Arrows.Parent = script
end

function t.CreateTargetingHandler(p1, p2) --[[ CreateTargetingHandler | Line: 50 | Upvalues: v1 (ref), t (copy), Highlight (copy), Arrows (copy) ]]
	v1 = true
	t.LastHover = nil
	t.CurrentTarget = nil
	t.Handler = nil
	Highlight.Parent = nil
	Arrows.Parent = script
	t.Handler = p2
	p2.OnHover = p2.OnHover or (function() --[[ Line: 54 ]] end)
	p2.OnUnhover = p2.OnUnhover or (function() --[[ Line: 55 ]] end)
	p2.OnCancelled = p2.OnCancelled or (function() --[[ Line: 56 ]] end)
	p2.OnConfirm = p2.OnConfirm or (function() --[[ Line: 57 ]] end)
	task.delay(0.5, function() --[[ Line: 58 | Upvalues: v1 (ref) ]]
		v1 = false
	end)
end
RunService.RenderStepped:Connect(function() --[[ Line: 63 | Upvalues: t (copy), t2 (copy), GetMouseToWorld (copy), Arrows (copy), Highlight (copy), Attachment1 (copy), Attachment2 (copy) ]]
	local Handler = t.Handler

	if not Handler then
		return
	end

	local v1 = t2[Handler.TargetType]

	if not v1 then
		return
	end

	local v2 = GetMouseToWorld(RaycastParams.new(), 100)
	local v3 = if v2 then v2.Instance else v2
	local v4 = if v3 then v1(v3) else v3

	t.CurrentTarget = v4
	Arrows.Parent = v3 and workspace or script
	Highlight.Adornee = v4
	Highlight.Parent = v4

	if v2 then
		Attachment1.WorldCFrame = Handler.Targeter:GetPivot()
		Attachment2.WorldCFrame = v4 and v4:GetPivot() or CFrame.new(v2.Position)
	end

	local LastHover = t.LastHover

	if LastHover ~= v4 then
		Handler.OnUnhover(LastHover)
		Handler.OnHover(v4)
	end
end)

local t3 = {
	[Enum.UserInputType.MouseButton1] = {}
}
local t4 = {
	[Enum.UserInputType.MouseButton1] = { confirmTarget }
}

UserInputService.InputBegan:Connect(function(p1) --[[ Line: 99 | Upvalues: t3 (copy) ]]
	local v1 = t3[p1.KeyCode] or t3[p1.UserInputType]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		task.spawn(function() --[[ Line: 105 | Upvalues: v3 (copy), p1 (copy) ]]
			v3(p1)
		end)
	end
end)
UserInputService.InputEnded:Connect(function(p1) --[[ Line: 111 | Upvalues: t4 (copy) ]]
	local v1 = t4[p1.KeyCode] or t4[p1.UserInputType]

	if not v1 then
		return
	end

	for v2, v3 in v1 do
		task.spawn(function() --[[ Line: 117 | Upvalues: v3 (copy), p1 (copy) ]]
			v3(p1)
		end)
	end
end)
UserInputService.TouchTap:Connect(function() --[[ Line: 123 | Upvalues: v1 (ref), t (copy), Highlight (copy), Arrows (copy) ]]
	if v1 then
		return
	end

	local Handler = t.Handler

	if not Handler then
		return
	end

	Handler.OnUnhover(t.LastHover)

	if t.CurrentTarget then
		Handler.OnConfirm(t.CurrentTarget)
	else
		Handler.OnCancelled()
	end

	t.LastHover = nil
	t.CurrentTarget = nil
	t.Handler = nil
	Highlight.Parent = nil
	Arrows.Parent = script
end)

return t