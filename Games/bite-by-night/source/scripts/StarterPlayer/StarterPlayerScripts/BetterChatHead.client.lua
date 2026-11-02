-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

game:GetService("TextChatService").BubbleChatConfiguration.AdorneeName = "ChatHeadAttachment"
local v_u_1 = game:GetService("Players")
local _ = Vector3.new
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_1
	local v2 = next
	local v3, v4 = v_u_1:GetPlayers()
	for _, v5 in v2, v3, v4 do
		local v6 = v5.Character
		if v6 then
			local v7 = v6:FindFirstChild("Head")
			local v8 = not v7
			if v8 then
				v8 = v6:FindFirstChild("HeadAttachment", true)
			end
			if not (v7 or v8) then
				return
			end
			local v9 = v6:FindFirstChild("ChatHeadAttachment")
			if not v9 then
				v9 = Instance.new("Attachment")
				v9.Name = "ChatHeadAttachment"
				v9.Parent = v6
			end
			local v10 = v7 and (v7.Size.Y / 2 or 1) or 1
			local v11 = v7 and v7.CFrame or v8.WorldCFrame
			local v12 = next
			local v13, v14 = v6:GetChildren()
			for _, v15 in v12, v13, v14 do
				if v15:IsA("Accessory") then
					local v16 = v15:FindFirstChild("Handle", true)
					if v16 then
						local v17 = v11:PointToObjectSpace(v16.Position).Y + v16.Size.Y / 2
						if v10 < v17 then
							v10 = v17
						end
					end
				end
			end
			v9.WorldCFrame = v11 * CFrame.new(0, v10 + 0.2, 0)
		end
	end
end)