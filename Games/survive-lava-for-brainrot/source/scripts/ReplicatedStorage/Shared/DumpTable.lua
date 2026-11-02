-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
function dump(p1)
	local v_u_2 = {
		["\7"] = "\\a",
		["\8"] = "\\b",
		["\f"] = "\\f",
		["\n"] = "\\n",
		["\r"] = "\\r",
		["\t"] = "\\t",
		["\11"] = "\\v",
		["\0"] = "\\0"
	}
	local v_u_3 = {
		["and"] = true,
		["break"] = true,
		["do"] = true,
		["else"] = true,
		["elseif"] = true,
		["end"] = true,
		["false"] = true,
		["for"] = true,
		["function"] = true,
		["if"] = true,
		["in"] = true,
		["local"] = true,
		["nil"] = true,
		["not"] = true,
		["or"] = true,
		["repeat"] = true,
		["return"] = true,
		["then"] = true,
		["true"] = true,
		["until"] = true,
		["while"] = true,
		["continue"] = true
	}
	local v_u_4 = {
		[DockWidgetPluginGuiInfo.new] = "DockWidgetPluginGuiInfo.new",
		[warn] = "warn",
		[CFrame.fromMatrix] = "CFrame.fromMatrix",
		[CFrame.fromAxisAngle] = "CFrame.fromAxisAngle",
		[CFrame.fromOrientation] = "CFrame.fromOrientation",
		[CFrame.fromEulerAnglesXYZ] = "CFrame.fromEulerAnglesXYZ",
		[CFrame.Angles] = "CFrame.Angles",
		[CFrame.fromEulerAnglesYXZ] = "CFrame.fromEulerAnglesYXZ",
		[CFrame.new] = "CFrame.new",
		[gcinfo] = "gcinfo",
		[os.clock] = "os.clock",
		[os.difftime] = "os.difftime",
		[os.time] = "os.time",
		[os.date] = "os.date",
		[tick] = "tick",
		[bit32.band] = "bit32.band",
		[bit32.extract] = "bit32.extract",
		[bit32.bor] = "bit32.bor",
		[bit32.bnot] = "bit32.bnot",
		[bit32.arshift] = "bit32.arshift",
		[bit32.rshift] = "bit32.rshift",
		[bit32.rrotate] = "bit32.rrotate",
		[bit32.replace] = "bit32.replace",
		[bit32.lshift] = "bit32.lshift",
		[bit32.lrotate] = "bit32.lrotate",
		[bit32.btest] = "bit32.btest",
		[bit32.bxor] = "bit32.bxor",
		[pairs] = "pairs",
		[NumberSequence.new] = "NumberSequence.new",
		[assert] = "assert",
		[tonumber] = "tonumber",
		[Color3.fromHSV] = "Color3.fromHSV",
		[Color3.toHSV] = "Color3.toHSV",
		[Color3.fromRGB] = "Color3.fromRGB",
		[Color3.new] = "Color3.new",
		[Delay] = "Delay",
		[Stats] = "Stats",
		[UserSettings] = "UserSettings",
		[coroutine.resume] = "coroutine.resume",
		[coroutine.yield] = "coroutine.yield",
		[coroutine.running] = "coroutine.running",
		[coroutine.status] = "coroutine.status",
		[coroutine.wrap] = "coroutine.wrap",
		[coroutine.create] = "coroutine.create",
		[coroutine.isyieldable] = "coroutine.isyieldable",
		[NumberRange.new] = "NumberRange.new",
		[PhysicalProperties.new] = "PhysicalProperties.new",
		[PluginManager] = "PluginManager",
		[Ray.new] = "Ray.new",
		[NumberSequenceKeypoint.new] = "NumberSequenceKeypoint.new",
		[Version] = "Version",
		[Vector2.new] = "Vector2.new",
		[Instance.new] = "Instance.new",
		[delay] = "delay",
		[spawn] = "spawn",
		[unpack] = "unpack",
		[string.split] = "string.split",
		[string.match] = "string.match",
		[string.gmatch] = "string.gmatch",
		[string.upper] = "string.upper",
		[string.gsub] = "string.gsub",
		[string.format] = "string.format",
		[string.lower] = "string.lower",
		[string.sub] = "string.sub",
		[string.pack] = "string.pack",
		[string.rep] = "string.rep",
		[string.char] = "string.char",
		[string.packsize] = "string.packsize",
		[string.reverse] = "string.reverse",
		[string.byte] = "string.byte",
		[string.unpack] = "string.unpack",
		[string.len] = "string.len",
		[string.find] = "string.find",
		[CellId.new] = "CellId.new",
		[ypcall] = "ypcall",
		[version] = "version",
		[print] = "print",
		[stats] = "stats",
		[printidentity] = "printidentity",
		[settings] = "settings",
		[UDim2.fromOffset] = "UDim2.fromOffset",
		[UDim2.fromScale] = "UDim2.fromScale",
		[UDim2.new] = "UDim2.new",
		[table.pack] = "table.pack",
		[table.move] = "table.move",
		[table.insert] = "table.insert",
		[table.getn] = "table.getn",
		[table.foreachi] = "table.foreachi",
		[table.maxn] = "table.maxn",
		[table.foreach] = "table.foreach",
		[table.concat] = "table.concat",
		[table.unpack] = "table.unpack",
		[table.find] = "table.find",
		[table.create] = "table.create",
		[table.sort] = "table.sort",
		[table.remove] = "table.remove",
		[TweenInfo.new] = "TweenInfo.new",
		[loadstring] = "loadstring",
		[require] = "require",
		[Vector3.FromNormalId] = "Vector3.FromNormalId",
		[Vector3.FromAxis] = "Vector3.FromAxis",
		[Vector3.fromAxis] = "Vector3.fromAxis",
		[Vector3.fromNormalId] = "Vector3.fromNormalId",
		[Vector3.new] = "Vector3.new",
		[Vector3int16.new] = "Vector3int16.new",
		[setmetatable] = "setmetatable",
		[next] = "next",
		[Wait] = "Wait",
		[wait] = "wait",
		[ipairs] = "ipairs",
		[elapsedTime] = "elapsedTime",
		[time] = "time",
		[rawequal] = "rawequal",
		[Vector2int16.new] = "Vector2int16.new",
		[collectgarbage] = "collectgarbage",
		[newproxy] = "newproxy",
		[Spawn] = "Spawn",
		[PluginDrag.new] = "PluginDrag.new",
		[Region3.new] = "Region3.new",
		[utf8.offset] = "utf8.offset",
		[utf8.codepoint] = "utf8.codepoint",
		[utf8.nfdnormalize] = "utf8.nfdnormalize",
		[utf8.char] = "utf8.char",
		[utf8.codes] = "utf8.codes",
		[utf8.len] = "utf8.len",
		[utf8.graphemes] = "utf8.graphemes",
		[utf8.nfcnormalize] = "utf8.nfcnormalize",
		[xpcall] = "xpcall",
		[tostring] = "tostring",
		[rawset] = "rawset",
		[PathWaypoint.new] = "PathWaypoint.new",
		[DateTime.fromUnixTimestamp] = "DateTime.fromUnixTimestamp",
		[DateTime.now] = "DateTime.now",
		[DateTime.fromIsoDate] = "DateTime.fromIsoDate",
		[DateTime.fromUnixTimestampMillis] = "DateTime.fromUnixTimestampMillis",
		[DateTime.fromLocalTime] = "DateTime.fromLocalTime",
		[DateTime.fromUniversalTime] = "DateTime.fromUniversalTime",
		[Random.new] = "Random.new",
		[typeof] = "typeof",
		[RaycastParams.new] = "RaycastParams.new",
		[math.log] = "math.log",
		[math.ldexp] = "math.ldexp",
		[math.rad] = "math.rad",
		[math.cosh] = "math.cosh",
		[math.random] = "math.random",
		[math.frexp] = "math.frexp",
		[math.tanh] = "math.tanh",
		[math.floor] = "math.floor",
		[math.max] = "math.max",
		[math.sqrt] = "math.sqrt",
		[math.modf] = "math.modf",
		[math.pow] = "math.pow",
		[math.atan] = "math.atan",
		[math.tan] = "math.tan",
		[math.cos] = "math.cos",
		[math.sign] = "math.sign",
		[math.clamp] = "math.clamp",
		[math.log10] = "math.log10",
		[math.noise] = "math.noise",
		[math.acos] = "math.acos",
		[math.abs] = "math.abs",
		[math.sinh] = "math.sinh",
		[math.asin] = "math.asin",
		[math.min] = "math.min",
		[math.deg] = "math.deg",
		[math.fmod] = "math.fmod",
		[math.randomseed] = "math.randomseed",
		[math.atan2] = "math.atan2",
		[math.ceil] = "math.ceil",
		[math.sin] = "math.sin",
		[math.exp] = "math.exp",
		[getfenv] = "getfenv",
		[pcall] = "pcall",
		[ColorSequenceKeypoint.new] = "ColorSequenceKeypoint.new",
		[ColorSequence.new] = "ColorSequence.new",
		[type] = "type",
		[Region3int16.new] = "Region3int16.new",
		[ElapsedTime] = "ElapsedTime",
		[select] = "select",
		[getmetatable] = "getmetatable",
		[rawget] = "rawget",
		[Faces.new] = "Faces.new",
		[Rect.new] = "Rect.new",
		[BrickColor.Blue] = "BrickColor.Blue",
		[BrickColor.White] = "BrickColor.White",
		[BrickColor.Yellow] = "BrickColor.Yellow",
		[BrickColor.Red] = "BrickColor.Red",
		[BrickColor.Gray] = "BrickColor.Gray",
		[BrickColor.palette] = "BrickColor.palette",
		[BrickColor.New] = "BrickColor.New",
		[BrickColor.Black] = "BrickColor.Black",
		[BrickColor.Green] = "BrickColor.Green",
		[BrickColor.Random] = "BrickColor.Random",
		[BrickColor.DarkGray] = "BrickColor.DarkGray",
		[BrickColor.random] = "BrickColor.random",
		[BrickColor.new] = "BrickColor.new",
		[setfenv] = "setfenv",
		[UDim.new] = "UDim.new",
		[Axes.new] = "Axes.new",
		[error] = "error",
		[debug.traceback] = "debug.traceback",
		[debug.profileend] = "debug.profileend",
		[debug.profilebegin] = "debug.profilebegin"
	}
	local function v_u_12(p5)
		-- upvalues: (copy) v_u_2, (copy) v_u_3
		local v6 = p5
		local v7 = 1
		local v8 = {}
		while p5 do
			p5 = p5.Parent
			v7 = v7 + 1
		end
		local v9 = 0
		while v6 do
			v9 = v9 + 1
			local v10 = string.gsub(v6.Name, "[%c%z]", v_u_2)
			local v11 = v6 == game and "game" or v10
			if v_u_3[v11] or not string.match(v11, "^[_%a][_%w]*$") then
				v11 = "[\"" .. v11 .. "\"]"
			elseif v9 ~= v7 - 1 then
				v11 = "." .. v11
			end
			v8[v7 - v9] = v11
			v6 = v6.Parent
		end
		return table.concat(v8)
	end
	local function v_u_16(p13, p14)
		-- upvalues: (copy) v_u_2, (copy) v_u_12, (copy) v_u_4
		if p14 == "string" then
			return string.format("\"%s\"", string.gsub(p13, "[%c%z]", v_u_2))
		elseif p14 == "Instance" then
			return v_u_12(p13)
		elseif type(p13) == p14 then
			if p14 == "function" then
				return v_u_4[p13] or "\'[Unknown " .. (pcall(setfenv, p13, getfenv(p13)) and "Lua" or "C") .. " " .. tostring(p13) .. "]\'"
			elseif p14 == "userdata" then
				local v15 = getmetatable(p13) and true or false
				return "newproxy(" .. tostring(v15) .. ")"
			elseif p14 == "thread" then
				return "\'" .. tostring(p13) .. ", status: " .. coroutine.status(p13) .. "\'"
			else
				return tostring(p13)
			end
		else
			return p14 .. ".new(" .. tostring(p13) .. ")"
		end
	end
	local function v_u_40(p17, p18, p19, p20)
		-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_40, (copy) v_u_16
		local v21 = p18 or {}
		local v22 = v21[p17]
		if v22 then
			return (v22[1] == p19[1] - 1 and "\'[Cyclic Parent " or "\'[Cyclic ") .. tostring(p17) .. ", path: " .. v22[2] .. "]\'"
		end
		local v23 = p20 or "ROOT"
		local v24 = p19 or { 0, v23 }
		local v25 = v24[1] + 1
		v24[1] = v25
		v24[2] = v23
		v21[p17] = v24
		local v26 = string.rep("    ", v25)
		local v27 = string.rep("    ", v25 - 1)
		local v28 = "\n" .. v26
		local v29 = 1
		local v30 = "{"
		local v31 = true
		local v32 = true
		for v33, v34 in next, p17 do
			v32 = false
			if v29 == v33 then
				v29 = v29 + 1
			else
				v31 = false
			end
			local v35 = typeof(v33)
			local v36 = typeof(v34)
			local v37 = false
			local v38
			if v35 == "string" then
				v38 = string.gsub(v33, "[%c%z]", v_u_2)
				if v_u_3[v38] or not string.match(v38, "^[_%a][_%w]*$") then
					v38 = string.format("[\"%s\"]", v38)
					v37 = true
				end
			else
				v38 = "[" .. (v35 == "table" and string.gsub(v_u_40(v33, v21, { v25, v23 }), "^%s*(.-)%s*$", "%1") or v_u_16(v33, v35)) .. "]"
				v37 = true
			end
			local v39 = v36 == "table" and v_u_40(v34, v21, { v25, v23 }, v23 .. (v37 and "" or ".") .. v38) or v_u_16(v34, v36)
			v30 = v30 .. v28 .. (v31 and v39 and v39 or v38 .. " = " .. v39) .. ","
		end
		return v32 and v30 .. "}" or string.sub(v30, 1, -2) .. "\n" .. v27 .. "}"
	end
	return v_u_40(p1)
end
return dump
