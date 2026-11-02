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
local t = {}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function renderlerp(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ renderlerp | Line: 12 | Upvalues: RunService (copy), TweenService (copy) ]]
	local v1 = nil
	local v2 = 0
	local v3 = false

	v1 = RunService.RenderStepped:Connect(function(p12) --[[ Line: 18 | Upvalues: p1 (copy), p2 (copy), p3 (copy), v3 (ref), v1 (ref), p8 (copy), p9 (copy), v2 (ref), TweenService (ref), p5 (copy), p6 (copy), p4 (copy) ]]
		if not (p1 and (p2 and p3)) then
			v3 = true
			v1:Disconnect()

			return
		end

		v2 = v2 + p12

		if p8 == true and p9 then
			if p9.Parent == nil then
				v3 = true
				v1:Disconnect()

				return
			end

			local _, v12, _2 = CFrame.lookAt(p9.PrimaryPart.Position, p3.CFrame.Position):ToOrientation()
			local v22 = p9.PrimaryPart.CFrame
			local v32 = CFrame.new(p3.CFrame.Position.X, p3.CFrame.Position.Y, p3.CFrame.Position.Z) * CFrame.fromOrientation(0, v12, 0)
			local v6 = TweenService:GetValue(math.min(v2 / 0.5, 1), p5, p6)
			local v7 = v22.Position:Lerp(v32.Position, v6)
			local v8 = v22.Rotation:Lerp(v32.Rotation, v6)

			p1:PivotTo(CFrame.new(v7) * v8)

			if v2 / 0.5 >= 1 then
				v3 = true
				v1:Disconnect()
			end
		else
			local v11 = TweenService:GetValue(math.min(v2 / p4, 1), p5, p6)
			local v12 = p2.Position:Lerp(p3.Position, v11)
			local v13 = p2.Rotation:Lerp(p3.Rotation, v11)

			p1:PivotTo(CFrame.new(v12) * v13)

			if not (v2 / p4 >= 1) then
				return
			end

			v3 = true
			v1:Disconnect()
		end
	end)

	if not p7 then
		return
	end

	while not v3 do
		task.wait()
	end
end

function t.RenderObject(p1) --[[ RenderObject | Line: 80 | Upvalues: ReplicatedStorage (copy), Debris (copy) ]]
	local v1 = p1[1]
	local v2 = p1[2]
	local Humanoid = v1:WaitForChild("Humanoid")
	local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
	local HumanoidRootPart2 = v2:WaitForChild("HumanoidRootPart")
	local Skin = v1:WaitForChild("Stats"):WaitForChild("Skin")
	local _ = HumanoidRootPart.Size.Y / 2 + Humanoid.HipHeight
	local v3 = require(ReplicatedStorage.SharedUtils.TowerLUT):GetSkinModuleFolder()

	if Skin.Value ~= "Default" then
		require(v3.Cosmo[Skin.Value]).UseAbility(v1, v2, HumanoidRootPart, HumanoidRootPart2)

		return
	end

	local v4 = script.Cookie:Clone()

	Debris:AddItem(v4, 2)
	v4.Parent = workspace
	v4.Position = HumanoidRootPart.Position
	v4.Trail.Enabled = true
	v4.SmokePart.Enabled = true

	local Position = HumanoidRootPart2.Position
	local Movement = require(script.Movement)

	local function chase() --[[ chase | Line: 120 | Upvalues: v4 (copy), HumanoidRootPart2 (copy), Movement (copy) ]]
		Movement.parabola(v4, v4.Position, HumanoidRootPart2, 20, 25, 0.5)
	end

	Movement.parabola(v4, v4.Position, HumanoidRootPart2, 20, 25, 0.5)

	if not v4 then
		return
	end

	v4.SmokePart.Enabled = false
	v4.Transparency = 1
	v4.HeartPart:Emit(10)
	v4.Eat:Play()
end

return t