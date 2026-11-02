--credit to leon games studio
-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	StartOrder = 11
}
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local PetData = require(ReplicatedStorage.SharedData.PetData)
local PetTypes = require(ReplicatedStorage.SharedData.PetTypes)
local RarityVisuals = require(ReplicatedStorage.SharedModules.RarityVisuals)
local AnimatedGradient = require(ReplicatedStorage.SharedModules.AnimatedGradient)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v1 = Color3.new(255/255, 255/255, 255/255)
local v2 = Color3.fromRGB(0, 0, 0)
local v3 = Vector2.new(260, 44)
local v4 = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local v5 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 165, 0)),
	ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 0)),
	ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 100, 255)),
	ColorSequenceKeypoint.new(0.83, Color3.fromRGB(140, 0, 200)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 200))
})
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = 0
local v13 = 0
local v14 = 0
local v15 = nil
local v16 = nil
local v17 = nil
local v18 = nil
local v19 = nil

local function _(p1) --[[ _ | Line: 45 ]]
	if type(p1) == "string" and p1 ~= "" then
		return p1
	end

	return nil
end

local function _2() --[[ _ | Line: 52 | Upvalues: v10 (ref), GuiService (copy), UserInputService (copy) ]]
	local v1 = v10

	if v1 then
		local v2 = GuiService:GetGuiInset()

		return Vector2.new(v1.Position.X + v2.X, v1.Position.Y + v2.Y)
	end

	if UserInputService.MouseEnabled then
		return UserInputService:GetMouseLocation()
	end

	return nil
end

local function _3() --[[ _ | Line: 64 | Upvalues: Workspace (copy), v17 (ref), v18 (ref) ]]
	local Map = Workspace:FindFirstChild("Map")

	v17 = if Map then Map:FindFirstChild("WildPetSpawns") else nil

	local _PetVisualClient = Workspace:FindFirstChild("_PetVisualClient")

	v18 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else nil
end

local function v56(p1, p2, p3, p4) --[[ v56 | Line: 71 ]]
	local v1 = p3:PointToObjectSpace(p1)
	local v2 = p3:VectorToObjectSpace(p2)
	local v3 = p4 * 0.5
	local t = { v1.X, v1.Y, v1.Z }
	local t2 = { v2.X, v2.Y, v2.Z }
	local t3 = { v3.X, v3.Y, v3.Z }
	local v4 = (-1 / 0)
	local v5 = (1 / 0)

	for i = 1, 3 do
		if math.abs(t2[i]) < 1e-6 then
			if t[i] < -t3[i] or t[i] > t3[i] then
				return nil
			end

			continue
		end

		local v7 = (-t3[i] - t[i]) / t2[i]
		local v8 = (t3[i] - t[i]) / t2[i]

		if v8 < v7 then
			v7, v8 = v8, v7
		end

		if v4 < v7 then
			v4 = v7
		end

		if v8 < v5 then
			v5 = v8
		end

		if v5 < v4 then
			return nil
		end
	end

	if v5 < 0 then
		return nil
	end

	return math.max(v4, 0)
end

local function v72(p1, p2) --[[ v72 | Line: 122 | Upvalues: Workspace (copy), v17 (ref), v18 (ref), v56 (copy) ]]
	local CurrentCamera = Workspace.CurrentCamera

	if not CurrentCamera then
		return nil
	end

	local v1 = CurrentCamera:ViewportPointToRay(p1, p2)
	local Origin = v1.Origin
	local Direction = v1.Direction
	local v2 = 1000
	local v3 = nil

	for v4, v5 in { v17, v18 } do
		if v5 then
			for v6, v7 in v5:GetChildren() do
				if v7:IsA("Model") then
					local v8, v9 = v7:GetBoundingBox()
					local v10 = v56(Origin, Direction, v8, v9)

					if v10 and v10 < v2 then
						v2 = v10
						v3 = v7
					end
				end
			end
		end
	end

	return v3
end

local function v86(p1) --[[ v86 | Line: 153 | Upvalues: v17 (ref), v18 (ref), Workspace (copy) ]]
	local v1 = p1.Parent

	if v1 == v17 then
		local v2 = p1:GetAttribute("PetName")
		local v3 = if type(v2) == "string" and v2 ~= "" then v2 else nil

		if not v3 then
			return nil
		end

		local t = {
			Species = v3
		}
		local v4 = p1:GetAttribute("PetSize")
		local v5, v6

		if type(v4) == "string" and v4 ~= "" then
			v5 = t
			v6 = v4
		else
			v5 = t
			v6 = nil
		end

		v5.Size = v6

		local v7 = p1:GetAttribute("PetType")

		if type(v7) ~= "string" or v7 == "" then
			v7 = nil
		end

		v5.Type = v7

		return v5
	end

	if v1 ~= v18 then
		return nil
	end

	local v8 = p1:GetAttribute("Owner")
	local v9 = if type(v8) == "string" and v8 ~= "" then v8 else nil
	local v10 = p1:GetAttribute("OwnerSlot")
	local v11 = if type(v10) == "string" and v10 ~= "" then v10 else nil

	if not (v9 and v11) then
		return nil
	end

	local PlayerPetReferences = Workspace:FindFirstChild("PlayerPetReferences")
	local v12 = PlayerPetReferences and PlayerPetReferences:FindFirstChild(v9)
	local v13 = if v12 then v12:FindFirstChild(v11) else v12

	if not v13 then
		return nil
	end

	local v14 = v13:GetAttribute("PetSpecies")
	local v15 = if type(v14) == "string" and v14 ~= "" then v14 else nil

	if not v15 then
		return nil
	end

	local t = {
		Species = v15
	}
	local v16 = v13:GetAttribute("PetSize")
	local v172, v182

	if type(v16) == "string" and v16 ~= "" then
		v172 = t
		v182 = v16
	else
		v172 = t
		v182 = nil
	end

	v172.Size = v182

	local v19 = v13:GetAttribute("PetType")

	if type(v19) ~= "string" or v19 == "" then
		v19 = nil
	end

	v172.Type = v19

	return v172
end

local function _4() --[[ _ | Line: 205 | Upvalues: v15 (ref), v8 (ref), AnimatedGradient (copy) ]]
	if v15 then
		v15()
		v15 = nil
	end

	if not v8 then
		return
	end

	local UIGradient = v8:FindFirstChildOfClass("UIGradient")

	if not UIGradient then
		return
	end

	AnimatedGradient:Remove(UIGradient)
	UIGradient:Destroy()
end

local function v94(p1) --[[ v94 | Line: 219 | Upvalues: v8 (ref), v15 (ref), AnimatedGradient (copy), PetData (copy), PetTypes (copy), v1 (copy), v5 (copy), RarityVisuals (copy) ]]
	if not v8 then
		return
	end

	if v15 then
		v15()
		v15 = nil
	end

	if v8 then
		local UIGradient = v8:FindFirstChildOfClass("UIGradient")

		if UIGradient then
			AnimatedGradient:Remove(UIGradient)
			UIGradient:Destroy()
		end
	end

	v8.Text = PetData.GetDisplayName(p1.Species, p1.Size)

	if p1.Type == PetTypes.Rainbow then
		v8.TextColor3 = v1

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Color = v5
		UIGradient.Parent = v8
		AnimatedGradient:Add(UIGradient)

		return
	end

	local v12 = PetData[p1.Species]

	v15 = RarityVisuals.ApplyToLabels({ v8 }, if v12 then if type(v12.Rarity) == "string" then v12.Rarity else "Common" else "Common")
end

local function _5() --[[ _ | Line: 253 | Upvalues: v16 (ref) ]]
	if not v16 then
		return
	end

	v16:Disconnect()
	v16 = nil
end

local function _6(p1) --[[ _ | Line: 273 | Upvalues: v86 (copy), v8 (ref), v15 (ref), AnimatedGradient (copy), v94 (copy) ]]
	local v1 = v86(p1)

	if v1 then
		v94(v1)

		return
	end

	if v8 then
		v8.Text = "?"
	end

	if v15 then
		v15()
		v15 = nil
	end

	if not v8 then
		return
	end

	local UIGradient = v8:FindFirstChildOfClass("UIGradient")

	if not UIGradient then
		return
	end

	AnimatedGradient:Remove(UIGradient)
	UIGradient:Destroy()
end

local function v113(p1) --[[ v113 | Line: 297 | Upvalues: v11 (ref), v14 (ref), v86 (copy), v8 (ref), v15 (ref), AnimatedGradient (copy), v94 (copy), v16 (ref) ]]
	if p1 then
		if p1 == v11 then
			if v14 ~= 0 then
				return
			end

			v14 = 1
		elseif v11 then
			v11 = p1

			local v1 = v86(p1)

			if v1 then
				v94(v1)
			else
				if v8 then
					v8.Text = "?"
				end

				if v15 then
					v15()
					v15 = nil
				end

				if v8 then
					local UIGradient = v8:FindFirstChildOfClass("UIGradient")

					if UIGradient then
						AnimatedGradient:Remove(UIGradient)
						UIGradient:Destroy()
					end
				end
			end

			if v16 then
				v16:Disconnect()
				v16 = nil
			end

			v16 = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 330 | Upvalues: v11 (ref), p1 (copy), v14 (ref) ]]
				if v11 ~= p1 or p2 then
					return
				end

				v14 = 0
			end)
		else
			v11 = p1

			local v2 = v86(p1)

			if v2 then
				v94(v2)
			else
				if v8 then
					v8.Text = "?"
				end

				if v15 then
					v15()
					v15 = nil
				end

				if v8 then
					local UIGradient = v8:FindFirstChildOfClass("UIGradient")

					if UIGradient then
						AnimatedGradient:Remove(UIGradient)
						UIGradient:Destroy()
					end
				end
			end

			if v16 then
				v16:Disconnect()
				v16 = nil
			end

			v16 = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 362 | Upvalues: v11 (ref), p1 (copy), v14 (ref) ]]
				if v11 ~= p1 or p2 then
					return
				end

				v14 = 0
			end)
			v14 = 1
		end
	else
		if not v11 then
			return
		end

		v14 = 0
	end
end

local function v128(p1) --[[ v128 | Line: 378 | Upvalues: v12 (ref), Workspace (copy), v17 (ref), v18 (ref), v10 (ref), GuiService (copy), UserInputService (copy), v113 (copy), v72 (copy), v7 (ref), v8 (ref), v9 (ref), v13 (ref), v14 (ref), v11 (ref), v16 (ref), v15 (ref), AnimatedGradient (copy), v3 (copy) ]]
	v12 = v12 + p1

	if v12 >= 0.1 then
		v12 = 0

		local Map = Workspace:FindFirstChild("Map")

		v17 = if Map then Map:FindFirstChild("WildPetSpawns") else nil

		local _PetVisualClient = Workspace:FindFirstChild("_PetVisualClient")

		v18 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else nil

		local v32 = v10
		local v4

		if v32 then
			local v5 = GuiService:GetGuiInset()

			v4 = Vector2.new(v32.Position.X + v5.X, v32.Position.Y + v5.Y)
		else
			v4 = if UserInputService.MouseEnabled then UserInputService:GetMouseLocation() else nil
		end

		v113(if v4 then v72(v4.X, v4.Y) else nil)
	end

	if not (v7 and (v8 and v9)) then
		return
	end

	local v102 = p1 / 0.1

	if v13 < v14 then
		v13 = math.min(v14, v13 + v102)
	elseif v14 < v13 then
		v13 = math.max(v14, v13 - v102)
	end

	local v152 = 1 - v13

	v8.TextTransparency = v152
	v9.Transparency = v152
	v7.Visible = v13 > 0

	if v13 == 0 and (v14 == 0 and v11) then
		v11 = nil

		if v16 then
			v16:Disconnect()
			v16 = nil
		end

		if v15 then
			v15()
			v15 = nil
		end

		if not v8 then
			return
		end

		local UIGradient = v8:FindFirstChildOfClass("UIGradient")

		if not UIGradient then
			return
		end

		AnimatedGradient:Remove(UIGradient)
		UIGradient:Destroy()
	else
		if not (v11 and v13 > 0) then
			return
		end

		local CurrentCamera = Workspace.CurrentCamera
		local v182 = v10
		local v19

		if v182 then
			local v20 = GuiService:GetGuiInset()

			v19 = Vector2.new(v182.Position.X + v20.X, v182.Position.Y + v20.Y)
		else
			v19 = if UserInputService.MouseEnabled then UserInputService:GetMouseLocation() else nil
		end

		if not (CurrentCamera and v19) then
			return
		end

		local v23 = if v10 then 42 else 28
		local v24 = math.min(v8.TextBounds.X, v3.X)
		local v25 = v24 / 2

		if v19.X + v23 + v24 <= CurrentCamera.ViewportSize.X then
			v7.AnchorPoint = Vector2.new(0.5, 0.5)
			v7.Position = UDim2.fromOffset(v19.X + v23 + v25, v19.Y)

			return
		end

		v7.AnchorPoint = Vector2.new(0.5, 0.5)
		v7.Position = UDim2.fromOffset(v19.X - v23 - v25, v19.Y)
	end
end

local function v135() --[[ v135 | Line: 457 | Upvalues: PlayerGui (copy), v6 (ref), v3 (copy), v7 (ref), v4 (copy), v8 (ref), v2 (copy), v9 (ref) ]]
	local PetHoverTooltip = Instance.new("ScreenGui")

	PetHoverTooltip.Name = "PetHoverTooltip"
	PetHoverTooltip.DisplayOrder = -1
	PetHoverTooltip.IgnoreGuiInset = true
	PetHoverTooltip.ResetOnSpawn = false
	PetHoverTooltip.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	PetHoverTooltip.Enabled = true
	PetHoverTooltip.Parent = PlayerGui
	v6 = PetHoverTooltip

	local Frame = Instance.new("Frame")

	Frame.Name = "Frame"
	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.fromOffset(v3.X, v3.Y)
	Frame.Position = UDim2.fromOffset(0, 0)
	Frame.Visible = false
	Frame.Parent = PetHoverTooltip
	v7 = Frame

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Parent = Frame

	local Name = Instance.new("TextLabel")

	Name.Name = "Name"
	Name.BackgroundTransparency = 1
	Name.BorderSizePixel = 0
	Name.FontFace = v4
	Name.Size = UDim2.new(1, 0, 1, 0)
	Name.Text = ""
	Name.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Name.TextScaled = true
	Name.TextSize = 24
	Name.TextTransparency = 1
	Name.TextWrapped = true
	Name.TextXAlignment = Enum.TextXAlignment.Center
	Name.TextYAlignment = Enum.TextYAlignment.Center
	Name.Parent = Frame
	v8 = Name

	local UIStroke = Instance.new("UIStroke")

	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Color = v2
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Thickness = 2
	UIStroke.Transparency = 1
	UIStroke.Parent = Name
	v9 = UIStroke

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new(v2)
	UIGradient.Parent = UIStroke
end

function t.Start(p1) --[[ Line: 512 | Upvalues: v135 (copy), v19 (ref), LocalPlayer (copy), Workspace (copy), v17 (ref), v18 (ref), v72 (copy), v86 (copy), UserInputService (copy), v10 (ref), GuiService (copy), RunService (copy), v128 (copy) ]]
	v135()

	local ok, result = pcall(function() --[[ Line: 515 ]]
		return require(script.Parent.PetListController)
	end)
	local v1

	if ok then
		v19 = result
	end

	v1 = function(p1, p2) --[[ Line: 521 | Upvalues: v19 (ref), LocalPlayer (ref), Workspace (ref), v17 (ref), v18 (ref), v72 (ref), v86 (ref) ]]
		if not (v19 and v19.ShowPetInfo) then
			return false
		end

		if LocalPlayer:GetAttribute("IsInOwnGarden") ~= true then
			return false
		end

		local Character = LocalPlayer.Character

		if Character and Character:FindFirstChildWhichIsA("Tool") then
			return false
		end

		local Map = Workspace:FindFirstChild("Map")

		v17 = if Map then Map:FindFirstChild("WildPetSpawns") else nil

		local _PetVisualClient = Workspace:FindFirstChild("_PetVisualClient")

		v18 = if _PetVisualClient then _PetVisualClient:FindFirstChild("Models") else nil

		local v3 = v72(p1, p2)

		if not v3 then
			return false
		end

		if v3.Parent ~= v18 then
			return false
		end

		if v3:GetAttribute("Owner") ~= LocalPlayer.Name then
			return false
		end

		local v4 = v86(v3)

		if v4 then
			v19:ShowPetInfo(v4.Species, v4.Size, v4.Type)

			return true
		end

		return false
	end
	UserInputService.InputBegan:Connect(function(p1, p2) --[[ Line: 555 | Upvalues: UserInputService (ref), v1 (ref) ]]
		if p2 then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			local v12 = UserInputService:GetMouseLocation()

			v1(v12.X, v12.Y)
		end
	end)
	UserInputService.TouchStarted:Connect(function(p1, p2) --[[ Line: 567 | Upvalues: v10 (ref) ]]
		if p2 then
			return
		end

		if v10 ~= nil then
			return
		end

		v10 = p1
	end)
	UserInputService.TouchEnded:Connect(function(p1) --[[ Line: 578 | Upvalues: v10 (ref) ]]
		if p1 ~= v10 then
			return
		end

		v10 = nil
	end)
	UserInputService.TouchTapInWorld:Connect(function(p1, p2) --[[ Line: 584 | Upvalues: GuiService (ref), v1 (ref) ]]
		if not p2 then
			local v12 = GuiService:GetGuiInset()

			v1(p1.X + v12.X, p1.Y + v12.Y)
		end
	end)
	RunService:BindToRenderStep("PetHoverTooltip", Enum.RenderPriority.Camera.Value - 1, v128)
end

return t