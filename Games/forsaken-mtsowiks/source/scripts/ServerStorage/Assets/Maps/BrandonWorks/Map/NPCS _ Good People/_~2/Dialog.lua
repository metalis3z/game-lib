-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v2 = {
	["FacePlayer"] = false,
	["PlayIdleOutsideOfDialog"] = true,
	["VoiceSFX"] = "rbxassetid://107648255423077",
	["Poses"] = {
		["Idle"] = "rbxassetid://180435571"
	},
	["Actions"] = {
		["Wave"] = "rbxassetid://128777973"
	}
}
v1.Config = v2
function v1.Interacted(p_u_3)
	p_u_3:CreateDialog({
		["Text"] = "lets chat! how are you feeling",
		["Action"] = "Wave"
	})
	local v4 = {
		{
			["Choice"] = "feeling good"
		},
		{
			["Choice"] = "feeling bad"
		},
		{
			["Choice"] = "Goodbye!"
		}
	}
	local function v_u_6()
		-- upvalues: (copy) p_u_3
		local v5 = { "Goodbye!" }
		p_u_3:CreateDialog({
			["Text"] = v5[math.random(1, #v5)]
		})
	end
	p_u_3:ProcessResponse(p_u_3:GetUserResponse(v4), { function()
			-- upvalues: (copy) p_u_3, (copy) v_u_6
			local v7 = { "cool :D what have you been up too" }
			p_u_3:CreateDialog({
				["Text"] = v7[math.random(1, #v7)]
			});
			(function()
				-- upvalues: (ref) p_u_3, (ref) v_u_6
				local v8 = {
					{
						["Choice"] = "playing games"
					},
					{
						["Choice"] = "hanging out"
					},
					{
						["Choice"] = "Goodbye!"
					}
				}
				local v11 = { function()
						-- upvalues: (ref) p_u_3, (ref) v_u_6
						p_u_3:CreateDialog({
							["Text"] = "oh whats your favorite game right now?"
						});
						(function()
							-- upvalues: (ref) p_u_3, (ref) v_u_6
							local v9 = {
								{
									["Choice"] = "heli wars"
								},
								{
									["Choice"] = "work at a pizza place"
								},
								{
									["Choice"] = "survive disasters"
								},
								{
									["Choice"] = "Goodbye!"
								}
							}
							local v10 = {
								function()
									-- upvalues: (ref) p_u_3
									p_u_3:CreateDialog({
										["Text"] = "<Color=Blue>ozo<Color=/> is that you? LOL it must be! hope you still get out there and pwn, so much fun"
									})
								end,
								function()
									-- upvalues: (ref) p_u_3
									p_u_3:CreateDialog({
										["Text"] = "<Color=Red>ERROR<Color=/>"
									})
								end,
								function()
									-- upvalues: (ref) p_u_3
									p_u_3:CreateDialog({
										["Text"] = "<Color=Red>ERROR<Color=/>"
									})
								end,
								v_u_6
							}
							p_u_3:ProcessResponse(p_u_3:GetUserResponse(v9), v10)
						end)()
					end, function()
						-- upvalues: (ref) p_u_3
						p_u_3:CreateDialog({
							["Text"] = "<Color=Red>ERROR<Color=/>"
						})
					end, v_u_6 }
				p_u_3:ProcessResponse(p_u_3:GetUserResponse(v8), v11)
			end)()
		end, function()
			-- upvalues: (copy) p_u_3, (copy) v_u_6
			local v12 = { "sorry :( whats going on?" }
			p_u_3:CreateDialog({
				["Text"] = v12[math.random(1, #v12)]
			});
			(function()
				-- upvalues: (ref) p_u_3, (ref) v_u_6
				local v13 = {
					{
						["Choice"] = "something online"
					},
					{
						["Choice"] = "something irl"
					},
					{
						["Choice"] = "Goodbye!"
					}
				}
				local v14 = { function()
						-- upvalues: (ref) p_u_3
						p_u_3:CreateDialog({
							["Text"] = "noobs/trolls bothering you? try ignoring :D itll be okay"
						})
					end, function()
						-- upvalues: (ref) p_u_3
						p_u_3:CreateDialog({
							["Text"] = "hope it works out, wish i could help sooner.. try talking it out with the person"
						})
					end, v_u_6 }
				p_u_3:ProcessResponse(p_u_3:GetUserResponse(v13), v14)
			end)()
		end, v_u_6 })
end
return v1
