-- // Creates the top frame of the chat GUI, assembles all chat GUI objects, and manages functionality dealing with the entire chat GUI window.

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local Chat = game:GetService("Chat")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local localPlayer = Players.LocalPlayer

local ChatScript = script.Parent
local WindowFocused = require(ChatScript.ChatInterface.WindowFocused)
local MouseHoveringOverWindow = require(ChatScript.ChatInterface.MouseHoveringOverWindow)

local ChatBar = require(script.ChatBar)
local ChatChannel = require(script.ChatChannel)
local ResizeButton = require(script.ResizeButton)

local camera = workspace.CurrentCamera
local guiInsetMin, guiInsetMax = GuiService:GetGuiInset()

local guiCreator = {}

function guiCreator.create()
	-- Chat GUI assembly
	local chatGui = Instance.new("ScreenGui")
	chatGui.Name = "Chat"
	chatGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension
	chatGui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	chatGui.ResetOnSpawn = false
	chatGui.DisplayOrder = 100
	
	local chatFrame = Instance.new("Frame")
	chatFrame.BackgroundTransparency = 1
	
	-- I know this if tree is a mess but I don't really know how to fix it -steven
	local defaultChatWindowSizeScale = ChatConstants.DefaultChatWindowSizeScale
	if ChatConstants.WindowResizeable then
		task.spawn(function()
			-- For some reason ViewportSize is 1, 1 at the very start
			while camera.ViewportSize.X == 1 do
				task.wait()
			end
			local safeAreaPixels: Vector2 = camera.ViewportSize - guiInsetMin - guiInsetMax
			local minimumSize = ChatConstants.ChatWindowSizeBoundsPixels.Minimum
			if not ChatConstants.DefaultChatEnabled then
				minimumSize = Vector2.new(minimumSize.X, 42)
				chatFrame.Size = UDim2.fromOffset(
					math.max(safeAreaPixels.X * defaultChatWindowSizeScale.X, minimumSize.X),
					minimumSize.Y
				)
			else
				chatFrame.Size = UDim2.fromOffset(
					math.max(safeAreaPixels.X * defaultChatWindowSizeScale.X, minimumSize.X),
					math.max(safeAreaPixels.Y * defaultChatWindowSizeScale.Y, minimumSize.Y)
				)
			end
		end)
		ResizeButton.create().Parent = chatFrame
	else
		if ChatConstants.DefaultChatEnabled then
			chatFrame.Size = UDim2.fromScale(defaultChatWindowSizeScale.X, defaultChatWindowSizeScale.Y)
		else
			chatFrame.Size = UDim2.new(defaultChatWindowSizeScale.X, 0, 0, 42)
		end
	end
	
	local chatChannelParentFrame = ChatChannel.create()
	if ChatConstants.DefaultChatEnabled then
		chatChannelParentFrame.Parent = chatFrame
	end
	ChatBar.create().Parent = chatFrame
	
	chatFrame.Parent = chatGui
	
	-- Fading in/out
	local fadeableElements: {[Frame | TextLabel]: {[string]: any}} = {}
	
	local tweenInfo = TweenInfo.new(.4, Enum.EasingStyle.Linear)
	
	local fadeInTweens: {Tween} = {}
	local fadeOutTweens: {Tween} = {}
	
	local function registerFadeableElement(v: any, properties: {string})
		local originalProperties: {[string]: any} = {}
		
		local fadeInTweenProperties = {}
		local fadeOutTweenProperties = {}
		
		for _,property in properties do
			originalProperties[property] = v[property]
			fadeInTweenProperties[property] = v[property]
			fadeOutTweenProperties[property] = 1
		end
		
		table.insert(
			fadeInTweens,
			TweenService:Create(v, tweenInfo, fadeInTweenProperties)
		)
		table.insert(
			fadeOutTweens,
			TweenService:Create(v, tweenInfo, fadeOutTweenProperties)
		)
		
		fadeableElements[v] = originalProperties
	end
	for _,v in chatFrame:GetDescendants() do
		if v:IsDescendantOf(chatChannelParentFrame) then
			continue
		end
		if v:IsA("Frame") then
			if v.BackgroundTransparency < 1 then
				registerFadeableElement(v, {"BackgroundTransparency"})
			end
		elseif v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
			if v.TextTransparency < 1 or v.TextStrokeTransparency < 1 then
				registerFadeableElement(v, {"TextTransparency", "TextStrokeTransparency", "BackgroundTransparency"})
			end
		elseif v:IsA("ImageButton") or v:IsA("ImageLabel") then
			if v.BackgroundTransparency < 1 or v.ImageTransparency < 1 then
				registerFadeableElement(v, {"ImageTransparency", "BackgroundTransparency"})
			end
		end
	end
	
	local function fadeInWindow()
		for _,tween in fadeInTweens do
			tween:Play()
		end
	end
	
	local function fadeOutWindow()
		for _,tween in fadeOutTweens do
			tween:Play()
		end	
	end
	
	WindowFocused.getBindable().Event:Connect(function(windowFocused)
		if windowFocused then
			fadeInWindow()
		else
			fadeOutWindow()
		end
	end)
	
	chatFrame.MouseEnter:Connect(function()
		MouseHoveringOverWindow.set(true)
		WindowFocused.update()
	end)
	
	chatFrame.MouseLeave:Connect(function()
		MouseHoveringOverWindow.set(false)
		WindowFocused.update()
	end)
	
	task.delay(1, function() -- ChatActive takes a moment to be registered
		RunService.RenderStepped:Connect(function()
			chatGui.Enabled = StarterGui:GetCore("ChatActive")
		end)
	end)
	
	chatGui.Parent = localPlayer.PlayerGui
end

return guiCreator