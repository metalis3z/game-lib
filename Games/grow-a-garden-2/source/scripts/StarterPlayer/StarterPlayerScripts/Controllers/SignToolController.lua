--credit to leon games studio
local t = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
local SignToolChangeTextMenu = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SignToolChangeTextMenu")
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local v1 = require("./GuiController")
local NotificationController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController)
local v2 = false
local v3 = 0

local function openSignMenu() --[[ openSignMenu | Line: 16 | Upvalues: v2 (ref), LocalPlayer (copy), v1 (copy), SignToolChangeTextMenu (copy) ]]
	if v2 then
		return
	end

	v2 = true

	local SignText = LocalPlayer:FindFirstChild("SignText")
	local v12 = if SignText then SignText.Value or "" else ""

	v1:Open("SignToolChangeTextMenu")
	SignToolChangeTextMenu.Frame.Input.Text = v12
	SignToolChangeTextMenu.Frame.Input:CaptureFocus()
	SignToolChangeTextMenu.Frame.CharCount.Text = ("%*/%*"):format(#v12, 100)
end

local function closeAndSave() --[[ closeAndSave | Line: 29 | Upvalues: v2 (ref), v3 (ref), v1 (copy), NotificationController (copy), SignToolChangeTextMenu (copy), Networking (copy) ]]
	if not v2 then
		return
	end

	v2 = false

	local v12 = os.clock()
	local v22 = 5 - (v12 - v3)

	if v22 > 0 then
		v1:Close("SignToolChangeTextMenu")
		NotificationController:CreateNotification((("Please wait %*s before changing sign text."):format((math.ceil(v22)))))

		return
	end

	v3 = v12

	local Text = SignToolChangeTextMenu.Frame.Input.Text

	if #Text > 100 then
		Text = string.sub(Text, 1, 100)
	end

	Networking.SignTool.SetSignText:Fire(Text)
	v1:Close("SignToolChangeTextMenu")
end

function t.Init(p1) --[[ Init | Line: 51 ]] end
function t.Start(p1) --[[ Start | Line: 54 | Upvalues: SignToolChangeTextMenu (copy), closeAndSave (copy), LocalPlayer (copy), openSignMenu (copy) ]]
	SignToolChangeTextMenu.Frame.Input:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 55 | Upvalues: SignToolChangeTextMenu (ref) ]]
		local Text = SignToolChangeTextMenu.Frame.Input.Text

		if #Text > 100 then
			SignToolChangeTextMenu.Frame.Input.Text = string.sub(Text, 1, 100)
		else
			SignToolChangeTextMenu.Frame.CharCount.Text = ("%*/%*"):format(#Text, 100)
		end
	end)
	SignToolChangeTextMenu.Frame.Input.FocusLost:Connect(function() --[[ Line: 64 | Upvalues: closeAndSave (ref) ]]
		closeAndSave()
	end)

	local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	local function onChildAdded(p1) --[[ onChildAdded | Line: 71 | Upvalues: openSignMenu (ref) ]]
		if not p1:IsA("Tool") then
			return
		end

		if p1:GetAttribute("Sign") then
			p1.Activated:Connect(function() --[[ Line: 75 | Upvalues: openSignMenu (ref) ]]
				openSignMenu()
			end)
		end
	end

	v1.ChildAdded:Connect(onChildAdded)

	for v2, v3 in v1:GetChildren() do
		onChildAdded(v3)
	end

	LocalPlayer.CharacterAdded:Connect(function(p1) --[[ Line: 83 | Upvalues: v1 (ref), onChildAdded (copy) ]]
		v1 = p1
		p1.ChildAdded:Connect(onChildAdded)
	end)
end

return t