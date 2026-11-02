

--!native
local RunService = game:GetService("RunService")
local exp = math.exp
local sin = math.sin
local cos = math.cos
local min = math.min
local max = math.max
local sqrt = math.sqrt
local atan2 = math.atan2
local round = math.round

local function magnitudeSq(t1: {[any]: any})
	local n1 = 0

	for _, v39 in t1 do
		n1 += v39 ^ 2
	end

	return n1
end
local function distanceSq(t2: {[any]: any}, t3: {[any]: any})
	local n2 = 0

	for v43, v44 in t2 do
		n2 += (t3[v43] - v44) ^ 2
	end

	return n2
end

local t4 = {}

t4.__index = t4

function t4.new(n3: number, n4: number, p1, p2, p3)
	local v50 = p3.toIntermediate(p1)

	return (setmetatable({
		d = n3,
		f = n4,
		g = v50,
		p = v50,
		v = table.create(#v50, 0),
		typedat = p3,
		rawGoal = p2
	}, t4))
end
function t4.setGoal(p4, p5)
	p4.rawGoal = p5
	p4.g = p4.typedat.toIntermediate(p5)
end
function t4.setDampingRatio(p6, n5: number)
	p6.d = n5
end
function t4.setFrequency(p7, n6: number)
	p7.f = n6
end
function t4.canSleep(p8)
	local n7 = 0

	for _, v60 in p8.v do
		n7 += v60 ^ 2
	end

	if n7 > 0.0001 then
		return false
	end

	local p = p8.p
	local g = p8.g
	local n8 = 0

	for v64, v65 in p do
		n8 += (g[v64] - v65) ^ 2
	end

	if n8 > 6.781684027777778E-08 then
		return false
	end

	return true
end
function t4.step(p9, n9: number)
	local d = p9.d
	local v69 = p9.f * 6.283185307179586
	local g = p9.g
	local p = p9.p
	local v = p9.v

	if d == 1 then
		local v73 = exp(-v69 * n9)
		local v74 = n9 * v73
		local v75 = v73 + v74 * v69
		local v76 = v73 - v74 * v69
		local v77 = v74 * v69 * v69

		for i = 1, #p do
			local v79 = p[i] - g[i]

			p[i] = v79 * v75 + v[i] * v74 + g[i]
			v[i] = v[i] * v76 - v79 * v77
		end
	elseif d < 1 then
		local v80 = exp(-d * v69 * n9)
		local v81 = sqrt(1 - d * d)
		local v82 = cos(n9 * v69 * v81)
		local v83 = sin(n9 * v69 * v81)
		local v84

		if v81 > 1E-05 then
			v84 = v83 / v81
		else
			local v85 = n9 * v69

			v84 = v85 + (v85 * v85 * (v81 * v81) * (v81 * v81) / 20 - v81 * v81) * (v85 * v85 * v85) / 6
		end

		local v86

		if v69 * v81 > 1E-05 then
			v86 = v83 / (v69 * v81)
		else
			local v87 = v69 * v81

			v86 = n9 + (n9 * n9 * (v87 * v87) * (v87 * v87) / 20 - v87 * v87) * (n9 * n9 * n9) / 6
		end

		for i = 1, #p do
			local v89 = p[i] - g[i]

			p[i] = (v89 * (v82 + v84 * d) + v[i] * v86) * v80 + g[i]
			v[i] = (v[i] * (v82 - v84 * d) - v89 * (v84 * v69)) * v80
		end
	else
		local v90 = sqrt(d * d - 1)
		local v91 = -v69 * (d + v90)
		local v92 = -v69 * (d - v90)
		local v93 = exp(v91 * n9)
		local v94 = exp(v92 * n9)

		for i = 1, #p do
			local v96 = p[i] - g[i]
			local v97 = (v[i] - v96 * v91) / (2 * v69 * v90)
			local v98 = v93 * (v96 - v97)

			p[i] = v98 + v97 * v94 + g[i]
			v[i] = v98 * v91 + v97 * v94 * v92
		end
	end

	return p9.typedat.fromIntermediate(p9.p)
end

local t5 = {}

t5.__index = t5

function t5.new(n10: number, n11: number, cFrame: CFrame, cFrame2: CFrame)
	return (setmetatable({
		v = Vector3.new(0, 0, 0),
		d = n10,
		f = n11,
		g = cFrame2:Orthonormalize(),
		p = cFrame:Orthonormalize()
	}, t5))
end
function t5.setGoal(p10, cFrame: CFrame)
	p10.g = cFrame:Orthonormalize()
end
function t5.setDampingRatio(p11, n12: number)
	p11.d = n12
end
function t5.setFrequency(p12, n13: number)
	p12.f = n13
end

local function dot(vector3: Vector3, vector3_2: Vector3)
	return vector3.X * vector3_2.X + vector3.Y * vector3_2.Y + vector3.Z * vector3_2.Z
end
local function areRotationsClose(cFrame: CFrame, cFrame3: CFrame)
	local XVector = cFrame.XVector
	local XVector2 = cFrame3.XVector
	local v115 = XVector.X * XVector2.X + XVector.Y * XVector2.Y + XVector.Z * XVector2.Z
	local YVector = cFrame.YVector
	local YVector2 = cFrame3.YVector
	local v118 = YVector.X * YVector2.X + YVector.Y * YVector2.Y + YVector.Z * YVector2.Z
	local ZVector = cFrame.ZVector
	local ZVector2 = cFrame3.ZVector
	local v121 = ZVector.X * ZVector2.X + ZVector.Y * ZVector2.Y + ZVector.Z * ZVector2.Z

	return v115 + v118 + v121 > 2.9999999695382584
end
local function angleDiff(cFrame: CFrame, cFrame4: CFrame)
	local XVector = cFrame.XVector
	local XVector3 = cFrame4.XVector
	local v126 = XVector.X * XVector3.X + XVector.Y * XVector3.Y + XVector.Z * XVector3.Z
	local YVector = cFrame.YVector
	local YVector3 = cFrame4.YVector
	local v129 = YVector.X * YVector3.X + YVector.Y * YVector3.Y + YVector.Z * YVector3.Z
	local ZVector = cFrame.ZVector
	local ZVector3 = cFrame4.ZVector
	local v132 = ZVector.X * ZVector3.X + ZVector.Y * ZVector3.Y + ZVector.Z * ZVector3.Z
	local v133 = v126 + v129 + v132 - 1

	return (atan2(sqrt((max(0, 1 - v133 * v133 * 0.25))), v133 * 0.5))
end
local function fromAxisAngle(vector3: Vector3, n14: number)
	local v136 = cos(n14)
	local v137 = sin(n14)
	local vector3X = vector3.X
	local vector3Y = vector3.Y
	local vector3Z = vector3.Z
	local v141 = vector3X * vector3Y * (1 - v136)
	local v142 = vector3Y * vector3Z * (1 - v136)
	local v143 = vector3Z * vector3X * (1 - v136)
	local vector3_3 = Vector3.new(vector3X * vector3X * (1 - v136) + v136, v141 + vector3Z * v137, v143 - vector3Y * v137)
	local vector3_4 = Vector3.new(v141 - vector3Z * v137, vector3Y * vector3Y * (1 - v136) + v136, v142 + vector3X * v137)
	local vector3_5 = Vector3.new(v143 + vector3Y * v137, v142 - vector3X * v137, vector3Z * vector3Z * (1 - v136) + v136)

	return CFrame.fromMatrix(Vector3.new(0, 0, 0), vector3_3, vector3_4, vector3_5):Orthonormalize()
end
local function rotateAxis(vector3: Vector3, cFrame: CFrame)
	local identity = CFrame.identity
	local Magnitude = vector3.Magnitude

	if Magnitude > 1E-06 then
		identity = fromAxisAngle(vector3.Unit, Magnitude)
	end

	return identity * cFrame
end
local function axisAngleDiff(cFrame: CFrame, cFrame5: CFrame)
	local v153 = (cFrame * cFrame5:Inverse()):ToAxisAngle()
	local v154 = angleDiff(cFrame, cFrame5)

	return v153.Unit * v154
end

function t5.canSleep(p13)
	local p = p13.p
	local g = p13.g
	local XVector = p.XVector
	local XVector4 = g.XVector
	local v160 = XVector.X * XVector4.X + XVector.Y * XVector4.Y + XVector.Z * XVector4.Z
	local YVector = p.YVector
	local YVector4 = g.YVector
	local v163 = YVector.X * YVector4.X + YVector.Y * YVector4.Y + YVector.Z * YVector4.Z
	local ZVector = p.ZVector
	local ZVector4 = g.ZVector
	local v166 = ZVector.X * ZVector4.X + ZVector.Y * ZVector4.Y + ZVector.Z * ZVector4.Z
	local v167 = v160 + v163 + v166 > 2.9999999695382584
	local v168 = p13.v.Magnitude < 0.0017453292519943296

	return v167 and v168
end
function t5.step(p14, n15: number)
	local d = p14.d
	local v172 = p14.f * 6.283185307179586
	local g = p14.g
	local p = p14.p
	local v = p14.v
	local v176 = (p * g:Inverse()):ToAxisAngle()
	local v177 = angleDiff(p, g)
	local v178 = v176.Unit * v177
	local v179 = exp(-d * v172 * n15)
	local v183, v184

	if d == 1 then
		local v180 = (v178 * (1 + v172 * n15) + v * n15) * v179
		local identity = CFrame.identity
		local Magnitude = v180.Magnitude

		if Magnitude > 1E-06 then
			identity = fromAxisAngle(v180.Unit, Magnitude)
		end

		v183 = identity * g
		v184 = (v * (1 - n15 * v172) - v178 * (n15 * v172 * v172)) * v179
	elseif d < 1 then
		local v185 = sqrt(1 - d * d)
		local v186 = cos(n15 * v172 * v185)
		local v187 = sin(n15 * v172 * v185)
		local v188 = v187 / (v172 * v185)
		local v189 = v187 / v185
		local v190 = (v178 * (v186 + v189 * d) + v * v188) * v179
		local identity = CFrame.identity
		local Magnitude = v190.Magnitude

		if Magnitude > 1E-06 then
			identity = fromAxisAngle(v190.Unit, Magnitude)
		end

		v183 = identity * g
		v184 = (v * (v186 - v189 * d) - v178 * (v189 * v172)) * v179
	else
		local v193 = sqrt(d * d - 1)
		local v194 = -v172 * (d + v193)
		local v195 = -v172 * (d - v193)
		local v196 = (v - v178 * v194) / (2 * v172 * v193)
		local v197 = (v178 - v196) * exp(v194 * n15)
		local v198 = v196 * exp(v195 * n15)
		local v199 = v197 + v198
		local identity = CFrame.identity
		local Magnitude = v199.Magnitude

		if Magnitude > 1E-06 then
			identity = fromAxisAngle(v199.Unit, Magnitude)
		end

		v183 = identity * g
		v184 = v197 * v194 + v198 * v195
	end

	p14.p = v183
	p14.v = v184

	return v183
end

local t7 = {
	springType = t4.new,
	toIntermediate = function(p15)
		return {
			p15.X,
			p15.Y,
			p15.Z
		}
	end,
	fromIntermediate = function(t6: {[any]: any})
		return (Vector3.new(t6[1], t6[2], t6[3]))
	end
}
local t8 = {}

t8.__index = t8

function t8.new(n16: number, n17: number, cFrame: CFrame, cFrame6: CFrame, _)
	return (setmetatable({
		rawGoal = cFrame6,
		_position = t4.new(n16, n17, cFrame.Position, cFrame6.Position, t7),
		_rotation = t5.new(n16, n17, cFrame.Rotation, cFrame6.Rotation)
	}, t8))
end
function t8.setGoal(t9: {[any]: any}, cFrame: CFrame)
	t9.rawGoal = cFrame
	t9._position:setGoal(cFrame.Position)
	t9._rotation:setGoal(cFrame.Rotation)
end
function t8.setDampingRatio(t10: {[any]: any}, n18: number)
	t10._position.d = n18
	t10._rotation.d = n18
end
function t8.setFrequency(t11: {[any]: any}, n19: number)
	t11._position.f = n19
	t11._rotation.f = n19
end
function t8.canSleep(p17)
	return p17._position:canSleep() and p17._rotation:canSleep()
end
function t8.step(p18, p19)
	local v218 = p18._position:step(p19)

	return p18._rotation:step(p19) + v218
end

local function inverseGammaCorrectD65(p20)
	return p20 < 0.0404482362771076 and p20 / 12.92 or 0.87941546140213 * (p20 + 0.055) ^ 2.4
end
local function gammaCorrectD65(p21)
	return p21 < 0.0031306684425 and 12.92 * p21 or 1.055 * p21 ^ 0.4166666666666667 - 0.055
end
local function rgbToLuv(color3: Color3)
	local R = color3.R
	local G = color3.G
	local B = color3.B
	local v225 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4
	local v226 = G < 0.0404482362771076 and G / 12.92 or 0.87941546140213 * (G + 0.055) ^ 2.4
	local v227 = B < 0.0404482362771076 and B / 12.92 or 0.87941546140213 * (B + 0.055) ^ 2.4
	local v228 = 0.9257063972951867 * v225 - 0.8333736323779866 * v226 - 0.09209820666085898 * v227
	local v229 = 0.2125862307855956 * v225 + 0.7151703037034108 * v226 + 0.0722004986433362 * v227
	local v230 = 3.6590806972265884 * v225 + 11.442689580057424 * v226 + 4.114991502426484 * v227
	local v231 = v229 > 0.008856451679035631 and 116 * v229 ^ 0.3333333333333333 - 16 or 903.296296296296 * v229
	local v232, v233

	if v230 > 1E-14 then
		v232 = v231 * v228 / v230
		v233 = v231 * (9 * v229 / v230 - 0.46832)
	else
		v232 = -0.19783 * v231
		v233 = -0.46832 * v231
	end

	return {
		v231,
		v232,
		v233
	}
end
local function luvToRgb(t12: {[any]: any})
	local v235 = t12[1]

	if v235 < 0.0197955 then
		return Color3.new(0, 0, 0)
	end

	local v236 = t12[2] / v235 + 0.19783
	local v237 = t12[3] / v235 + 0.46832
	local v238 = (v235 + 16) / 116
	local v239 = v238 > 0.20689655172413793 and v238 * v238 * v238 or v238 * 0.12841854934601665 - 0.01771290335807126
	local v240 = v239 * v236 / v237
	local v241 = v239 * ((3 - v236 * 0.75) / v237 - 5)
	local v242 = v240 * 7.2914074 - v239 * 1.537208 - v241 * 0.4986286
	local v243 = v240 * -2.180094 + v239 * 1.8757561 + v241 * 0.0415175
	local v244 = v240 * 0.1253477 - v239 * 0.2040211 + v241 * 1.0569959

	if v242 < 0 and v242 < v243 and v242 < v244 then
		v243 -= v242
		v244 -= v242
		v242 = 0
	elseif v243 < 0 and v243 < v244 then
		v242 -= v243
		v244 -= v243
		v243 = 0
	elseif v244 < 0 then
		v242 -= v244
		v243 -= v244
		v244 = 0
	end

	return Color3.new(min(v242 < 0.0031306684425 and 12.92 * v242 or 1.055 * v242 ^ 0.4166666666666667 - 0.055, 1), min(v243 < 0.0031306684425 and 12.92 * v243 or 1.055 * v243 ^ 0.4166666666666667 - 0.055, 1), (min(v244 < 0.0031306684425 and 12.92 * v244 or 1.055 * v244 ^ 0.4166666666666667 - 0.055, 1)))
end

local t17 = {
	boolean = {
		springType = t4.new,
		toIntermediate = function(p22)
			return { not p22 and 0 or 1 }
		end,
		fromIntermediate = function(p23)
			return p23[1] >= 0.5
		end
	},
	number = {
		springType = t4.new,
		toIntermediate = function(p24)
			return { p24 }
		end,
		fromIntermediate = function(p25)
			return p25[1]
		end
	},
	NumberRange = {
		springType = t4.new,
		toIntermediate = function(p26)
			return {
				p26.Min,
				p26.Max
			}
		end,
		fromIntermediate = function(p27)
			return NumberRange.new(p27[1], p27[2])
		end
	},
	UDim = {
		springType = t4.new,
		toIntermediate = function(p28)
			return {
				p28.Scale,
				p28.Offset
			}
		end,
		fromIntermediate = function(t13: {[any]: any})
			return UDim.new(t13[1], (round(t13[2])))
		end
	},
	UDim2 = {
		springType = t4.new,
		toIntermediate = function(p29)
			local p29X = p29.X
			local p29Y = p29.Y

			return {
				p29X.Scale,
				p29X.Offset,
				p29Y.Scale,
				p29Y.Offset
			}
		end,
		fromIntermediate = function(t14: {[any]: any})
			return UDim2.new(t14[1], round(t14[2]), t14[3], (round(t14[4])))
		end
	},
	Vector2 = {
		springType = t4.new,
		toIntermediate = function(p30)
			return {
				p30.X,
				p30.Y
			}
		end,
		fromIntermediate = function(t15: {[any]: any})
			return Vector2.new(t15[1], t15[2])
		end
	},
	Vector3 = t7,
	Color3 = {
		springType = t4.new,
		toIntermediate = rgbToLuv,
		fromIntermediate = luvToRgb
	},
	ColorSequence = {
		springType = t4.new,
		toIntermediate = function(p31)
			local Keypoints = p31.Keypoints
			local v261 = rgbToLuv(Keypoints[1].Value)
			local v262 = rgbToLuv(Keypoints[#Keypoints].Value)

			return {
				v261[1],
				v261[2],
				v261[3],
				v262[1],
				v262[2],
				v262[3]
			}
		end,
		fromIntermediate = function(t16: {[any]: any})
			return ColorSequence.new(luvToRgb({
				t16[1],
				t16[2],
				t16[3]
			}), luvToRgb({
				t16[4],
				t16[5],
				t16[6]
			}))
		end
	},
	CFrame = {
		springType = t8.new,
		toIntermediate = error,
		fromIntermediate = error
	}
}
local t18 = {
	Pivot = {
		class = "PVInstance",
		get = function(p32)
			return p32:GetPivot()
		end,
		set = function(p33, cFrame: CFrame)
			p33:PivotTo(cFrame)
		end
	},
	Scale = {
		class = "Model",
		get = function(p34)
			return p34:GetScale()
		end,
		set = function(p35, n20: number)
			p35:ScaleTo((math.clamp(n20, 1.402E-45, 16777216)))
		end
	}
}

local function getProperty(p36, s1: string)
	local v272 = t18[s1]

	if v272 and p36:IsA(v272.class) then
		return v272.get(p36)
	end

	return p36[s1]
end
local function setProperty(p37, s2: string, p38)
	local v276 = t18[s2]

	if v276 and p37:IsA(v276.class) then
		v276.set(p37, p38)

		return
	end

	p37[s2] = p38
end

local t19 = {}
local t20 = {}
local t21 = {}

local function processSprings(p39, n21: number)
	for v279, v280 in p39 do
		for v281, v282 in v280 do
			if v282:canSleep() then
				v280[v281] = nil

				local rawGoal = v282.rawGoal
				local v284 = t18[v281]

				if v284 and v279:IsA(v284.class) then
					v284.set(v279, rawGoal)
				else
					v279[v281] = rawGoal
				end
			else
				local v285 = v282:step(n21)
				local v286 = t18[v281]

				if v286 and v279:IsA(v286.class) then
					v286.set(v279, v285)
				else
					v279[v281] = v285
				end
			end
		end

		if not next(v280) then
			p39[v279] = nil

			local v287 = t21[v279]

			if v287 then
				t21[v279] = nil

				for _, v289 in v287 do
					task.spawn(v289)
				end
			end
		end
	end
end

RunService.PreSimulation:Connect(function(p40)
	debug.profilebegin("Spr:processSprings:other")
	processSprings(t19, p40)
	debug.profileend()
end)
RunService.PostSimulation:Connect(function(p41)
	debug.profilebegin("Spr:processSprings:render")
	processSprings(t20, p41)
	debug.profileend()
end)

local function assertType(n22: number, s3: string, s4: string, p42)
	if not s4:find((typeof(p42))) then
		error(`bad argument #{ n22 } to { s3 } ({ s4 } expected, got { typeof(p42) })`, 3)
	end
end

local t23 = {
	target = function(p43, n23: number, n24: number, t22: {[any]: any})
		if not ("Instance"):find((typeof(p43))) then
			error(`bad argument #{ 1 } to spr.target (Instance expected, got { typeof(p43) })`, 3)
		end

		if not ("number"):find((typeof(n23))) then
			error(`bad argument #{ 2 } to spr.target (number expected, got { typeof(n23) })`, 3)
		end

		if not ("number"):find((typeof(n24))) then
			error(`bad argument #{ 3 } to spr.target (number expected, got { typeof(n24) })`, 3)
		end

		if not ("table"):find((typeof(t22))) then
			error(`bad argument #{ 4 } to spr.target (table expected, got { typeof(t22) })`, 3)
		end

		if n23 ~= n23 or n23 < 0 then
			error(("expected damping ratio >= 0; got %.2f"):format(n23), 2)
		end

		if n24 ~= n24 or n24 < 0 then
			error(("expected undamped frequency >= 0; got %.2f"):format(n24), 2)
		end

		local v300 = if not p43:IsA("Camera") then t19 else t20
		local v301 = v300[p43]

		if not v301 then
			v301 = {}
			v300[p43] = v301
		end

		for v302, v303 in t22 do
			local v304 = t18[v302]
			local v305 = if not v304 or not p43:IsA(v304.class) then p43[v302] else v304.get(p43)

			if typeof(v303) ~= typeof(v305) then
				error(`bad property { v302 } to spr.target ({ typeof(v305) } expected, got { typeof(v303) })`, 2)
			end

			if n24 == 1e999 then
				local v306 = t18[v302]

				if v306 and p43:IsA(v306.class) then
					v306.set(p43, v303)
				else
					p43[v302] = v303
				end

				v301[v302] = nil
			else
				local v307 = v301[v302]

				if not v307 then
					local v308 = t17[typeof(v303)]

					if not v308 then
						error("unsupported type: " .. typeof(v303), 2)
					end

					v307 = v308.springType(n23, n24, v305, v303, v308)
					v301[v302] = v307
				end

				v307:setGoal(v303)
				v307:setDampingRatio(n23)
				v307:setFrequency(n24)
			end
		end

		if not next(v301) then
			v300[p43] = nil
		end
	end,
	stop = function(p44, s5: string?)
		if not ("Instance"):find((typeof(p44))) then
			error(`bad argument #{ 1 } to spr.stop (Instance expected, got { typeof(p44) })`, 3)
		end

		if not ("string|nil"):find((typeof(s5))) then
			error(`bad argument #{ 2 } to spr.stop (string|nil expected, got { typeof(s5) })`, 3)
		end

		if s5 then
			local v311 = t19[p44] or t20[p44]

			if v311 then
				v311[s5] = nil

				return
			end
		else
			t19[p44] = nil
			t20[p44] = nil
		end
	end,
	completed = function(p45, p46: ((...any) -> ...any))
		if not ("Instance"):find((typeof(p45))) then
			error(`bad argument #{ 1 } to spr.completed (Instance expected, got { typeof(p45) })`, 3)
		end

		if not ("function"):find((typeof(p46))) then
			error(`bad argument #{ 2 } to spr.completed (function expected, got { typeof(p46) })`, 3)
		end

		local v314 = t21[p45]

		if v314 then
			table.insert(v314, p46)

			return
		end

		t21[p45] = { p46 }
	end
}

return table.freeze(t23)
