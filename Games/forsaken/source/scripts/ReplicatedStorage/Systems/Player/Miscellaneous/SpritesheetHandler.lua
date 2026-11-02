-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local v_u_4 = require(script.Spritesheets)
local v_u_5 = {
	"FPS",
	"TimeScale",
	"Paused",
	"FrameOffset"
}
local v_u_10 = {
	["ImageLabel"] = function(p6, p7, p8)
		local v9 = p6.Config
		p6.Instance.ImageRectSize = v9.Resolution / Vector2.new(p6.Config.Columns, p6.Config.Rows)
		p6.Instance.ImageRectOffset = Vector2.new(p8 - 1, p7 - 1) * v9.Resolution / Vector2.new(p6.Config.Columns, p6.Config.Rows)
	end
}
v_u_10.ImageButton = v_u_10.ImageLabel
local v_u_11 = v3:IsServer() and v3.Heartbeat or v3.RenderStepped
local v_u_12 = {}
local function v_u_27(p_u_13)
	-- upvalues: (copy) v_u_10, (copy) v_u_12, (copy) v_u_4, (copy) v_u_5
	local v14 = v_u_10[p_u_13.ClassName]
	local v15 = ("Instances of type %* aren\'t supported. womp womp"):format(p_u_13.ClassName)
	assert(v14, v15)
	local v16 = not v_u_12[p_u_13]
	local v17 = ("%* is already registered!"):format((tostring(p_u_13)))
	assert(v16, v17)
	local v_u_18 = {
		["Garbage"] = {},
		["Instance"] = p_u_13,
		["Time"] = 0
	}
	for _, v_u_19 in ipairs(v_u_5) do
		v_u_18[v_u_19] = p_u_13:GetAttribute(v_u_19)
		local v20 = v_u_18.Garbage
		local v21 = p_u_13:GetAttributeChangedSignal(v_u_19)
		table.insert(v20, v21:Connect(function()
			-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) p_u_13
			v_u_18[v_u_19] = p_u_13:GetAttribute(v_u_19)
		end))
	end
	local v22 = v_u_18.Garbage
	local v23 = p_u_13:GetAttributeChangedSignal("Spritesheet")
	local function v25()
		-- upvalues: (copy) p_u_13, (ref) v_u_4, (copy) v_u_18
		local v24 = p_u_13:GetAttribute("Spritesheet")
		if v24 then
			v24 = v_u_4[v24]
		end
		v_u_18.Config = v24
		v_u_18.Time = 0
		p_u_13.Image = v24 and v24.Image or ""
	end
	table.insert(v22, v23:Connect(v25))
	local v26 = p_u_13:GetAttribute("Spritesheet")
	if v26 then
		v26 = v_u_4[v26]
	end
	v_u_18.Config = v26
	v_u_18.Time = 0
	p_u_13.Image = v26 and v26.Image or ""
	v_u_12[p_u_13] = v_u_18
end
local function v_u_31(p28)
	-- upvalues: (copy) v_u_12
	local v29 = v_u_12[p28]
	if v29 then
		for _, v30 in ipairs(v29.Garbage) do
			v30:Disconnect()
		end
		v_u_12[p28] = nil
		table.clear(v29)
	end
end
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_1, (copy) v_u_12, (copy) v_u_2, (copy) v_u_27, (copy) v_u_31, (copy) v_u_11, (copy) v_u_10
	v_u_1.RunningSheets = v_u_12
	v_u_2:GetInstanceAddedSignal("Spritesheet"):Connect(v_u_27)
	v_u_2:GetInstanceRemovedSignal("Spritesheet"):Connect(v_u_31)
	task.spawn(function()
		-- upvalues: (ref) v_u_11, (ref) v_u_12, (ref) v_u_10
		v_u_11:Connect(function(p32)
			-- upvalues: (ref) v_u_12, (ref) v_u_10
			for v33, v34 in pairs(v_u_12) do
				if v33 and v33.Parent then
					local v35 = v34.Config
					if v35 then
						local v36 = v34.Instance.ClassName
						local v37 = v34.FPS or v35.FPS
						local v38 = v37 == 0 and (1 / 0) or 1 / v37
						local v39 = (v34.Time + (v34.FrameOffset or 0) * v38) % (v35.Frames * v38) / v38
						local v40 = math.floor(v39) + 1
						local v41 = v40 / v35.Columns
						local v42 = math.ceil(v41)
						local v43 = (v40 - 1) % v35.Columns + 1
						v_u_10[v36](v34, v42, v43)
						if not v34.Paused then
							v34.Time = v34.Time + p32 * (v34.TimeScale or 1)
						end
					end
				end
			end
		end)
	end)
	for _, v44 in ipairs(v_u_2:GetTagged("Spritesheet")) do
		v_u_27(v44)
	end
end
return v_u_1
