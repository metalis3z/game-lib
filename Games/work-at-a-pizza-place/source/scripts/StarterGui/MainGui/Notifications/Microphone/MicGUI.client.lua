chats = {}
function chat(msg)
	for i,v in pairs(chats) do
		v.Position = UDim2.new(0,0,1,v.Position.Y.Offset -75)
	end
	local c = script.Parent.Chat:clone()
	c.Position = UDim2.new(0,0,1, -75)
	c.Text = msg
	c.Visible = true
	c.Parent = script.Parent
	table.insert(chats,c)
	delay(6,function()
		c:Destroy()
	end)
end


workspace.Main.Microphone.OnClientEvent:connect(chat)