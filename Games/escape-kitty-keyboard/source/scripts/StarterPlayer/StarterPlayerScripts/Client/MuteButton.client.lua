

local v1 = game:GetService("Players")
local u2 = game:GetService("Workspace")
local v3 = v1.LocalPlayer
assert(v3, "LocalPlayer manquant")
local v4 = v3:WaitForChild("PlayerGui"):WaitForChild("AdminAbuseGui", 30)
if v4 then
	local v5 = v4:WaitForChild("MuteButton", 10)
	if v5 then
		local u6 = v5:WaitForChild("MuteButton", 10)
		if u6 then
			if u6:IsA("TextButton") then
				u6.Active = true
				u6.AutoButtonColor = true
				local function u10() 

					local v7 = u6:GetAttribute("SoundName")
					if typeof(v7) == "string" and v7 ~= "" then
						local v8 = u2:FindFirstChild(v7, true)
						if v8 and v8:IsA("Sound") then
							return v8
						end
					end
					for _, v9 in ipairs(u2:GetDescendants()) do
						if v9:IsA("Sound") then
							return v9
						end
					end
					return nil
				end
				local function u14(p11, p12) 
					if p12 then
						if p11:GetAttribute("AdminAbuseMuted") ~= true then
							p11:SetAttribute("AdminAbusePrevVolume", p11.Volume)
							p11:SetAttribute("AdminAbuseMuted", true)
							p11.Volume = 0
						end
					elseif p11:GetAttribute("AdminAbuseMuted") == true then
						local v13 = p11:GetAttribute("AdminAbusePrevVolume")
						if typeof(v13) == "number" then
							p11.Volume = v13
						end
						p11:SetAttribute("AdminAbusePrevVolume", nil)
						p11:SetAttribute("AdminAbuseMuted", false)
					end
				end
				u6.Activated:Connect(function()

					print("[MuteButton] click")
					local v15 = u10()
					if v15 then
						local v16 = v15:GetAttribute("AdminAbuseMuted") ~= true
						print((("[MuteButton] sound=%* -> muted=%*"):format(v15:GetFullName(), v16)))
						u14(v15, v16)
						local v17 = u10()
						if v17 then
							u6.Text = v17:GetAttribute("AdminAbuseMuted") == true and "\240\159\148\136" or "\240\159\148\138"
						else
							u6.Text = "\240\159\148\138"
						end
					else
						warn("[MuteButton] Aucun Sound trouv\195\169 dans Workspace")
						return
					end
				end)
				local v18 = u10()
				if v18 then
					u6.Text = v18:GetAttribute("AdminAbuseMuted") == true and "\240\159\148\136" or "\240\159\148\138"
				else
					u6.Text = "\240\159\148\138"
				end
			else
				warn((("[MuteButton] L\'\195\169l\195\169ment cible doit \195\170tre un TextButton (re\195\167u: %*)"):format(u6.ClassName)))
				return
			end
		else
			warn("[MuteButton] MuteButton (button) introuvable dans le frame")
			return
		end
	else
		warn("[MuteButton] MuteButton (frame) introuvable dans AdminAbuseGui")
		return
	end
else
	warn("[MuteButton] AdminAbuseGui introuvable dans PlayerGui")
	return
end