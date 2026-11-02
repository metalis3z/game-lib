client = nil
cPcall = nil
Pcall = nil
Routine = nil
service = nil
gTable = nil

--// All global vars will be wiped/replaced except script

return function(data)
	local playergui = service.PlayerGui
	local localplayer = service.Players.LocalPlayer
	local scr = client.UI.Prepare(script.Parent.Parent)
	local window = scr.Window
	local msg = data.Message
	local color = data.Color

	local found = client.UI.Get("Output")
	if found then
		for i,v in pairs(found) do
			local p = v.Object
			if p and p.Parent then
				p.Window.Position = UDim2.new(0.5, 0, 0.5, p.Window.Position.Y.Offset+160)
			end
		end
	end

	window.Main.ScrollingFrame.ErrorText.Text = msg
	window.Main.ScrollingFrame.ErrorText.TextColor3 = color

	window.Close.MouseButton1Down:Connect(function()
		gTable.Destroy()
	end)

	spawn(function()
		local sound = Instance.new("Sound",service.LocalContainer())
		sound.SoundId = "rbxassetid://160715357"
		sound.Volume = 2
		sound:Play()
		wait(0.8)
		sound:Destroy()
	end)

	gTable.Ready()
	wait(5)
	gTable.Destroy()
end