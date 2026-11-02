-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = {
	["_version"] = 1
}
v_u_3.__index = v_u_3
local v_u_4 = {
	["version"] = "number",
	["size"] = "number",
	["count"] = "number",
	["columns"] = "number",
	["rows"] = "number",
	["images"] = "table"
}
function v_u_3.new(p5, p6)
	-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_3
	if type(p5) == "string" then
		p5 = v_u_1:JSONDecode(p5)
	elseif type(p5) ~= "table" then
		error("Argument #1 (configuration) must be a JSON string or table.", 2)
	end
	for v7, v8 in pairs(p5) do
		if v_u_4[v7] == nil then
			error(("Invalid property name in Radial Image configuration: %s"):format(v7), 2)
		end
		if type(v8) ~= v_u_4[v7] then
			error(("Invalid property type %q in Radial Image configuration: must be a %s."):format(v7, v_u_4[v7]), 2)
		end
	end
	if p5.version ~= v_u_3._version then
		error(("Passed configuration version does not match this module\'s version (which is %d)"):format(v_u_3._version), 2)
	end
	local v9 = {
		["config"] = p5,
		["label"] = p6
	}
	local v10 = v_u_3
	setmetatable(v9, v10)
	return v9
end
function v_u_3.Preload(p11)
	-- upvalues: (copy) v_u_2
	if p11.label == nil then
		error("You must provide a label to RadialImage.new to use Preload", 2)
	end
	p11.labels = {}
	for _, v12 in ipairs(p11.config.images) do
		local v13 = p11.label:Clone()
		v13.Image = v12
		v13.Visible = true
		v13.Size = UDim2.new(0, 0, 0, 0)
		v13.Parent = p11.label.Parent
		local v14 = p11.labels
		table.insert(v14, v13)
	end
	v_u_2:PreloadAsync(p11.labels)
	for _, v15 in ipairs(p11.labels) do
		v15.Visible = false
	end
end
function v_u_3.Destroy(p16)
	if p16.labels then
		for _, v17 in ipairs(p16.labels) do
			v17:Destroy()
		end
	end
	for v18, _ in pairs(p16) do
		p16[v18] = nil
	end
end
function v_u_3.GetFromAlpha(p19, p20)
	if type(p20) ~= "number" then
		error("Argument #1 (alpha) to GetFromAlpha must be a number.", 2)
	end
	local v21 = p19.config.count
	local v22 = p19.config.size
	local v23 = p19.config.columns
	local v24 = p19.config.rows
	local v25 = p20 >= 1 and v21 - 1
	if not v25 then
		local v26 = p20 * v21
		v25 = math.floor(v26)
	end
	local v27 = v25 / (v23 * v24)
	local v28 = math.floor(v27) + 1
	local v29 = v25 - v23 * v24 * (v28 - 1)
	local v30 = v29 % v23 * v22
	local v31 = v29 / v23
	return v30, math.floor(v31) * v22, v28
end
function v_u_3.UpdateLabel(p32, p33, p34)
	local v35 = p34 or p32.label
	if type(p33) ~= "number" then
		error("Argument #1 (alpha) to UpdateLabel must be a number.", 2)
	end
	if typeof(v35) ~= "Instance" or not (v35:IsA("ImageLabel") or v35:IsA("ImageButton")) then
		error("Attempt to update label but no label has been given. Either pass the label as argument #2 to \"new\", or as argument #2 to \"UpdateLabel\".", 2)
	end
	local v36, v37, v38 = p32:GetFromAlpha(p33)
	v35.ImageRectSize = Vector2.new(p32.config.size, p32.config.size)
	v35.ImageRectOffset = Vector2.new(v36, v37)
	v35.Image = p33 <= 0 and "" or p32.config.images[v38]
end
return v_u_3
