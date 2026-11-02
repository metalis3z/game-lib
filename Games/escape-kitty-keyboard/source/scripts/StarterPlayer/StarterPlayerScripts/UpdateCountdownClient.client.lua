

local u1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage"):WaitForChild("UpdateCountdownData", 15)
if not v2 then
	warn("[UpdateCountdownClient] UpdateCountdownData introuvable")
	return
end
local u3 = v2:WaitForChild("AA_Time").Value
local u4 = v2:WaitForChild("Update_Time").Value
local u5 = v2:WaitForChild("ShowThreshold").Value
local u6 = v2:WaitForChild("ShowAA").Value
local v7 = v2:WaitForChild("ShowUpdate").Value
if u3 == 0 and u4 == 0 then
	return
end
u1:GetInstanceAddedSignal("MysteryCountdownAAClient"):Connect(function(p8)

	if p8:IsA("TextLabel") then
		local v9 = u3 - os.time()
		if v9 > 0 and v9 <= u5 then
			local v10 = "ADMIN ABUSE : "
			local v11
			if v9 <= 0 then
				v11 = "00:00:00"
			else
				local v12 = v9 / 3600
				local v13 = math.floor(v12)
				local v14 = v9 % 3600 / 60
				local v15 = math.floor(v14)
				local v16 = v9 % 60
				v11 = string.format("%02d:%02d:%02d", v13, v15, v16)
			end
			p8.Text = v10 .. v11
			return
		end
		p8.Text = ""
	end
end)
u1:GetInstanceAddedSignal("MysteryCountdownUpClient"):Connect(function(p17)

	if p17:IsA("TextLabel") then
		local v18 = os.time()
		local v19 = u4 - v18
		local v20
		if u6 then
			if u3 <= v18 then
				v20 = v19 > 0
			else
				v20 = false
			end
		elseif v19 > 0 then
			v20 = v19 <= u5
		else
			v20 = false
		end
		if v20 then
			local v21 = "UPDATE : "
			local v22
			if v19 <= 0 then
				v22 = "00:00:00"
			else
				local v23 = v19 / 3600
				local v24 = math.floor(v23)
				local v25 = v19 % 3600 / 60
				local v26 = math.floor(v25)
				local v27 = v19 % 60
				v22 = string.format("%02d:%02d:%02d", v24, v26, v27)
			end
			p17.Text = v21 .. v22
			return
		end
		p17.Text = ""
	end
end)
local v28 = math.max(u3, u4)
local function v39(p29) 

	local v30 = u3 - os.time()
	for _, v31 in ipairs(u1:GetTagged(p29)) do
		if v31:IsA("TextLabel") then
			if v30 > 0 and v30 <= u5 then
				local v32 = "ADMIN ABUSE : "
				local v33
				if v30 <= 0 then
					v33 = "00:00:00"
				else
					local v34 = v30 / 3600
					local v35 = math.floor(v34)
					local v36 = v30 % 3600 / 60
					local v37 = math.floor(v36)
					local v38 = v30 % 60
					v33 = string.format("%02d:%02d:%02d", v35, v37, v38)
				end
				v31.Text = v32 .. v33
			else
				v31.Text = ""
			end
		end
	end
end
local function v52(p40) 

	local v41 = os.time()
	local v42 = u4 - v41
	local v43
	if u6 then
		if u3 <= v41 then
			v43 = v42 > 0
		else
			v43 = false
		end
	elseif v42 > 0 then
		v43 = v42 <= u5
	else
		v43 = false
	end
	for _, v44 in ipairs(u1:GetTagged(p40)) do
		if v44:IsA("TextLabel") then
			if v43 then
				local v45 = "UPDATE : "
				local v46
				if v42 <= 0 then
					v46 = "00:00:00"
				else
					local v47 = v42 / 3600
					local v48 = math.floor(v47)
					local v49 = v42 % 3600 / 60
					local v50 = math.floor(v49)
					local v51 = v42 % 60
					v46 = string.format("%02d:%02d:%02d", v48, v50, v51)
				end
				v44.Text = v45 .. v46
			elseif not u1:HasTag(v44, "MysteryCountdownAAClient") then
				v44.Text = ""
			end
		end
	end
end
while true do
	if u6 then
		v39("MysteryCountdownAAClient")
	end
	if v7 then
		v52("MysteryCountdownUpClient")
	end
	if v28 <= os.time() then
		if u6 then
			v39("MysteryCountdownAAClient")
		end
		if v7 then
			v52("MysteryCountdownUpClient")
		end
	end
	task.wait(1)
end