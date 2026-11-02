-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toSquareCentimeter = function(p1) --[[ toSquareCentimeter | Line: 54 ]]
		return p1 * 10000
	end,
	toSquareMillimeter = function(p1) --[[ toSquareMillimeter | Line: 57 ]]
		return p1 * 1000000
	end,
	toSquareKilometer = function(p1) --[[ toSquareKilometer | Line: 60 ]]
		return p1 * 1e-6
	end,
	toSquareMile = function(p1) --[[ toSquareMile | Line: 63 ]]
		return p1 * 3.861e-7
	end,
	toSquareYard = function(p1) --[[ toSquareYard | Line: 66 ]]
		return p1 * 1.19599
	end,
	toSquareFeet = function(p1) --[[ toSquareFeet | Line: 69 ]]
		return p1 * 10.7639
	end,
	toSquareInch = function(p1) --[[ toSquareInch | Line: 72 ]]
		return p1 * 1550
	end,
	toHectare = function(p1) --[[ toHectare | Line: 75 ]]
		return p1 * 0.0001
	end,
	toAcre = function(p1) --[[ toAcre | Line: 78 ]]
		return p1 * 0.000247105
	end
}
local t2 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 83 ]]
		return p1 / 10000
	end
}

function t2.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 86 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareMillimeter(t2.toSquareMeter(p1))
end
function t2.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 89 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareKilometer(t2.toSquareMeter(p1))
end
function t2.toSquareMile(p1) --[[ toSquareMile | Line: 92 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareMile(t2.toSquareMeter(p1))
end
function t2.toSquareYard(p1) --[[ toSquareYard | Line: 95 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareYard(t2.toSquareMeter(p1))
end
function t2.toSquareFeet(p1) --[[ toSquareFeet | Line: 98 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareFeet(t2.toSquareMeter(p1))
end
function t2.toSquareInch(p1) --[[ toSquareInch | Line: 101 | Upvalues: t (copy), t2 (copy) ]]
	return t.toSquareInch(t2.toSquareMeter(p1))
end
function t2.toHectare(p1) --[[ toHectare | Line: 104 | Upvalues: t (copy), t2 (copy) ]]
	return t.toHectare(t2.toSquareMeter(p1))
end
function t2.toAcre(p1) --[[ toAcre | Line: 107 | Upvalues: t (copy), t2 (copy) ]]
	return t.toAcre(t2.toSquareMeter(p1))
end

local t3 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 112 ]]
		return p1 / 1000000
	end
}

function t3.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 115 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareCentimeter(t3.toSquareMeter(p1))
end
function t3.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 118 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareKilometer(t3.toSquareMeter(p1))
end
function t3.toSquareMile(p1) --[[ toSquareMile | Line: 121 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareMile(t3.toSquareMeter(p1))
end
function t3.toSquareYard(p1) --[[ toSquareYard | Line: 124 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareYard(t3.toSquareMeter(p1))
end
function t3.toSquareFeet(p1) --[[ toSquareFeet | Line: 127 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareFeet(t3.toSquareMeter(p1))
end
function t3.toSquareInch(p1) --[[ toSquareInch | Line: 130 | Upvalues: t (copy), t3 (copy) ]]
	return t.toSquareInch(t3.toSquareMeter(p1))
end
function t3.toHectare(p1) --[[ toHectare | Line: 133 | Upvalues: t (copy), t3 (copy) ]]
	return t.toHectare(t3.toSquareMeter(p1))
end
function t3.toAcre(p1) --[[ toAcre | Line: 136 | Upvalues: t (copy), t3 (copy) ]]
	return t.toAcre(t3.toSquareMeter(p1))
end

local t4 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 141 ]]
		return p1 / 10.7639
	end
}

function t4.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 144 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareMillimeter(t4.toSquareMeter(p1))
end
function t4.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 147 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareKilometer(t4.toSquareMeter(p1))
end
function t4.toSquareMile(p1) --[[ toSquareMile | Line: 150 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareMile(t4.toSquareMeter(p1))
end
function t4.toSquareYard(p1) --[[ toSquareYard | Line: 153 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareYard(t4.toSquareMeter(p1))
end
function t4.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 156 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareCentimeter(t4.toSquareMeter(p1))
end
function t4.toSquareInch(p1) --[[ toSquareInch | Line: 159 | Upvalues: t (copy), t4 (copy) ]]
	return t.toSquareInch(t4.toSquareMeter(p1))
end
function t4.toHectare(p1) --[[ toHectare | Line: 162 | Upvalues: t (copy), t4 (copy) ]]
	return t.toHectare(t4.toSquareMeter(p1))
end
function t4.toAcre(p1) --[[ toAcre | Line: 165 | Upvalues: t (copy), t4 (copy) ]]
	return t.toAcre(t4.toSquareMeter(p1))
end

local t5 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 170 ]]
		return p1 / 1550
	end
}

function t5.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 173 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareMillimeter(t5.toSquareMeter(p1))
end
function t5.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 176 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareKilometer(t5.toSquareMeter(p1))
end
function t5.toSquareMile(p1) --[[ toSquareMile | Line: 179 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareMile(t5.toSquareMeter(p1))
end
function t5.toSquareYard(p1) --[[ toSquareYard | Line: 182 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareYard(t5.toSquareMeter(p1))
end
function t5.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 185 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareCentimeter(t5.toSquareMeter(p1))
end
function t5.toSquareInch(p1) --[[ toSquareInch | Line: 188 | Upvalues: t (copy), t5 (copy) ]]
	return t.toSquareInch(t5.toSquareMeter(p1))
end
function t5.toHectare(p1) --[[ toHectare | Line: 191 | Upvalues: t (copy), t5 (copy) ]]
	return t.toHectare(t5.toSquareMeter(p1))
end
function t5.toAcre(p1) --[[ toAcre | Line: 194 | Upvalues: t (copy), t5 (copy) ]]
	return t.toAcre(t5.toSquareMeter(p1))
end

local t6 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 199 ]]
		return p1 / 10000
	end
}

function t6.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 202 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareMillimeter(t6.toSquareMeter(p1))
end
function t6.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 205 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareKilometer(t6.toSquareMeter(p1))
end
function t6.toSquareMile(p1) --[[ toSquareMile | Line: 208 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareMile(t6.toSquareMeter(p1))
end
function t6.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 211 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareCentimeter(t6.toSquareMeter(p1))
end
function t6.toSquareFeet(p1) --[[ toSquareFeet | Line: 214 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareFeet(t6.toSquareMeter(p1))
end
function t6.toSquareInch(p1) --[[ toSquareInch | Line: 217 | Upvalues: t (copy), t6 (copy) ]]
	return t.toSquareInch(t6.toSquareMeter(p1))
end
function t6.toHectare(p1) --[[ toHectare | Line: 220 | Upvalues: t (copy), t6 (copy) ]]
	return t.toHectare(t6.toSquareMeter(p1))
end
function t6.toAcre(p1) --[[ toAcre | Line: 223 | Upvalues: t (copy), t6 (copy) ]]
	return t.toAcre(t6.toSquareMeter(p1))
end

local t7 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 228 ]]
		return p1 / 1e-6
	end
}

function t7.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 231 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareMillimeter(t7.toSquareMeter(p1))
end
function t7.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 234 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareCentimeter(t7.toSquareMeter(p1))
end
function t7.toSquareMile(p1) --[[ toSquareMile | Line: 237 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareMile(t7.toSquareMeter(p1))
end
function t7.toSquareYard(p1) --[[ toSquareYard | Line: 240 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareYard(t7.toSquareMeter(p1))
end
function t7.toSquareFeet(p1) --[[ toSquareFeet | Line: 243 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareFeet(t7.toSquareMeter(p1))
end
function t7.toSquareInch(p1) --[[ toSquareInch | Line: 246 | Upvalues: t (copy), t7 (copy) ]]
	return t.toSquareInch(t7.toSquareMeter(p1))
end
function t7.toHectare(p1) --[[ toHectare | Line: 249 | Upvalues: t (copy), t7 (copy) ]]
	return t.toHectare(t7.toSquareMeter(p1))
end
function t7.toAcre(p1) --[[ toAcre | Line: 252 | Upvalues: t (copy), t7 (copy) ]]
	return t.toAcre(t7.toSquareMeter(p1))
end

local t8 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 257 ]]
		return p1 / 10000
	end
}

function t8.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 260 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareMillimeter(t8.toSquareMeter(p1))
end
function t8.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 263 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareKilometer(t8.toSquareMeter(p1))
end
function t8.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 266 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareCentimeter(t8.toSquareMeter(p1))
end
function t8.toSquareYard(p1) --[[ toSquareYard | Line: 269 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareYard(t8.toSquareMeter(p1))
end
function t8.toSquareFeet(p1) --[[ toSquareFeet | Line: 272 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareFeet(t8.toSquareMeter(p1))
end
function t8.toSquareInch(p1) --[[ toSquareInch | Line: 275 | Upvalues: t (copy), t8 (copy) ]]
	return t.toSquareInch(t8.toSquareMeter(p1))
end
function t8.toHectare(p1) --[[ toHectare | Line: 278 | Upvalues: t (copy), t8 (copy) ]]
	return t.toHectare(t8.toSquareMeter(p1))
end
function t8.toAcre(p1) --[[ toAcre | Line: 281 | Upvalues: t (copy), t8 (copy) ]]
	return t.toAcre(t8.toSquareMeter(p1))
end

local t9 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 286 ]]
		return p1 / 0.000247105
	end
}

function t9.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 289 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareMillimeter(t9.toSquareMeter(p1))
end
function t9.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 292 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareKilometer(t9.toSquareMeter(p1))
end
function t9.toSquareMile(p1) --[[ toSquareMile | Line: 295 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareMile(t9.toSquareMeter(p1))
end
function t9.toSquareYard(p1) --[[ toSquareYard | Line: 298 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareYard(t9.toSquareMeter(p1))
end
function t9.toSquareFeet(p1) --[[ toSquareFeet | Line: 301 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareFeet(t9.toSquareMeter(p1))
end
function t9.toSquareInch(p1) --[[ toSquareInch | Line: 304 | Upvalues: t (copy), t9 (copy) ]]
	return t.toSquareInch(t9.toSquareMeter(p1))
end
function t9.toHectare(p1) --[[ toHectare | Line: 307 | Upvalues: t (copy), t9 (copy) ]]
	return t.toHectare(t9.toSquareMeter(p1))
end
function t9.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 310 | Upvalues: t (copy), t9 (copy) ]]
	return t.toAcre(t9.toSquareMeter(p1))
end

local t10 = {
	toSquareMeter = function(p1) --[[ toSquareMeter | Line: 315 ]]
		return p1 / 0.0001
	end
}

function t10.toSquareMillimeter(p1) --[[ toSquareMillimeter | Line: 318 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareMillimeter(t10.toSquareMeter(p1))
end
function t10.toSquareKilometer(p1) --[[ toSquareKilometer | Line: 321 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareKilometer(t10.toSquareMeter(p1))
end
function t10.toSquareMile(p1) --[[ toSquareMile | Line: 324 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareMile(t10.toSquareMeter(p1))
end
function t10.toSquareYard(p1) --[[ toSquareYard | Line: 327 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareYard(t10.toSquareMeter(p1))
end
function t10.toSquareFeet(p1) --[[ toSquareFeet | Line: 330 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareFeet(t10.toSquareMeter(p1))
end
function t10.toSquareInch(p1) --[[ toSquareInch | Line: 333 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareInch(t10.toSquareMeter(p1))
end
function t10.toSquareCentimeter(p1) --[[ toSquareCentimeter | Line: 336 | Upvalues: t (copy), t10 (copy) ]]
	return t.toSquareCentimeter(t10.toSquareMeter(p1))
end
function t10.toAcre(p1) --[[ toAcre | Line: 339 | Upvalues: t (copy), t10 (copy) ]]
	return t.toAcre(t10.toSquareMeter(p1))
end

return {
	SquareMeter = t,
	SquareCentimeter = t2,
	SquareMillimeter = t3,
	SquareFeet = t4,
	SquareInch = t5,
	SquareYard = t6,
	SquareKilometer = t7,
	SquareMile = t8,
	Acre = t9,
	Hectare = t10
}