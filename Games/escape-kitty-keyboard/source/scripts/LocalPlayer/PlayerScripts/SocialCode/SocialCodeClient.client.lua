local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("UserInputService")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local u5 = v2:WaitForChild("SubmitDiscordVerifyCode")
local v6 = v2:WaitForChild("DiscordVerifyResult")
local v7 = v4:WaitForChild("SocialVerifyGui")
local v8 = v7:FindFirstChild("Panel")
if v8 then
	if not v8:IsA("ImageLabel") then
		v8 = v7
	end
else
	v8 = v7
end
local v9 = v8:FindFirstChild("Boxes")
if not (v9 and v9:IsA("Frame")) then
	error("[SocialVerify] Frame \'Boxes\' not found under SocialVerifyGui / Panel")
end
local u10 = v8:FindFirstChild("Status")
local u11 = v8:FindFirstChild("Submit")
if not (u10 and (u10:IsA("TextLabel") and (u11 and u11:IsA("TextButton")))) then
	error("[DiscordVerify] TextLabel \'Status\' or TextButton \'Submit\' missing")
end
local u12 = false
v6.OnClientEvent:Connect(function(p13, p14)
	-- upvalues: (ref) u12, (copy) u11, (copy) u10
	u12 = false
	u11.Active = true
	if typeof(p13) == "boolean" then
		if p13 then
			u10.Text = "VERIFIED, REWARD RECEIVED."
			u10.TextColor3 = Color3.fromRGB(120, 220, 140)
		else
			local v15 = typeof(p14) ~= "string" and "" or p14
			u10.Text = v15 == "invalid_or_expired_code" and "INVALID CODE OR EXPIRED. GET A NEW ONE ON DISCORD." or (v15 == "discord_not_in_guild" and "THIS DISCORD ACCOUNT IS NOT (OR NO LONGER) ON THE GAME SERVER. JOIN THE DISCORD AND THEN REQUEST A NEW CODE." or (v15 == "invalid_roblox_user_id" and "INVALID PLAYER ID. REJOIN AND TRY AGAIN OR CONTACT AN ADMIN." or (v15 == "unauthorized" and "SERVER ERROR (AUTH). CONTACT AN ADMIN." or ((v15 == "invalid_code" or v15 == "invalid_body") and "REQUEST REJECTED. TRY AGAIN." or (v15 == "network" and "NO RESPONSE FROM THE SERVER. TRY AGAIN LATER." or (v15 == "rate_limited" and "TOO MANY ATTEMPTS. WAIT BEFORE TRYING AGAIN." or (v15 == "bad_gateway" and "THE VERIFICATION API IS UNAVAILABLE (SERVER). TRY AGAIN LATER OR CONTACT AN ADMIN." or ((v15 == "invalid_response" or v15 == "internal") and "TECHNICAL ERROR. TRY AGAIN LATER." or "FAILURE: " .. v15))))))))
			u10.TextColor3 = Color3.fromRGB(255, 120, 120)
		end
	else
		return
	end
end)
local u16 = u12
local u17 = {}
for v18 = 1, 8 do
	local v19 = v9:WaitForChild("Digit" .. v18)
	local v20 = v19:IsA("TextBox")
	local v21 = "Digit" .. v18 .. " must be a TextBox"
	assert(v20, v21)
	table.insert(u17, v19)
end
local u22 = false
local function u38(p23, p24) -- name: distributeFrom
	-- upvalues: (copy) u17, (ref) u22
	local v25 = string.upper(p24)
	local v26 = string.gsub(v25, "[^0-9A-F]", "")
	if v26 == "" then
		for v27 = p23, 8 do
			u17[v27].Text = ""
		end
	else
		u22 = true
		local v28 = #v26
		local v29 = 8 - p23 + 1
		local v30 = math.min(v28, v29)
		for v31 = 0, v30 - 1 do
			local v32 = u17[p23 + v31]
			local v33 = v31 + 1
			local v34 = v31 + 1
			v32.Text = string.sub(v26, v33, v34)
		end
		for v35 = p23 + v30, 8 do
			u17[v35].Text = ""
		end
		u22 = false
		local v36 = p23 + v30
		local v37 = u17[math.min(v36, 8)]
		if v37 then
			v37:CaptureFocus()
		end
	end
end
local function u40() -- name: getFocusedDigitIndex
	-- upvalues: (copy) u17
	for v39 = 1, 8 do
		if u17[v39]:IsFocused() then
			return v39
		end
	end
	return nil
end
v3.InputBegan:Connect(function(p41, _)
	-- upvalues: (copy) u40, (copy) u17, (ref) u22
	if p41.KeyCode == Enum.KeyCode.Backspace or p41.KeyCode == Enum.KeyCode.Delete then
		local v42 = u40()
		if v42 then
			local v43 = u17[v42]
			if p41.KeyCode == Enum.KeyCode.Backspace then
				if v43.Text == "" and v42 > 1 then
					u22 = true
					u17[v42 - 1].Text = ""
					u22 = false
					local v44 = u17[v42 - 1]
					if v44 then
						v44:CaptureFocus()
						return
					end
				end
			elseif p41.KeyCode == Enum.KeyCode.Delete and (v43.Text == "" and v42 < 8) then
				u22 = true
				u17[v42 + 1].Text = ""
				u22 = false
				local v45 = u17[v42 + 1]
				if v45 then
					v45:CaptureFocus()
				end
			end
		end
	else
		return
	end
end)
local u46 = u22
local function u48() -- name: joinCode
	-- upvalues: (copy) u17
	local v47 = table.create(8)
	v47[1] = u17[1].Text
	v47[2] = u17[2].Text
	v47[3] = u17[3].Text
	v47[4] = u17[4].Text
	v47[5] = u17[5].Text
	v47[6] = u17[6].Text
	v47[7] = u17[7].Text
	v47[8] = u17[8].Text
	return table.concat(v47)
end
for u49 = 1, 8 do
	local u50 = u17[u49]
	u50:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (ref) u46, (copy) u50, (copy) u38, (copy) u49, (copy) u17
		if u46 then
			return
		else
			local u51 = u50.Text
			if #u51 > 1 then
				task.defer(function()
					-- upvalues: (ref) u46, (ref) u38, (ref) u49, (copy) u51
					if not u46 then
						u38(u49, u51)
					end
				end)
				return
			elseif #u51 == 1 and string.match(u51, "^[0-9A-F]$") == nil then
				u46 = true
				u50.Text = ""
				u46 = false
			elseif #u51 == 1 and u49 < 8 then
				task.defer(function()
					-- upvalues: (ref) u49, (ref) u17
					local v52 = u17[u49 + 1]
					if v52 then
						v52:CaptureFocus()
					end
				end)
			end
		end
	end)
end
u11.MouseButton1Click:Connect(function()
	-- upvalues: (ref) u16, (copy) u48, (copy) u10, (copy) u11, (copy) u5
	if u16 then
		return
	else
		local v53 = u48()
		if #v53 == 8 then
			u16 = true
			u11.Active = false
			u10.Text = "SENDING..."
			u10.TextColor3 = Color3.fromRGB(180, 180, 190)
			u5:FireServer(v53)
		else
			u10.Text = "INCOMPLETE CODE."
			u10.TextColor3 = Color3.fromRGB(255, 120, 120)
		end
	end
end)