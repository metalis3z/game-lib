-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toPound = function(p1) --[[ toPound | Line: 65 ]]
		return p1 * 2.20462
	end,
	toOunce = function(p1) --[[ toOunce | Line: 68 ]]
		return p1 * 35.27392
	end,
	toStone = function(p1) --[[ toStone | Line: 71 ]]
		return p1 * 30.864679999999996
	end,
	toTon = function(p1) --[[ toTon | Line: 74 ]]
		return p1 * 0.00110231
	end,
	toKiloton = function(p1) --[[ toKiloton | Line: 77 ]]
		return p1 * 1.10231e-6
	end,
	toMegaton = function(p1) --[[ toMegaton | Line: 80 ]]
		return p1 * 1.10231e-9
	end,
	toGram = function(p1) --[[ toGram | Line: 83 ]]
		return p1 * 1000
	end,
	toMilligram = function(p1) --[[ toMilligram | Line: 86 ]]
		return p1 * 1000000
	end,
	toTonne = function(p1) --[[ toTonne | Line: 89 ]]
		return p1 * 0.001
	end,
	toKilotonne = function(p1) --[[ toKilotonne | Line: 92 ]]
		return p1 * 1e-6
	end,
	toMegatonne = function(p1) --[[ toMegatonne | Line: 95 ]]
		return p1 * 9.999999999999999e-10
	end
}
local t2 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 100 ]]
		return p1 / 35.27392
	end
}

function t2.toPound(p1) --[[ toPound | Line: 103 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPound(t2.toKilogram(p1))
end
function t2.toStone(p1) --[[ toStone | Line: 106 | Upvalues: t (copy), t2 (copy) ]]
	return t.toStone(t2.toKilogram(p1))
end
function t2.toTon(p1) --[[ toTon | Line: 109 | Upvalues: t (copy), t2 (copy) ]]
	return t.toTon(t2.toKilogram(p1))
end
function t2.toKiloton(p1) --[[ toKiloton | Line: 112 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKiloton(t2.toKilogram(p1))
end
function t2.toMegaton(p1) --[[ toMegaton | Line: 115 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMegaton(t2.toKilogram(p1))
end
function t2.toGram(p1) --[[ toGram | Line: 118 | Upvalues: t (copy), t2 (copy) ]]
	return t.toGram(t2.toKilogram(p1))
end
function t2.toMilligram(p1) --[[ toMilligram | Line: 121 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMilligram(t2.toKilogram(p1))
end
function t2.toTonne(p1) --[[ toTonne | Line: 124 | Upvalues: t (copy), t2 (copy) ]]
	return t.toTonne(t2.toKilogram(p1))
end
function t2.toKilotonne(p1) --[[ toKilotonne | Line: 127 | Upvalues: t (copy), t2 (copy) ]]
	return t.toKilotonne(t2.toKilogram(p1))
end
function t2.toMegatonne(p1) --[[ toMegatonne | Line: 130 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMegatonne(t2.toKilogram(p1))
end

local t3 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 135 ]]
		return p1 / 2.20462
	end
}

function t3.toTon(p1) --[[ toTon | Line: 138 | Upvalues: t (copy), t3 (copy) ]]
	return t.toTon(t3.toKilogram(p1))
end
function t3.toOunce(p1) --[[ toOunce | Line: 141 | Upvalues: t (copy), t3 (copy) ]]
	return t.toOunce(t3.toKilogram(p1))
end
function t3.toStone(p1) --[[ toStone | Line: 144 | Upvalues: t (copy), t3 (copy) ]]
	return t.toStone(t3.toKilogram(p1))
end
function t3.toKiloton(p1) --[[ toKiloton | Line: 147 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKiloton(t3.toKilogram(p1))
end
function t3.toMegaton(p1) --[[ toMegaton | Line: 150 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMegaton(t3.toKilogram(p1))
end
function t3.toGram(p1) --[[ toGram | Line: 153 | Upvalues: t (copy), t3 (copy) ]]
	return t.toGram(t3.toKilogram(p1))
end
function t3.toMilligram(p1) --[[ toMilligram | Line: 156 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMilligram(t3.toKilogram(p1))
end
function t3.toTonne(p1) --[[ toTonne | Line: 159 | Upvalues: t (copy), t3 (copy) ]]
	return t.toTonne(t3.toKilogram(p1))
end
function t3.toKilotonne(p1) --[[ toKilotonne | Line: 162 | Upvalues: t (copy), t3 (copy) ]]
	return t.toKilotonne(t3.toKilogram(p1))
end
function t3.toMegatonne(p1) --[[ toMegatonne | Line: 165 | Upvalues: t (copy), t3 (copy) ]]
	return t.toMegatonne(t3.toKilogram(p1))
end

local t4 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 170 ]]
		return p1 / 2.20462
	end
}

function t4.toTon(p1) --[[ toTon | Line: 173 | Upvalues: t (copy), t4 (copy) ]]
	return t.toTon(t4.toKilogram(p1))
end
function t4.toOunce(p1) --[[ toOunce | Line: 176 | Upvalues: t (copy), t4 (copy) ]]
	return t.toOunce(t4.toKilogram(p1))
end
function t4.toPound(p1) --[[ toPound | Line: 179 | Upvalues: t (copy), t4 (copy) ]]
	return t.toPound(t4.toKilogram(p1))
end
function t4.toKiloton(p1) --[[ toKiloton | Line: 182 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKiloton(t4.toKilogram(p1))
end
function t4.toMegaton(p1) --[[ toMegaton | Line: 185 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMegaton(t4.toKilogram(p1))
end
function t4.toGram(p1) --[[ toGram | Line: 188 | Upvalues: t (copy), t4 (copy) ]]
	return t.toGram(t4.toKilogram(p1))
end
function t4.toMilligram(p1) --[[ toMilligram | Line: 191 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMilligram(t4.toKilogram(p1))
end
function t4.toTonne(p1) --[[ toTonne | Line: 194 | Upvalues: t (copy), t4 (copy) ]]
	return t.toTonne(t4.toKilogram(p1))
end
function t4.toKilotonne(p1) --[[ toKilotonne | Line: 197 | Upvalues: t (copy), t4 (copy) ]]
	return t.toKilotonne(t4.toKilogram(p1))
end
function t4.toMegatonne(p1) --[[ toMegatonne | Line: 200 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMegatonne(t4.toKilogram(p1))
end

local t5 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 205 ]]
		return p1 / 0.00110231
	end
}

function t5.toOunce(p1) --[[ toOunce | Line: 208 | Upvalues: t (copy), t5 (copy) ]]
	return t.toOunce(t5.toKilogram(p1))
end
function t5.toPound(p1) --[[ toPound | Line: 211 | Upvalues: t (copy), t5 (copy) ]]
	return t.toPound(t5.toKilogram(p1))
end
function t5.toStone(p1) --[[ toStone | Line: 214 | Upvalues: t (copy), t5 (copy) ]]
	return t.toStone(t5.toKilogram(p1))
end
function t5.toKiloton(p1) --[[ toKiloton | Line: 217 | Upvalues: t (copy), t5 (copy) ]]
	return t.toKiloton(t5.toKilogram(p1))
end
function t5.toMegaton(p1) --[[ toMegaton | Line: 220 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMegaton(t5.toKilogram(p1))
end
function t5.toGram(p1) --[[ toGram | Line: 223 | Upvalues: t (copy), t5 (copy) ]]
	return t.toGram(t5.toKilogram(p1))
end
function t5.toMilligram(p1) --[[ toMilligram | Line: 226 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMilligram(t5.toKilogram(p1))
end
function t5.toTonne(p1) --[[ toTonne | Line: 229 | Upvalues: t (copy), t5 (copy) ]]
	return t.toTonne(t5.toKilogram(p1))
end
function t5.toKilotonne(p1) --[[ toKilotonne | Line: 232 | Upvalues: t (copy), t5 (copy) ]]
	return t.toKilotonne(t5.toKilogram(p1))
end
function t5.toMegatonne(p1) --[[ toMegatonne | Line: 235 | Upvalues: t (copy), t5 (copy) ]]
	return t.toMegatonne(t5.toKilogram(p1))
end

local t6 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 240 ]]
		return p1 / 35.27392
	end
}

function t6.toOunce(p1) --[[ toOunce | Line: 243 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKiloton(t6.toKilogram(p1))
end
function t6.toPound(p1) --[[ toPound | Line: 246 | Upvalues: t (copy), t6 (copy) ]]
	return t.toPound(t6.toKilogram(p1))
end
function t6.toStone(p1) --[[ toStone | Line: 249 | Upvalues: t (copy), t6 (copy) ]]
	return t.toStone(t6.toKilogram(p1))
end
function t6.toTon(p1) --[[ toTon | Line: 252 | Upvalues: t (copy), t6 (copy) ]]
	return t.toTon(t6.toKilogram(p1))
end
function t6.toMegaton(p1) --[[ toMegaton | Line: 255 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMegaton(t6.toKilogram(p1))
end
function t6.toGram(p1) --[[ toGram | Line: 258 | Upvalues: t (copy), t6 (copy) ]]
	return t.toGram(t6.toKilogram(p1))
end
function t6.toMilligram(p1) --[[ toMilligram | Line: 261 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMilligram(t6.toKilogram(p1))
end
function t6.toTonne(p1) --[[ toTonne | Line: 264 | Upvalues: t (copy), t6 (copy) ]]
	return t.toTonne(t6.toKilogram(p1))
end
function t6.toKilotonne(p1) --[[ toKilotonne | Line: 267 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKilotonne(t6.toKilogram(p1))
end
function t6.toMegatonne(p1) --[[ toMegatonne | Line: 270 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMegatonne(t6.toKilogram(p1))
end

local t7 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 275 ]]
		return p1 / 1.10231e-9
	end
}

function t7.toOunce(p1) --[[ toOunce | Line: 278 | Upvalues: t (copy), t7 (copy) ]]
	return t.toOunce(t7.toKilogram(p1))
end
function t7.toPound(p1) --[[ toPound | Line: 281 | Upvalues: t (copy), t7 (copy) ]]
	return t.toPound(t7.toKilogram(p1))
end
function t7.toStone(p1) --[[ toStone | Line: 284 | Upvalues: t (copy), t7 (copy) ]]
	return t.toStone(t7.toKilogram(p1))
end
function t7.toTon(p1) --[[ toTon | Line: 287 | Upvalues: t (copy), t7 (copy) ]]
	return t.toTon(t7.toKilogram(p1))
end
function t7.toKiloton(p1) --[[ toKiloton | Line: 290 | Upvalues: t (copy), t7 (copy) ]]
	return t.toKiloton(t7.toKilogram(p1))
end
function t7.toGram(p1) --[[ toGram | Line: 293 | Upvalues: t (copy), t7 (copy) ]]
	return t.toGram(t7.toKilogram(p1))
end
function t7.toMilligram(p1) --[[ toMilligram | Line: 296 | Upvalues: t (copy), t7 (copy) ]]
	return t.toMilligram(t7.toKilogram(p1))
end
function t7.toTonne(p1) --[[ toTonne | Line: 299 | Upvalues: t (copy), t7 (copy) ]]
	return t.toTonne(t7.toKilogram(p1))
end
function t7.toKilotonne(p1) --[[ toKilotonne | Line: 302 | Upvalues: t (copy), t7 (copy) ]]
	return t.toKilotonne(t7.toKilogram(p1))
end
function t7.toMegatonne(p1) --[[ toMegatonne | Line: 305 | Upvalues: t (copy), t7 (copy) ]]
	return t.toMegatonne(t7.toKilogram(p1))
end

local t8 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 310 ]]
		return p1 / 1000
	end
}

function t8.toOunce(p1) --[[ toOunce | Line: 313 | Upvalues: t (copy), t8 (copy) ]]
	return t.toOunce(t8.toKilogram(p1))
end
function t8.toPound(p1) --[[ toPound | Line: 316 | Upvalues: t (copy), t8 (copy) ]]
	return t.toPound(t8.toKilogram(p1))
end
function t8.toStone(p1) --[[ toStone | Line: 319 | Upvalues: t (copy), t8 (copy) ]]
	return t.toStone(t8.toKilogram(p1))
end
function t8.toTon(p1) --[[ toTon | Line: 322 | Upvalues: t (copy), t8 (copy) ]]
	return t.toTon(t8.toKilogram(p1))
end
function t8.toKiloton(p1) --[[ toKiloton | Line: 325 | Upvalues: t (copy), t8 (copy) ]]
	return t.toKiloton(t8.toKilogram(p1))
end
function t8.toMegaton(p1) --[[ toMegaton | Line: 328 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMegaton(t8.toKilogram(p1))
end
function t8.toMilligram(p1) --[[ toMilligram | Line: 331 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMilligram(t8.toKilogram(p1))
end
function t8.toTonne(p1) --[[ toTonne | Line: 334 | Upvalues: t (copy), t8 (copy) ]]
	return t.toTonne(t8.toKilogram(p1))
end
function t8.toKilotonne(p1) --[[ toKilotonne | Line: 337 | Upvalues: t (copy), t8 (copy) ]]
	return t.toKilotonne(t8.toKilogram(p1))
end
function t8.toMegatonne(p1) --[[ toMegatonne | Line: 340 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMegatonne(t8.toKilogram(p1))
end

local t9 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 345 ]]
		return p1 / 1000000
	end
}

function t9.toOunce(p1) --[[ toOunce | Line: 348 | Upvalues: t (copy), t9 (copy) ]]
	return t.toOunce(t9.toKilogram(p1))
end
function t9.toPound(p1) --[[ toPound | Line: 351 | Upvalues: t (copy), t9 (copy) ]]
	return t.toPound(t9.toKilogram(p1))
end
function t9.toStone(p1) --[[ toStone | Line: 354 | Upvalues: t (copy), t9 (copy) ]]
	return t.toStone(t9.toKilogram(p1))
end
function t9.toTon(p1) --[[ toTon | Line: 357 | Upvalues: t (copy), t9 (copy) ]]
	return t.toTon(t9.toKilogram(p1))
end
function t9.toKiloton(p1) --[[ toKiloton | Line: 360 | Upvalues: t (copy), t9 (copy) ]]
	return t.toKiloton(t9.toKilogram(p1))
end
function t9.toMegaton(p1) --[[ toMegaton | Line: 363 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMegaton(t9.toKilogram(p1))
end
function t9.toGram(p1) --[[ toGram | Line: 366 | Upvalues: t (copy), t9 (copy) ]]
	return t.toGram(t9.toKilogram(p1))
end
function t9.toTonne(p1) --[[ toTonne | Line: 369 | Upvalues: t (copy), t9 (copy) ]]
	return t.toTonne(t9.toKilogram(p1))
end
function t9.toKilotonne(p1) --[[ toKilotonne | Line: 372 | Upvalues: t (copy), t9 (copy) ]]
	return t.toKilotonne(t9.toKilogram(p1))
end
function t9.toMegatonne(p1) --[[ toMegatonne | Line: 375 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMegatonne(t9.toKilogram(p1))
end

local t10 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 380 ]]
		return p1 / 0.001
	end
}

function t10.toOunce(p1) --[[ toOunce | Line: 383 | Upvalues: t (copy), t10 (copy) ]]
	return t.toOunce(t10.toKilogram(p1))
end
function t10.toPound(p1) --[[ toPound | Line: 386 | Upvalues: t (copy), t10 (copy) ]]
	return t.toPound(t10.toKilogram(p1))
end
function t10.toStone(p1) --[[ toStone | Line: 389 | Upvalues: t (copy), t10 (copy) ]]
	return t.toStone(t10.toKilogram(p1))
end
function t10.toTon(p1) --[[ toTon | Line: 392 | Upvalues: t (copy), t10 (copy) ]]
	return t.toTon(t10.toKilogram(p1))
end
function t10.toKiloton(p1) --[[ toKiloton | Line: 395 | Upvalues: t (copy), t10 (copy) ]]
	return t.toKiloton(t10.toKilogram(p1))
end
function t10.toMegaton(p1) --[[ toMegaton | Line: 398 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMegaton(t10.toKilogram(p1))
end
function t10.toGram(p1) --[[ toGram | Line: 401 | Upvalues: t (copy), t10 (copy) ]]
	return t.toGram(t10.toKilogram(p1))
end
function t10.toMilligram(p1) --[[ toMilligram | Line: 404 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMilligram(t10.toKilogram(p1))
end
function t10.toKilotonne(p1) --[[ toKilotonne | Line: 407 | Upvalues: t (copy), t10 (copy) ]]
	return t.toKilotonne(t10.toKilogram(p1))
end
function t10.toMegatonne(p1) --[[ toMegatonne | Line: 410 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMegatonne(t10.toKilogram(p1))
end

local t11 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 415 ]]
		return p1 / 1e-6
	end
}

function t11.toOunce(p1) --[[ toOunce | Line: 418 | Upvalues: t (copy), t11 (copy) ]]
	return t.toOunce(t11.toKilogram(p1))
end
function t11.toPound(p1) --[[ toPound | Line: 421 | Upvalues: t (copy), t11 (copy) ]]
	return t.toPound(t11.toKilogram(p1))
end
function t11.toStone(p1) --[[ toStone | Line: 424 | Upvalues: t (copy), t11 (copy) ]]
	return t.toStone(t11.toKilogram(p1))
end
function t11.toTon(p1) --[[ toTon | Line: 427 | Upvalues: t (copy), t11 (copy) ]]
	return t.toTon(t11.toKilogram(p1))
end
function t11.toKiloton(p1) --[[ toKiloton | Line: 430 | Upvalues: t (copy), t11 (copy) ]]
	return t.toKiloton(t11.toKilogram(p1))
end
function t11.toMegaton(p1) --[[ toMegaton | Line: 433 | Upvalues: t (copy), t11 (copy) ]]
	return t.toMegaton(t11.toKilogram(p1))
end
function t11.toGram(p1) --[[ toGram | Line: 436 | Upvalues: t (copy), t11 (copy) ]]
	return t.toGram(t11.toKilogram(p1))
end
function t11.toMilligram(p1) --[[ toMilligram | Line: 439 | Upvalues: t (copy), t11 (copy) ]]
	return t.toMilligram(t11.toKilogram(p1))
end
function t11.toTonne(p1) --[[ toTonne | Line: 442 | Upvalues: t (copy), t11 (copy) ]]
	return t.toTonne(t11.toKilogram(p1))
end
function t11.toMegatonne(p1) --[[ toMegatonne | Line: 445 | Upvalues: t (copy), t11 (copy) ]]
	return t.toMegatonne(t11.toKilogram(p1))
end

local t12 = {
	toKilogram = function(p1) --[[ toKilogram | Line: 450 ]]
		return p1 / 9.999999999999999e-10
	end
}

function t12.toOunce(p1) --[[ toOunce | Line: 453 | Upvalues: t (copy), t12 (copy) ]]
	return t.toOunce(t12.toKilogram(p1))
end
function t12.toPound(p1) --[[ toPound | Line: 456 | Upvalues: t (copy), t12 (copy) ]]
	return t.toPound(t12.toKilogram(p1))
end
function t12.toStone(p1) --[[ toStone | Line: 459 | Upvalues: t (copy), t12 (copy) ]]
	return t.toStone(t12.toKilogram(p1))
end
function t12.toTon(p1) --[[ toTon | Line: 462 | Upvalues: t (copy), t12 (copy) ]]
	return t.toTon(t12.toKilogram(p1))
end
function t12.toKiloton(p1) --[[ toKiloton | Line: 465 | Upvalues: t (copy), t12 (copy) ]]
	return t.toKiloton(t12.toKilogram(p1))
end
function t12.toMegaton(p1) --[[ toMegaton | Line: 468 | Upvalues: t (copy), t12 (copy) ]]
	return t.toMegaton(t12.toKilogram(p1))
end
function t12.toGram(p1) --[[ toGram | Line: 471 | Upvalues: t (copy), t12 (copy) ]]
	return t.toGram(t12.toKilogram(p1))
end
function t12.toMilligram(p1) --[[ toMilligram | Line: 474 | Upvalues: t (copy), t12 (copy) ]]
	return t.toMilligram(t12.toKilogram(p1))
end
function t12.toTonne(p1) --[[ toTonne | Line: 477 | Upvalues: t (copy), t12 (copy) ]]
	return t.toTonne(t12.toKilogram(p1))
end
function t12.toKilotonne(p1) --[[ toKilotonne | Line: 480 | Upvalues: t (copy), t12 (copy) ]]
	return t.toKilotonne(t12.toKilogram(p1))
end

return {
	Ounce = t2,
	Pound = t3,
	Stone = t4,
	Ton = t5,
	Kiloton = t6,
	Megaton = t7,
	Gram = t8,
	Kilogram = t,
	Milligram = t9,
	Tonne = t10,
	Kilotonne = t11,
	Megatonne = t12
}