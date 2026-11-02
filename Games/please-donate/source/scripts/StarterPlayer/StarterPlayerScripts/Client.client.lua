--[[
    Made by arxx brooo
]]

local market = game:GetService('MarketplaceService')
local player = game:GetService("Players").LocalPlayer
local _LocalPlayer = player
local _PlayerGui = _LocalPlayer.PlayerGui
local _Screengui = _PlayerGui:FindFirstChild("ScreenGui")
local ui = game:GetService("UserInputService")

local FrameTI = TweenInfo.new(.5, Enum.EasingStyle.Quint)
local _Templates = game:GetService("ReplicatedStorage").Templates

function tween(Object, Time, Data)

	game.TweenService:Create(Object, TweenInfo.new(Time, Enum.EasingStyle.Quint), Data):Play()

end

local function PopUpRed(text)

	workspace.Camera.FieldOfView = 65

	spawn(function()
		local PopupTemplate = _Templates.PopupTemplate:Clone()
		PopupTemplate.Text = text
		PopupTemplate.TextColor3 = Color3.fromRGB(255, 0, 0)
		PopupTemplate.Parent = _Screengui
		tween(PopupTemplate, 0.9, {
			Position = UDim2.new(0, 0, 0.8, 0)
		})
		wait(0.75)
		tween(PopupTemplate, 3, {
			TextTransparency = 1
		})
		wait(2)
		PopupTemplate:Destroy()
	end)

	tween(workspace.Camera, 0.5, {
		FieldOfView = 70
	})

end

while wait(1) do
	for i,v in pairs(workspace.BoothModels:GetDescendants()) do
		if v:IsA("TextButton") then
			v.MouseButton1Click:Connect(function()
				game.TweenService:Create(v.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Scale = 1
				}):Play()
				wait(0.1)
				game.TweenService:Create(v.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Scale = 1.3
				}):Play()
				if v.OwnerID.Value == player.UserId then
					PopUpRed("Already owned, you cant buy your own items.")
				else
					local id = v.Gamepass.Value
					market:PromptGamePassPurchase(player, id)
				end
			end)
			v.MouseEnter:Connect(function()
				game.SoundService.Hover2:Play()
				game.TweenService:Create(v.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Scale = 1.3
				}):Play()
				-- buttoninfo
				local pos = ui:GetMouseLocation()
				local relativePosition = pos - player.PlayerGui.ScreenGui.ButtonInfo.AbsolutePosition
				player.PlayerGui.ScreenGui.ButtonInfo.Visible = true
				player.PlayerGui.ScreenGui.ButtonInfo.Position = UDim2.new(0, pos.X, 0, pos.Y - 36)
				player.PlayerGui.ScreenGui.ButtonInfo.Info.ItemName.Text = v.Name
				player.PlayerGui.ScreenGui.ButtonInfo.Info.Price.Text = v.Text
				player.PlayerGui.ScreenGui.ButtonInfo.Info.Type.Text = "Gamepass"
				player.PlayerGui.ScreenGui.ButtonInfo.Info.Giftbux.Amount.Text = "EARN " .. math.floor(math.sqrt(tonumber(v.Robux.Value)) * 5)
				player.PlayerGui.ScreenGui.ButtonInfo.Icon.Image = "rbxthumb://type=GamePass&id=".. v.Gamepass.Value.."&w=150&h=150" 
			end)
			v.MouseLeave:Connect(function()
				game.TweenService:Create(v.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Scale = 1
				}):Play()
				player.PlayerGui.ScreenGui.ButtonInfo.Visible = false
			end)
		end
	end
end