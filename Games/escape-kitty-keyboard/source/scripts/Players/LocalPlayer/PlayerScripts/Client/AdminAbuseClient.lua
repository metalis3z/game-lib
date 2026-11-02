-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local u1 = game:GetService("Players")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("UserInputService")
local u4 = require(script.Parent:WaitForChild("AdminAbuseGui"))
local u5 = require(script.Parent:WaitForChild("AdminAbuseRegistry"))
local u6 = require(script.Parent:WaitForChild("AdminAbuseTransition"))
local u7 = Enum.KeyCode.F8
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local function u12() -- name: invalidateRegistry
	-- upvalues: (ref) u11
	u11 = nil
end
return {
	["init"] = function() -- name: init
		-- upvalues: (ref) u8, (copy) u2, (ref) u9, (ref) u10, (copy) u12, (copy) u1, (copy) u5, (copy) u4, (copy) u3, (copy) u7, (ref) u11, (copy) u6
		u8 = u2:WaitForChild("AdminAbuse"):WaitForChild("Modules")
		local v13 = u2:WaitForChild("AdminAbuse"):WaitForChild("Remotes")
		local v14 = v13:WaitForChild("AdminAbuseRequest")
		local v15 = v13:WaitForChild("AdminAbuseSync")
		u9 = v14
		u10 = v15
		local u16 = u8
		u16.ChildAdded:Connect(u12)
		u16.ChildRemoved:Connect(u12)
		local u17 = u1.LocalPlayer
		assert(u17, "LocalPlayer manquant")
		local u18 = u9
		local v19 = u10
		local u20 = nil
		local u21 = nil
		local u22 = nil
		local u23 = false
		local function u27() -- name: buildProps
			-- upvalues: (ref) u5, (copy) u16, (copy) u18, (copy) u17
			return {
				["moduleMetas"] = u5.listModuleMetas(u16),
				["onPickModule"] = function(p24, p25) -- name: onPickModule
					-- upvalues: (ref) u18
					if p25 then
						u18:FireServer("Start", p24, p25)
					else
						u18:FireServer("Start", p24)
					end
				end,
				["onStop"] = function() -- name: onStop
					-- upvalues: (ref) u18
					u18:FireServer("Stop")
				end,
				["onBossDelta"] = function(p26) -- name: onBossDelta
					-- upvalues: (ref) u17, (ref) u18
					if u17:GetAttribute("AdminAbuseTrusted") == true then
						u18:FireServer("BossDelta", p26)
					end
				end,
				["showStop"] = u17:GetAttribute("AdminAbuseTrusted") == true
			}
		end
		u3.InputBegan:Connect(function(p28, p29)
			-- upvalues: (ref) u7, (copy) u17, (ref) u22, (ref) u4, (copy) u27, (ref) u23
			if not p29 then
				if p28.KeyCode == u7 then
					if u17:GetAttribute("AdminAbuseTrusted") ~= true then
						return
					end
					local v30
					if u22 then
						v30 = u22
					else
						u22 = u4.mountLocalPlayer((u27()))
						v30 = u22
					end
					u23 = not u23
					v30.SetProps((u27()))
					v30.SetVisible(u23)
				end
			end
		end)
		u17:GetAttributeChangedSignal("AdminAbuseTrusted"):Connect(function()
			-- upvalues: (copy) u17, (ref) u22, (ref) u23
			if u17:GetAttribute("AdminAbuseTrusted") ~= true and u22 then
				u23 = false
				u22.SetVisible(false)
			end
		end)
		local u31 = 0
		local u32 = false
		local u33 = false
		v19.OnClientEvent:Connect(function(p34, u35, p36, p37, p38, p39)
			-- upvalues: (ref) u31, (ref) u32, (ref) u33, (ref) u20, (ref) u21, (ref) u8, (ref) u11, (ref) u5, (ref) u6
			local v40 = type(p38) ~= "number" and 0 or p38
			if p34 == "Start" and (type(u35) == "string" and u35 ~= "") then
				local v41 = nil
				if type(p36) == "number" then
					if p36 < 0 then
						p36 = v41
					end
				else
					p36 = v41
				end
				local v42 = p37 == true
				if v40 > 0 then
					if v40 < u31 then
						return
					end
					if u31 < v40 then
						u31 = v40
						u32 = false
						u33 = false
					end
					if v42 then
						if u32 or u33 then
							return
						end
						u33 = true
					else
						if u32 then
							return
						end
						u32 = true
					end
				elseif u20 == u35 and u21 == p36 then
					return
				end
				local v43 = u20
				u20 = u35
				u21 = p36
				if v43 and v43 ~= u35 then
					local v44 = u8
					assert(v44, "AdminAbuseClient.init() d\'abord")
					if not u11 then
						u11 = u5.loadRegistry(v44)
					end
					local v45 = u11[v43]
					if v45 then
						local v46 = v45.Stop
						if type(v46) == "function" then
							v45:Stop()
						end
					end
				end
				local u47 = u21
				local v48 = p39 == true
				u6.play(function()
					-- upvalues: (ref) u20, (copy) u35, (copy) u47, (ref) u8, (ref) u11, (ref) u5
					if u20 == u35 then
						local v49 = u35
						local v50 = u47
						local v51 = u8
						assert(v51, "AdminAbuseClient.init() d\'abord")
						if not u11 then
							u11 = u5.loadRegistry(v51)
						end
						local v52 = u11[v49]
						if v52 then
							local v53 = v52.Fire
							if type(v53) == "function" then
								if v50 then
									v52:Fire(v50)
									return
								end
								v52:Fire()
							end
						end
					end
				end, {
					["skip"] = v42,
					["skipDoor"] = v48
				})
			elseif p34 == "Stop" then
				if v40 > 0 then
					if v40 <= u31 then
						return
					end
					u31 = v40
				end
				u32 = false
				u33 = false
				u6.cancel()
				if u20 then
					local v54 = u20
					local v55 = u8
					assert(v55, "AdminAbuseClient.init() d\'abord")
					if not u11 then
						u11 = u5.loadRegistry(v55)
					end
					local v56 = u11[v54]
					if v56 then
						local v57 = v56.Stop
						if type(v57) == "function" then
							v56:Stop()
						end
					end
				end
				u20 = nil
				u21 = nil
			end
		end)
		local u58 = u17.Character
		u17.CharacterAdded:Connect(function(p59)
			-- upvalues: (ref) u20, (ref) u8, (ref) u11, (ref) u5, (ref) u58, (ref) u21
			if u20 then
				local v60 = u8
				assert(v60, "AdminAbuseClient.init() d\'abord")
				if not u11 then
					u11 = u5.loadRegistry(v60)
				end
				local v61 = u11[u20]
				if v61 and v61.RequiresRespawnRefire == true then
					if u58 == nil then
						u58 = p59
					else
						u58 = p59
						task.defer(function()
							-- upvalues: (ref) u20, (ref) u21, (ref) u8, (ref) u11, (ref) u5
							local v62 = u20
							local v63 = u21
							local v64 = u8
							assert(v64, "AdminAbuseClient.init() d\'abord")
							if not u11 then
								u11 = u5.loadRegistry(v64)
							end
							local v65 = u11[v62]
							if v65 then
								local v66 = v65.Fire
								if type(v66) == "function" then
									if v63 then
										v65:Fire(v63)
										return
									end
									v65:Fire()
								end
							end
						end)
					end
				else
					return
				end
			else
				return
			end
		end)
		u18:FireServer("GetState")
	end,
	["getAdminAbuseTable"] = function() -- name: getAdminAbuseTable
		-- upvalues: (ref) u8, (copy) u5
		local v67 = u8
		assert(v67, "AdminAbuseClient.init() d\'abord")
		return u5.buildAdminAbuseTable(v67)
	end
}