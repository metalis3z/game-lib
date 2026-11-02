-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = v1:WaitForChild("Remotes"):WaitForChild("DataStream")
local _ = script.Parent
require(script.Parent.Signal)
local v_u_4 = require(script.Parent.PathSignalClass)
local v_u_5 = require(script.Parent.DeepClone)
local v_u_6 = {}
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new(p8)
	-- upvalues: (copy) v_u_7
	local v9 = v_u_7
	local v10 = setmetatable({}, v9)
	v10.Name = p8
	return v10
end
function v_u_7.GetChannelData(p11)
	-- upvalues: (copy) v_u_6
	return v_u_6[p11.Name]
end
function v_u_7.GetChannelDataAsync(p12, p13)
	local v14 = p12:GetChannelData()
	if v14 then
		::l2::
		return v14
	else
		local v15 = 0
		local v16 = p13 or (1 / 0)
		while true do
			v15 = v15 + task.wait()
			v14 = p12:GetChannelData()
			if v16 <= v15 then
				return v14
			end
			if v14 then
				goto l2
			end
		end
	end
end
function v_u_7.GetData(p17)
	-- upvalues: (copy) v_u_6
	local v18 = v_u_6[p17.Name]
	if v18 then
		return v18.Table
	end
end
function v_u_7.Destroy(p19)
	-- upvalues: (copy) v_u_6
	v_u_6[p19.Name] = nil
end
function v_u_7.GetDataAsync(p20, p21)
	return p20:GetChannelDataAsync(p21).Table
end
function v_u_7.GetPathSignal(p22, p23)
	local v24 = p22:GetChannelDataAsync()
	if v24 then
		return v24:GetPathSignal(p23)
	end
end
local v_u_57 = {
	["InitData"] = function(p25, p26)
		-- upvalues: (copy) v_u_6, (copy) v_u_4
		if p25 and p26 then
			v_u_6[p25] = v_u_4.new(p26)
		end
	end,
	["UpdateData"] = function(p27, p28)
		-- upvalues: (copy) v_u_6, (copy) v_u_5
		local v_u_29 = v_u_6[p27]
		if v_u_29 then
			for _, v_u_30 in p28 do
				task.spawn(function()
					-- upvalues: (copy) v_u_29, (copy) v_u_30, (ref) v_u_5
					local v31 = v_u_29:GetTable()
					local v32 = v_u_30[1]
					local v33 = v_u_30[2]
					local v34 = v32:split("/")
					if #v34 < 1 then
						return
					end
					table.remove(v34, 1)
					table.concat(v34, "/", 1, #v34)
					table.concat(v34, "/", 1, #v34 == 1 and 1 or #v34 - 1)
					local _ = v31[v34[#v34]]
					for v35, v36 in v34 do
						local v37 = tonumber(v36) or v36
						if v35 == #v34 then
							if type(v33) == "table" then
								local v38 = v31[v37]
								if type(v38) == "table" then
									v31[v37] = v_u_5(v33)
									break
								end
							end
							v31[v37] = v33
							break
						end
						local v39 = v31[v37] or {}
						v31[v37] = v39
						if v37 == #v34 - 1 then
							v31 = v39
						else
							v31 = v39
						end
					end
					local v40 = v_u_29:GetTable()
					local v41 = v_u_30[1]
					local v42 = v_u_30[2]
					local v43 = v41:split("/")
					if #v43 < 1 then
						return
					end
					table.remove(v43, 1)
					local v44 = table.concat(v43, "/", 1, #v43)
					local v45 = table.concat(v43, "/", 1, #v43 == 1 and 1 or #v43 - 1)
					local v46 = v40[v43[#v43]]
					local v47 = nil
					for v48, v49 in v43 do
						local v50 = tonumber(v49) or v49
						if v47 then
							v47 = ("%*/%*"):format(v47, v50)
						else
							v47 = v50
						end
						local v51 = v_u_29:FindPathSignal((("%*/@"):format(v47)))
						if v51 then
							v51:Fire(v50, v42, v44, v46)
						end
						if v48 == #v43 then
							if type(v42) == "table" then
								local v52 = v40[v50]
								if type(v52) == "table" then
									v40[v50] = v_u_5(v42)
									goto l35
								end
							end
							v40[v50] = v42
							::l35::
							local v53 = v_u_29:FindPathSignal((("%*"):format(v45)))
							if v53 then
								v53:Fire(v50, v42, v46, v45)
							end
							local v54 = v_u_29:FindPathSignal((("%*/*"):format(v45)))
							if v54 then
								v54:Fire(v50, v42, v46, v44)
							end
							local v55 = v_u_29:FindPathSignal((("%*/%*"):format(v45, v50)))
							if v55 then
								v55:Fire()
								return
							end
							break
						end
						local v56 = v40[v50] or {}
						v40[v50] = v56
						if v50 == #v43 - 1 then
							v40 = v56
						else
							v40 = v56
						end
					end
				end)
			end
		end
	end
}
if v2:IsClient() then
	v3.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) v_u_57
		local v58 = { ... }
		local v59 = v58[1]
		table.remove(v58, 1)
		local v60 = v_u_57[v59]
		if v60 then
			v60(unpack(v58))
		end
	end)
end
return v_u_7
