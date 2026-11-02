-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ScreenShake, time of decompilation: Sun May  3 10:11:07 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Vide = require(ReplicatedStorage.Packages.Vide)
local Frame = require(ReplicatedStorage.Source.Core.UI.Primitives.Frame)
local n1 = 0

return function(t1: {[any]: any}) -- line: 23
	-- upvalues: n1 (ref), Vide (copy), RunService (copy), Workspace (copy), Frame (copy)
	n1 += 1

	local v8 = t1.Duration or 0.55
	local v9 = t1.PositionStrength or 0.18
	local v10 = t1.RotationStrength or 0.013962634015954637
	local v11 = t1.BindName or "ScreenShake_" .. tostring(n1)
	local u12 = t1.Trigger()
	local n2 = 0

	Vide.effect(function() -- line: 33
		-- upvalues: t1 (copy), u12 (ref), n2 (ref), v8 (copy)
		local v14 = t1.Trigger()

		if v14 == u12 then
			return
		end

		u12 = v14
		n2 = math.max(n2, os.clock() + v8)
	end)
	RunService:BindToRenderStep(v11, Enum.RenderPriority.Camera.Value + 1, function() -- line: 43
		-- upvalues: n2 (ref), Workspace (copy), v8 (copy), v9 (copy), v10 (copy)
		local v15 = n2 - os.clock()

		if v15 <= 0 then
			return
		end

		local CurrentCamera = Workspace.CurrentCamera

		if not CurrentCamera then
			return
		end

		local v17 = math.clamp(v15 / v8, 0, 1)
		local v18 = v17 * v17
		local v19 = os.clock() * 55
		local v20 = math.noise(v19, 0, 0) * v9 * v18
		local v21 = math.noise(0, v19, 0) * v9 * 0.65 * v18
		local v22 = math.noise(0, 0, v19) * v10 * v18

		CurrentCamera.CFrame = CurrentCamera.CFrame * (CFrame.new(v20, v21, 0) * CFrame.Angles(0, 0, v22))
	end)
	Vide.cleanup(function() -- line: 63
		-- upvalues: RunService (copy), v11 (copy), n2 (ref)
		RunService:UnbindFromRenderStep(v11)
		n2 = 0
	end)

	return Frame({
		BackgroundTransparency = 1,
		Name = t1.Name or "ScreenShake",
		Visible = t1.Visible == nil or t1.Visible,
		Size = UDim2.fromOffset(0, 0)
	})
end
