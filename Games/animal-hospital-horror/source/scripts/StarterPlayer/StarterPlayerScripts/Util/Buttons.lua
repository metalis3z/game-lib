local t = {}
local UserInputService = game:GetService("UserInputService")
local v1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local LocalPlayer = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local v2 = Random.new()
local v3 = nil

function OnActivate(p1, p2, p3) --[[ OnActivate | Line: 14 | Upvalues: v3 (ref), v1 (copy), v2 (copy), UserInputService (copy), TweenService (copy) ]]
	if not p1:IsA("GuiButton") then
		return
	end

	local v12 = if p3 then function() --[[ Line: 19 | Upvalues: p3 (copy), v3 (ref), p2 (copy), p1 (copy) ]]
	if not p3.Visible and v3 then
		v3.Visible = false
	end

	v3 = p3
	p2(p1)
end else p2
	local Size = p1.Size
	local v22 = (p1.AbsoluteSize.X * 0.05 + p1.AbsoluteSize.Y * 0.05) / 2
	local v32 = UDim2.new(Size.X.Scale * 1, v22, Size.Y.Scale * 1, v22)

	if v1 then
		return p1.MouseButton1Up:connect(function(p12, p2) --[[ Line: 35 | Upvalues: v2 (ref), v12 (ref), p1 (copy) ]]
			task.spawn(function() --[[ Line: 36 | Upvalues: v2 (ref) ]]
				script.Sound2.PlaybackSpeed = v2:NextNumber(0.95, 1.05)
				script.Sound2:Play()
			end)
			v12(p1)
		end)
	end

	local v4 = p1.MouseButton1Down:connect(function(p12, p2) --[[ Line: 46 | Upvalues: v2 (ref), v12 (ref), p1 (copy) ]]
		task.spawn(function() --[[ Line: 47 | Upvalues: v2 (ref) ]]
			script.Sound2.PlaybackSpeed = v2:NextNumber(0.95, 1.05)
			script.Sound2:Play()
		end)
		v12(p1)
	end)

	p1.Activated:Connect(function() --[[ Line: 58 | Upvalues: UserInputService (ref), v2 (ref), v12 (ref), p1 (copy) ]]
		if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
			task.spawn(function() --[[ Line: 60 | Upvalues: v2 (ref) ]]
				script.Sound2.PlaybackSpeed = v2:NextNumber(0.95, 1.05)
				script.Sound2:Play()
			end)
			v12(p1)
		end
	end)

	local function onFocus(...) --[[ onFocus | Line: 67 | Upvalues: v2 (ref), p1 (copy), TweenService (ref), v32 (copy) ]]
		script.Sound.PlaybackSpeed = v2:NextNumber(0.9, 1.2)
		script.Sound:Play()

		if not p1:GetAttribute("Static") then
			TweenService:Create(p1, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
				Size = v32
			}):Play()
		end
	end

	local function onBlur(...) --[[ onBlur | Line: 74 | Upvalues: TweenService (ref), p1 (copy), Size (copy) ]]
		TweenService:Create(p1, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
			Size = Size
		}):Play()
	end

	p1.MouseEnter:Connect(onFocus)
	p1.SelectionGained:Connect(onFocus)

	if p1:GetAttribute("Static") then
		return v4
	end

	p1.MouseLeave:Connect(onBlur)
	p1.SelectionLost:Connect(onBlur)

	return v4
end

local function isUsingController() --[[ isUsingController | Line: 114 ]]
	if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 then
		return true
	end
end

function t.OnActivate(p1, p2, p3) --[[ OnActivate | Line: 119 ]]
	if typeof(p1) ~= "table" then
		return OnActivate(p1, p2, p3)
	end

	local t = {}

	for i, v in ipairs(p1) do
		if v:IsA("TextButton") or v:IsA("ImageButton") then
			t[v] = OnActivate(v, p2, p3)
		end
	end

	return t
end

local v4 = nil

function t.GetCurrentDisplay() --[[ GetCurrentDisplay | Line: 135 | Upvalues: v4 (ref) ]]
	return v4
end

local v5 = TweenInfo.new(0.125, Enum.EasingStyle.Linear)

function t.ChangeVisibility(p1) --[[ ChangeVisibility | Line: 140 | Upvalues: v4 (ref), TweenService (copy), v5 (copy), CollectionService (copy) ]]
	if v4 and v4 ~= p1 then
		v4.Visible = false
	end

	p1.Visible = not p1.Visible

	local v1 = if p1 then p1:FindFirstChild("modal") else p1

	if v1 then
		v1.Modal = p1.Visible
	end

	v4 = if p1.Visible and p1 then p1 else nil

	if v4 and v4:GetAttribute("Blur") then
		if v4 and v4:GetAttribute("Blur") then
			TweenService:Create(game.Lighting.Blur, v5, {
				Size = 24
			}):Play()
			game.Lighting:WaitForChild("Atmosphere", 5).Density = 1
			game.Lighting.Atmosphere.Offset = 0.9
		end
	else
		TweenService:Create(game.Lighting.Blur, v5, {
			Size = 0
		}):Play()
		game.Lighting:WaitForChild("Atmosphere", 5).Density = 0.666
		game.Lighting.Atmosphere.Offset = 0.2
	end

	local v3 = not v4

	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, v3)

	if v3 then
		if if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 then true else nil then
			CollectionService:RemoveTag(game.Players.LocalPlayer, "UIVisible")

			if if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 then true else nil then
				game:GetService("GuiService").GuiNavigationEnabled = false
				game:GetService("GuiService").SelectedObject = nil
			end
		end

		TweenService:Create(workspace.CurrentCamera, v5, {
			FieldOfView = 75   -- absoluto: con UI abierta (antes era +5 relativo -> derivaba)
		}):Play()
	else
		CollectionService:AddTag(game.Players.LocalPlayer, "UIVisible")

		if if game:GetService("UserInputService"):GetLastInputType() == Enum.UserInputType.Gamepad1 then true else nil then
			game:GetService("GuiService").GuiNavigationEnabled = true
			game:GetService("GuiService"):Select(v4)
		end

		TweenService:Create(workspace.CurrentCamera, v5, {
			FieldOfView = 70   -- absoluto: FOV de reposo (antes era -5 relativo -> se acercaba y no volvía)
		}):Play()
	end
end
function t.CloseCurrent() --[[ CloseCurrent | Line: 189 | Upvalues: t (copy) ]]
	local v1 = t.GetCurrentDisplay()

	if v1 then
		return t.ChangeVisibility(v1)
	end
end

return t