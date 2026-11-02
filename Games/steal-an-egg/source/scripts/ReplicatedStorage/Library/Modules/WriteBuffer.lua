-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 4 | Upvalues: t (copy) ]]
	return setmetatable({
		offset = 0,
		currentSize = 0,
		stepSize = 128,
		buf = nil,
		startSize = if p1 == nil then 0 else math.max(p1, 0)
	}, t)
end
function t.GetBuffer(p1) --[[ GetBuffer | Line: 21 ]]
	if buffer.len(p1.buf) == p1.offset then
		return p1.buf
	end

	local v1 = buffer.create(p1.offset)

	p1.currentSize = p1.offset
	buffer.copy(v1, 0, p1.buf, 0, p1.offset)
	p1.buf = v1

	return v1
end
function t.CheckSize(p1, p2) --[[ CheckSize | Line: 34 ]]
	if p1.buf ~= nil and not (p1.currentSize < p1.offset + p2) then
		return
	end

	if p1.buf == nil then
		p1.currentSize = math.max(p1.startSize, p2)
	else
		p1.currentSize = p1.currentSize + math.max(p1.stepSize, p2)
	end

	local v2 = buffer.create(p1.currentSize)

	if p1.buf then
		buffer.copy(v2, 0, p1.buf, 0, p1.offset)
	end

	p1.buf = v2
end
function t.WriteU8(p1, p2) --[[ WriteU8 | Line: 50 ]]
	p1:CheckSize(1)
	buffer.writeu8(p1.buf, p1.offset, p2)
	p1.offset = p1.offset + 1
end
function t.WriteI16(p1, p2) --[[ WriteI16 | Line: 56 ]]
	p1:CheckSize(2)
	buffer.writeu16(p1.buf, p1.offset, p2)
	p1.offset = p1.offset + 2
end
function t.WriteVector3(p1, p2) --[[ WriteVector3 | Line: 62 ]]
	p1:CheckSize(12)
	buffer.writef32(p1.buf, p1.offset, p2.X)
	p1.offset = p1.offset + 4
	buffer.writef32(p1.buf, p1.offset, p2.Y)
	p1.offset = p1.offset + 4
	buffer.writef32(p1.buf, p1.offset, p2.Z)
	p1.offset = p1.offset + 4
end
function t.WriteFloat16(p1, p2) --[[ WriteFloat16 | Line: 72 ]]
	p1:CheckSize(2)

	local v1 = p2 < 0
	local v2 = math.abs(p2)
	local v3, v4 = math.frexp(v2)

	if v2 == (1 / 0) then
		if v1 then
			buffer.writeu8(p1.buf, p1.offset, 252)
		else
			buffer.writeu8(p1.buf, p1.offset, 124)
		end

		p1.offset = p1.offset + 1
		buffer.writeu8(p1.buf, p1.offset, 0)
	elseif v2 == v2 and v2 ~= 0 then
		if v4 + 15 <= 1 then
			local v5 = math.floor(v3 * 1024 + 0.5)

			if v1 then
				buffer.writeu8(p1.buf, p1.offset, bit32.rshift(v5, 8) + 128)
			else
				buffer.writeu8(p1.buf, p1.offset, (bit32.rshift(v5, 8)))
			end

			p1.offset = p1.offset + 1
			buffer.writeu8(p1.buf, p1.offset, (bit32.band(v5, 255)))
		else
			local v10 = math.floor((v3 - 0.5) * 2048 + 0.5)

			if v1 then
				buffer.writeu8(p1.buf, p1.offset, bit32.lshift(v4 + 14, 2) + 128 + bit32.rshift(v10, 8))
			else
				buffer.writeu8(p1.buf, p1.offset, bit32.lshift(v4 + 14, 2) + bit32.rshift(v10, 8))
			end

			p1.offset = p1.offset + 1
			buffer.writeu8(p1.buf, p1.offset, (bit32.band(v10, 255)))
		end
	else
		buffer.writeu8(p1.buf, p1.offset, 0)
		p1.offset = p1.offset + 1
		buffer.writeu8(p1.buf, p1.offset, 0)
	end

	p1.offset = p1.offset + 1
end

return t