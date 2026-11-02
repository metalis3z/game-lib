-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LuckHudState, time of decompilation: Sun May  3 10:11:23 2026 ]]
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local uDim2 = UDim2.fromScale(0.015, 0.965)
local vector2 = Vector2.new(32, -32)
local t1 = {}

local function findLuckCounterGui() -- line: 9
	-- upvalues: Players (copy)
	local LocalPlayer = Players.LocalPlayer
	local v8 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")

	if not v8 then
		return nil
	end

	local Root = v8:FindFirstChild("Root")

	if not Root then
		return nil
	end

	local LuckStat = Root:FindFirstChild("LuckStat", true)

	if LuckStat and LuckStat:IsA("GuiObject") then
		local Content = LuckStat:FindFirstChild("Content")

		if Content and Content:IsA("GuiObject") then
			return Content
		end

		return LuckStat
	end

	return nil
end

function t1.getCounterCenter() -- line: 34
	-- upvalues: findLuckCounterGui (copy), Workspace (copy), uDim2 (copy), vector2 (copy)
	local v12 = findLuckCounterGui()

	if v12 and v12.AbsoluteSize.Magnitude > 0 then
		return v12.AbsolutePosition + v12.AbsoluteSize / 2
	end

	local CurrentCamera = Workspace.CurrentCamera
	local v14 = if not CurrentCamera then Vector2.new(1920, 1080) else CurrentCamera.ViewportSize

	return Vector2.new(v14.X * uDim2.X.Scale + uDim2.X.Offset, v14.Y * uDim2.Y.Scale + uDim2.Y.Offset) + vector2
end

return t1
