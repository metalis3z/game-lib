--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {}

t.__index = t

local function normalizeClamped(p1, p2, p3) --[[ normalizeClamped | Line: 7 ]]
	return math.clamp((p1 - p2) / (p3 - p2), 0, 1)
end

function t.new(p1, p2) --[[ new | Line: 11 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Template = p1
	v2.MaxSize = if p2 then p2 else p1.Size.X
	v2.Part = p1:Clone()
	v2.Selection = p1.Parent:FindFirstChild("targetSelect"):Clone()
	v2.Part.Anchored = true
	v2.Part.Parent = workspace
	v2.Selection.Anchored = true
	v2.Selection.Parent = workspace
	v2._conn = nil

	return v2
end
function t.Attach(p1, p2, p3) --[[ Attach | Line: 28 | Upvalues: RunService (copy) ]]
	p1:Detach()
	p1._conn = RunService.Heartbeat:Connect(function() --[[ Line: 31 | Upvalues: p2 (copy), p3 (copy), p1 (copy) ]]
		local v1 = p2 and p2:FindFirstChild("HumanoidRootPart")

		if not v1 then
			return
		end

		local Position = p3.Position

		if not Position then
			return
		end

		local v4 = v1.Position - Vector3.new(0, v1.Size.Y / 2 + (if v1.Parent:FindFirstChild("Humanoid") then v1.Parent:FindFirstChild("Humanoid").HipHeight else 0) - 0.25, 0)
		local v5 = Position - v4
		local v6 = Vector3.new(v5.X, 0, v5.Z)
		local v11 = v5.Magnitude + (p1.Part.Size.Z / 2 * math.max(0.1, (math.clamp((v5.Magnitude / p1.MaxSize - 1) / -1, 0, 1))) + 0.5)
		local MaxSize = p1.MaxSize
		local v12 = MaxSize * 0.5
		local v13 = math.clamp((v11 - v12) / (MaxSize - v12), 0, 1)
		local v15 = math.sin(os.clock() * 40) * v13

		p1.Part.Size = Vector3.new(math.clamp(v11, 5, MaxSize), p1.Part.Size.Y, p1.Part.Size.Z)
		p1.Part.PivotOffset = CFrame.new(-(p1.Part.Size.X / 2) + p1.Part.Size.Z / 2 * math.clamp((v11 / MaxSize - 1) / -1, 0, 1), 0, 0)

		if v6.Magnitude > 0.01 then
			p1.Part:PivotTo(CFrame.lookAt(v4, v4 + v6) * CFrame.Angles(0, 1.5707963267948966, 0))
			p1.Selection:PivotTo(CFrame.new(Position - Vector3.new(0, p3.Size.Y / 2 + (if p3.Parent:FindFirstChild("Humanoid") then p3.Parent:FindFirstChild("Humanoid").HipHeight else 0) - 0.25, 0)))
		end

		local SurfaceGui = p1.Part:FindFirstChild("SurfaceGui")

		if not (SurfaceGui and SurfaceGui:FindFirstChild("Frame1")) then
			return
		end

		SurfaceGui.Frame1.AnchorPoint = Vector2.new(0.5 - v15 * 0.5, 0)
		SurfaceGui.Frame1.Size = UDim2.fromScale(math.max(0.1, (math.clamp((v11 / MaxSize - 1) / -1, 0, 1))), 1)
	end)
end
function t.Detach(p1) --[[ Detach | Line: 89 ]]
	if not p1._conn then
		return
	end

	p1._conn:Disconnect()
	p1._conn = nil
end
function t.Destroy(p1) --[[ Destroy | Line: 96 ]]
	p1:Detach()

	if p1.Part then
		p1.Part:Destroy()
		p1.Part = nil
	end

	if not p1.Selection then
		return
	end

	p1.Selection:Destroy()
	p1.Selection = nil
end

return t