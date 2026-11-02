-- https://lua.expert/
local v1 = script.Parent
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Warning_Youtuber = PlayerGui:WaitForChild("Warning_Youtuber")
local YoutuberTagRemote = ReplicatedStorage:WaitForChild("YoutuberTagRemote")

local function openWarningGui(p1, p2, p3) --[[ openWarningGui | Line: 11 | Upvalues: Warning_Youtuber (copy) ]]
	Warning_Youtuber.Enabled = true

	local Main = Warning_Youtuber:FindFirstChild("Main")

	if not Main then
		return
	end

	local v1 = Main:FindFirstChild("Content")

	if not v1 then
		return
	end

	local Thumb = v1:FindFirstChild("Thumb")

	if Thumb then
		Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
		Thumb.Position = UDim2.fromScale(0.33, 0.5)
		Thumb.Size = UDim2.fromScale(0.9, 0.92)
		Thumb.BackgroundTransparency = 1
		Thumb.ImageTransparency = 0
		Thumb.ZIndex = 4
		Thumb.ScaleType = Enum.ScaleType.Fit
		Thumb.Image = "rbxthumb://type=Avatar&id=" .. tostring(p1) .. "&w=720&h=720"

		local UICorner = Thumb:FindFirstChildOfClass("UICorner")

		if UICorner then
			UICorner:Destroy()
		end

		local UIStroke = Thumb:FindFirstChildOfClass("UIStroke")

		if UIStroke then
			UIStroke:Destroy()
		end
	end

	local Info = v1:FindFirstChild("Info")

	if not Info then
		return
	end

	Info.AnchorPoint = Vector2.new(0.5, 0.5)
	Info.Position = UDim2.fromScale(0.33, 0.87)
	Info.Size = UDim2.fromScale(0.7, 0.16)
	Info.BackgroundTransparency = 1
	Info.ZIndex = 6

	local Title = Info:FindFirstChild("Title")

	if Title then
		Title.AnchorPoint = Vector2.new(0, 0.5)
		Title.Position = UDim2.fromScale(0.02, 0.2)
		Title.Size = UDim2.fromScale(0.95, 0.46)
		Title.BackgroundTransparency = 1
		Title.ZIndex = 6
		Title.Rotation = 0
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		Title.Text = "@" .. tostring(p2 or "")

		local UID = Title:FindFirstChild("UID")

		if UID then
			UID.AnchorPoint = Vector2.new(0, 0.5)
			UID.Position = UDim2.fromScale(0, 0.92)
			UID.Size = UDim2.fromScale(1, 0.7)
			UID.BackgroundTransparency = 1
			UID.ZIndex = 6
			UID.Rotation = 0
			UID.TextXAlignment = Enum.TextXAlignment.Left
			UID.TextColor3 = Color3.new(255/255, 255/255, 255/255)
			UID.Text = "New Youtuber"
		end
	end

	local amount = Info:FindFirstChild("amount")

	if not amount then
		return
	end

	amount.Visible = false
end

v1.MouseButton1Click:Connect(function() --[[ Line: 86 | Upvalues: openWarningGui (copy), LocalPlayer (copy), YoutuberTagRemote (copy) ]]
	openWarningGui(LocalPlayer.UserId, LocalPlayer.Name, LocalPlayer.DisplayName)
	YoutuberTagRemote:FireServer("GetYoutuberTag")
end)
YoutuberTagRemote.OnClientEvent:Connect(function(p1, p2) --[[ Line: 91 | Upvalues: openWarningGui (copy) ]]
	if p1 == "ShowWarningYoutuber" and type(p2) == "table" then
		openWarningGui(p2.userId, p2.name, p2.displayName)
	end
end)