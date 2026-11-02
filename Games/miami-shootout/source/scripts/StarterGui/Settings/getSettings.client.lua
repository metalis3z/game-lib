local gotSetting = nil
local settingsRemote = nil

while wait(0.5) do
	settingsRemote = game.ReplicatedStorage.getSettings:InvokeServer()
	if settingsRemote then
		gotSetting = true
		break
	end
end

local setting = game.ReplicatedStorage.getSettings

local bobbing = nil
local autoRP = nil

if settingsRemote == nil then
	print("No settings available!")
	bobbing = true
	autoRP = false
else
	bobbing = settingsRemote[1]
	autoRP = settingsRemote[2]
	print("Loaded settings",tostring(bobbing))
end

function execute(settingName,value)
	if settingName == "bobbing" then
		local BOBSCRIPT = game.Players.LocalPlayer.PlayerGui:FindFirstChild('Bobbing Camera')
		if value == false then _G.disconnectBob() end
		BOBSCRIPT.Enabled = value
	end
	if settingName == "autoRP" then
		-- do nothing, handled by server
	end
end

function switch(settingName,value,display)
	if settingName == "bobbing" then		
		if value == true then
			script.Parent.Frame.cameraBobbing.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			script.Parent.Frame.cameraBobbing.Text = "Camera Bobbing: On"
			if not display then
				setting:InvokeServer("bobbing",true)
				execute("bobbing",true)
				bobbing = true
			end	
		else
			script.Parent.Frame.cameraBobbing.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			script.Parent.Frame.cameraBobbing.Text = "Camera Bobbing: Off"
			if not display then
				setting:InvokeServer("bobbing",false)
				execute("bobbing",false)
				bobbing = false
			end
		end
		
	end
	
	if settingName == "autoRP" then	
		print("EXECUTED",value)
		if value == true then
			print("executing yes")
			script.Parent.Frame.autoRP.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
			script.Parent.Frame.autoRP.Text = "Auto RP: On"
			if not display then
				setting:InvokeServer("autoRP",true)
				execute("autoRP",true)
				autoRP = true
			end	
		else
			print("executing no")
			script.Parent.Frame.autoRP.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
			script.Parent.Frame.autoRP.Text = "Auto RP: Off"
			if not display then
				setting:InvokeServer("autoRP",false)
				execute("autoRP",false)
				autoRP = false
			end
		end

	end
end

script.Parent.Frame.cameraBobbing.MouseButton1Click:Connect(function()
	
	switch("bobbing",not bobbing)
	
end)
script.Parent.Frame.autoRP.MouseButton1Click:Connect(function()

	switch("autoRP",not autoRP)

end)

spawn(function()
	repeat wait() until bobbing ~= nil
	switch("bobbing",bobbing,true)
	execute("bobbing",bobbing)
end)
	
spawn(function()
	repeat wait() until autoRP ~= nil
	switch("autoRP",autoRP,true)
	execute("autoRP",autoRP)
end)