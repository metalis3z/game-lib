-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")

Library:WaitForChild("Types")

local Client = Library:WaitForChild("Client")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Variables = require(Library.Variables)
local Tween = require(Library.Functions.Tween)
local Player = require(Library.Player)

require(Library.Signal)

local Audio = require(Library.Audio)
local ScreenResolution = require(Client.ScreenResolution)
local InfoOverlay = Assets.UI.FRAMEWORK.InfoOverlay
local Blocks = InfoOverlay:WaitForChild("Blocks")
local v1 = GuiService:GetGuiInset()
local v2 = nil
local t2 = {}
local v3 = nil

function t.IsActive() --[[ IsActive | Line: 25 | Upvalues: v2 (ref) ]]
	return v2 ~= nil
end
function t.Remove() --[[ Remove | Line: 29 | Upvalues: v2 (ref) ]]
	if not v2 then
		return
	end

	v2:Destroy()
	v2 = nil
end
function t.Add(p1, ...) --[[ Add | Line: 36 | Upvalues: v2 (ref), t (copy), InfoOverlay (copy), TextService (copy), ScreenResolution (copy), Blocks (copy), t2 (copy), v3 (ref), Player (copy), Audio (copy), Tween (copy), RunService (copy), v1 (copy), Variables (copy), GuiService (copy) ]]
	local list = { ... }

	if v2 then
		t.Remove()
	end

	local v12 = InfoOverlay:FindFirstChild("Base"):Clone()
	local v22 = 0
	local t3 = {}

	local function updateSize() --[[ updateSize | Line: 46 | Upvalues: v22 (ref), list (copy), t3 (copy), TextService (ref), v12 (copy), ScreenResolution (ref) ]]
		v22 = 0

		for i, v in ipairs(list) do
			local v1 = t3[i]
			local v2 = v1:FindFirstChild("settings")
			local UIListLayout = v1:FindFirstChildOfClass("UIListLayout")
			local UIGridLayout = v1:FindFirstChildOfClass("UIGridLayout")
			local UIPadding = v1:FindFirstChildOfClass("UIPadding")
			local zero = Vector2.zero

			if UIListLayout then
				zero = UIListLayout:GetAttribute("OriginalAbsoluteContentSize") or UIListLayout.AbsoluteContentSize
			end

			if v2 then
				local v4 = v2:GetAttribute("boundsX")
				local Y = v4.Y
				local sum = 0
				local sum2 = 0
				local sum3 = 0

				if UIListLayout then
					sum3 = zero.Y
				elseif not UIGridLayout then
					for i2, v3 in ipairs(v1:GetChildren()) do
						local v5

						if v3:IsA("GuiObject") and v3.Visible then
							local v6 = v3:GetAttribute("OriginalSize")

							if not v6 then
								v6 = v3.Size
								v3:SetAttribute("OriginalSize", v6)
							end

							local v7 = v3:GetAttribute("OriginalAbsoluteSize") or v3.AbsoluteSize

							if v3.ClassName == "TextLabel" or v3.ClassName == "TextButton" then
								if v6.X.Scale ~= 0 or v3.AutomaticSize == Enum.AutomaticSize.X then
									local v8 = Vector2.new(Y * v6.X.Scale, 1000)
									local v9 = v3:GetAttribute("BaseText") or v3.ContentText

									v5 = v3.Font == Enum.Font.Unknown and Enum.Font.Arial or v3.Font

									local v122 = TextService:GetTextSize(v9, v3.TextSize, v5, v8) + Vector2.new(10, 1)
									local v13 = math.max(v122.X, sum)

									sum2 = sum2 + math.max(v122.Y, v7.Y)

									local UIStroke = v3:FindFirstChildOfClass("UIStroke")

									if UIStroke then
										sum = v13 + UIStroke.Thickness * 2
										sum2 = sum2 + UIStroke.Thickness * 2
									else
										sum = v13
									end

									v3.Size = UDim2.new(0, v122.X, 0, v122.Y)
								end

								continue
							end

							if v6.X.Scale ~= 0 then
								sum3 = sum3 + v7.Y
							end
						end
					end
				end

				if UIListLayout and UIListLayout.FillDirection == Enum.FillDirection.Horizontal then
					sum = math.max(zero.X + 10, sum)
				end

				if UIPadding then
					if not UIGridLayout then
						sum2 = sum2 + (UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)
					end

					sum = sum + (UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset)
				end

				v22 = math.max(math.clamp(sum, v4.X, Y), v22)

				if UIGridLayout then
					sum3 = (UIGridLayout:GetAttribute("OriginalAbsoluteContentSize") or UIGridLayout.AbsoluteContentSize).Y
				end

				v1.Size = UDim2.new(1, 0, 0, sum2 + sum3)
			end
		end

		local UIPadding = v12.Frame.Blocks:FindFirstChildOfClass("UIPadding")
		local UIListLayout = v12.Frame.Blocks:FindFirstChildOfClass("UIListLayout")

		UIListLayout:ApplyLayout()
		v12.Size = UDim2.new(0, v22 + UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset, 0, UIListLayout.AbsoluteContentSize.Y + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset)

		local v19, v20

		if #list == 1 then
			v12.Frame.UICorner.CornerRadius = UDim.new(0.15, 0)
		end

		v19 = v12.UIScale
		v20 = ScreenResolution.GetScale()
		v19.Scale = 1 - (1 - math.min(v20, 1)) / 1.5
	end

	local v32 = false
	local v4 = false
	local v5 = "Down"

	for i, v in ipairs(list) do
		local v6 = v[1]
		local v7 = Blocks:FindFirstChild(v6):Clone()

		table.insert(t3, v7)

		local v8 = v7:FindFirstChild("settings")

		if v8 and v8:FindFirstChild("code") then
			task.spawn(function() --[[ Line: 168 | Upvalues: t2 (ref), v6 (copy), v8 (copy), v7 (copy), v32 (ref), v4 (ref), v (copy) ]]
				local v1 = t2[v6] or require(v8:FindFirstChild("code"))

				v7:GetAttributeChangedSignal("Updated"):Connect(function() --[[ Line: 170 | Upvalues: v7 (ref), v32 (ref), v4 (ref) ]]
					if v7:GetAttribute("Updated") ~= true then
						return
					end

					v7:SetAttribute("Updated", false)

					if not v32 then
						return
					end

					v4 = true
				end)
				v1(v7, unpack(v))
			end)
		end

		v7.LayoutOrder = i * 100
		v7.Parent = v12.Frame.Blocks
	end

	updateSize()

	if not v3 then
		v3 = Instance.new("ScreenGui")
		v3.DisplayOrder = 10000
		v3.ZIndexBehavior = Enum.ZIndexBehavior.Global
		v3.ResetOnSpawn = false
		v3.Name = "InfoOverlay"
		v3.Parent = Player.PlayerGui()
		v3.ClipToDeviceSafeArea = false
	end

	v12.Parent = v3
	Audio.Play("rbxassetid://89944486811970", script, 1, 0.2)
	v2 = v12

	local v9 = false

	for i, v in ipairs(list) do
		if v[1] == "Rarity" then
			if v[2] == "Exclusive" then
				v9 = true
			end

			break
		end
	end

	if v9 then
		local v10 = InfoOverlay.ExclusiveShine:Clone()

		v10.Parent = v12.Frame

		local UIStroke = v12.Frame:FindFirstChildOfClass("UIStroke")
		local v11 = InfoOverlay.ExclusiveShineOutline:Clone()

		v11.Parent = UIStroke
		UIStroke.Color = Color3.fromRGB(255, 255, 255)
		v10.Offset = Vector2.new(0, -1.25)
		Tween(v10, {
			Offset = Vector2.new(0, 2)
		}, { 0.75, "Sine", "Out" })
		task.spawn(function() --[[ Line: 228 | Upvalues: v12 (copy), v11 (copy), RunService (ref) ]]
			local v1 = tick()

			task.wait()

			while v12 and v12.Parent do
				v11.Rotation = 100 + (tick() - v1) * 100
				RunService.RenderStepped:Wait()
			end
		end)
	end

	coroutine.wrap(function() --[[ Line: 238 | Upvalues: Player (ref), v12 (copy), v4 (ref), updateSize (copy), v1 (ref), Variables (ref), p1 (copy), v5 (ref), RunService (ref) ]]
		local v13 = Player.Mouse()
		local CurrentCamera = game.Workspace.CurrentCamera

		while v12 and v12.Parent do
			if v4 then
				v4 = false
				updateSize()
			end

			local X = v13.X
			local Y = v13.Y
			local Y2 = v12.AbsoluteSize.Y
			local v3 = CurrentCamera.ViewportSize.Y - v1.Y

			if Variables.Console then
				X = p1.AbsolutePosition.X + p1.AbsoluteSize.X * 0.5
				Y = p1.AbsolutePosition.Y + p1.AbsoluteSize.Y * 0.5
			end

			if Y + Y2 + 10 < v3 then
				v5 = "Down"
			elseif Y - Y2 - 10 > 0 then
				v5 = "Up"
			end

			local v42 = CurrentCamera.ViewportSize.X - v1.X - v12.AbsoluteSize.X
			local v6 = v3 + (v5 == "Down" and -Y2 or Y2)

			if v42 < 0 then
				v42 = 0
			end

			if v6 < 0 then
				v6 = 0
			end

			v12.AnchorPoint = Vector2.new(0, if v5 == "Down" then 0 else 1)
			v12.Position = UDim2.new(0, math.clamp(X + 10, 0, v42), 0, (math.clamp(Y + (if v5 == "Down" then 10 else -10), 0, v6)))
			RunService.RenderStepped:Wait()
		end
	end)()
	coroutine.wrap(function() --[[ Line: 277 | Upvalues: Player (ref), p1 (copy), v12 (copy), Variables (ref), GuiService (ref), t (ref), RunService (ref), v2 (ref) ]]
		local v1 = Player.Mouse()

		if p1:GetAttribute("SurfaceElement") then
			local v22 = nil

			v22 = p1.MouseLeave:Connect(function() --[[ Line: 303 | Upvalues: v12 (ref), v2 (ref), t (ref), v22 (ref) ]]
				if v12 ~= v2 then
					return
				end

				t.Remove()

				if not v22 then
					return
				end

				v22:Disconnect()
				v22 = nil
			end)
			p1.Destroying:Connect(function() --[[ Line: 313 | Upvalues: v12 (ref), v2 (ref), t (ref), v22 (ref) ]]
				if v12 ~= v2 then
					return
				end

				t.Remove()

				if not v22 then
					return
				end

				v22:Disconnect()
				v22 = nil
			end)

			return
		end

		while v12 and v12.Parent do
			local X = v1.X
			local Y = v1.Y
			local X2 = p1.AbsolutePosition.X
			local Y2 = p1.AbsolutePosition.Y
			local X3 = p1.AbsoluteSize.X
			local Y3 = p1.AbsoluteSize.Y

			if Variables.Console then
				if GuiService.SelectedObject ~= p1 then
					t.Remove()
				end
			elseif not (X <= X2 + X3) or (not (X2 <= X) or (Y2 + Y3 <= Y or Y < Y2)) then
				t.Remove()
			end

			RunService.RenderStepped:Wait()
		end
	end)()
end
function t.Hook(p1, p2) --[[ Hook | Line: 328 | Upvalues: Variables (copy), t (copy) ]]
	local v1 = p1.MouseEnter:Connect(function() --[[ Line: 329 | Upvalues: Variables (ref), t (ref), p1 (copy), p2 (copy) ]]
		if Variables.DisableInfoOverlay then
			return
		end

		t.Add(p1, unpack(p2))
	end)
	local v2 = p1.SelectionGained:Connect(function() --[[ Line: 334 | Upvalues: Variables (ref), t (ref), p1 (copy), p2 (copy) ]]
		if Variables.DisableInfoOverlay then
			return
		end

		t.Add(p1, unpack(p2))
	end)

	return function() --[[ Line: 339 | Upvalues: v1 (copy), v2 (copy) ]]
		v1:Disconnect()
		v2:Disconnect()
	end
end
function t.DynamicHook(p1, p2) --[[ DynamicHook | Line: 345 | Upvalues: Variables (copy), t (copy) ]]
	local v1 = p1.MouseEnter:Connect(function() --[[ Line: 346 | Upvalues: Variables (ref), t (ref), p1 (copy), p2 (copy) ]]
		if Variables.DisableInfoOverlay then
			return
		end

		t.Add(p1, unpack(p2()))
	end)
	local v2 = p1.SelectionGained:Connect(function() --[[ Line: 351 | Upvalues: Variables (ref), t (ref), p1 (copy), p2 (copy) ]]
		if Variables.DisableInfoOverlay then
			return
		end

		t.Add(p1, unpack(p2()))
	end)

	return function() --[[ Line: 356 | Upvalues: v1 (copy), v2 (copy) ]]
		v1:Disconnect()
		v2:Disconnect()
	end
end

return t