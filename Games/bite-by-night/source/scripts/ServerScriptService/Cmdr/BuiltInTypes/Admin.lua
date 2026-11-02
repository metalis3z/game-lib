-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = {}
local v_u_3 = false

local Translate = require('@game/ReplicatedStorage/Modules/Misc/RankTranslations')
return function(p4)
	-- upvalues: (copy) v_u_2, (ref) v_u_3, (copy) v_u_1
	p4:RegisterHook("BeforeRun", function(p_u_5)
		-- upvalues: (ref) v_u_2, (ref) v_u_3, (ref) v_u_1
		local v6 = {}
		local _, groupRole = pcall(function()
			return Translate.RankTranslate[p_u_5.Executor:GetAttribute("Rank")]
		end)
		local v7 = groupRole or p_u_5.Executor:GetRoleInGroup(Translate.GroupID)
		warn(v7)
		if p_u_5.Group == "Admin+" and (v7 ~= "Lead Developer" and (v7 ~= "Director" and (v7 ~= "Co-Director" and v7 ~= "Manager"))) then
			return "You don\'t have permission to run this command"
		end
		if p_u_5.Group == "Admin" and (v7 ~= "Developer" and (v7 ~= "Lead Developer" and (v7 ~= "Manager" and (v7 ~= "Director" and (v7 ~= "Co-Director"))))) then
			return "You don\'t have permission to run this command"
		end
		if p_u_5.Group == "Developer" and (v7 ~= "Developer" and (v7 ~= "Lead Developer" and (v7 ~= "Director" and (v7 ~= "Co-Director" and (v7 ~= "Manager"))))) then
			return "You don\'t have permission to run this command"
		end
		if p_u_5.Group == "LeadDeveloper" and (v7 ~= "Lead Developer" and (v7 ~= "Director" and (v7 ~= "Co-Director" and (v7 ~= "Manager")))) then
			return "You don\'t have permission to run this command"
		end
		if p_u_5.Group == "Moderator" and (v7 ~= "Moderator" and (v7 ~= "Developer" and (v7 ~= "Lead Developer" and (v7 ~= "Director" and (v7 ~= "Manager" and (v7 ~= "Co-Director")))))) then
			return "You don\'t have permission to run this command"
		end
		if v7.Group == "Tester" and (v7 ~= "Tester" and (v7 ~= "Moderator" and (v7 ~= "Developer" and (v7 ~= "Lead Developer" and (v7 ~= "Manager" and (v7 ~= "Director" and (v7 ~= "Co-Director"))))))) then
			return (game.PrivateServerId == "" or (v7 == "Developer" or (v7 == "Lead Developer" or (v7 == "Director" or v7 == "Co-Director")))) and "You don\'t have permission to run this command" or "Cannot run these commnads in public servers"
		end
		if v7.Group == "Creator" and (v7 ~= "Content Creator" and (v7 ~= "Tester" and (v7 ~= "Moderator" and (v7 ~= "Developer" and (v7 ~= "Lead Developer" and (v7 ~= "Director" and (v7 ~= "Co-Director" and (v7 ~= "Manager")))))))) then
			return "You don\'t have permission to run this command"
		end
		
		print(p_u_5.Executor.Name .. " | COMMAND | " .. p_u_5.RawText)
		task.spawn(function()
			-- upvalues: (copy) p_u_5, (ref) v_u_2, (ref) v_u_3, (ref) v_u_1
			if game:GetService("RunService"):IsServer() and not p_u_5.Object.IgnoreLog then
				v_u_2[#v_u_2 + 1] = p_u_5
				if not v_u_3 then
					v_u_3 = true
					task.delay(15, function()
						-- upvalues: (ref) v_u_2, (ref) v_u_3, (ref) v_u_1
						local v8 = {}
						for _, v9 in next, v_u_2 do
							v8[#v8 + 1] = ("**%* [_%*_]** `` > %* ``"):format(v9.Executor.Name, v9.Executor.UserId, v9.RawText)
						end
						local v10 = table.concat(v8, "\n")
						v_u_3 = false
						table.clear(v_u_2)
						local v11 = v_u_1:GetSecret("CommandLogs")
						local v13 = {}
						local v14 = {}
						local v15 = {
							["title"] = "Command Log",
							["description"] = v10,
							["color"] = 4360181,
							["fields"] = {
								{
									["name"] = "Server Type",
									["value"] = game:GetService("RunService"):IsStudio() and "Studio" or (game.PrivateServerId == "" and "Public" or "Private"),
									["inline"] = true
								}
							},
							["footer"] = {
								["text"] = ("%*s Buffer"):format(15)
							},
							["timestamp"] = DateTime.now():ToIsoDate()
						}
						v14[1] = {v15}
						v13.embeds = v14
						v_u_1:PostAsync(v11, (v_u_1:JSONEncode(v13)))
					end)
				end
			end
		end)
	end)
end