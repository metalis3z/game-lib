-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Variables = require(Library.Variables)
local PlayerGui = Players.LocalPlayer.PlayerGui

return function(p1, p2) --[[ Tooltip | Line: 14 | Upvalues: Variables (copy), PlayerGui (copy), TextService (copy), Players (copy), RunService (copy) ]]
	if Variables.Mobile then
		return function() --[[ Line: 16 ]] end
	end

	local t = {}
	local v1 = nil
	local v2 = nil
	local TooltipsFolder = PlayerGui:FindFirstChild("TooltipsFolder")

	if TooltipsFolder == nil then
		TooltipsFolder = Instance.new("ScreenGui")
		TooltipsFolder.Name = "TooltipsFolder"
		TooltipsFolder.DisplayOrder = 999
		TooltipsFolder.Parent = PlayerGui
	end

	local function showTooltip() --[[ showTooltip | Line: 32 | Upvalues: TooltipsFolder (ref), v1 (ref), p2 (copy), TextService (ref), v2 (ref), p1 (copy), Variables (ref), Players (ref), RunService (ref) ]]
		TooltipsFolder:ClearAllChildren()
		v1 = Instance.new("TextLabel")
		v1.BorderSizePixel = 0
		v1.BackgroundColor3 = Color3.new(0.35, 0.35, 0.35)
		v1.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		v1.TextSize = 18
		v1.Font = Enum.Font.FredokaOne
		v1.Text = p2

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = v1

		local v12 = TextService:GetTextSize(v1.Text, v1.TextSize, v1.Font, Vector2.new(1000, 1000))

		v1.Size = UDim2.fromOffset(v12.X + 14, v12.Y + 8)
		v1.Parent = TooltipsFolder

		if not TooltipsFolder.Enabled then
			TooltipsFolder.Enabled = true
		end

		while not v2 and (v1 and (v1.Parent and (p1 and not Variables.Mobile))) do
			local v22 = Players.LocalPlayer:GetMouse()
			local X = v22.X
			local Y = v22.Y
			local X3 = p1.AbsolutePosition.X
			local Y3 = p1.AbsolutePosition.Y

			if Variables.Console then
				X = p1.AbsolutePosition.X + p1.AbsoluteSize.X * 0.5
				Y = p1.AbsolutePosition.Y + p1.AbsoluteSize.Y * 0.5
			end

			if X3 - 10 < X and (X < X3 + p1.AbsoluteSize.X + 10 and (Y3 - 10 < Y and Y < Y3 + p1.AbsoluteSize.Y + 10)) then
				if Variables.Console then
					v1.Position = UDim2.fromOffset(X + 17, Y)
				else
					v1.Position = UDim2.fromOffset(v22.X + 17, v22.Y)
				end
			else
				v2 = true
			end

			RunService.RenderStepped:Wait()
		end

		if not v1 then
			return
		end

		v1:Destroy()
	end

	local function destroyTooltip() --[[ destroyTooltip | Line: 87 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		v1:Destroy()
	end

	t[#t + 1] = p1.MouseEnter:Connect(function() --[[ Line: 93 | Upvalues: v1 (ref), showTooltip (copy) ]]
		if not v1 then
			showTooltip()

			return
		end

		v1:Destroy()
		showTooltip()
	end)
	t[#t + 1] = p1.MouseLeave:Connect(function() --[[ Line: 98 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		v1:Destroy()
	end)
	t[#t + 1] = p1.SelectionGained:Connect(function() --[[ Line: 102 | Upvalues: v1 (ref), showTooltip (copy) ]]
		if v1 then
			v1:Destroy()
		end

		showTooltip()
	end)
	t[#t + 1] = p1.SelectionLost:Connect(function() --[[ Line: 107 | Upvalues: v1 (ref) ]]
		if not v1 then
			return
		end

		v1:Destroy()
	end)

	return function() --[[ Line: 111 | Upvalues: t (ref), v2 (ref) ]]
		for i, v in ipairs(t) do
			v:Disconnect()
		end

		t = {}
		v2 = true
	end
end