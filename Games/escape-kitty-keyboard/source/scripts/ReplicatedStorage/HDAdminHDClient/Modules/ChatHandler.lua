

local v1 = {}
local u2 = _G.HDAdminMain
task.defer(function()

	if not u2.player.Character then
		u2.player.CharacterAdded:Wait()
	end
	task.wait(1)
	local v3 = game:GetService("TextChatService")
	local u4 = Instance.new("TextChatCommand")
	u4.PrimaryAlias = "/zzz"
	u4.Enabled = true
	u4.AutocompleteVisible = true
	u4.Name = "FixChat"
	u4.Parent = v3
	task.delay(0.25, function()

		u4.Enabled = false
		u4.AutocompleteVisible = false
		task.wait(0.25)
		u4:Destroy()
	end)
end)
local u5 = u2.TextChatService
u5.SendingMessage:Connect(function(p6)

	local v7 = p6.TextSource
	if v7 then
		v7 = u2.players:FindFirstChild(v7.Name)
	end
	if v7 then
		if v7:GetAttribute("HDChatConfigEnabled") then
			local v8 = v7:GetAttribute("ChatTag")
			local v9 = v7:GetAttribute("ChatTagColor")
			local v10 = v7:GetAttribute("ChatName")
			local v11 = v7:GetAttribute("ChatNameColor")
			if p6.TextSource then
				local v12
				if v8 then
					v12 = ("[%*]"):format(v8)
				else
					v12 = v8
				end
				if v12 and v9 then
					v12 = ("<font color=\'#%*\'>%*</font>"):format(v9:ToHex(), v12)
				end
				local v13 = ("%*:"):format(v10 or v7.DisplayName)
				if v13 and v11 then
					v13 = ("<font color=\'#%*\'>%*</font>"):format(v11:ToHex(), v13)
				end
				if v12 then
					v13 = v12 .. " " .. v13
				end
				local v14 = p6.PrefixText
				local v15 = string.match(v14, "<.*>(.*)<.*>")
				if not v8 and v15 then
					local v16, v17 = string.find(string.reverse(v14), string.reverse(v15))
					local v18 = string.len(v14) - v17 + 1
					local v19 = string.len(v14) - v16 + 1
					if v18 and v19 then
						local v20 = v18 - 1
						local v21 = string.sub(v14, 1, v20)
						local v22 = string.match(v21, "<.*>(.*)<.*>")
						local v23 = v19 + 1
						local v24 = string.sub(v14, v23)
						if v22 then
							v21 = v21 .. " "
						end
						v13 = v21 .. v13 .. v24
					end
				end
				p6.PrefixText = v13
			end
			return p6
		end
	end
end)
u5.MessageReceived:Connect(function(p25)

	local v26 = p25.TextSource
	if v26 then
		v26 = u2.players:FindFirstChild(v26.Name)
	end
	if v26 then
		if v26:GetAttribute("HDChatConfigEnabled") then
			local v27 = v26:GetAttribute("ChatTag")
			local v28 = v26:GetAttribute("ChatTagColor")
			local v29 = v26:GetAttribute("ChatName")
			local v30 = v26:GetAttribute("ChatNameColor")
			if p25.TextSource then
				local v31
				if v27 then
					v31 = ("[%*]"):format(v27)
				else
					v31 = v27
				end
				if v31 and v28 then
					v31 = ("<font color=\'#%*\'>%*</font>"):format(v28:ToHex(), v31)
				end
				local v32 = ("%*:"):format(v29 or v26.DisplayName)
				if v32 and v30 then
					v32 = ("<font color=\'#%*\'>%*</font>"):format(v30:ToHex(), v32)
				end
				if v31 then
					v32 = v31 .. " " .. v32
				end
				local v33 = p25.PrefixText
				local v34 = string.match(v33, "<.*>(.*)<.*>")
				if not v27 and v34 then
					local v35, v36 = string.find(string.reverse(v33), string.reverse(v34))
					local v37 = string.len(v33) - v36 + 1
					local v38 = string.len(v33) - v35 + 1
					if v37 and v38 then
						local v39 = v37 - 1
						local v40 = string.sub(v33, 1, v39)
						local v41 = string.match(v40, "<.*>(.*)<.*>")
						local v42 = v38 + 1
						local v43 = string.sub(v33, v42)
						if v41 then
							v40 = v40 .. " "
						end
						v32 = v40 .. v32 .. v43
					end
				end
				p25.PrefixText = v32
			end
			return p25
		end
	end
end)
local u44 = {}
function v1.GenerateChatCommands(_) 

	for _, v45 in pairs(u2.infoOnAllCommands.ChatCommands) do
		if not u44[v45] then
			u44[v45] = true
			local v46 = Instance.new("TextChatCommand")
			v46.AutocompleteVisible = true
			v46.Enabled = true
			v46.PrimaryAlias = v45
			v46.Parent = u5
		end
	end
end
local _ = not game:GetService("RunService"):IsStudio()
function v1.DecideWelcomePrompt(_) 

	if not u44["/dance"] then
		u44["/dance"] = true
		local v47 = Instance.new("TextChatCommand")
		v47.AutocompleteVisible = true
		v47.Enabled = true
		v47.PrimaryAlias = "/dance"
		v47.Parent = u5
	end
	if not u44["/backflip"] then
		u44["/backflip"] = true
		local v48 = Instance.new("TextChatCommand")
		v48.AutocompleteVisible = true
		v48.Enabled = true
		v48.PrimaryAlias = "/backflip"
		v48.Parent = u5
	end
	if not u44["/commands"] then
		u44["/commands"] = true
		local v49 = Instance.new("TextChatCommand")
		v49.AutocompleteVisible = true
		v49.Enabled = true
		v49.PrimaryAlias = "/commands"
		v49.Parent = u5
	end
	if not u44["/helicopter"] then
		u44["/helicopter"] = true
		local v50 = Instance.new("TextChatCommand")
		v50.AutocompleteVisible = true
		v50.Enabled = true
		v50.PrimaryAlias = "/helicopter"
		v50.Parent = u5
	end
	if not u44["/plane"] then
		u44["/plane"] = true
		local v51 = Instance.new("TextChatCommand")
		v51.AutocompleteVisible = true
		v51.Enabled = true
		v51.PrimaryAlias = "/plane"
		v51.Parent = u5
	end
end
return v1