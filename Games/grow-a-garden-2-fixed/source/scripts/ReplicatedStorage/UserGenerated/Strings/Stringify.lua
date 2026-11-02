--credit to prince games studio
local t = {
	Pretty = true,
	IndentChar = " ",
	IndentSize = 2
}

local function isInt(p1) --[[ isInt | Line: 68 ]]
	return math.abs(p1 - math.round(p1)) < 1e-6
end

local function roundTo(p1, p2) --[[ roundTo | Line: 72 ]]
	return math.round(p1 * p2) / p2
end

local function formatNum(p1, p2) --[[ formatNum | Line: 76 ]]
	local v1 = 10 ^ p2
	local v2 = math.round(p1 * v1) / v1

	if v2 == 0 and p1 ~= 0 then
		return tostring(p1)
	end

	local v3, _ = string.format("%." .. p2 .. "f", v2):gsub("%.?0+$", "")

	if v3 == "" or v3 == "-" then
		return "0"
	end

	return v3
end

local function isValidId(p1) --[[ isValidId | Line: 86 ]]
	return p1:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == p1
end

local function makeIndent(p1, p2, p3) --[[ makeIndent | Line: 90 ]]
	return string.rep(p1, p2 * p3)
end

local t2 = {}

local function serialize(p1, p2) --[[ serialize | Line: 100 | Upvalues: t2 (copy) ]]
	local v1 = t2[typeof(p1)]

	if v1 then
		return v1(p1, p2)
	end

	return ("[%*]"):format((typeof(p1)))
end

t2["nil"] = function(p1, p2) --[[ Line: 113 ]]
	return "nil"
end
function t2.boolean(p1, p2) --[[ Line: 117 ]]
	if p1 then
		return "true"
	end

	return "false"
end
function t2.number(p1, p2) --[[ Line: 121 ]]
	if p1 == (1 / 0) then
		return "math.huge"
	end

	if p1 == (-1 / 0) then
		return "-math.huge"
	end

	if p1 ~= p1 then
		return "0/0"
	end

	local v1

	if p2.cfg.Pretty then
		local v2 = math.round(p1 * 1000000) / 1000000

		if v2 == 0 and p1 ~= 0 then
			v1 = tostring(p1)
		else
			local v4, _ = string.format("%." .. 6 .. "f", v2):gsub("%.?0+$", "")

			v1 = if v4 == "" or v4 == "-" then "0" else v4
		end

		if not v1 then
			v1 = tostring(p1)
		end
	else
		v1 = tostring(p1)
	end

	return v1
end
function t2.string(p1, p2) --[[ Line: 128 ]]
	return string.format("%q", p1)
end
t2["function"] = function(p1) --[[ Line: 132 ]]
	return "[function]"
end
function t2.Instance(p1) --[[ Line: 136 ]]
	if p1.Parent then
		return ("[%* %*]"):format(p1.ClassName, (p1:GetFullName()))
	end

	return ("[%*]"):format(p1.ClassName)
end
function t2.table(p1, p2) --[[ Line: 147 | Upvalues: t2 (copy) ]]
	local v1 = getmetatable(p1)

	if v1 and v1.__tostring then
		return tostring(p1):gsub("\n", "\n" .. string.rep(p2.cfg.IndentChar, p2.cfg.IndentSize * p2.depth))
	end

	if p2.seen[p1] then
		return "{...}"
	end

	p2.seen[p1] = true

	local list = {}
	local v3 = 0

	for k in pairs(p1) do
		if typeof(k) == "number" and ((if math.abs(k - math.round(k)) < 1e-6 then true else false) and k > 0) then
			v3 = math.max(v3, k)
		end

		table.insert(list, k)
	end

	local v7 = if #list == v3 then if #list > 0 then true else false else false

	for i = 1, v3 do
		if p1[i] == nil then
			v7 = false

			break
		end
	end

	p2.depth = p2.depth + 1

	local Pretty = p2.cfg.Pretty
	local v8 = Pretty and "\n" .. string.rep(p2.cfg.IndentChar, p2.cfg.IndentSize * p2.depth) or ""
	local v9 = Pretty and ",\n" .. string.rep(p2.cfg.IndentChar, p2.cfg.IndentSize * p2.depth) or ","
	local t = {}

	if v7 then
		for j = 1, v3 do
			local v10
			local v11 = p1[j]
			local v12 = t2[typeof(v11)]

			v10 = if v12 then v12(v11, p2) else ("[%*]"):format((typeof(v11)))
			t[j] = v10
		end
	else
		local order = p2.order
		local t3 = {}

		for i, v in ipairs(list) do
			t3[v] = i
		end

		local list2 = {}

		for i, v in ipairs(list) do
			table.insert(list2, { v, p1[v] })
		end

		if order then
			table.sort(list2, function(p1, p2) --[[ Line: 199 | Upvalues: order (copy), t3 (copy) ]]
				local v1 = order[p1[1]] and order[p1[1]].Index or (1 / 0)
				local v2 = order[p2[1]] and order[p2[1]].Index or (1 / 0)

				return if v1 == v2 or not (v1 < v2) then t3[p1[1]] < t3[p2[1]] else true
			end)
		end

		for i, v in ipairs(list2) do
			local v15, v16, v17, v18
			local v19 = v[1]
			local v20 = v[2]
			local order2 = p2.order

			p2.order = order and order[v19] and order[v19].Child or nil

			if typeof(v19) == "string" and (v19:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == v19 and v19) then
				v15 = v19
			else
				local v22, v23, v24, v25, v26

				v22 = "[%*]"
				v23 = t2[typeof(v19)]

				if v23 then
					v24 = v23(v19, p2)
					v16 = v24
				else
					v25 = ("[%*]"):format((typeof(v19)))
					v16 = v25
				end

				v26 = v22:format(v16)
				v15 = v26
			end

			local v28 = t2[typeof(v20)]

			v17 = if v28 then v28(v20, p2) else ("[%*]"):format((typeof(v20)))

			local v31

			if Pretty then
				local v32 = ("%* = %*"):format(v15, v17)

				if v32 then
					v18 = v32
				else
					v31 = ("%*=%*"):format(v15, v17)
					v18 = v31
				end
			else
				v31 = ("%*=%*"):format(v15, v17)
				v18 = v31
			end

			table.insert(t, v18)
			p2.order = order2
		end
	end

	p2.depth = p2.depth - 1
	p2.seen[p1] = nil

	if #t == 0 then
		return "{}"
	end

	if Pretty then
		local v33 = "\n" .. string.rep(p2.cfg.IndentChar, p2.cfg.IndentSize * p2.depth)

		return "{" .. v8 .. table.concat(t, v9) .. "," .. v33 .. "}"
	end

	return "{" .. table.concat(t, v9) .. "}"
end
function t2.Color3(p1, p2) --[[ Line: 237 | Upvalues: t2 (copy) ]]
	local v1 = p1.R * 255
	local v2 = p1.G * 255
	local v3 = p1.B * 255
	local v4 = "fromRGB"
	local v7, v8, v9

	if if math.abs(v1 - math.round(v1)) < 1e-6 then true else false then
		local v11 = if math.abs(v2 - math.round(v2)) < 1e-6 then true else false

		if v11 and (if math.abs(v3 - math.round(v3)) < 1e-6 then true else false) then
			local v14 = math.round(v1)
			local v15 = math.round(v2)

			v7, v8, v9 = v14, v15, math.round(v3)
		else
			v7 = p1.R
			v8 = p1.G
			v9 = p1.B
			v4 = "new"
		end
	else
		v7 = p1.R
		v8 = p1.G
		v9 = p1.B
		v4 = "new"
	end

	if p2.cfg.Pretty then
		local v18 = t2[typeof(v7)]
		local v19 = if v18 then v18(v7, p2) else ("[%*]"):format((typeof(v7)))
		local v22 = t2[typeof(v8)]
		local v23, v24

		if v22 then
			v23, v24 = v4, v22(v8, p2)
		else
			v23, v24 = v4, ("[%*]"):format((typeof(v8)))
		end

		local v27 = t2[typeof(v9)]

		return ("Color3.%*(%*, %*, %*)"):format(v23, v19, v24, if v27 then v27(v9, p2) else ("[%*]"):format((typeof(v9))))
	end

	local v32 = t2[typeof(v7)]
	local v33 = if v32 then v32(v7, p2) else ("[%*]"):format((typeof(v7)))
	local v36 = t2[typeof(v8)]
	local v37, v38

	if v36 then
		v37, v38 = v4, v36(v8, p2)
	else
		v37, v38 = v4, ("[%*]"):format((typeof(v8)))
	end

	local v41 = t2[typeof(v9)]

	return ("Color3.%*(%*,%*,%*)"):format(v37, v33, v38, if v41 then v41(v9, p2) else ("[%*]"):format((typeof(v9))))
end
function t2.Vector3(p1, p2) --[[ Line: 251 | Upvalues: t2 (copy) ]]
	if p1 == Vector3.new(0, 0, 0) then
		return "Vector3.zero"
	end

	if p1 == Vector3.new(1, 1, 1) then
		return "Vector3.one"
	end

	if p1 == Vector3.new(1, 0, 0) then
		return "Vector3.xAxis"
	end

	if p1 == Vector3.new(0, 1, 0) then
		return "Vector3.yAxis"
	end

	if p1 == Vector3.new(0, 0, 1) then
		return "Vector3.zAxis"
	end

	if p2.cfg.Pretty then
		local X = p1.X
		local v2 = t2[typeof(X)]
		local v3 = if v2 then v2(X, p2) else ("[%*]"):format((typeof(X)))
		local Y = p1.Y
		local v6 = t2[typeof(Y)]
		local v7 = if v6 then v6(Y, p2) else ("[%*]"):format((typeof(Y)))
		local Z = p1.Z
		local v10 = t2[typeof(Z)]

		return ("Vector3.new(%*, %*, %*)"):format(v3, v7, if v10 then v10(Z, p2) else ("[%*]"):format((typeof(Z))))
	end

	local X = p1.X
	local v15 = t2[typeof(X)]
	local v16 = if v15 then v15(X, p2) else ("[%*]"):format((typeof(X)))
	local Y = p1.Y
	local v19 = t2[typeof(Y)]
	local v20 = if v19 then v19(Y, p2) else ("[%*]"):format((typeof(Y)))
	local Z = p1.Z
	local v23 = t2[typeof(Z)]

	return ("Vector3.new(%*,%*,%*)"):format(v16, v20, if v23 then v23(Z, p2) else ("[%*]"):format((typeof(Z))))
end
function t2.Vector2(p1, p2) --[[ Line: 263 | Upvalues: t2 (copy) ]]
	if p1 == Vector2.zero then
		return "Vector2.zero"
	end

	if p1 == Vector2.one then
		return "Vector2.one"
	end

	if p1 == Vector2.xAxis then
		return "Vector2.xAxis"
	end

	if p1 == Vector2.yAxis then
		return "Vector2.yAxis"
	end

	if p2.cfg.Pretty then
		local X = p1.X
		local v2 = t2[typeof(X)]
		local v3 = if v2 then v2(X, p2) else ("[%*]"):format((typeof(X)))
		local Y = p1.Y
		local v6 = t2[typeof(Y)]

		return ("Vector2.new(%*, %*)"):format(v3, if v6 then v6(Y, p2) else ("[%*]"):format((typeof(Y))))
	end

	local X = p1.X
	local v11 = t2[typeof(X)]
	local v12 = if v11 then v11(X, p2) else ("[%*]"):format((typeof(X)))
	local Y = p1.Y
	local v15 = t2[typeof(Y)]

	return ("Vector2.new(%*,%*)"):format(v12, if v15 then v15(Y, p2) else ("[%*]"):format((typeof(Y))))
end
function t2.CFrame(p1, p2) --[[ Line: 274 | Upvalues: t2 (copy) ]]
	if p1 == CFrame.identity then
		return "CFrame.identity"
	end

	local Position = p1.Position
	local v1, v2, v3 = p1:ToOrientation()
	local _, _2, _3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = p1:GetComponents()
	local v13 = if math.abs(v4 - 1) > 1e-6 or (math.abs(v8 - 1) > 1e-6 or (math.abs(v12 - 1) > 1e-6 or (math.abs(v5) > 1e-6 or (math.abs(v6) > 1e-6 or (math.abs(v7) > 1e-6 or (math.abs(v9) > 1e-6 or math.abs(v10) > 1e-6)))))) then true else math.abs(v11) > 1e-6
	local v14 = if Position.Magnitude > 1e-6 then true else false
	local Pretty = p2.cfg.Pretty
	local v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32

	if Pretty then
		local v35 = math.round(Position.X * 1000000) / 1000000
		local v36 = t2[typeof(v35)]
		local v37 = if v36 then v36(v35, p2) else ("[%*]"):format((typeof(v35)))
		local v41 = math.round(Position.Y * 1000000) / 1000000
		local v42 = t2[typeof(v41)]
		local v43 = if v42 then v42(v41, p2) else ("[%*]"):format((typeof(v41)))
		local v47 = math.round(Position.Z * 1000000) / 1000000
		local v48 = t2[typeof(v47)]
		local v52 = ("CFrame.new(%*, %*, %*)"):format(v37, v43, if v48 then v48(v47, p2) else ("[%*]"):format((typeof(v47))))

		if v52 then
			v15 = v52
		else
			v16 = "CFrame.new(%*,%*,%*)"
			v17 = Position.X
			v18 = t2[typeof(v17)]

			if v18 then
				v19 = v18(v17, p2)
				v20 = v19
			else
				v21 = ("[%*]"):format((typeof(v17)))
				v20 = v21
			end

			v22 = Position.Y
			v23 = t2[typeof(v22)]

			if v23 then
				v24 = v23(v22, p2)
				v25 = v24
			else
				v26 = ("[%*]"):format((typeof(v22)))
				v25 = v26
			end

			v27 = Position.Z
			v28 = t2[typeof(v27)]

			if v28 then
				v29 = v28(v27, p2)
				v30 = v29
			else
				v31 = ("[%*]"):format((typeof(v27)))
				v30 = v31
			end

			v32 = v16:format(v20, v25, v30)
			v15 = v32
		end
	else
		v16 = "CFrame.new(%*,%*,%*)"
		v17 = Position.X
		v18 = t2[typeof(v17)]

		if v18 then
			v19 = v18(v17, p2)
			v20 = v19
		else
			v21 = ("[%*]"):format((typeof(v17)))
			v20 = v21
		end

		v22 = Position.Y
		v23 = t2[typeof(v22)]

		if v23 then
			v24 = v23(v22, p2)
			v25 = v24
		else
			v26 = ("[%*]"):format((typeof(v22)))
			v25 = v26
		end

		v27 = Position.Z
		v28 = t2[typeof(v27)]

		if v28 then
			v29 = v28(v27, p2)
			v30 = v29
		else
			v31 = ("[%*]"):format((typeof(v27)))
			v30 = v31
		end

		v32 = v16:format(v20, v25, v30)
		v15 = v32
	end

	local v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63, v64, v65, v66, v67

	if Pretty then
		local v70 = math.round(math.deg(v1) * 1000000) / 1000000
		local v71 = t2[typeof(v70)]
		local v72 = if v71 then v71(v70, p2) else ("[%*]"):format((typeof(v70)))
		local v76 = math.round(math.deg(v2) * 1000000) / 1000000
		local v77 = t2[typeof(v76)]
		local v78 = if v77 then v77(v76, p2) else ("[%*]"):format((typeof(v76)))
		local v82 = math.round(math.deg(v3) * 1000000) / 1000000
		local v83 = t2[typeof(v82)]
		local v87 = ("CFrame.fromOrientation(math.rad(%*), math.rad(%*), math.rad(%*))"):format(v72, v78, if v83 then v83(v82, p2) else ("[%*]"):format((typeof(v82))))

		if v87 then
			v53 = v87
		else
			v54 = "CFrame.fromOrientation(%*,%*,%*)"
			v55 = t2[typeof(v1)]

			if v55 then
				v56 = v55(v1, p2)
				v57 = v56
			else
				v58 = ("[%*]"):format((typeof(v1)))
				v57 = v58
			end

			v59 = t2[typeof(v2)]

			if v59 then
				v60 = v59(v2, p2)
				v61 = v60
			else
				v62 = ("[%*]"):format((typeof(v2)))
				v61 = v62
			end

			v63 = t2[typeof(v3)]

			if v63 then
				v64 = v63(v3, p2)
				v65 = v64
			else
				v66 = ("[%*]"):format((typeof(v3)))
				v65 = v66
			end

			v67 = v54:format(v57, v61, v65)
			v53 = v67
		end
	else
		v54 = "CFrame.fromOrientation(%*,%*,%*)"
		v55 = t2[typeof(v1)]

		if v55 then
			v56 = v55(v1, p2)
			v57 = v56
		else
			v58 = ("[%*]"):format((typeof(v1)))
			v57 = v58
		end

		v59 = t2[typeof(v2)]

		if v59 then
			v60 = v59(v2, p2)
			v61 = v60
		else
			v62 = ("[%*]"):format((typeof(v2)))
			v61 = v62
		end

		v63 = t2[typeof(v3)]

		if v63 then
			v64 = v63(v3, p2)
			v65 = v64
		else
			v66 = ("[%*]"):format((typeof(v3)))
			v65 = v66
		end

		v67 = v54:format(v57, v61, v65)
		v53 = v67
	end

	if not v14 then
		return v53
	end

	return v13 and v15 .. (if Pretty then " * " else "*") .. v53 or v15
end
function t2.EnumItem(p1, p2) --[[ Line: 304 ]]
	return ("Enum.%*.%*"):format(tostring(p1.EnumType), p1.Name)
end

local t3 = {
	DEFAULT_CONFIG = t,
	Pretty = function(p1, p2) --[[ Pretty | Line: 316 | Upvalues: t (copy), serialize (copy) ]]
		local t2 = {}

		t2.Pretty = p2 and p2.Pretty or t.Pretty
		t2.IndentChar = p2 and p2.IndentChar or t.IndentChar
		t2.IndentSize = p2 and p2.IndentSize or t.IndentSize
		t2.Order = p2 and p2.Order or t.Order

		return serialize(p1, {
			depth = 0,
			cfg = t2,
			order = t2.Order,
			seen = {}
		})
	end,
	Serialize = function(p1, p2) --[[ Serialize | Line: 332 | Upvalues: serialize (copy) ]]
		return serialize(p1, {
			depth = 0,
			cfg = p2,
			order = p2.Order,
			seen = {}
		})
	end,
	Default = function(p1) --[[ Default | Line: 341 | Upvalues: t (copy), serialize (copy) ]]
		local v1 = t

		return serialize(p1, {
			depth = 0,
			cfg = v1,
			order = v1.Order,
			seen = {}
		})
	end
}

function t3.DefaultArgs(...) --[[ DefaultArgs | Line: 351 | Upvalues: t3 (copy) ]]
	local v1 = table.pack(...)
	local t = {}

	for i = 1, v1.n do
		if i > 1 then
			table.insert(t, ", ")
		end

		table.insert(t, t3.Default(v1[i]))
	end

	return table.concat(t)
end
function t3.DefaultArgsPrefix(...) --[[ DefaultArgsPrefix | Line: 363 | Upvalues: t3 (copy) ]]
	local v1 = table.pack(...)
	local t = {}

	for i = 1, v1.n do
		table.insert(t, ", ")
		table.insert(t, t3.Default(v1[i]))
	end

	return table.concat(t)
end
function t3.CompileOrder(p1) --[[ CompileOrder | Line: 373 | Upvalues: t3 (copy) ]]
	assert(type(p1) == "table")
	assert(if #p1 == 0 then if next(p1) == nil then true else false else true)

	local t = {}

	for i, v in ipairs(p1) do
		if type(v) == "table" then
			local Key = v.Key

			assert(type(Key) == "string")
			t[Key] = {
				Index = i,
				Child = t3.CompileOrder(v.Value)
			}

			continue
		end

		t[v] = {
			Index = i
		}
	end

	return t
end

return table.freeze(t3)