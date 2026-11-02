

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local _ = v1.LocalPlayer
local u3 = script.Parent
local u4 = v2:WaitForChild("GetMessageToPlayer")
local v5 = v2:WaitForChild("PushMessageToPlayer")
local u6 = v2:WaitForChild("ClearMessageToPlayer")
local u7 = v2:WaitForChild("ReplyMessageToAdmin")
local u8 = u3:WaitForChild("MainFrame")
local u9 = u8:WaitForChild("Frame"):WaitForChild("ListFrame"):WaitForChild("TextFrame"):WaitForChild("TextLabel")
local v10 = u8:WaitForChild("FrameRepondre"):WaitForChild("Frame"):WaitForChild("Frame")
local u11 = v10:WaitForChild("TextBox")
local u12 = v10:WaitForChild("SendButton")
u3.Enabled = false
u8.Visible = false
local u13 = false
u12.MouseButton1Click:Connect(function()

	if u13 then
		return
	else
		local v14 = u11.Text
		if v14:gsub(" ", "") == "" then
			u11.PlaceholderText = "\195\137crivez un message..."
		else
			u13 = true
			u12.Text = "Envoi..."
			u7:FireServer(v14)
			task.wait(0.5)
			u6:FireServer()
			u3.Enabled = false
			u12.Text = "Send"
			u11.Text = ""
			u13 = false
		end
	end
end)
task.wait(5)
local v15, v16 = pcall(function()

	return u4:InvokeServer()
end)
if v15 and (type(v16) == "string" and (v16 ~= "" and (typeof(v16) == "string" and v16 ~= ""))) then
	u9.Text = v16
	u11.Text = ""
	u3.Enabled = true
	u8.Visible = true
end
v5.OnClientEvent:Connect(function(p17)

	if typeof(p17) == "string" then
		if p17 == "" then
			return
		end
		u9.Text = p17
		u11.Text = ""
		u3.Enabled = true
		u8.Visible = true
	end
end)