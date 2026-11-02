-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	toMinute = function(p1) --[[ toMinute | Line: 73 ]]
		return p1 / 60
	end,
	toHour = function(p1) --[[ toHour | Line: 76 ]]
		return p1 / 3600
	end,
	toDay = function(p1) --[[ toDay | Line: 79 ]]
		return p1 / 86400
	end
}

function t.toWeek(p1) --[[ toWeek | Line: 82 | Upvalues: t (copy) ]]
	return t.toDay(p1) / 7
end
function t.toYear(p1) --[[ toYear | Line: 85 | Upvalues: t (copy) ]]
	return t.toDay(p1) / 365.25
end
function t.toDecade(p1) --[[ toDecade | Line: 88 | Upvalues: t (copy) ]]
	return t.toYear(p1) / 10
end
function t.toCentury(p1) --[[ toCentury | Line: 91 | Upvalues: t (copy) ]]
	return t.toYear(p1) / 100
end
function t.toMillenia(p1) --[[ toMillenia | Line: 94 | Upvalues: t (copy) ]]
	return t.toYear(p1) / 1000
end
function t.toMicrosecond(p1) --[[ toMicrosecond | Line: 97 ]]
	return p1 * 1000000
end
function t.toMillisecond(p1) --[[ toMillisecond | Line: 100 | Upvalues: t (copy) ]]
	return t.toMicrosecond(p1) / 1000
end
function t.toPicosecond(p1) --[[ toPicosecond | Line: 103 | Upvalues: t (copy) ]]
	return t.toMicrosecond(p1) * 1000000
end
function t.toNanosecond(p1) --[[ toNanosecond | Line: 106 | Upvalues: t (copy) ]]
	return t.toPicosecond(p1) / 1000
end

local t2 = {
	toSecond = function(p1) --[[ toSecond | Line: 111 ]]
		return p1 * 86400
	end
}

function t2.toMinute(p1) --[[ toMinute | Line: 114 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMinute(t2.toSecond(p1))
end
function t2.toHour(p1) --[[ toHour | Line: 117 | Upvalues: t (copy), t2 (copy) ]]
	return t.toHour(t2.toSecond(p1))
end
function t2.toWeek(p1) --[[ toWeek | Line: 120 | Upvalues: t (copy), t2 (copy) ]]
	return t.toWeek(t2.toSecond(p1))
end
function t2.toYear(p1) --[[ toYear | Line: 123 | Upvalues: t (copy), t2 (copy) ]]
	return t.toYear(t2.toSecond(p1))
end
function t2.toDecade(p1) --[[ toDecade | Line: 126 | Upvalues: t (copy), t2 (copy) ]]
	return t.toDecade(t2.toSecond(p1))
end
function t2.toCentury(p1) --[[ toCentury | Line: 129 | Upvalues: t (copy), t2 (copy) ]]
	return t.toCentury(t2.toSecond(p1))
end
function t2.toMillenia(p1) --[[ toMillenia | Line: 132 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMillenia(t2.toSecond(p1))
end
function t2.toMicrosecond(p1) --[[ toMicrosecond | Line: 135 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMicrosecond(t2.toSecond(p1))
end
function t2.toMillisecond(p1) --[[ toMillisecond | Line: 138 | Upvalues: t (copy), t2 (copy) ]]
	return t.toMillisecond(t2.toSecond(p1))
end
function t2.toPicosecond(p1) --[[ toPicosecond | Line: 141 | Upvalues: t (copy), t2 (copy) ]]
	return t.toPicosecond(t2.toSecond(p1))
end
function t2.toNanosecond(p1) --[[ toNanosecond | Line: 144 | Upvalues: t (copy), t2 (copy) ]]
	return t.toNanosecond(t2.toSecond(p1))
end

local t3 = {
	toDay = function(p1) --[[ toDay | Line: 149 ]]
		return p1 * 365.25
	end
}

function t3.toSecond(p1) --[[ toSecond | Line: 152 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMinute(t3.toDay(p1))
end
function t3.toMinute(p1) --[[ toMinute | Line: 155 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMinute(t3.toDay(p1))
end
function t3.toHour(p1) --[[ toHour | Line: 158 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toHour(t3.toDay(p1))
end
function t3.toWeek(p1) --[[ toWeek | Line: 161 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toWeek(t3.toDay(p1))
end
function t3.toDecade(p1) --[[ toDecade | Line: 164 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toDecade(t3.toDay(p1))
end
function t3.toCentury(p1) --[[ toCentury | Line: 167 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toCentury(t3.toDay(p1))
end
function t3.toMillenia(p1) --[[ toMillenia | Line: 170 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMillenia(t3.toDay(p1))
end
function t3.toMicrosecond(p1) --[[ toMicrosecond | Line: 173 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMicrosecond(t3.toDay(p1))
end
function t3.toMillisecond(p1) --[[ toMillisecond | Line: 176 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toMillisecond(t3.toDay(p1))
end
function t3.toPicosecond(p1) --[[ toPicosecond | Line: 179 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toPicosecond(t3.toDay(p1))
end
function t3.toNanosecond(p1) --[[ toNanosecond | Line: 182 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2.toNanosecond(t3.toDay(p1))
end

local t4 = {
	toSecond = function(p1) --[[ toSecond | Line: 187 ]]
		return p1 / 1000000
	end,
	toMillisecond = function(p1) --[[ toMillisecond | Line: 190 ]]
		return p1 / 1000
	end
}

function t4.toMinute(p1) --[[ toMinute | Line: 193 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMinute(t4.toSecond(p1))
end
function t4.toHour(p1) --[[ toHour | Line: 196 | Upvalues: t (copy), t4 (copy) ]]
	return t.toHour(t4.toSecond(p1))
end
function t4.toDay(p1) --[[ toDay | Line: 199 | Upvalues: t (copy), t4 (copy) ]]
	return t.toDay(t4.toSecond(p1))
end
function t4.toWeek(p1) --[[ toWeek | Line: 202 | Upvalues: t (copy), t4 (copy) ]]
	return t.toWeek(t4.toSecond(p1))
end
function t4.toYear(p1) --[[ toYear | Line: 205 | Upvalues: t (copy), t4 (copy) ]]
	return t.toYear(t4.toSecond(p1))
end
function t4.toDecade(p1) --[[ toDecade | Line: 208 | Upvalues: t (copy), t4 (copy) ]]
	return t.toDecade(t4.toSecond(p1))
end
function t4.toCentury(p1) --[[ toCentury | Line: 211 | Upvalues: t (copy), t4 (copy) ]]
	return t.toCentury(t4.toSecond(p1))
end
function t4.toMillenia(p1) --[[ toMillenia | Line: 214 | Upvalues: t (copy), t4 (copy) ]]
	return t.toMillenia(t4.toSecond(p1))
end
function t4.toPicosecond(p1) --[[ toPicosecond | Line: 217 | Upvalues: t (copy), t4 (copy) ]]
	return t.toPicosecond(t4.toSecond(p1))
end
function t4.toNanosecond(p1) --[[ toNanosecond | Line: 220 | Upvalues: t (copy), t4 (copy) ]]
	return t.toNanosecond(t4.toSecond(p1))
end

local t5 = {
	toMicrosecond = function(p1) --[[ toMicrosecond | Line: 225 ]]
		return p1 / 1000000
	end,
	toNanosecond = function(p1) --[[ toNanosecond | Line: 228 ]]
		return p1 / 1000
	end
}

function t5.toSecond(p1) --[[ toSecond | Line: 231 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toSecond(t5.toMicrosecond(p1))
end
function t5.toMillisecond(p1) --[[ toMillisecond | Line: 234 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toMillisecond(t5.toMicrosecond(p1))
end
function t5.toMinute(p1) --[[ toMinute | Line: 237 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toMinute(t5.toMicrosecond(p1))
end
function t5.toHour(p1) --[[ toHour | Line: 240 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toHour(t5.toMicrosecond(p1))
end
function t5.toDay(p1) --[[ toDay | Line: 243 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toDay(t5.toMicrosecond(p1))
end
function t5.toWeek(p1) --[[ toWeek | Line: 246 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toWeek(t5.toMicrosecond(p1))
end
function t5.toYear(p1) --[[ toYear | Line: 249 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toYear(t5.toMicrosecond(p1))
end
function t5.toDecade(p1) --[[ toDecade | Line: 252 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toDecade(t5.toMicrosecond(p1))
end
function t5.toCentury(p1) --[[ toCentury | Line: 255 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toCentury(t5.toMicrosecond(p1))
end
function t5.toMillenia(p1) --[[ toMillenia | Line: 258 | Upvalues: t4 (copy), t5 (copy) ]]
	return t4.toMillenia(t5.toMicrosecond(p1))
end

local t6 = {
	toPicosecond = function(p1) --[[ toPicosecond | Line: 263 ]]
		return p1 * 1000
	end
}

function t6.toMicrosecond(p1) --[[ toMicrosecond | Line: 266 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toMicrosecond(t6.toPicosecond(p1))
end
function t6.toSecond(p1) --[[ toSecond | Line: 269 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toSecond(t6.toPicosecond(p1))
end
function t6.toMillisecond(p1) --[[ toMillisecond | Line: 272 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toMillisecond(t6.toPicosecond(p1))
end
function t6.toMinute(p1) --[[ toMinute | Line: 275 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toMinute(t6.toPicosecond(p1))
end
function t6.toHour(p1) --[[ toHour | Line: 278 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toHour(t6.toPicosecond(p1))
end
function t6.toDay(p1) --[[ toDay | Line: 281 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toDay(t6.toPicosecond(p1))
end
function t6.toWeek(p1) --[[ toWeek | Line: 284 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toWeek(t6.toPicosecond(p1))
end
function t6.toYear(p1) --[[ toYear | Line: 287 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toYear(t6.toPicosecond(p1))
end
function t6.toDecade(p1) --[[ toDecade | Line: 290 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toDecade(t6.toPicosecond(p1))
end
function t6.toCentury(p1) --[[ toCentury | Line: 293 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toCentury(t6.toPicosecond(p1))
end
function t6.toMillenia(p1) --[[ toMillenia | Line: 296 | Upvalues: t5 (copy), t6 (copy) ]]
	return t5.toMillenia(t6.toPicosecond(p1))
end

local t7 = {
	toMicrosecond = function(p1) --[[ toMicrosecond | Line: 301 ]]
		return p1 * 1000
	end
}

function t7.toSecond(p1) --[[ toSecond | Line: 304 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toMinute(t7.toMicrosecond(p1))
end
function t7.toMinute(p1) --[[ toMinute | Line: 307 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toMinute(t7.toMicrosecond(p1))
end
function t7.toHour(p1) --[[ toHour | Line: 310 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toHour(t7.toMicrosecond(p1))
end
function t7.toDay(p1) --[[ toDay | Line: 313 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toDay(t7.toMicrosecond(p1))
end
function t7.toWeek(p1) --[[ toWeek | Line: 316 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toWeek(t7.toMicrosecond(p1))
end
function t7.toYear(p1) --[[ toYear | Line: 319 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toYear(t7.toMicrosecond(p1))
end
function t7.toDecade(p1) --[[ toDecade | Line: 322 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toDecade(t7.toMicrosecond(p1))
end
function t7.toCentury(p1) --[[ toCentury | Line: 325 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toCentury(t7.toMicrosecond(p1))
end
function t7.toMillenia(p1) --[[ toMillenia | Line: 328 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toMillenia(t7.toMicrosecond(p1))
end
function t7.toPicosecond(p1) --[[ toPicosecond | Line: 331 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toPicosecond(t7.toMicrosecond(p1))
end
function t7.toNanosecond(p1) --[[ toNanosecond | Line: 334 | Upvalues: t4 (copy), t7 (copy) ]]
	return t4.toNanosecond(t7.toMicrosecond(p1))
end

local t8 = {
	toSecond = function(p1) --[[ toSecond | Line: 339 ]]
		return p1 * 60
	end
}

function t8.toDay(p1) --[[ toDay | Line: 342 | Upvalues: t (copy), t8 (copy) ]]
	return t.toDay(t8.toSecond(p1))
end
function t8.toHour(p1) --[[ toHour | Line: 345 | Upvalues: t (copy), t8 (copy) ]]
	return t.toHour(t8.toSecond(p1))
end
function t8.toWeek(p1) --[[ toWeek | Line: 348 | Upvalues: t (copy), t8 (copy) ]]
	return t.toWeek(t8.toSecond(p1))
end
function t8.toYear(p1) --[[ toYear | Line: 351 | Upvalues: t (copy), t8 (copy) ]]
	return t.toYear(t8.toSecond(p1))
end
function t8.toDecade(p1) --[[ toDecade | Line: 354 | Upvalues: t (copy), t8 (copy) ]]
	return t.toDecade(t8.toSecond(p1))
end
function t8.toCentury(p1) --[[ toCentury | Line: 357 | Upvalues: t (copy), t8 (copy) ]]
	return t.toCentury(t8.toSecond(p1))
end
function t8.toMillenia(p1) --[[ toMillenia | Line: 360 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMillenia(t8.toSecond(p1))
end
function t8.toMicrosecond(p1) --[[ toMicrosecond | Line: 363 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMicrosecond(t8.toSecond(p1))
end
function t8.toMillisecond(p1) --[[ toMillisecond | Line: 366 | Upvalues: t (copy), t8 (copy) ]]
	return t.toMillisecond(t8.toSecond(p1))
end
function t8.toPicosecond(p1) --[[ toPicosecond | Line: 369 | Upvalues: t (copy), t8 (copy) ]]
	return t.toPicosecond(t8.toSecond(p1))
end
function t8.toNanosecond(p1) --[[ toNanosecond | Line: 372 | Upvalues: t (copy), t8 (copy) ]]
	return t.toNanosecond(t8.toSecond(p1))
end

local t9 = {
	toSecond = function(p1) --[[ toSecond | Line: 377 ]]
		return p1 * 3600
	end
}

function t9.toDay(p1) --[[ toDay | Line: 380 | Upvalues: t (copy), t9 (copy) ]]
	return t.toDay(t9.toSecond(p1))
end
function t9.toMinute(p1) --[[ toMinute | Line: 383 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMinute(t9.toSecond(p1))
end
function t9.toWeek(p1) --[[ toWeek | Line: 386 | Upvalues: t (copy), t9 (copy) ]]
	return t.toWeek(t9.toSecond(p1))
end
function t9.toYear(p1) --[[ toYear | Line: 389 | Upvalues: t (copy), t9 (copy) ]]
	return t.toYear(t9.toSecond(p1))
end
function t9.toDecade(p1) --[[ toDecade | Line: 392 | Upvalues: t (copy), t9 (copy) ]]
	return t.toDecade(t9.toSecond(p1))
end
function t9.toCentury(p1) --[[ toCentury | Line: 395 | Upvalues: t (copy), t9 (copy) ]]
	return t.toCentury(t9.toSecond(p1))
end
function t9.toMillenia(p1) --[[ toMillenia | Line: 398 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMillenia(t9.toSecond(p1))
end
function t9.toMicrosecond(p1) --[[ toMicrosecond | Line: 401 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMicrosecond(t9.toSecond(p1))
end
function t9.toMillisecond(p1) --[[ toMillisecond | Line: 404 | Upvalues: t (copy), t9 (copy) ]]
	return t.toMillisecond(t9.toSecond(p1))
end
function t9.toPicosecond(p1) --[[ toPicosecond | Line: 407 | Upvalues: t (copy), t9 (copy) ]]
	return t.toPicosecond(t9.toSecond(p1))
end
function t9.toNanosecond(p1) --[[ toNanosecond | Line: 410 | Upvalues: t (copy), t9 (copy) ]]
	return t.toNanosecond(t9.toSecond(p1))
end

local t10 = {
	toDay = function(p1) --[[ toDay | Line: 415 ]]
		return p1 * 7
	end
}

function t10.toSecond(p1) --[[ toSecond | Line: 418 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toMinute(t10.toDay(p1))
end
function t10.toMinute(p1) --[[ toMinute | Line: 421 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toMinute(t10.toDay(p1))
end
function t10.toHour(p1) --[[ toHour | Line: 424 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toHour(t10.toDay(p1))
end
function t10.toYear(p1) --[[ toYear | Line: 427 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toYear(t10.toDay(p1))
end
function t10.toDecade(p1) --[[ toDecade | Line: 430 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toDecade(t10.toDay(p1))
end
function t10.toCentury(p1) --[[ toCentury | Line: 433 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toCentury(t10.toDay(p1))
end
function t10.toMillenia(p1) --[[ toMillenia | Line: 436 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toMillenia(t10.toDay(p1))
end
function t10.toMicrosecond(p1) --[[ toMicrosecond | Line: 439 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toMicrosecond(t10.toDay(p1))
end
function t10.toMillisecond(p1) --[[ toMillisecond | Line: 442 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toMillisecond(t10.toDay(p1))
end
function t10.toPicosecond(p1) --[[ toPicosecond | Line: 445 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toPicosecond(t10.toDay(p1))
end
function t10.toNanosecond(p1) --[[ toNanosecond | Line: 448 | Upvalues: t2 (copy), t10 (copy) ]]
	return t2.toNanosecond(t10.toDay(p1))
end

local t11 = {
	toYear = function(p1) --[[ toYear | Line: 453 ]]
		return p1 * 1000
	end
}

function t11.toSecond(p1) --[[ toSecond | Line: 456 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toSecond(t11.toYear(p1))
end
function t11.toMinute(p1) --[[ toMinute | Line: 459 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toMinute(t11.toYear(p1))
end
function t11.toHour(p1) --[[ toHour | Line: 462 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toHour(t11.toYear(p1))
end
function t11.toWeek(p1) --[[ toWeek | Line: 465 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toWeek(t11.toYear(p1))
end
function t11.toDecade(p1) --[[ toDecade | Line: 468 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toDecade(t11.toYear(p1))
end
function t11.toCentury(p1) --[[ toCentury | Line: 471 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toCentury(t11.toYear(p1))
end
function t11.toDay(p1) --[[ toDay | Line: 474 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toDay(t11.toYear(p1))
end
function t11.toMicrosecond(p1) --[[ toMicrosecond | Line: 477 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toMicrosecond(t11.toYear(p1))
end
function t11.toMillisecond(p1) --[[ toMillisecond | Line: 480 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toMillisecond(t11.toYear(p1))
end
function t11.toPicosecond(p1) --[[ toPicosecond | Line: 483 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toPicosecond(t11.toYear(p1))
end
function t11.toNanosecond(p1) --[[ toNanosecond | Line: 486 | Upvalues: t3 (copy), t11 (copy) ]]
	return t3.toNanosecond(t11.toYear(p1))
end

local t12 = {
	toYear = function(p1) --[[ toYear | Line: 491 ]]
		return p1 * 10
	end
}

function t12.toMillenia(p1) --[[ toMillenia | Line: 494 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toDecade(t12.toYear(p1))
end
function t12.toSecond(p1) --[[ toSecond | Line: 497 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toSecond(t12.toYear(p1))
end
function t12.toMinute(p1) --[[ toMinute | Line: 500 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toMinute(t12.toYear(p1))
end
function t12.toHour(p1) --[[ toHour | Line: 503 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toHour(t12.toYear(p1))
end
function t12.toWeek(p1) --[[ toWeek | Line: 506 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toWeek(t12.toYear(p1))
end
function t12.toCentury(p1) --[[ toCentury | Line: 509 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toCentury(t12.toYear(p1))
end
function t12.toDay(p1) --[[ toDay | Line: 512 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toDay(t12.toYear(p1))
end
function t12.toMicrosecond(p1) --[[ toMicrosecond | Line: 515 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toMicrosecond(t12.toYear(p1))
end
function t12.toMillisecond(p1) --[[ toMillisecond | Line: 518 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toMillisecond(t12.toYear(p1))
end
function t12.toPicosecond(p1) --[[ toPicosecond | Line: 521 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toPicosecond(t12.toYear(p1))
end
function t12.toNanosecond(p1) --[[ toNanosecond | Line: 524 | Upvalues: t3 (copy), t12 (copy) ]]
	return t3.toNanosecond(t12.toYear(p1))
end

local t13 = {
	toYear = function(p1) --[[ toYear | Line: 529 ]]
		return p1 * 100
	end
}

function t13.toMillenia(p1) --[[ toMillenia | Line: 532 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toMillenia(t13.toYear(p1))
end
function t13.toSecond(p1) --[[ toSecond | Line: 535 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toSecond(t13.toYear(p1))
end
function t13.toMinute(p1) --[[ toMinute | Line: 538 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toMinute(t13.toYear(p1))
end
function t13.toHour(p1) --[[ toHour | Line: 541 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toHour(t13.toYear(p1))
end
function t13.toWeek(p1) --[[ toWeek | Line: 544 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toWeek(t13.toYear(p1))
end
function t13.toDecade(p1) --[[ toDecade | Line: 547 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toDecade(t13.toYear(p1))
end
function t13.toDay(p1) --[[ toDay | Line: 550 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toDay(t13.toYear(p1))
end
function t13.toMicrosecond(p1) --[[ toMicrosecond | Line: 553 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toMicrosecond(t13.toYear(p1))
end
function t13.toMillisecond(p1) --[[ toMillisecond | Line: 556 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toMillisecond(t13.toYear(p1))
end
function t13.toPicosecond(p1) --[[ toPicosecond | Line: 559 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toPicosecond(t13.toYear(p1))
end
function t13.toNanosecond(p1) --[[ toNanosecond | Line: 562 | Upvalues: t3 (copy), t13 (copy) ]]
	return t3.toNanosecond(t13.toYear(p1))
end

return {
	Millenia = t11,
	Century = t13,
	Decade = t12,
	Year = t3,
	Week = t10,
	Day = t2,
	Hour = t9,
	Minute = t8,
	Second = t,
	Millisecond = t7,
	Microsecond = t4,
	Nanosecond = t6,
	Picosecond = t5
}