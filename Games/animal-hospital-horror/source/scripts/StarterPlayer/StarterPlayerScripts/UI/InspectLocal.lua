local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = nil
local v2 = nil
local CurrentCamera = workspace.CurrentCamera

-- Encuentra el ProximityPrompt del model, sea hijo directo o dentro de un BasePart
-- (para que el prompt pueda renderizar sobre una parte, no solo colgando del Model).
local function getPP(m)
	return m and (m:FindFirstChild("PP") or m:FindFirstChildWhichIsA("ProximityPrompt", true))
end

local function InspectModel(p1, p2) --[[ InspectModel | Line: 7 | Upvalues: v1 (ref), v2 (ref), CurrentCamera (copy) ]]
	v1 = p1
	local pp = getPP(p1)
	if pp then pp.Enabled = false end
	v2 = p2

	while p1 or p2 do
		if not (p1.PrimaryPart and p1:IsDescendantOf(game.Workspace)) then
			break
		end

		if not p1.PrimaryPart then
			return
		end

		p1:SetPrimaryPartCFrame(CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(math.pi, 0, math.pi))
		game:GetService("RunService").RenderStepped:Wait()
	end

	if not p1.PrimaryPart then
		return
	end

	p1:SetPrimaryPartCFrame(p1.PrimaryPart.CFrame)
	if pp then pp.Enabled = pp:GetAttribute("MultipleInspect") and not pp:GetAttribute("DisableInspect") end
end

Lib.Inject("GetCurrentInspect", function() --[[ Line: 25 | Upvalues: v1 (ref), v2 (ref) ]]
	return v1 or v2
end)

local function process(p1) --[[ process | Line: 29 | Upvalues: v1 (ref), InspectModel (copy) ]]
	p1.PP.Triggered:Connect(function() --[[ Line: 30 | Upvalues: v1 (ref), InspectModel (ref), p1 (copy) ]]
		if v1 then
			v1 = nil
		else
			InspectModel(p1)
		end
	end)
end

Lib.Inject("InspectModel", InspectModel)
Lib.Inject("StopForcedInspect", function() --[[ Line: 41 | Upvalues: v1 (ref), v2 (ref) ]]
	if not (v1 and (v1.Parent and v1.PrimaryPart)) then
		v2 = nil
		v1 = nil

		return
	end

	v1:Destroy()
	v2 = nil
	v1 = nil
end)

for v3, v4 in Lib.CS:GetTagged("Inspect") do
	local pp = getPP(v4)
	if pp then
		pp.Triggered:Connect(function()
			if v1 then
				v1 = nil
			else
				InspectModel(v4)
			end
		end)
	end
end

Lib.CS:GetInstanceAddedSignal("Inspect"):Connect(function(p1) --[[ Line: 52 | Upvalues: v1 (ref), InspectModel (copy) ]]
	local pp = getPP(p1)
	if pp then
		pp.Triggered:Connect(function()
			if v1 then
				v1 = nil
			else
				InspectModel(p1)
			end
		end)
	end
end)
game:GetService("UserInputService").InputBegan:Connect(function(p1, p2) --[[ Line: 56 | Upvalues: v1 (ref) ]]
	if p2 then
		return
	end

	if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Touch and p1.KeyCode ~= Enum.KeyCode.ButtonX) or not v1 then
		return
	end

	v1 = nil
end)

return {}