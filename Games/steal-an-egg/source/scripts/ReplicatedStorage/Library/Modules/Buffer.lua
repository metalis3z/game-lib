-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local create = buffer.create
local fromstring = buffer.fromstring
local v1 = buffer.tostring
local len = buffer.len
local readi8 = buffer.readi8
local readu8 = buffer.readu8
local readi16 = buffer.readi16
local readu16 = buffer.readu16
local readi32 = buffer.readi32
local readu32 = buffer.readu32
local readf32 = buffer.readf32
local readf64 = buffer.readf64
local writei8 = buffer.writei8
local writeu8 = buffer.writeu8
local writei16 = buffer.writei16
local writeu16 = buffer.writeu16
local writei32 = buffer.writei32
local writeu32 = buffer.writeu32
local writef32 = buffer.writef32
local writef64 = buffer.writef64
local readstring = buffer.readstring
local writestring = buffer.writestring
local copy = buffer.copy
local fill = buffer.fill
local band = bit32.band
local bor = bit32.bor
local lshift = bit32.lshift
local rshift = bit32.rshift
local bnot = bit32.bnot
local len2 = string.len
local floor = math.floor
local min = math.min
local ldexp = math.ldexp
local log = math.log
local clamp = math.clamp
local v2 = create(8)
local t = {}
local t2 = {
	__index = t,
	__tostring = function(p1) --[[ __tostring | Line: 45 | Upvalues: readstring (copy) ]]
		local _pos = p1._pos
		local _lim = p1._lim

		return readstring(p1._h, p1._off + _pos, _pos <= _lim and _lim - _pos or 0)
	end
}

local function remainingSpan(p1, p2) --[[ remainingSpan | Line: 53 ]]
	return if p1 <= p2 then p2 - p1 or 0 else 0
end

local function f32tobits(p1) --[[ f32tobits | Line: 57 | Upvalues: v2 (copy), writef32 (copy), readu32 (copy) ]]
	writef32(v2, 0, p1)

	return readu32(v2, 0)
end

local function bitstof32(p1) --[[ bitstof32 | Line: 62 | Upvalues: v2 (copy), writeu32 (copy), readf32 (copy) ]]
	writeu32(v2, 0, p1)

	return readf32(v2, 0)
end

local function f64tobits(p1) --[[ f64tobits | Line: 67 | Upvalues: v2 (copy), writef64 (copy), readu32 (copy) ]]
	writef64(v2, 0, p1)

	return readu32(v2, 0), readu32(v2, 4)
end

local function bitstof64(p1, p2) --[[ bitstof64 | Line: 72 | Upvalues: v2 (copy), writeu32 (copy), readf64 (copy) ]]
	writeu32(v2, 0, p1)
	writeu32(v2, 4, p2)

	return readf64(v2, 0)
end

local function castf32(p1) --[[ castf32 | Line: 78 | Upvalues: v2 (copy), writef32 (copy), readf32 (copy) ]]
	writef32(v2, 0, p1)

	return readf32(v2, 0)
end

local function decomposef16(p1) --[[ decomposef16 | Line: 83 | Upvalues: log (copy), floor (copy), clamp (copy) ]]
	warn("I don\'t think this is correct")

	local v1

	if p1 < 0 then
		p1 = -p1
		v1 = 1
	else
		v1 = 0
	end

	if p1 == 0 then
		return v1, 0, 0
	end

	if p1 == (1 / 0) then
		return v1, 31, 0
	end

	local v2 = floor((log(p1, 2)))
	local v3 = floor((p1 / 2 ^ v2 - 1) * 1024)

	return v1, clamp(v2 + 15, 0, 31), v3
end

local function composef16(p1, p2, p3) --[[ composef16 | Line: 104 | Upvalues: ldexp (copy) ]]
	warn("I don\'t think this is correct")

	local v1 = 1 - p1 * 2

	if p2 == 0 then
		if p3 == 0 then
			return 0
		end

		return v1 * ldexp(p3 / 1024, -14)
	end

	if p2 ~= 31 then
		return v1 * ldexp(p3 / 1024 + 1, p2 - 15)
	end

	if p3 == 0 then
		return v1 * (1 / 0)
	end

	return (0 / 0)
end

local function buffer_readu24(p1, p2) --[[ buffer_readu24 | Line: 116 ]]
	error("nyi")
end

local function buffer_readi24(p1, p2) --[[ buffer_readi24 | Line: 120 ]]
	error("nyi")
end

local function buffer_writeu24(p1, p2, p3) --[[ buffer_writeu24 | Line: 124 ]]
	error("nyi")
end

local function buffer_writei24(p1, p2, p3) --[[ buffer_writei24 | Line: 128 ]]
	error("nyi")
end

local function buffer_readu64(p1, p2) --[[ buffer_readu64 | Line: 132 | Upvalues: readu32 (copy) ]]
	return readu32(p1, p2) + readu32(p1, p2 + 4) * 4294967296
end

local function buffer_readi64(p1, p2) --[[ buffer_readi64 | Line: 136 | Upvalues: readu32 (copy), readi32 (copy) ]]
	return readu32(p1, p2) + readi32(p1, p2 + 4) * 4294967296
end

local function buffer_writeu64(p1, p2, p3) --[[ buffer_writeu64 | Line: 140 | Upvalues: writeu32 (copy) ]]
	writeu32(p1, p2, p3)
	writeu32(p1, p2 + 4, p3 // 4294967296)
end

local function buffer_writei64(p1, p2, p3) --[[ buffer_writei64 | Line: 145 | Upvalues: writeu32 (copy), writei32 (copy) ]]
	writeu32(p1, p2, p3)
	writei32(p1, p2 + 4, p3 // 4294967296)
end

local function buffer_readf16(p1, p2) --[[ buffer_readf16 | Line: 150 | Upvalues: readu16 (copy), composef16 (copy), rshift (copy), band (copy) ]]
	local v1 = readu16(p1, p2)

	return composef16(rshift(v1, 15), band(rshift(v1, 10), 31), (band(v1, 1023)))
end

local function buffer_writef16(p1, p2, p3) --[[ buffer_writef16 | Line: 155 | Upvalues: decomposef16 (copy), composef16 (copy), lshift (copy), bor (copy), writeu16 (copy) ]]
	local v1, v2, v3 = decomposef16(p3)

	composef16(v1, v2, v3)
	writeu16(p1, p2, (bor(lshift(v1, 15), lshift(v2, 10), v3)))
end

local function isbuffer(p1) --[[ isbuffer | Line: 161 | Upvalues: t2 (copy) ]]
	return type(p1) == "table" and getmetatable(p1) == t2
end

local function isnumber(p1) --[[ isnumber | Line: 165 ]]
	return type(p1) == "number"
end

local function isint(p1) --[[ isint | Line: 169 | Upvalues: floor (copy) ]]
	return p1 == floor(p1)
end

local function isu8(p1) --[[ isu8 | Line: 173 | Upvalues: band (copy) ]]
	return p1 == band(p1, 255)
end

local function isu16(p1) --[[ isu16 | Line: 177 | Upvalues: band (copy) ]]
	return p1 == band(p1, 65535)
end

local function isu24(p1) --[[ isu24 | Line: 181 | Upvalues: band (copy) ]]
	return p1 == band(p1, 16777215)
end

local function isu32(p1) --[[ isu32 | Line: 185 | Upvalues: lshift (copy) ]]
	return p1 == lshift(p1, 0)
end

local function isu64(p1) --[[ isu64 | Line: 189 | Upvalues: lshift (copy) ]]
	return p1 == lshift(p1, 0) + lshift(p1 // 4294967296, 0) * 4294967296
end

local function isi8(p1) --[[ isi8 | Line: 193 | Upvalues: band (copy) ]]
	local v1 = p1 + 128

	return v1 == band(v1, 255)
end

local function isi16(p1) --[[ isi16 | Line: 198 | Upvalues: band (copy) ]]
	local v1 = p1 + 32768

	return v1 == band(v1, 65535)
end

local function isi24(p1) --[[ isi24 | Line: 203 | Upvalues: band (copy) ]]
	local v1 = p1 + 8388608

	return v1 == band(v1, 16777215)
end

local function isi32(p1) --[[ isi32 | Line: 208 | Upvalues: lshift (copy) ]]
	local v1 = p1 + 2147483648

	return v1 == lshift(v1, 0)
end

local function isi64(p1) --[[ isi64 | Line: 213 | Upvalues: lshift (copy) ]]
	local v1 = lshift(p1, 0)
	local v2 = p1 // 4294967296
	local v3 = v2 + 2147483648

	return v3 == lshift(v3, 0) and p1 == v1 + v2 * 4294967296
end

local function isstring(p1) --[[ isstring | Line: 223 ]]
	return type(p1) == "string"
end

local function checkFromIndexSize(p1, p2, p3) --[[ checkFromIndexSize | Line: 227 ]]
	assert(if p3 > 0 and (p1 > 0 and p2 > 0) then p2 <= p3 - p1 else false, "outofbounds")

	return p1
end

local function readIndex(p1) --[[ readIndex | Line: 246 ]]
	local _pos = p1._pos

	assert(_pos < p1._lim, "underflow")
	p1._pos = _pos + 1

	return p1._off + _pos
end

local function readIndexOf(p1, p2) --[[ readIndexOf | Line: 253 ]]
	local _pos = p1._pos

	assert(p2 <= p1._lim - _pos, "underflow")
	p1._pos = _pos + p2

	return p1._off + _pos
end

local function writeIndex(p1) --[[ writeIndex | Line: 260 ]]
	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(_pos < p1._lim, "overflow")
	p1._pos = _pos + 1

	return p1._off + _pos
end

local function writeIndexOf(p1, p2) --[[ writeIndexOf | Line: 268 ]]
	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(p2 <= p1._lim - _pos, "overflow")
	p1._pos = _pos + p2

	return p1._off + _pos
end

local function getIndex(p1, p2) --[[ getIndex | Line: 276 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")

	return p1._off + p2
end

local function getIndexOf(p1, p2, p3) --[[ getIndexOf | Line: 282 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(p2 >= 0 and p2 < p1._lim - p3 + 1, "outofbounds")

	return p1._off + p2
end

local function putIndex(p1, p2) --[[ putIndex | Line: 288 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")

	return p1._off + p2
end

local function putIndexOf(p1, p2, p3) --[[ putIndexOf | Line: 295 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - p3 + 1, "outofbounds")

	return p1._off + p2
end

local function copyBuffer(p1, p2, p3, p4, p5) --[[ copyBuffer | Line: 302 | Upvalues: copy (copy) ]]
	copy(p1._h, p1._off + p2, p3._h, p3._off + p4, p5)
end

local function writeBuffer(p1, p2) --[[ writeBuffer | Line: 306 | Upvalues: copy (copy) ]]
	assert(p1 ~= p2, "src~=dst")
	assert(not p2._ro, "readonly")

	local _pos = p1._pos
	local _lim = p1._lim
	local v3 = _pos <= _lim and _lim - _pos or 0
	local _pos2 = p2._pos
	local _lim2 = p2._lim

	assert(if v3 <= (_pos2 <= _lim2 and _lim2 - _pos2 or 0) then true else false, "overflow")
	copy(p2._h, p2._off + _pos2, p1._h, p1._off + _pos, v3)
	p2._pos = _pos2 + v3
	p1._pos = _pos + v3
end

local function getBuffer(p1, p2, p3) --[[ getBuffer | Line: 318 | Upvalues: floor (copy), copy (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p3._ro, "readonly")

	local _pos = p3._pos
	local _lim = p3._lim
	local v3 = _pos <= _lim and _lim - _pos or 0

	assert(p2 >= 0 and p2 < p1._lim - v3 + 1, "outofbounds")
	copy(p3._h, p3._off + _pos, p1._h, p1._off + p2, v3)
end

local function putBuffer(p1, p2, p3) --[[ putBuffer | Line: 327 | Upvalues: floor (copy), copy (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")

	local _pos = p3._pos
	local _lim = p3._lim
	local v3 = _pos <= _lim and _lim - _pos or 0

	assert(p2 >= 0 and p2 < p1._lim - v3 + 1, "outofbounds")
	copy(p1._h, p1._off + p2, p3._h, p3._off + _pos, v3)
end

local function wrap(p1, p2, p3) --[[ wrap | Line: 336 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_mark = -1,
		_pos = 0,
		_bpos = 0,
		_ro = false,
		_lim = p3,
		_cap = p3,
		_h = p1,
		_off = p2
	}, t2)
end

function t.handle(p1) --[[ handle | Line: 349 ]]
	return p1._h
end
function t.handleOffset(p1) --[[ handleOffset | Line: 353 ]]
	return p1._off
end
function t.capacity(p1) --[[ capacity | Line: 357 ]]
	return p1._cap
end
function t.clear(p1) --[[ clear | Line: 361 ]]
	p1._pos = 0
	p1._bpos = 0
	p1._lim = p1._cap

	return p1
end
function t.duplicate(p1) --[[ duplicate | Line: 368 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_mark = p1._mark,
		_pos = p1._pos,
		_bpos = p1._bpos,
		_lim = p1._lim,
		_cap = p1._cap,
		_ro = p1._ro,
		_h = p1._h,
		_off = p1._off
	}, t2)
end
function t.flip(p1) --[[ flip | Line: 381 ]]
	p1._lim = p1._pos
	p1._pos = 0
	p1._bpos = 0
	p1._mark = -1

	return p1
end
function t.hasRemaining(p1) --[[ hasRemaining | Line: 389 ]]
	return p1._pos < p1._lim
end
function t.isReadOnly(p1) --[[ isReadOnly | Line: 393 ]]
	return p1._ro
end
function t.limit(p1) --[[ limit | Line: 397 ]]
	return p1._lim
end
function t.limitTo(p1, p2) --[[ limitTo | Line: 401 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(p2 <= p1._cap and p2 >= 0, "outofbounds")
	p1._lim = p2

	if p2 < p1._pos then
		p1._pos = p2
	end

	if p2 < p1._mark then
		p1._mark = -1
	end

	p1._bpos = 0

	return p1
end
function t.mark(p1) --[[ mark | Line: 415 ]]
	p1._mark = p1._pos

	return p1
end
function t.position(p1) --[[ position | Line: 420 ]]
	return p1._pos
end
function t.positionTo(p1, p2) --[[ positionTo | Line: 424 | Upvalues: floor (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(p2 <= p1._lim and p2 >= 0, "outofbounds")

	if p2 < p1._mark then
		p1._mark = -1
	end

	p1._pos = p2
	p1._bpos = 0

	return p1
end
function t.remaining(p1) --[[ remaining | Line: 435 ]]
	local v1 = p1._lim - p1._pos

	return if v1 > 0 then v1 else 0
end
function t.reset(p1) --[[ reset | Line: 440 ]]
	local _mark = p1._mark

	assert(_mark >= 0, "invalidmark")
	p1._pos = _mark
	p1._bpos = 0

	return p1
end
function t.rewind(p1) --[[ rewind | Line: 448 ]]
	p1._pos = 0
	p1._bpos = 0
	p1._mark = -1

	return p1
end
function t.slice(p1) --[[ slice | Line: 455 | Upvalues: t2 (copy) ]]
	local _pos = p1._pos
	local _lim = p1._lim
	local v1 = _pos <= _lim and _lim - _pos or 0

	return setmetatable({
		_mark = -1,
		_pos = 0,
		_bpos = 0,
		_lim = v1,
		_cap = v1,
		_ro = p1._ro,
		_h = p1._h,
		_off = _pos + p1._off
	}, t2)
end
function t.sliceTo(p1, p2, p3) --[[ sliceTo | Line: 470 | Upvalues: floor (copy), t2 (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(if p3 == floor(p3) then true else false, "isint")

	local _lim = p1._lim

	assert(if _lim > 0 and (p2 > 0 and p3 > 0) then p3 <= _lim - p2 else false, "outofbounds")

	return setmetatable({
		_mark = -1,
		_pos = 0,
		_bpos = 0,
		_lim = p3,
		_cap = p3,
		_ro = p1._ro,
		_h = p1._h,
		_off = p2 + p1._off
	}, t2)
end
function t.compact(p1) --[[ compact | Line: 486 | Upvalues: copy (copy) ]]
	local _pos = p1._pos
	local _lim = p1._lim

	assert(_pos <= _lim, "outofbounds")

	local v2 = _pos <= _lim and _lim - _pos or 0

	copy(p1._h, p1._off, p1._h, p1._off + _pos, v2)
	p1._pos = v2
	p1._bpos = 0
	p1._lim = p1._cap
	p1._mark = -1

	return p1
end
function t.asReadOnly(p1) --[[ asReadOnly | Line: 499 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_ro = true,
		_mark = p1._mark,
		_pos = p1._pos,
		_bpos = p1._bpos,
		_lim = p1._lim,
		_cap = p1._cap,
		_h = p1._h,
		_off = p1._off
	}, t2)
end
function t.debugString(p1) --[[ debugString | Line: 512 | Upvalues: v1 (copy) ]]
	return ("Buffer { _mark=%*, _pos=%*, _lim=%*, _cap=%*, _ro=%*, _off=%*, _h=buffer.fromstring(%*) }"):format(p1._mark, p1._pos, p1._lim, p1._cap, p1._ro, p1._off, string.format("%q", v1(p1._h)))
end
function t.tostring(p1) --[[ tostring | Line: 524 | Upvalues: readstring (copy) ]]
	local _pos = p1._pos
	local _lim = p1._lim

	return readstring(p1._h, p1._off + _pos, _pos <= _lim and _lim - _pos or 0)
end
function t.fill(p1, p2) --[[ fill | Line: 530 | Upvalues: band (copy), fill (copy) ]]
	assert(not p1._ro, "readonly")
	assert(p2 == band(p2, 255))

	local _pos = p1._pos
	local _lim = p1._lim
	local v5, v6

	if _pos <= _lim then
		v5 = _lim - _pos

		if v5 then
			v6 = p2
		else
			v6 = p2
			v5 = 0
		end
	else
		v6 = p2
		v5 = 0
	end

	fill(p1._h, p1._off + _pos, v6, v5)
	p1._pos = _lim
	p1._bpos = 0

	return p1
end
function t.readi8(p1) --[[ readi8 | Line: 541 | Upvalues: readi8 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(_pos < p1._lim, "underflow")
	p1._pos = _pos + 1

	return readi8(_h, p1._off + _pos)
end
function t.readu8(p1) --[[ readu8 | Line: 545 | Upvalues: readu8 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(_pos < p1._lim, "underflow")
	p1._pos = _pos + 1

	return readu8(_h, p1._off + _pos)
end
function t.readi16(p1) --[[ readi16 | Line: 549 | Upvalues: readi16 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 2, "underflow")
	p1._pos = _pos + 2

	return readi16(_h, p1._off + _pos)
end
function t.readu16(p1) --[[ readu16 | Line: 553 | Upvalues: readu16 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 2, "underflow")
	p1._pos = _pos + 2

	return readu16(_h, p1._off + _pos)
end
function t.readi24(p1) --[[ readi24 | Line: 557 | Upvalues: buffer_readi24 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 3, "underflow")
	p1._pos = _pos + 3

	return buffer_readi24(_h, p1._off + _pos)
end
function t.readu24(p1) --[[ readu24 | Line: 561 | Upvalues: buffer_readu24 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 3, "underflow")
	p1._pos = _pos + 3

	return buffer_readu24(_h, p1._off + _pos)
end
function t.readi32(p1) --[[ readi32 | Line: 565 | Upvalues: readi32 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 4, "underflow")
	p1._pos = _pos + 4

	return readi32(_h, p1._off + _pos)
end
function t.readu32(p1) --[[ readu32 | Line: 569 | Upvalues: readu32 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 4, "underflow")
	p1._pos = _pos + 4

	return readu32(_h, p1._off + _pos)
end
function t.readi64(p1) --[[ readi64 | Line: 573 | Upvalues: readu32 (copy), readi32 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 8, "underflow")
	p1._pos = _pos + 8

	local v2 = p1._off + _pos

	return readu32(_h, v2) + readi32(_h, v2 + 4) * 4294967296
end
function t.readu64(p1) --[[ readu64 | Line: 577 | Upvalues: readu32 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 8, "underflow")
	p1._pos = _pos + 8

	local v2 = p1._off + _pos

	return readu32(_h, v2) + readu32(_h, v2 + 4) * 4294967296
end
function t.readf16(p1) --[[ readf16 | Line: 581 | Upvalues: readu16 (copy), composef16 (copy), rshift (copy), band (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 2, "underflow")
	p1._pos = _pos + 2

	local v2 = readu16(_h, p1._off + _pos)

	return composef16(rshift(v2, 15), band(rshift(v2, 10), 31), (band(v2, 1023)))
end
function t.readf32(p1) --[[ readf32 | Line: 585 | Upvalues: readf32 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 4, "underflow")
	p1._pos = _pos + 4

	return readf32(_h, p1._off + _pos)
end
function t.readf64(p1) --[[ readf64 | Line: 589 | Upvalues: readf64 (copy) ]]
	local _h = p1._h
	local _pos = p1._pos

	assert(p1._lim - _pos >= 8, "underflow")
	p1._pos = _pos + 8

	return readf64(_h, p1._off + _pos)
end
function t.readstring(p1, p2) --[[ readstring | Line: 593 | Upvalues: floor (copy), readstring (copy) ]]
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(if p2 >= 0 then true else false, "outofbounds")

	local _h = p1._h
	local _pos = p1._pos

	assert(p2 <= p1._lim - _pos, "underflow")
	p1._pos = _pos + p2

	return readstring(_h, p1._off + _pos, p2)
end
function t.readbuffer(p1, p2) --[[ readbuffer | Line: 599 | Upvalues: t2 (copy), writeBuffer (copy) ]]
	assert(type(p2) == "table" and getmetatable(p2) == t2, "isbuffer")
	writeBuffer(p1, p2)

	return p1
end
function t.geti8(p1, p2) --[[ geti8 | Line: 605 | Upvalues: floor (copy), readi8 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")

	return readi8(p1._h, p1._off + p2)
end
function t.getu8(p1, p2) --[[ getu8 | Line: 609 | Upvalues: floor (copy), readu8 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")

	return readu8(p1._h, p1._off + p2)
end
function t.geti16(p1, p2) --[[ geti16 | Line: 613 | Upvalues: floor (copy), readi16 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")

	return readi16(p1._h, p1._off + p2)
end
function t.getu16(p1, p2) --[[ getu16 | Line: 617 | Upvalues: floor (copy), readu16 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")

	return readu16(p1._h, p1._off + p2)
end
function t.geti24(p1, p2) --[[ geti24 | Line: 621 | Upvalues: buffer_readi24 (copy), floor (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 3 + 1, "outofbounds")

	return buffer_readi24(p1._h, p1._off + p2)
end
function t.getu24(p1, p2) --[[ getu24 | Line: 625 | Upvalues: buffer_readu24 (copy), floor (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 3 + 1, "outofbounds")

	return buffer_readu24(p1._h, p1._off + p2)
end
function t.geti32(p1, p2) --[[ geti32 | Line: 629 | Upvalues: floor (copy), readi32 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")

	return readi32(p1._h, p1._off + p2)
end
function t.getu32(p1, p2) --[[ getu32 | Line: 633 | Upvalues: floor (copy), readu32 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")

	return readu32(p1._h, p1._off + p2)
end
function t.geti64(p1, p2) --[[ geti64 | Line: 637 | Upvalues: floor (copy), readu32 (copy), readi32 (copy) ]]
	local _h = p1._h

	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")

	local v3 = p1._off + p2

	return readu32(_h, v3) + readi32(_h, v3 + 4) * 4294967296
end
function t.getu64(p1, p2) --[[ getu64 | Line: 641 | Upvalues: floor (copy), readu32 (copy) ]]
	local _h = p1._h

	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")

	local v3 = p1._off + p2

	return readu32(_h, v3) + readu32(_h, v3 + 4) * 4294967296
end
function t.getf16(p1, p2) --[[ getf16 | Line: 645 | Upvalues: floor (copy), readu16 (copy), composef16 (copy), rshift (copy), band (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")

	local v3 = readu16(p1._h, p1._off + p2)

	return composef16(rshift(v3, 15), band(rshift(v3, 10), 31), (band(v3, 1023)))
end
function t.getf32(p1, p2) --[[ getf32 | Line: 649 | Upvalues: floor (copy), readf32 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")

	return readf32(p1._h, p1._off + p2)
end
function t.getf64(p1, p2) --[[ getf64 | Line: 653 | Upvalues: floor (copy), readf64 (copy) ]]
	assert(p2 == floor(p2), "isint")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")

	return readf64(p1._h, p1._off + p2)
end
function t.getstring(p1, p2, p3) --[[ getstring | Line: 657 | Upvalues: floor (copy), readstring (copy) ]]
	assert(if p3 == floor(p3) then true else false, "isint")
	assert(if p3 >= 0 then true else false, "outofbounds")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(p2 >= 0 and p2 < p1._lim - p3 + 1, "outofbounds")

	return readstring(p1._h, p1._off + p2, p3)
end
function t.getbuffer(p1, p2, p3) --[[ getbuffer | Line: 663 | Upvalues: t2 (copy), getBuffer (copy) ]]
	assert(type(p3) == "table" and getmetatable(p3) == t2, "isbuffer")
	getBuffer(p1, p2, p3)

	return p1
end
function t.writei8(p1, p2) --[[ writei8 | Line: 669 | Upvalues: band (copy), writei8 (copy) ]]
	local v1 = p2 + 128

	assert(if v1 == band(v1, 255) then true else false, "isi8")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if _pos < p1._lim then true else false, "overflow")
	p1._pos = _pos + 1
	writei8(_h, p1._off + _pos, p2)

	return p1
end
function t.writeu8(p1, p2) --[[ writeu8 | Line: 675 | Upvalues: band (copy), writeu8 (copy) ]]
	assert(if p2 == band(p2, 255) then true else false, "isu8")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if _pos < p1._lim then true else false, "overflow")
	p1._pos = _pos + 1
	writeu8(_h, p1._off + _pos, p2)

	return p1
end
function t.writei16(p1, p2) --[[ writei16 | Line: 681 | Upvalues: band (copy), writei16 (copy) ]]
	local v1 = p2 + 32768

	assert(if v1 == band(v1, 65535) then true else false, "isi16")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 2 then true else false, "overflow")
	p1._pos = _pos + 2
	writei16(_h, p1._off + _pos, p2)

	return p1
end
function t.writeu16(p1, p2) --[[ writeu16 | Line: 687 | Upvalues: band (copy), writeu16 (copy) ]]
	assert(if p2 == band(p2, 65535) then true else false, "isu16")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 2 then true else false, "overflow")
	p1._pos = _pos + 2
	writeu16(_h, p1._off + _pos, p2)

	return p1
end
function t.writei24(p1, p2) --[[ writei24 | Line: 693 | Upvalues: band (copy) ]]
	local v1 = p2 + 8388608

	assert(if v1 == band(v1, 16777215) then true else false, "isi24")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(p1._lim - _pos >= 3, "overflow")
	p1._pos = _pos + 3

	local _ = p1._off + _pos

	error("nyi")
end
function t.writeu24(p1, p2) --[[ writeu24 | Line: 699 | Upvalues: band (copy) ]]
	assert(if p2 == band(p2, 16777215) then true else false, "isu24")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(p1._lim - _pos >= 3, "overflow")
	p1._pos = _pos + 3

	local _ = p1._off + _pos

	error("nyi")
end
function t.writei32(p1, p2) --[[ writei32 | Line: 705 | Upvalues: lshift (copy), writei32 (copy) ]]
	local v1 = p2 + 2147483648

	assert(if v1 == lshift(v1, 0) then true else false, "isi32")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 4 then true else false, "overflow")
	p1._pos = _pos + 4
	writei32(_h, p1._off + _pos, p2)

	return p1
end
function t.writeu32(p1, p2) --[[ writeu32 | Line: 711 | Upvalues: lshift (copy), writeu32 (copy) ]]
	assert(if p2 == lshift(p2, 0) then true else false, "isu32")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 4 then true else false, "overflow")
	p1._pos = _pos + 4
	writeu32(_h, p1._off + _pos, p2)

	return p1
end
function t.writei64(p1, p2) --[[ writei64 | Line: 717 | Upvalues: lshift (copy), writeu32 (copy), writei32 (copy) ]]
	local v1 = lshift(p2, 0)
	local v2 = p2 // 4294967296
	local v3 = v2 + 2147483648

	assert((if v3 == lshift(v3, 0) then true else false) and (if p2 == v1 + v2 * 4294967296 then true else false), "isi64")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 8 then true else false, "overflow")
	p1._pos = _pos + 8

	local v7 = p1._off + _pos

	writeu32(_h, v7, p2)
	writei32(_h, v7 + 4, p2 // 4294967296)

	return p1
end
function t.writeu64(p1, p2) --[[ writeu64 | Line: 723 | Upvalues: lshift (copy), writeu32 (copy) ]]
	assert(if p2 == lshift(p2, 0) + lshift(p2 // 4294967296, 0) * 4294967296 then true else false, "isu64")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 8 then true else false, "overflow")
	p1._pos = _pos + 8

	local v4 = p1._off + _pos

	writeu32(_h, v4, p2)
	writeu32(_h, v4 + 4, p2 // 4294967296)

	return p1
end
function t.writef16(p1, p2) --[[ writef16 | Line: 729 | Upvalues: decomposef16 (copy), composef16 (copy), lshift (copy), bor (copy), writeu16 (copy) ]]
	assert(if type(p2) == "number" then true else false, "isnumber")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 2 then true else false, "overflow")
	p1._pos = _pos + 2

	local v5, v6, v7 = decomposef16(p2)

	composef16(v5, v6, v7)
	writeu16(_h, p1._off + _pos, (bor(lshift(v5, 15), lshift(v6, 10), v7)))

	return p1
end
function t.writef32(p1, p2) --[[ writef32 | Line: 735 | Upvalues: writef32 (copy) ]]
	assert(if type(p2) == "number" then true else false, "isnumber")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 4 then true else false, "overflow")
	p1._pos = _pos + 4
	writef32(_h, p1._off + _pos, p2)

	return p1
end
function t.writef64(p1, p2) --[[ writef64 | Line: 741 | Upvalues: writef64 (copy) ]]
	assert(if type(p2) == "number" then true else false, "isnumber")

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p1._lim - _pos >= 8 then true else false, "overflow")
	p1._pos = _pos + 8
	writef64(_h, p1._off + _pos, p2)

	return p1
end
function t.writestring(p1, p2, p3) --[[ writestring | Line: 747 | Upvalues: len2 (copy), floor (copy), writestring (copy) ]]
	assert(if type(p2) == "string" then true else false, "isstring")

	local v2 = len2(p2)

	if p3 == nil then
		p3 = v2
	else
		assert(p3 == floor(p3), "isint")
		assert(p3 >= 0 and p3 < v2, "outofbounds")
	end

	local _h = p1._h

	assert(not p1._ro, "readonly")

	local _pos = p1._pos

	assert(if p3 <= p1._lim - _pos then true else false, "overflow")
	p1._pos = _pos + p3
	writestring(_h, p1._off + _pos, p2, p3)

	return p1
end
function t.writebuffer(p1, p2) --[[ writebuffer | Line: 760 | Upvalues: t2 (copy), writeBuffer (copy) ]]
	assert(type(p2) == "table" and getmetatable(p2) == t2, "isbuffer")
	writeBuffer(p2, p1)

	return p1
end
function t.puti8(p1, p2, p3) --[[ puti8 | Line: 766 | Upvalues: band (copy), floor (copy), writei8 (copy) ]]
	local v1 = p3 + 128

	assert(if v1 == band(v1, 255) then true else false, "isi8")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")
	writei8(p1._h, p1._off + p2, p3)

	return p1
end
function t.putu8(p1, p2, p3) --[[ putu8 | Line: 772 | Upvalues: band (copy), floor (copy), writeu8 (copy) ]]
	assert(if p3 == band(p3, 255) then true else false, "isu8")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim, "outofbounds")
	writeu8(p1._h, p1._off + p2, p3)

	return p1
end
function t.puti16(p1, p2, p3) --[[ puti16 | Line: 778 | Upvalues: band (copy), floor (copy), writei16 (copy) ]]
	local v1 = p3 + 32768

	assert(if v1 == band(v1, 65535) then true else false, "isi16")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")
	writei16(p1._h, p1._off + p2, p3)

	return p1
end
function t.putu16(p1, p2, p3) --[[ putu16 | Line: 784 | Upvalues: band (copy), floor (copy), writeu16 (copy) ]]
	assert(if p3 == band(p3, 65535) then true else false, "isu16")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")
	writeu16(p1._h, p1._off + p2, p3)

	return p1
end
function t.puti24(p1, p2, p3) --[[ puti24 | Line: 790 | Upvalues: band (copy), floor (copy) ]]
	local v1 = p3 + 8388608

	assert(if v1 == band(v1, 16777215) then true else false, "isi24")

	local _h = p1._h

	assert(p2 == floor(p2), "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 3 + 1, "outofbounds")

	local _ = p1._off + p2

	error("nyi")
end
function t.putu24(p1, p2, p3) --[[ putu24 | Line: 796 | Upvalues: band (copy), floor (copy) ]]
	assert(if p3 == band(p3, 16777215) then true else false, "isu24")

	local _h = p1._h

	assert(p2 == floor(p2), "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 3 + 1, "outofbounds")

	local _ = p1._off + p2

	error("nyi")
end
function t.puti32(p1, p2, p3) --[[ puti32 | Line: 802 | Upvalues: lshift (copy), floor (copy), writei32 (copy) ]]
	local v1 = p3 + 2147483648

	assert(if v1 == lshift(v1, 0) then true else false, "isi32")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")
	writei32(p1._h, p1._off + p2, p3)

	return p1
end
function t.putu32(p1, p2, p3) --[[ putu32 | Line: 808 | Upvalues: lshift (copy), floor (copy), writeu32 (copy) ]]
	assert(if p3 == lshift(p3, 0) then true else false, "isu32")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")
	writeu32(p1._h, p1._off + p2, p3)

	return p1
end
function t.puti64(p1, p2, p3) --[[ puti64 | Line: 814 | Upvalues: lshift (copy), floor (copy), writeu32 (copy), writei32 (copy) ]]
	local v1 = lshift(p3, 0)
	local v2 = p3 // 4294967296
	local v3 = v2 + 2147483648

	assert((if v3 == lshift(v3, 0) then true else false) and (if p3 == v1 + v2 * 4294967296 then true else false), "isi64")

	local _h = p1._h

	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")

	local v8 = p1._off + p2

	writeu32(_h, v8, p3)
	writei32(_h, v8 + 4, p3 // 4294967296)

	return p1
end
function t.putu64(p1, p2, p3) --[[ putu64 | Line: 820 | Upvalues: lshift (copy), floor (copy), writeu32 (copy) ]]
	assert(if p3 == lshift(p3, 0) + lshift(p3 // 4294967296, 0) * 4294967296 then true else false, "isu64")

	local _h = p1._h

	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")

	local v5 = p1._off + p2

	writeu32(_h, v5, p3)
	writeu32(_h, v5 + 4, p3 // 4294967296)

	return p1
end
function t.putf16(p1, p2, p3) --[[ putf16 | Line: 826 | Upvalues: floor (copy), decomposef16 (copy), composef16 (copy), lshift (copy), bor (copy), writeu16 (copy) ]]
	assert(if type(p3) == "number" then true else false, "isnumber")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 2 + 1, "outofbounds")

	local v6, v7, v8 = decomposef16(p3)

	composef16(v6, v7, v8)
	writeu16(p1._h, p1._off + p2, (bor(lshift(v6, 15), lshift(v7, 10), v8)))

	return p1
end
function t.putf32(p1, p2, p3) --[[ putf32 | Line: 832 | Upvalues: floor (copy), writef32 (copy) ]]
	assert(if type(p3) == "number" then true else false, "isnumber")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 4 + 1, "outofbounds")
	writef32(p1._h, p1._off + p2, p3)

	return p1
end
function t.putf64(p1, p2, p3) --[[ putf64 | Line: 838 | Upvalues: floor (copy), writef64 (copy) ]]
	assert(if type(p3) == "number" then true else false, "isnumber")
	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - 8 + 1, "outofbounds")
	writef64(p1._h, p1._off + p2, p3)

	return p1
end
function t.putstring(p1, p2, p3, p4) --[[ putstring | Line: 844 | Upvalues: len2 (copy), floor (copy), writestring (copy) ]]
	assert(if type(p3) == "string" then true else false, "isstring")

	local v2 = len2(p3)

	if p4 == nil then
		p4 = v2
	else
		assert(p4 == floor(p4), "isint")
		assert(p4 >= 0 and p4 < v2, "outofbounds")
	end

	assert(if p2 == floor(p2) then true else false, "isint")
	assert(not p1._ro, "readonly")
	assert(p2 >= 0 and p2 < p1._lim - p4 + 1, "outofbounds")
	writestring(p1._h, p1._off + p2, p3, p4)

	return p1
end
function t.putbuffer(p1, p2, p3) --[[ putbuffer | Line: 857 | Upvalues: t2 (copy), putBuffer (copy) ]]
	assert(type(p3) == "table" and getmetatable(p3) == t2, "isbuffer")
	putBuffer(p1, p2, p3)

	return p1
end
function t.readbits(p1, p2) --[[ readbits | Line: 863 | Upvalues: band (copy), min (copy), floor (copy), readu8 (copy), rshift (copy), lshift (copy), bor (copy) ]]
	assert(if p2 == 0 then true elseif band(p2 - 1, 31) == p2 - 1 then true else false)

	local _bpos = p1._bpos
	local _h = p1._h
	local sum = 0
	local v2 = 0

	while sum < p2 do
		local v3
		local v4 = min(8 - _bpos, p2 - sum)

		if _bpos == 0 then
			local _pos = p1._pos

			assert(_pos < p1._lim, "underflow")
			p1._pos = _pos + 1

			local _ = p1._off + _pos
		end

		local v6 = p1._pos - 1

		assert(if v6 == floor(v6) then true else false, "isint")
		v3 = v6 >= 0 and v6 < p1._lim
		assert(v3, "outofbounds")

		local v8 = bor(v2, (lshift(band(rshift(readu8(_h, p1._off + v6), _bpos), lshift(1, v4) - 1), sum)))

		sum, _bpos, v2 = sum + v4, band(_bpos + v4, 7), v8
	end

	p1._bpos = _bpos

	return v2
end
function t.writebits(p1, p2, p3) --[[ writebits | Line: 885 | Upvalues: band (copy), lshift (copy), min (copy), floor (copy), readu8 (copy), bnot (copy), bor (copy), writeu8 (copy), rshift (copy) ]]
	assert(if p3 == 0 then true elseif band(p3 - 1, 31) == p3 - 1 then true else false)
	assert(if band(p2, lshift(1, p3) - 1) == p2 then true else false)

	local _bpos = p1._bpos
	local _h = p1._h

	while p3 > 0 do
		local v3
		local v4 = min(8 - _bpos, p3)
		local v5 = lshift(1, v4) - 1

		if _bpos == 0 then
			assert(not p1._ro, "readonly")

			local _pos = p1._pos

			assert(_pos < p1._lim, "overflow")
			p1._pos = _pos + 1

			local _ = p1._off + _pos
		end

		local v8 = p1._pos - 1

		assert(if v8 == floor(v8) then true else false, "isint")
		assert(not p1._ro, "readonly")
		v3 = v8 >= 0 and v8 < p1._lim
		assert(v3, "outofbounds")

		local v11 = p1._off + v8

		writeu8(_h, v11, (bor(band(readu8(_h, v11), (bnot((lshift(v5, _bpos))))), (lshift(band(p2, v5), _bpos)))))
		p3, _bpos, p2 = p3 - v4, band(_bpos + v4, 7), rshift(p2, v4)
	end

	p1._bpos = _bpos

	return p1
end
function t.writef32bits(p1, p2) --[[ writef32bits | Line: 909 | Upvalues: t (copy), v2 (copy), writef32 (copy), readu32 (copy) ]]
	writef32(v2, 0, p2)
	t.writebits(p1, readu32(v2, 0), 32)

	return p1
end
function t.writef64bits(p1, p2) --[[ writef64bits | Line: 914 | Upvalues: v2 (copy), writef64 (copy), readu32 (copy), t (copy) ]]
	writef64(v2, 0, p2)

	local v1 = readu32(v2, 0)
	local v22 = readu32(v2, 4)

	t.writebits(p1, v1, 32)
	t.writebits(p1, v22, 32)

	return p1
end
function t.readf32bits(p1) --[[ readf32bits | Line: 921 | Upvalues: t (copy), v2 (copy), writeu32 (copy), readf32 (copy) ]]
	writeu32(v2, 0, (t.readbits(p1, 32)))

	return readf32(v2, 0)
end
function t.readf64bits(p1) --[[ readf64bits | Line: 925 | Upvalues: t (copy), v2 (copy), writeu32 (copy), readf64 (copy) ]]
	local v1 = t.readbits(p1, 32)
	local v22 = t.readbits(p1, 32)

	writeu32(v2, 0, v1)
	writeu32(v2, 4, v22)

	return readf64(v2, 0)
end
function t.closebits(p1) --[[ closebits | Line: 929 ]]
	p1._bpos = 0

	return p1
end
function t.bitPosition(p1) --[[ bitPosition | Line: 934 ]]
	return p1._bpos
end
function t.bitPositionTo(p1, p2) --[[ bitPositionTo | Line: 938 | Upvalues: band (copy) ]]
	assert(if band(p2, 7) == p2 then true else false)
	p1._bpos = p2

	return p1
end

local t3 = {
	wrap = function(p1) --[[ wrap | Line: 946 | Upvalues: len (copy), t2 (copy) ]]
		assert(type(p1) == "buffer", "isbuffer")

		local v2 = len(p1)

		return setmetatable({
			_mark = -1,
			_pos = 0,
			_bpos = 0,
			_ro = false,
			_off = 0,
			_lim = v2,
			_cap = v2,
			_h = p1
		}, t2)
	end,
	wrapFrom = function(p1, p2, p3) --[[ wrapFrom | Line: 951 | Upvalues: floor (copy), len (copy), t2 (copy) ]]
		assert(if type(p1) == "buffer" then true else false, "isbuffer")
		assert(if p2 == floor(p2) then true else false, "isint")
		assert(if p3 == floor(p3) then true else false, "isint")

		local v4 = len(p1)

		assert(if v4 > 0 and (p2 > 0 and p3 > 0) then p3 <= v4 - p2 else false, "outofbounds")

		return setmetatable({
			_mark = -1,
			_pos = 0,
			_bpos = 0,
			_ro = false,
			_lim = p3,
			_cap = p3,
			_h = p1,
			_off = p2
		}, t2)
	end,
	allocate = function(p1) --[[ allocate | Line: 959 | Upvalues: floor (copy), create (copy), t2 (copy) ]]
		assert(p1 == floor(p1), "isint")

		return setmetatable({
			_mark = -1,
			_pos = 0,
			_bpos = 0,
			_ro = false,
			_off = 0,
			_lim = p1,
			_cap = p1,
			_h = create(p1)
		}, t2)
	end,
	from = function(p1, p2) --[[ from | Line: 965 | Upvalues: fromstring (copy), floor (copy), len2 (copy), create (copy), writestring (copy), len (copy), t2 (copy) ]]
		assert(if type(p1) == "string" then true else false, "isstring")

		local v2

		if p2 == nil then
			v2 = fromstring(p1)
		else
			assert(if p2 == floor(p2) then true else false, "isint")
			assert(p2 >= 0 and p2 <= len2(p1))

			local v6 = create(p2)

			writestring(v6, 0, p1, p2)
			v2 = v6
		end

		local v7 = len(v2)

		return setmetatable({
			_mark = -1,
			_pos = 0,
			_bpos = 0,
			_ro = false,
			_off = 0,
			_lim = v7,
			_cap = v7,
			_h = v2
		}, t2)
	end
}

local function sizeof32(p1) --[[ sizeof32 | Line: 980 | Upvalues: band (copy) ]]
	if band(p1, 4294901760) == 0 then
		if band(p1, 4294967040) == 0 then
			return 1
		end

		return 2
	end

	if band(p1, 4278190080) == 0 then
		return 3
	end

	return 4
end

local function sizeof64(p1) --[[ sizeof64 | Line: 984 | Upvalues: band (copy) ]]
	local v1 = p1 // 4294967296

	if v1 == 0 then
		if band(p1, 4294901760) == 0 then
			if band(p1, 4294967040) == 0 then
				return 1
			end

			return 2
		end

		if band(p1, 4278190080) == 0 then
			return 3
		end

		return 4
	end

	return 4 + (if band(v1, 4294901760) == 0 then if band(v1, 4294967040) == 0 then 1 else 2 elseif band(v1, 4278190080) == 0 then 3 else 4)
end

local function size32ext(p1) --[[ size32ext | Line: 993 | Upvalues: band (copy) ]]
	if band(p1, 4294967295) ~= p1 then
		return -1
	end

	if band(p1, 4294901760) == 0 then
		if band(p1, 4294967040) ~= 0 then
			return 2
		end

		if p1 == 0 then
			return 0
		end

		return 1
	end

	if band(p1, 4278190080) == 0 then
		return 3
	end

	return 4
end

t3.sizeof32 = sizeof32
t3.sizeof64 = sizeof64
t3.size32ext = size32ext
t3.castf32 = castf32
t3.composef16 = composef16
t3.decomposef16 = decomposef16
table.freeze(t2)
table.freeze(t)
table.freeze(t3)

return t3