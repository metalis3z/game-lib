

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("CollectionService")
local u3 = game:GetService("Players")
game:GetService("SocialService")
local u4 = game:GetService("GroupService")
local u5 = require(v1:WaitForChild("SoundManager"))
local u6 = require(v1:WaitForChild("ClientState"))
local u7 = require(game:GetService("ReplicatedStorage"):WaitForChild("Config"))
local v8 = v1:WaitForChild("Remotes")
local u9 = v8:WaitForChild("VerifyGroup")
local u10 = v8:WaitForChild("ClaimGift")
local v11 = {}
local u12 = false
local u13 = {}
local function u21() 

	local u14 = u3.LocalPlayer:WaitForChild("PlayerGui")
	local function v18(p15) 

		local v16 = u2:GetTagged(p15)
		for _, v17 in ipairs(v16) do
			if v17:IsDescendantOf(u14) then
				return v17
			end
		end
		return nil
	end
	u13.modal = v18("GiftModal")
	u13.closeBtn = v18("GiftCloseBtn")
	u13.verifyBtn = v18("GiftVerifyBtn")
	u13.check1 = v18("GiftStep1Check")
	u13.check2 = v18("GiftStep2Check")
	u13.verifyBtnFrame = v18("VerifyButtonFrame")
	for v19, v20 in pairs(u13) do
		if not v20 then
			warn("\226\157\140 " .. v19 .. " MANQUANT (V\195\169rifie tes tags)")
		end
	end
end
function v11.UpdateDisplay(_) 

	if not u13.modal then
		u21()
	end
	if u6:Get().GiftClaimed then
		if u13.check1 then
			u13.check1.Visible = true
		end
		if u13.check2 then
			u13.check2.Visible = true
		end
		if u13.verifyBtn then
			u13.verifyBtn.Text = "Claimed! \226\156\147"
			u13.verifyBtnFrame.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
			return
		end
	else
		if u13.check1 then
			u13.check1.Visible = false
		end
		if u13.check2 then
			u13.check2.Visible = false
		end
		if u13.verifyBtn then
			u13.verifyBtn.Text = "Verify & Claim!"
			u13.verifyBtnFrame.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
		end
	end
end
local function u26() 

	if not u12 then
		if not u13.modal then
			u21()
		end
		if u13.closeBtn then
			u13.closeBtn.MouseButton1Click:Connect(function()

				u6:CloseCurrentModal()
			end)
		end
		if u13.verifyBtn then
			u13.verifyBtn.MouseButton1Click:Connect(function()

				if u6:Get().GiftClaimed then
					return
				else
					u13.verifyBtn.Text = "Checking..."
					local v22, v23 = pcall(function()

						return u9:InvokeServer()
					end)
					if v22 and v23 then
						if u13.check1 then
							u13.check1.Visible = true
						end
						if u13.check2 then
							u13.check2.Visible = true
						end
						u10:FireServer()
						u6:Update({
							["GiftClaimed"] = true
						})
						u5:Play("SUCCESS")
						u13.verifyBtn.Text = "Claimed! \226\156\147"
						u13.verifyBtnFrame.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
						task.delay(0.5, function()

							u6:CloseCurrentModal(u13.modal)
						end)
					else
						u5:Play("ERROR")
						u13.verifyBtn.Text = "Join Group First!"
						u13.verifyBtnFrame.BackgroundColor3 = Color3.fromRGB(220, 44, 44)
						task.delay(5, function()

							u13.verifyBtn.Text = "Verify & Claim!"
							u13.verifyBtnFrame.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
						end)
						task.wait(1)
						task.spawn(function()

							local v24, v25 = pcall(function()

								return u4:PromptJoinAsync(u7.GROUP_ID)
							end)
							if not v24 then
								warn("\226\157\140 Erreur GroupService:PromptJoinAsync :", v25)
							end
						end)
					end
				end
			end)
		end
		u12 = true
	end
end
function v11.InitLogic(p27) 

	if not u13.modal then
		u21()
	end
	u26()
	p27:UpdateDisplay()
end
function v11.OnClose(_) 
 end
return v11