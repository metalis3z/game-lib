-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("ReplicatedStorage")
game:GetService("ServerStorage")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v4 = require(v1.Modules.Warp)
if v2:IsServer() then
	v4.Server("Side")
end
local v_u_33 = {
	["Server"] = {},
	["FindCharacter"] = function(_, p5)
		-- upvalues: (copy) v_u_3
		if typeof(p5) == "string" and v_u_3:FindFirstChild(p5) then
			p5 = v_u_3[p5].Character or p5
		end
		return p5
	end,
	["GetPlayers"] = function(_)
		-- upvalues: (copy) v_u_3
		local v6 = next
		local v7, v8 = v_u_3:GetPlayers()
		local v9 = {}
		for _, v10 in v6, v7, v8 do
			if v10.Character then
				v9[#v9 + 1] = v10.Character
			end
		end
		return v9
	end,
	["GetAlive"] = function(_)
		local v11 = next
		local v12, v13 = workspace.PLAYERS.ALIVE:GetChildren()
		local v14 = {}
		for _, v15 in v11, v12, v13 do
			v14[#v14 + 1] = v15
		end
		return v14
	end,
	["GetKillers"] = function(_)
		local v16 = next
		local v17, v18 = workspace.PLAYERS.KILLER:GetChildren()
		local v19 = {}
		for _, v20 in v16, v17, v18 do
			v19[#v19 + 1] = v20
		end
		return v19
	end,
	["GetLobby"] = function(_)
		local v21 = next
		local v22, v23 = workspace.PLAYERS.LOBBY:GetChildren()
		local v24 = {}
		for _, v25 in v21, v22, v23 do
			v24[#v24 + 1] = v25
		end
		return v24
	end,
	["GetClosestCharacter"] = function(_, p26, p27)
		-- upvalues: (copy) v_u_33
		local v28 = p27 or v_u_33:GetPlayers()
		local v29 = (1 / 0)
		local v30 = nil
		for _, v31 in next, v28 do
			if v31:FindFirstChild("HumanoidRootPart") then
				local v32 = (v31.HumanoidRootPart.Position - p26).Magnitude
				if v32 < v29 then
					v30 = v31
					v29 = v32
				end
			end
		end
		return v30, v29
	end
}
return v_u_33