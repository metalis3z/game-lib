

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("CollectionService")
local v3 = game:GetService("Players")
local u4 = game:GetService("MarketplaceService")
local u5 = require(v1:WaitForChild("ClientState"))
local u6 = require(v1:WaitForChild("Config"))
local u7 = {}
local u8 = {
	["ATTRIBUTE_NAME"] = "EquippedSoundPack",
	["COLOR_DEFAULT"] = Color3.fromHex("361400"),
	["COLOR_EQUIPPED"] = Color3.fromHex("ffffff")
}
local u9 = v3.LocalPlayer
local u10 = false
local u11 = false
if u9:GetAttribute(u8.ATTRIBUTE_NAME) == nil then
	u9:SetAttribute(u8.ATTRIBUTE_NAME, "Default")
end
local function u16(p12) 

	local v13 = u2:HasTag(p12, "Sounds2") or u2:HasTag(p12, "Sounds3")
	if v13 then
		v13 = not u11
	end
	local v14 = u9:GetAttribute(u8.ATTRIBUTE_NAME)
	p12.Active = not v13
	p12.ImageTransparency = v13 and 0.6 or 0
	local v15 = p12:FindFirstChildOfClass("UIStroke")
	if v15 then
		v15.Color = p12.Name == v14 and u8.COLOR_EQUIPPED or u8.COLOR_DEFAULT
	end
end
local function u18() 

	local v17 = u6.GAMEPASS_IDS.SOUNDPACK_ACCESS
	if v17 and v17 ~= 0 then
		u4:PromptGamePassPurchase(u9, v17)
	end
end
local function u22(u19) 

	if u19:IsA("ImageButton") then
		u19.MouseButton1Click:Connect(function()

			local v20 = u19
			if (u2:HasTag(v20, "Sounds2") or u2:HasTag(v20, "Sounds3")) and not u11 then
				local v21 = u6.GAMEPASS_IDS.SOUNDPACK_ACCESS
				if v21 and v21 ~= 0 then
					u4:PromptGamePassPurchase(u9, v21)
				end
			else
				u9:SetAttribute(u8.ATTRIBUTE_NAME, u19.Name)
			end
		end)
		u16(u19)
	end
end
function u7.UpdateDisplay(_) 

	for _, v23 in ipairs(u2:GetTagged("SoundButton")) do
		if v23:IsA("ImageButton") then
			u16(v23)
		end
	end
end
u4.PromptGamePassPurchaseFinished:Connect(function(p24, p25, p26)

	if p24 == u9 then
		if p25 == u6.GAMEPASS_IDS.SOUNDPACK_ACCESS then
			if p26 then
				u11 = true
				for _, v27 in ipairs(u2:GetTagged("LockSound")) do
					v27.Visible = false
				end
				u7:UpdateDisplay()
			end
		else
			return
		end
	else
		return
	end
end)
task.spawn(function() 

	local u28 = u6.GAMEPASS_IDS.SOUNDPACK_ACCESS
	if u28 and u28 ~= 0 then
		local v29, v30 = pcall(function()

			return u4:UserOwnsGamePassAsync(u9.UserId, u28)
		end)
		if v29 and v30 then
			u11 = true
			for _, v31 in ipairs(u2:GetTagged("LockSound")) do
				v31.Visible = false
			end
			u7:UpdateDisplay()
		end
	end
end)
function u7.InitLogic(u32) 

	if u9:GetAttribute(u8.ATTRIBUTE_NAME) == nil then
		u9:SetAttribute(u8.ATTRIBUTE_NAME, "Default")
	end
	if u11 then
		for _, v33 in ipairs(u2:GetTagged("LockSound")) do
			v33.Visible = false
		end
	end
	if u10 then
		u32:UpdateDisplay()
	else
		local function v35(p34) 

			p34.MouseButton1Click:Connect(function()

				u5:CloseCurrentModal()
			end)
		end
		for _, v36 in ipairs(u2:GetTagged("SoundPackCloseBtn")) do
			v36.MouseButton1Click:Connect(function()

				u5:CloseCurrentModal()
			end)
		end
		u2:GetInstanceAddedSignal("SoundPackCloseBtn"):Connect(v35)
		local function v38(p37) 

			if p37:IsA("GuiButton") then
				p37.MouseButton1Click:Connect(u18)
			end
		end
		for _, v39 in ipairs(u2:GetTagged("BuySoundpackGamepass")) do
			if v39:IsA("GuiButton") then
				v39.MouseButton1Click:Connect(u18)
			end
		end
		u2:GetInstanceAddedSignal("BuySoundpackGamepass"):Connect(v38)
		for _, u40 in ipairs(u2:GetTagged("SoundButton")) do
			if u40:IsA("ImageButton") then
				u40.MouseButton1Click:Connect(function()

					local v41 = u40
					if (u2:HasTag(v41, "Sounds2") or u2:HasTag(v41, "Sounds3")) and not u11 then
						local v42 = u6.GAMEPASS_IDS.SOUNDPACK_ACCESS
						if v42 and v42 ~= 0 then
							u4:PromptGamePassPurchase(u9, v42)
						end
					else
						u9:SetAttribute(u8.ATTRIBUTE_NAME, u40.Name)
					end
				end)
				u16(u40)
			end
		end
		u2:GetInstanceAddedSignal("SoundButton"):Connect(u22)
		u2:GetInstanceAddedSignal("LockSound"):Connect(function(p43)

			p43.Visible = not u11
		end)
		u9:GetAttributeChangedSignal(u8.ATTRIBUTE_NAME):Connect(function()

			u32:UpdateDisplay()
		end)
		u10 = true
	end
end
return u7