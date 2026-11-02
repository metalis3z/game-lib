local UIS = game:GetService("UserInputService")
local active = false

local distressDb = false

local comFrame = script.Parent.Comms
local callFrame = script.Parent.IncomingCallFrame
local hidFrame = script.Parent.Hidden

local player = game.Players.LocalPlayer

local animation = nil

function addChat(phrase,distress)
	print("Firing")
	game.ReplicatedStorage.Pol:FireServer(phrase,distress)
end

player.Chatted:Connect(function(msg)
	if active then addChat(msg,false) end
end)

function shift()
	game.Lighting.sound.radioSound:Play()
	if active == false then
		comFrame.activebutton.BackgroundColor3 = Color3.new(0,255,0)
		comFrame.activebutton.Text = "ACTIVE (T)"
		active = true
		
		if animation then
			print("start")
			animation:Play()
		end
		
	else
		comFrame.activebutton.BackgroundColor3 = Color3.new(255,0,0)
		comFrame.activebutton.Text = "INACTIVE (T)"
		active = false
		
		if animation then
			print("stop")
			animation:Stop()
		end
		
	end
end

comFrame.distress.MouseButton1Click:Connect(function()
	if distressDb == true then return end
	addChat("**DISTRESS SIGNAL FIRED**",true)
	_G.showMsg("Your location has been marked by fellow officers for 3 minutes!",6)
	distressDb = true
	wait(15)
	distressDb = false
end)

comFrame.activebutton.MouseButton1Click:Connect(function()
	shift()
end)

UIS.InputBegan:Connect(function(key,pro)
	if pro then return print("pro") end
	if key.KeyCode == Enum.KeyCode.T then
		shift()
	end
end)

hidFrame.ComCollapse.MouseButton1Click:Connect(function()
	if comFrame.Visible == true then
		comFrame.Visible = false
		hidFrame.ComCollapse.Text = "+"
	else
		comFrame.Visible = true
		hidFrame.ComCollapse.Text = "-"
	end
end)

hidFrame.CallCollapse.MouseButton1Click:Connect(function()
	if callFrame.Visible == true then
		callFrame.Visible = false
		hidFrame.CallCollapse.Text = "+"
	else
		callFrame.Visible = true
		hidFrame.CallCollapse.Text = "-"
	end
end)

if not player.Character then player.CharacterAdded:Wait() end

print("CHARACTERADDED")
animation = player.Character:WaitForChild("Humanoid"):LoadAnimation(script.Animation)
print("LOADED ANIMATION")