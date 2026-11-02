

local u1 = _G.HDAdminMain
local u2 = Instance.new("Folder")
u2.Name = "MessageContainer"
u2.Parent = u1.gui
local v3 = {}
for _, v4 in pairs({ "Messages", "Hints" }) do
	local v5 = Instance.new("Frame")
	v5.Size = UDim2.new(1, 0, 1, 0)
	v5.Position = UDim2.new(0, 0, 0, 0)
	v5.BackgroundTransparency = 1
	v5.Name = v4
	if v4 == "Hints" then
		Instance.new("UIListLayout").Parent = v5
	end
	v5.Parent = u2
end
local function u12(p6, p7, p8) 

	for _, v9 in pairs(p6) do
		local v10 = v9:IsA("Frame") and p7 < 0.35 and 0.35 or p7
		local v11 = {
			[v9:IsA("Frame") and "BackgroundTransparency" or (v9:IsA("TextLabel") and "TextTransparency" or (v9:IsA("ImageLabel") and "ImageTransparency" or nil))] = v10
		}
		u1.tweenService:Create(v9, TweenInfo.new(p8), v11):Play()
	end
	wait(p8)
end
local function u14(p13) 
	return {
		{ p13.Bg },
		{ p13.Title, p13.SubTitle, p13.Pic },
		{ p13.Desc }
	}
end
function v3.Message(_, p15) 

	local v16 = u2.Messages
	local v17 = p15[1]
	local v18 = p15[2]
	local v19 = p15[3]
	local v20 = p15[4]
	local v21 = p15[5]
	local v22 = p15[6]
	local v23 = u1.templates.Message:Clone()
	for _, v24 in pairs(v23:GetChildren()) do
		v24[v24:IsA("Frame") and "BackgroundTransparency" or (v24:IsA("TextLabel") and "TextTransparency" or (v24:IsA("ImageLabel") and "ImageTransparency" or nil))] = 1
	end
	v23.Visible = true
	if v18 == "Countdown" then
		local u25 = { v23.Bg, v23.Title, v23.Desc }
		v23.Title.Text = "Countdown"
		v23.Title.TextColor3 = Color3.fromRGB(200, 200, 200)
		v23.Desc.TextColor3 = v22
		v23.Parent = v16
		spawn(function()

			u12(u25, 0, 0.4)
		end)
		for v26 = 1, v21 do
			v23.Desc.Text = v21 + 1 - v26
			wait(1)
		end
		u12(u25, 1, 0.4)
	else
		v23.Title.Text = v19
		v23.SubTitle.Text = v19
		v23.Desc.Text = v21
		v23.Desc.TextColor3 = v22
		if v18 == "Server" or v17 == nil then
			v23.Pic.Visible = false
			v23.SubTitle.Visible = false
		else
			local v27 = u1.textService:GetTextSize(v19, v23.Title.TextSize, v23.Title.Font, Vector2.new(0, 0))
			v23.Pic.Position = UDim2.new(0.5, -(v27.X / 2 + 75))
			v23.Pic.Image = u1:GetModule("cf"):GetUserImage(v17.UserId)
			v23.SubTitle.Text = v20
		end
		v23.Parent = v16
		local v28 = u14(v23)
		for v29 = 1, #v28 do
			u12(v28[v29], 0, 0.4)
		end
		wait(u1:GetModule("cf"):GetMessageTime(v21))
		for v30 = 1, #v28 do
			u12(v28[#v28 + 1 - v30], 1, 0.4)
		end
	end
	v23:Destroy()
end
function v3.Hint(_, p31) 

	local v32 = u2.Hints
	local v33 = p31[1]
	local v34 = p31[2]
	local v35 = p31[3]
	local v36 = u1.templates.Hint:Clone()
	local u37 = {}
	for _, v38 in pairs(v36:GetChildren()) do
		v38[v38:IsA("Frame") and "BackgroundTransparency" or (v38:IsA("TextLabel") and "TextTransparency" or (v38:IsA("ImageLabel") and "ImageTransparency" or nil))] = 1
		table.insert(u37, v38)
	end
	v36.Desc.Text = v34
	v36.Desc.TextColor3 = v35
	v36.Parent = v32
	v36.Visible = true
	if v33 == "Countdown" then
		spawn(function()

			u12(u37, 0, 0.6)
		end)
		for v39 = 1, v34 do
			v36.Desc.Text = v34 + 1 - v39
			wait(1)
		end
		u12(u37, 1, 0.6)
	else
		v36.Desc.Text = v34
		v36.Desc.TextColor3 = v35
		v36.Parent = v32
		u12(u37, 0, 0.6)
		wait(u1:GetModule("cf"):GetMessageTime(v34))
		u12(u37, 1, 0.6)
	end
	v36:Destroy()
end
function v3.GlobalAnnouncement(_, p40) 

	local v41 = u2.Messages
	local v42 = u1.templates.GlobalAnnouncement:Clone()
	local v43 = p40.DisplayFrom
	for _, v44 in pairs(v42:GetChildren()) do
		v44[v44:IsA("Frame") and "BackgroundTransparency" or (v44:IsA("TextLabel") and "TextTransparency" or (v44:IsA("ImageLabel") and "ImageTransparency" or nil))] = 1
	end
	v42.Visible = true
	v42.Title.Text = p40.Title
	v42.Pic.Visible = v43
	v42.SubTitle.Visible = v43
	local v45 = u1.textService:GetTextSize(v42.SubTitle.Text, v42.SubTitle.TextSize, v42.SubTitle.Font, Vector2.new(0, 0))
	v42.Pic.Position = UDim2.new(0.5, -(v45.X / 2 + 30), 0, 60)
	if v43 then
		v42.Pic.Image = u1:GetModule("cf"):GetUserImage(p40.SenderId)
		v42.SubTitle.Text = "From " .. p40.SenderName
	end
	v42.Desc.TextColor3 = Color3.new(p40.Color[1], p40.Color[2], p40.Color[3])
	v42.Desc.Text = p40.Message
	v42.Parent = v41
	local v46 = u14(v42)
	for v47 = 1, #v46 do
		u12(v46[v47], 0, 0.4)
	end
	wait(u1:GetModule("cf"):GetMessageTime(p40.Message) * 1.5)
	for v48 = 1, #v46 do
		u12(v46[#v46 + 1 - v48], 1, 0.4)
	end
	v42:Destroy()
end
function v3.ClearMessageContainer(_) 

	for _, v49 in pairs(u2:GetChildren()) do
		for _, v50 in pairs(v49:GetChildren()) do
			if v50:IsA("Frame") then
				v50.Visible = false
			end
		end
	end
end
return v3