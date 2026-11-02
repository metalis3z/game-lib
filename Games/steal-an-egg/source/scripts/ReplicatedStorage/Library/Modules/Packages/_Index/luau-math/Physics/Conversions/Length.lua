-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toKilometer = function(p1) --[[ toKilometer | Line: 78 ]]
		return p1 / 1000
	end
}

function t.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 81 | Upvalues: t (copy) ]]
	return t.toKilometer(p1) / 149597870.7
end
function t.toLightYear(p1) --[[ toLightYear | Line: 84 | Upvalues: t (copy) ]]
	return t.toAstronomicalUnit(p1) / 63241.1
end
function t.toLightSecond(p1) --[[ toLightSecond | Line: 87 | Upvalues: t (copy) ]]
	return t.toKilometer(p1) / 299792.6369041473
end
function t.toLeague(p1) --[[ toLeague | Line: 90 ]]
	return p1 / 5556
end
function t.toMile(p1) --[[ toMile | Line: 93 | Upvalues: t (copy) ]]
	return t.toKilometer(p1) / 1.60934
end
function t.toFeet(p1) --[[ toFeet | Line: 96 ]]
	return p1 * 3.28
end
function t.toCentimeter(p1) --[[ toCentimeter | Line: 99 ]]
	return p1 * 100
end
function t.toMillimeter(p1) --[[ toMillimeter | Line: 102 ]]
	return p1 * 1000
end
function t.toMicrometer(p1) --[[ toMicrometer | Line: 105 | Upvalues: t (copy) ]]
	return t.toMillimeter(p1) * 1000
end
function t.toNanometer(p1) --[[ toNanometer | Line: 108 | Upvalues: t (copy) ]]
	return t.toNanometer(p1) * 1000
end
function t.toPicometer(p1) --[[ toPicometer | Line: 111 | Upvalues: t (copy) ]]
	return t.toNanometer(p1) * 1000
end
function t.toPlanck(p1) --[[ toPlanck | Line: 114 | Upvalues: t (copy) ]]
	return t.toPicometer(p1) * 1.6000000000000002e-23
end

local t2 = {
	toMeter = function(p1) --[[ toMeter | Line: 119 ]]
		return p1 * 1000
	end
}

function t2.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 122 | Upvalues: t (copy), t2 (copy) ]]
	return t.toAstronomicalUnit(t2.toMeter(p1))
end
function t2.toLightYear(p1) --[[ toLightYear | Line: 125 | Upvalues: t (copy), t2 (copy) ]]
	return t.toLightYear(t2.toMeter(p1))
end
function t2.toLightSecond(p1) --[[ toLightSecond | Line: 128 | Upvalues: t (copy), t2 (copy) ]]
	return t.toLightSecond(t2.toMeter(p1))
end
function t2.toLeague(p1) --[[ toLeague | Line: 131 | Upvalues: t (copy), t2 (copy) ]]
	return t.toLeague(t2.toMeter(p1))
end
function t2.toMile(p1) --[[ toMile | Line: 134 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMile(t2.toMeter(p1))
end
function t2.toFeet(p1) --[[ toFeet | Line: 137 | Upvalues: t (copy), t2 (copy) ]]
	return t.toFeet(t2.toMeter(p1))
end
function t2.toCentimeter(p1) --[[ toCentimeter | Line: 140 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCentimeter(t2.toMeter(p1))
end
function t2.toMillimeter(p1) --[[ toMillimeter | Line: 143 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMillimeter(t2.toMeter(p1))
end
function t2.toMicrometer(p1) --[[ toMicrometer | Line: 146 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMicrometer(t2.toMeter(p1))
end
function t2.toNanometer(p1) --[[ toNanometer | Line: 149 | Upvalues: t (copy), t2 (copy) ]]
	return t.toNanometer(t2.toMeter(p1))
end
function t2.toPicometer(p1) --[[ toPicometer | Line: 152 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPicometer(t2.toMeter(p1))
end
function t2.toPlanck(p1) --[[ toPlanck | Line: 155 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPlanck(t2.toMeter(p1))
end

local t3 = {
	toKilometer = function(p1) --[[ toKilometer | Line: 160 ]]
		return p1 * 149597870.7
	end
}

function t3.toMeter(p1) --[[ toMeter | Line: 163 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMeter(t3.toKilometer(p1))
end
function t3.toLightYear(p1) --[[ toLightYear | Line: 166 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toLightYear(t3.toKilometer(p1))
end
function t3.toLightSecond(p1) --[[ toLightSecond | Line: 169 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toLightSecond(t3.toKilometer(p1))
end
function t3.toLeague(p1) --[[ toLeague | Line: 172 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toLeague(t3.toKilometer(p1))
end
function t3.toMile(p1) --[[ toMile | Line: 175 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMile(t3.toKilometer(p1))
end
function t3.toFeet(p1) --[[ toFeet | Line: 178 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toFeet(t3.toKilometer(p1))
end
function t3.toCentimeter(p1) --[[ toCentimeter | Line: 181 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toCentimeter(t3.toKilometer(p1))
end
function t3.toMillimeter(p1) --[[ toMillimeter | Line: 184 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMillimeter(t3.toKilometer(p1))
end
function t3.toMicrometer(p1) --[[ toMicrometer | Line: 187 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMicrometer(t3.toKilometer(p1))
end
function t3.toNanometer(p1) --[[ toNanometer | Line: 190 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toNanometer(t3.toKilometer(p1))
end
function t3.toPicometer(p1) --[[ toPicometer | Line: 193 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toPicometer(t3.toKilometer(p1))
end
function t3.toPlanck(p1) --[[ toPlanck | Line: 196 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toPlanck(t3.toKilometer(p1))
end

local t4 = {
	toKilometer = function(p1) --[[ toKilometer | Line: 201 | Upvalues: t3 (copy) ]]
		return t3.toKilometer(p1 * 63241.1)
	end
}

function t4.toMeter(p1) --[[ toMeter | Line: 204 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toMeter(t4.toKilometer(p1))
end
function t4.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 207 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toAstronomicalUnit(t4.toKilometer(p1))
end
function t4.toLightSecond(p1) --[[ toLightSecond | Line: 210 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toLightSecond(t4.toKilometer(p1))
end
function t4.toLeague(p1) --[[ toLeague | Line: 213 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toLeague(t4.toKilometer(p1))
end
function t4.toMile(p1) --[[ toMile | Line: 216 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toMile(t4.toKilometer(p1))
end
function t4.toFeet(p1) --[[ toFeet | Line: 219 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toFeet(t4.toKilometer(p1))
end
function t4.toCentimeter(p1) --[[ toCentimeter | Line: 222 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toCentimeter(t4.toKilometer(p1))
end
function t4.toMillimeter(p1) --[[ toMillimeter | Line: 225 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toMillimeter(t4.toKilometer(p1))
end
function t4.toMicrometer(p1) --[[ toMicrometer | Line: 228 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toMicrometer(t4.toKilometer(p1))
end
function t4.toNanometer(p1) --[[ toNanometer | Line: 231 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toNanometer(t4.toKilometer(p1))
end
function t4.toPicometer(p1) --[[ toPicometer | Line: 234 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toPicometer(t4.toKilometer(p1))
end
function t4.toPlanck(p1) --[[ toPlanck | Line: 237 | Upvalues: t2 (copy), t4 (copy) ]]
	return t2.toPlanck(t4.toKilometer(p1))
end

local t5 = {
	toKilometer = function(p1) --[[ toKilometer | Line: 242 ]]
		return p1 * 299792.6369041473
	end
}

function t5.toMeter(p1) --[[ toMeter | Line: 245 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toMeter(t5.toKilometer(p1))
end
function t5.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 248 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toAstronomicalUnit(t5.toKilometer(p1))
end
function t5.toLightYear(p1) --[[ toLightYear | Line: 251 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toLightYear(t5.toKilometer(p1))
end
function t5.toLeague(p1) --[[ toLeague | Line: 254 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toLeague(t5.toKilometer(p1))
end
function t5.toMile(p1) --[[ toMile | Line: 257 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toMile(t5.toKilometer(p1))
end
function t5.toFeet(p1) --[[ toFeet | Line: 260 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toFeet(t5.toKilometer(p1))
end
function t5.toCentimeter(p1) --[[ toCentimeter | Line: 263 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toCentimeter(t5.toKilometer(p1))
end
function t5.toMillimeter(p1) --[[ toMillimeter | Line: 266 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toMillimeter(t5.toKilometer(p1))
end
function t5.toMicrometer(p1) --[[ toMicrometer | Line: 269 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toMicrometer(t5.toKilometer(p1))
end
function t5.toNanometer(p1) --[[ toNanometer | Line: 272 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toNanometer(t5.toKilometer(p1))
end
function t5.toPicometer(p1) --[[ toPicometer | Line: 275 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toPicometer(t5.toKilometer(p1))
end
function t5.toPlanck(p1) --[[ toPlanck | Line: 278 | Upvalues: t2 (copy), t5 (copy) ]]
	return t2.toPlanck(t5.toKilometer(p1))
end

local t6 = {
	toMeter = function(p1) --[[ toMeter | Line: 283 ]]
		return p1 * 5556
	end
}

function t6.toKilometer(p1) --[[ toKilometer | Line: 286 | Upvalues: t (copy), t6 (copy) ]]
	return t.toKilometer(t6.toMeter(p1))
end
function t6.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 289 | Upvalues: t (copy), t6 (copy) ]]
	return t.toAstronomicalUnit(t6.toMeter(p1))
end
function t6.toLightYear(p1) --[[ toLightYear | Line: 292 | Upvalues: t (copy), t6 (copy) ]]
	return t.toLightYear(t6.toMeter(p1))
end
function t6.toLightSecond(p1) --[[ toLightSecond | Line: 295 | Upvalues: t (copy), t6 (copy) ]]
	return t.toLightSecond(t6.toMeter(p1))
end
function t6.toMile(p1) --[[ toMile | Line: 298 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMile(t6.toMeter(p1))
end
function t6.toFeet(p1) --[[ toFeet | Line: 301 | Upvalues: t (copy), t6 (copy) ]]
	return t.toFeet(t6.toMeter(p1))
end
function t6.toCentimeter(p1) --[[ toCentimeter | Line: 304 | Upvalues: t (copy), t6 (copy) ]]
	return t.toCentimeter(t6.toMeter(p1))
end
function t6.toMillimeter(p1) --[[ toMillimeter | Line: 307 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMillimeter(t6.toMeter(p1))
end
function t6.toMicrometer(p1) --[[ toMicrometer | Line: 310 | Upvalues: t (copy), t6 (copy) ]]
	return t.toMicrometer(t6.toMeter(p1))
end
function t6.toNanometer(p1) --[[ toNanometer | Line: 313 | Upvalues: t (copy), t6 (copy) ]]
	return t.toNanometer(t6.toMeter(p1))
end
function t6.toPicometer(p1) --[[ toPicometer | Line: 316 | Upvalues: t (copy), t6 (copy) ]]
	return t.toPicometer(t6.toMeter(p1))
end
function t6.toPlanck(p1) --[[ toPlanck | Line: 319 | Upvalues: t (copy), t6 (copy) ]]
	return t.toPlanck(t6.toMeter(p1))
end

local t7 = {
	toKilometer = function(p1) --[[ toKilometer | Line: 324 ]]
		return p1 * 1.60934
	end
}

function t7.toMeter(p1) --[[ toMeter | Line: 327 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toMeter(t7.toKilometer(p1))
end
function t7.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 330 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toAstronomicalUnit(t7.toKilometer(p1))
end
function t7.toLightYear(p1) --[[ toLightYear | Line: 333 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toLightYear(t7.toKilometer(p1))
end
function t7.toLightSecond(p1) --[[ toLightSecond | Line: 336 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toLightSecond(t7.toKilometer(p1))
end
function t7.toLeague(p1) --[[ toLeague | Line: 339 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toLeague(t7.toKilometer(p1))
end
function t7.toFeet(p1) --[[ toFeet | Line: 342 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toFeet(t7.toKilometer(p1))
end
function t7.toCentimeter(p1) --[[ toCentimeter | Line: 345 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toCentimeter(t7.toKilometer(p1))
end
function t7.toMillimeter(p1) --[[ toMillimeter | Line: 348 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toMillimeter(t7.toKilometer(p1))
end
function t7.toMicrometer(p1) --[[ toMicrometer | Line: 351 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toMicrometer(t7.toKilometer(p1))
end
function t7.toNanometer(p1) --[[ toNanometer | Line: 354 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toNanometer(t7.toKilometer(p1))
end
function t7.toPicometer(p1) --[[ toPicometer | Line: 357 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toPicometer(t7.toKilometer(p1))
end
function t7.toPlanck(p1) --[[ toPlanck | Line: 360 | Upvalues: t2 (copy), t7 (copy) ]]
	return t2.toPlanck(t7.toKilometer(p1))
end

local t8 = {
	toMeter = function(p1) --[[ toMeter | Line: 365 ]]
		return p1 / 3.28
	end
}

function t8.toKilometer(p1) --[[ toKilometer | Line: 368 | Upvalues: t (copy), t8 (copy) ]]
	return t.toKilometer(t8.toMeter(p1))
end
function t8.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 371 | Upvalues: t (copy), t8 (copy) ]]
	return t.toAstronomicalUnit(t8.toMeter(p1))
end
function t8.toLightYear(p1) --[[ toLightYear | Line: 374 | Upvalues: t (copy), t8 (copy) ]]
	return t.toLightYear(t8.toMeter(p1))
end
function t8.toLightSecond(p1) --[[ toLightSecond | Line: 377 | Upvalues: t (copy), t8 (copy) ]]
	return t.toLightSecond(t8.toMeter(p1))
end
function t8.toLeague(p1) --[[ toLeague | Line: 380 | Upvalues: t (copy), t8 (copy) ]]
	return t.toLeague(t8.toMeter(p1))
end
function t8.toMile(p1) --[[ toMile | Line: 383 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMile(t8.toMeter(p1))
end
function t8.toCentimeter(p1) --[[ toCentimeter | Line: 386 | Upvalues: t (copy), t8 (copy) ]]
	return t.toCentimeter(t8.toMeter(p1))
end
function t8.toMillimeter(p1) --[[ toMillimeter | Line: 389 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMillimeter(t8.toMeter(p1))
end
function t8.toMicrometer(p1) --[[ toMicrometer | Line: 392 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMicrometer(t8.toMeter(p1))
end
function t8.toNanometer(p1) --[[ toNanometer | Line: 395 | Upvalues: t (copy), t8 (copy) ]]
	return t.toNanometer(t8.toMeter(p1))
end
function t8.toPicometer(p1) --[[ toPicometer | Line: 398 | Upvalues: t (copy), t8 (copy) ]]
	return t.toPicometer(t8.toMeter(p1))
end
function t8.toPlanck(p1) --[[ toPlanck | Line: 401 | Upvalues: t (copy), t8 (copy) ]]
	return t.toPlanck(t8.toMeter(p1))
end

local t9 = {
	toMeter = function(p1) --[[ toMeter | Line: 406 ]]
		return p1 / 100
	end
}

function t9.toKilometer(p1) --[[ toKilometer | Line: 409 | Upvalues: t (copy), t9 (copy) ]]
	return t.toKilometer(t9.toMeter(p1))
end
function t9.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 412 | Upvalues: t (copy), t9 (copy) ]]
	return t.toAstronomicalUnit(t9.toMeter(p1))
end
function t9.toLightYear(p1) --[[ toLightYear | Line: 415 | Upvalues: t (copy), t9 (copy) ]]
	return t.toLightYear(t9.toMeter(p1))
end
function t9.toLightSecond(p1) --[[ toLightSecond | Line: 418 | Upvalues: t (copy), t9 (copy) ]]
	return t.toLightSecond(t9.toMeter(p1))
end
function t9.toLeague(p1) --[[ toLeague | Line: 421 | Upvalues: t (copy), t9 (copy) ]]
	return t.toLeague(t9.toMeter(p1))
end
function t9.toMile(p1) --[[ toMile | Line: 424 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMile(t9.toMeter(p1))
end
function t9.toFeet(p1) --[[ toFeet | Line: 427 | Upvalues: t (copy), t9 (copy) ]]
	return t.toFeet(t9.toMeter(p1))
end
function t9.toMillimeter(p1) --[[ toMillimeter | Line: 430 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMillimeter(t9.toMeter(p1))
end
function t9.toMicrometer(p1) --[[ toMicrometer | Line: 433 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMicrometer(t9.toMeter(p1))
end
function t9.toNanometer(p1) --[[ toNanometer | Line: 436 | Upvalues: t (copy), t9 (copy) ]]
	return t.toNanometer(t9.toMeter(p1))
end
function t9.toPicometer(p1) --[[ toPicometer | Line: 439 | Upvalues: t (copy), t9 (copy) ]]
	return t.toPicometer(t9.toMeter(p1))
end
function t9.toPlanck(p1) --[[ toPlanck | Line: 442 | Upvalues: t (copy), t9 (copy) ]]
	return t.toPlanck(t9.toMeter(p1))
end

local t10 = {
	toMeter = function(p1) --[[ toMeter | Line: 447 | Upvalues: t9 (copy) ]]
		return t9.toMeter(p1 / 1000)
	end
}

function t10.toKilometer(p1) --[[ toKilometer | Line: 450 | Upvalues: t (copy), t10 (copy) ]]
	return t.toKilometer(t10.toMeter(p1))
end
function t10.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 453 | Upvalues: t (copy), t10 (copy) ]]
	return t.toAstronomicalUnit(t10.toMeter(p1))
end
function t10.toLightYear(p1) --[[ toLightYear | Line: 456 | Upvalues: t (copy), t10 (copy) ]]
	return t.toLightYear(t10.toMeter(p1))
end
function t10.toLightSecond(p1) --[[ toLightSecond | Line: 459 | Upvalues: t (copy), t10 (copy) ]]
	return t.toLightSecond(t10.toMeter(p1))
end
function t10.toLeague(p1) --[[ toLeague | Line: 462 | Upvalues: t (copy), t10 (copy) ]]
	return t.toLeague(t10.toMeter(p1))
end
function t10.toMile(p1) --[[ toMile | Line: 465 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMile(t10.toMeter(p1))
end
function t10.toFeet(p1) --[[ toFeet | Line: 468 | Upvalues: t (copy), t10 (copy) ]]
	return t.toFeet(t10.toMeter(p1))
end
function t10.toCentimeter(p1) --[[ toCentimeter | Line: 471 | Upvalues: t (copy), t10 (copy) ]]
	return t.toCentimeter(t10.toMeter(p1))
end
function t10.toMicrometer(p1) --[[ toMicrometer | Line: 474 | Upvalues: t (copy), t10 (copy) ]]
	return t.toMicrometer(t10.toMeter(p1))
end
function t10.toNanometer(p1) --[[ toNanometer | Line: 477 | Upvalues: t (copy), t10 (copy) ]]
	return t.toNanometer(t10.toMeter(p1))
end
function t10.toPicometer(p1) --[[ toPicometer | Line: 480 | Upvalues: t (copy), t10 (copy) ]]
	return t.toPicometer(t10.toMeter(p1))
end
function t10.toPlanck(p1) --[[ toPlanck | Line: 483 | Upvalues: t (copy), t10 (copy) ]]
	return t.toPlanck(t10.toMeter(p1))
end

local t11 = {
	toMillimeter = function(p1) --[[ toMillimeter | Line: 488 ]]
		return p1 / 1000
	end
}

function t11.toMeter(p1) --[[ toMeter | Line: 491 | Upvalues: t10 (copy), t11 (copy) ]]
	return t10.toMeter(t11.toMillimeter(p1))
end
function t11.toKilometer(p1) --[[ toKilometer | Line: 494 | Upvalues: t (copy), t11 (copy) ]]
	return t.toKilometer(t11.toMeter(p1))
end
function t11.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 497 | Upvalues: t (copy), t11 (copy) ]]
	return t.toAstronomicalUnit(t11.toMeter(p1))
end
function t11.toLightYear(p1) --[[ toLightYear | Line: 500 | Upvalues: t (copy), t11 (copy) ]]
	return t.toLightYear(t11.toMeter(p1))
end
function t11.toLightSecond(p1) --[[ toLightSecond | Line: 503 | Upvalues: t (copy), t11 (copy) ]]
	return t.toLightSecond(t11.toMeter(p1))
end
function t11.toLeague(p1) --[[ toLeague | Line: 506 | Upvalues: t (copy), t11 (copy) ]]
	return t.toLeague(t11.toMeter(p1))
end
function t11.toMile(p1) --[[ toMile | Line: 509 | Upvalues: t (copy), t11 (copy) ]]
	return t.toMile(t11.toMeter(p1))
end
function t11.toFeet(p1) --[[ toFeet | Line: 512 | Upvalues: t (copy), t11 (copy) ]]
	return t.toFeet(t11.toMeter(p1))
end
function t11.toCentimeter(p1) --[[ toCentimeter | Line: 515 | Upvalues: t (copy), t11 (copy) ]]
	return t.toCentimeter(t11.toMeter(p1))
end
function t11.toNanometer(p1) --[[ toNanometer | Line: 518 | Upvalues: t (copy), t11 (copy) ]]
	return t.toNanometer(t11.toMeter(p1))
end
function t11.toPicometer(p1) --[[ toPicometer | Line: 521 | Upvalues: t (copy), t11 (copy) ]]
	return t.toPicometer(t11.toMeter(p1))
end
function t11.toPlanck(p1) --[[ toPlanck | Line: 524 | Upvalues: t (copy), t11 (copy) ]]
	return t.toPlanck(t11.toMeter(p1))
end

local t12 = {
	toMicrometer = function(p1) --[[ toMicrometer | Line: 529 ]]
		return p1 / 1000
	end
}

function t12.toMeter(p1) --[[ toMeter | Line: 532 | Upvalues: t10 (copy), t12 (copy) ]]
	return t10.toMeter(t12.toMicrometer(p1))
end
function t12.toKilometer(p1) --[[ toKilometer | Line: 535 | Upvalues: t (copy), t12 (copy) ]]
	return t.toKilometer(t12.toMeter(p1))
end
function t12.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 538 | Upvalues: t (copy), t12 (copy) ]]
	return t.toAstronomicalUnit(t12.toMeter(p1))
end
function t12.toLightYear(p1) --[[ toLightYear | Line: 541 | Upvalues: t (copy), t12 (copy) ]]
	return t.toLightYear(t12.toMeter(p1))
end
function t12.toLightSecond(p1) --[[ toLightSecond | Line: 544 | Upvalues: t (copy), t12 (copy) ]]
	return t.toLightSecond(t12.toMeter(p1))
end
function t12.toLeague(p1) --[[ toLeague | Line: 547 | Upvalues: t (copy), t12 (copy) ]]
	return t.toLeague(t12.toMeter(p1))
end
function t12.toMile(p1) --[[ toMile | Line: 550 | Upvalues: t (copy), t12 (copy) ]]
	return t.toMile(t12.toMeter(p1))
end
function t12.toFeet(p1) --[[ toFeet | Line: 553 | Upvalues: t (copy), t12 (copy) ]]
	return t.toFeet(t12.toMeter(p1))
end
function t12.toCentimeter(p1) --[[ toCentimeter | Line: 556 | Upvalues: t (copy), t12 (copy) ]]
	return t.toCentimeter(t12.toMeter(p1))
end
function t12.toMillimeter(p1) --[[ toMillimeter | Line: 559 | Upvalues: t (copy), t12 (copy) ]]
	return t.toMillimeter(t12.toMeter(p1))
end
function t12.toPicometer(p1) --[[ toPicometer | Line: 562 | Upvalues: t (copy), t12 (copy) ]]
	return t.toPicometer(t12.toMeter(p1))
end
function t12.toPlanck(p1) --[[ toPlanck | Line: 565 | Upvalues: t (copy), t12 (copy) ]]
	return t.toPlanck(t12.toMeter(p1))
end

local t13 = {
	toNanometer = function(p1) --[[ toNanometer | Line: 570 ]]
		return p1 / 1000
	end
}

function t13.toMeter(p1) --[[ toMeter | Line: 573 | Upvalues: t10 (copy), t13 (copy) ]]
	return t10.toMeter(t13.toMicrometer(p1))
end
function t13.toKilometer(p1) --[[ toKilometer | Line: 576 | Upvalues: t (copy), t13 (copy) ]]
	return t.toKilometer(t13.toMeter(p1))
end
function t13.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 579 | Upvalues: t (copy), t13 (copy) ]]
	return t.toAstronomicalUnit(t13.toMeter(p1))
end
function t13.toLightYear(p1) --[[ toLightYear | Line: 582 | Upvalues: t (copy), t13 (copy) ]]
	return t.toLightYear(t13.toMeter(p1))
end
function t13.toLightSecond(p1) --[[ toLightSecond | Line: 585 | Upvalues: t (copy), t13 (copy) ]]
	return t.toLightSecond(t13.toMeter(p1))
end
function t13.toLeague(p1) --[[ toLeague | Line: 588 | Upvalues: t (copy), t13 (copy) ]]
	return t.toLeague(t13.toMeter(p1))
end
function t13.toMile(p1) --[[ toMile | Line: 591 | Upvalues: t (copy), t13 (copy) ]]
	return t.toMile(t13.toMeter(p1))
end
function t13.toFeet(p1) --[[ toFeet | Line: 594 | Upvalues: t (copy), t13 (copy) ]]
	return t.toFeet(t13.toMeter(p1))
end
function t13.toCentimeter(p1) --[[ toCentimeter | Line: 597 | Upvalues: t (copy), t13 (copy) ]]
	return t.toCentimeter(t13.toMeter(p1))
end
function t13.toMillimeter(p1) --[[ toMillimeter | Line: 600 | Upvalues: t (copy), t13 (copy) ]]
	return t.toMillimeter(t13.toMeter(p1))
end
function t13.toMicrometer(p1) --[[ toMicrometer | Line: 603 | Upvalues: t (copy), t13 (copy) ]]
	return t.toMicrometer(t13.toMeter(p1))
end
function t13.toPicometer(p1) --[[ toPicometer | Line: 606 | Upvalues: t (copy), t13 (copy) ]]
	return t.toPicometer(t13.toMeter(p1))
end
function t13.toPlanck(p1) --[[ toPlanck | Line: 609 | Upvalues: t (copy), t13 (copy) ]]
	return t.toPlanck(t13.toMeter(p1))
end

local t14 = {
	toPicometer = function(p1) --[[ toPicometer | Line: 614 ]]
		return p1 / 1.6000000000000002e-23
	end
}

function t14.toMeter(p1) --[[ toMeter | Line: 617 | Upvalues: t10 (copy), t14 (copy) ]]
	return t10.toMeter(t14.toMicrometer(p1))
end
function t14.toKilometer(p1) --[[ toKilometer | Line: 620 | Upvalues: t (copy), t14 (copy) ]]
	return t.toKilometer(t14.toMeter(p1))
end
function t14.toAstronomicalUnit(p1) --[[ toAstronomicalUnit | Line: 623 | Upvalues: t (copy), t14 (copy) ]]
	return t.toAstronomicalUnit(t14.toMeter(p1))
end
function t14.toLightYear(p1) --[[ toLightYear | Line: 626 | Upvalues: t (copy), t14 (copy) ]]
	return t.toLightYear(t14.toMeter(p1))
end
function t14.toLightSecond(p1) --[[ toLightSecond | Line: 629 | Upvalues: t (copy), t14 (copy) ]]
	return t.toLightSecond(t14.toMeter(p1))
end
function t14.toLeague(p1) --[[ toLeague | Line: 632 | Upvalues: t (copy), t14 (copy) ]]
	return t.toLeague(t14.toMeter(p1))
end
function t14.toMile(p1) --[[ toMile | Line: 635 | Upvalues: t (copy), t14 (copy) ]]
	return t.toMile(t14.toMeter(p1))
end
function t14.toFeet(p1) --[[ toFeet | Line: 638 | Upvalues: t (copy), t14 (copy) ]]
	return t.toFeet(t14.toMeter(p1))
end
function t14.toCentimeter(p1) --[[ toCentimeter | Line: 641 | Upvalues: t (copy), t14 (copy) ]]
	return t.toCentimeter(t14.toMeter(p1))
end
function t14.toMillimeter(p1) --[[ toMillimeter | Line: 644 | Upvalues: t (copy), t14 (copy) ]]
	return t.toMillimeter(t14.toMeter(p1))
end
function t14.toMicrometer(p1) --[[ toMicrometer | Line: 647 | Upvalues: t (copy), t14 (copy) ]]
	return t.toMicrometer(t14.toMeter(p1))
end
function t14.toNanometer(p1) --[[ toNanometer | Line: 650 | Upvalues: t (copy), t14 (copy) ]]
	return t.toNanometer(t14.toMeter(p1))
end

return {
	Meter = t,
	Kilometer = t2,
	AstronomicalUnit = t3,
	LightYear = t4,
	LightSecond = t5,
	League = t6,
	Mile = t7,
	Feet = t8,
	Centimeter = t9,
	Millimeter = t10,
	Micrometer = t11,
	Nanometer = t12,
	Picometer = t13,
	Planck = t14
}