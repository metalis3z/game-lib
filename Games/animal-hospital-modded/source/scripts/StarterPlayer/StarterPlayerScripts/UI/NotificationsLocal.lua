local t = {}

game:GetService("CollectionService")
game:GetService("UserInputService")

local Lib = require(game.ReplicatedStorage.Lib)
local Notifications = Lib.UI.Get("Notifications").Notifications
local LocalPlayer = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local v1 = TweenInfo.new(3.3333333333333335)
local t2 = {}

function t.Notify(p1, p2) --[[ Notify | Line: 13 | Upvalues: t2 (copy), Notifications (copy), Lib (copy), TweenService (copy), v1 (copy) ]]
	if t2[p1] then
		return
	end

	local v12 = Notifications.Templates:FindFirstChild("Notification"):Clone()
	local v2 = Lib.Talk.Translate(v12, p1)

	v12.Text = string.lower(v2)
	v12.TextColor3 = if p2 then p2 else Color3.new(255/255, 255/255, 255/255)
	v12.Parent = Notifications.Feed
	v12.Visible = true
	Lib.MusicService.Get("click"):Play()
	task.spawn(function() --[[ Line: 26 | Upvalues: t2 (ref), v2 (ref), TweenService (ref), v12 (copy), v1 (ref) ]]
		task.wait(6.666666666666667)
		t2[v2] = nil
		TweenService:Create(v12, v1, {
			TextTransparency = 1,
			TextStrokeTransparency = 1,
			BackgroundTransparency = 1
		}):Play()
		task.wait(4.333333333333334)
		v12:Destroy()
	end)
end

local Frame = Lib.UI.Get("Announcement").Frame
local t3 = {}
local v2 = nil

function t.SetHeader(p1, p2, p3) --[[ SetHeader | Line: 39 | Upvalues: t3 (copy), v2 (ref), Frame (copy), Lib (copy) ]]
	t3[#t3 + 1] = { p1, p2, p3 }

	if v2 then
		return
	end

	v2 = true
	Frame.Frame.text.Text = ""
	Frame.Frame.text.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	Lib.TS:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Cubic), {
		GroupTransparency = 0
	}):Play()
	task.wait(0.35)

	while #t3 > 0 do
		local v3 = t3[1][3]

		table.remove(t3, 1)
		Frame.Frame.text.Text = t3[1][1]
		Frame.Frame.text.TextColor3 = if v3 then v3 else Color3.new(255/255, 255/255, 255/255)
		Lib.MusicService.Get("Creepy Suspense Hit"):Play()
		task.wait(t3[1][2] or 5)
	end

	Lib.TS:Create(Frame, TweenInfo.new(0.2, Enum.EasingStyle.Cubic), {
		GroupTransparency = 1
	}):Play()
	task.wait(0.2)
	v2 = false
end
Lib.Network:BindEvents({
	Notify = t.Notify,
	Announcement = t.SetHeader,
	SystemMessage = function(p1, p2) --[[ SystemMessage | Line: 69 ]]
		game:GetService("TextChatService").TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\'" .. (p2 or "#fca103") .. "\'><b>[Server] " .. p1 .. "</b></font>")
	end
})
Lib.Inject("Notify", t.Notify)
Lib.Inject("Announcement", t.SetHeader)

return t