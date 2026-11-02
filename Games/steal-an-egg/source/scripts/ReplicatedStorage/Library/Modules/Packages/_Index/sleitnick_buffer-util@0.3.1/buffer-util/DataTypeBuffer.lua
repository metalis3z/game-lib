-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Types)

local t = {
	DataTypesToString = {
		[BrickColor] = "BrickColor",
		[CFrame] = "CFrame",
		[Color3] = "Color3",
		[DateTime] = "DateTime",
		[Ray] = "Ray",
		[Rect] = "Rect",
		[Region3] = "Region3",
		[Region3int16] = "Region3int16",
		[UDim] = "UDim",
		[UDim2] = "UDim2",
		[Vector2] = "Vector2",
		[Vector3] = "Vector3",
		[Vector2int16] = "Vector2int16",
		[Vector3int16] = "Vector3int16"
	},
	ReadWrite = {}
}

t.ReadWrite.BrickColor = {
	write = function(p1, p2) --[[ write | Line: 32 ]]
		p1:WriteUInt16(p2.Number)
	end,
	read = function(p1) --[[ read | Line: 36 ]]
		return BrickColor.new((p1:ReadUInt16()))
	end
}
t.ReadWrite.CFrame = {
	write = function(p1, p2) --[[ write | Line: 43 | Upvalues: t (copy) ]]
		t.ReadWrite.Vector3.write(p1, p2.Position)
		t.ReadWrite.Vector3.write(p1, p2.XVector)
		t.ReadWrite.Vector3.write(p1, p2.YVector)
		t.ReadWrite.Vector3.write(p1, p2.ZVector)
	end,
	read = function(p1) --[[ read | Line: 50 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.Vector3.read(p1)
		local v2 = t.ReadWrite.Vector3.read(p1)
		local v3 = t.ReadWrite.Vector3.read(p1)

		return CFrame.fromMatrix(v1, v2, v3, (t.ReadWrite.Vector3.read(p1)))
	end
}
t.ReadWrite.Color3 = {
	write = function(p1, p2) --[[ write | Line: 60 ]]
		p1:WriteFloat32(p2.R)
		p1:WriteFloat32(p2.G)
		p1:WriteFloat32(p2.B)
	end,
	read = function(p1) --[[ read | Line: 66 ]]
		local v1 = p1:ReadFloat32()
		local v2 = p1:ReadFloat32()

		return Color3.new(v1, v2, (p1:ReadFloat32()))
	end
}
t.ReadWrite.DateTime = {
	write = function(p1, p2) --[[ write | Line: 75 ]]
		p1:WriteFloat64(p2.UnixTimestampMillis)
	end,
	read = function(p1) --[[ read | Line: 79 ]]
		return DateTime.fromUnixTimestampMillis((p1:ReadFloat64()))
	end
}
t.ReadWrite.Ray = {
	write = function(p1, p2) --[[ write | Line: 86 | Upvalues: t (copy) ]]
		t.ReadWrite.Vector3.write(p1, p2.Origin)
		t.ReadWrite.Vector3.write(p1, p2.Direction)
	end,
	read = function(p1) --[[ read | Line: 91 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.Vector3.read(p1)

		return Ray.new(v1, (t.ReadWrite.Vector3.read(p1)))
	end
}
t.ReadWrite.Rect = {
	write = function(p1, p2) --[[ write | Line: 99 | Upvalues: t (copy) ]]
		t.ReadWrite.Vector3.write(p1, p2.Min)
		t.ReadWrite.Vector3.write(p1, p2.Max)
	end,
	read = function(p1) --[[ read | Line: 104 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.Vector3.read(p1)

		return Rect.new(v1, (t.ReadWrite.Vector3.read(p1)))
	end
}
t.ReadWrite.Region3 = {
	write = function(p1, p2) --[[ write | Line: 112 | Upvalues: t (copy) ]]
		local Position = p2.CFrame.Position
		local v1 = p2.Size * 0.5

		t.ReadWrite.Vector3.write(p1, Position - v1)
		t.ReadWrite.Vector3.write(p1, Position + v1)
	end,
	read = function(p1) --[[ read | Line: 121 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.Vector3.read(p1)

		return Region3.new(v1, (t.ReadWrite.Vector3.read(p1)))
	end
}
t.ReadWrite.Region3int16 = {
	write = function(p1, p2) --[[ write | Line: 129 | Upvalues: t (copy) ]]
		t.ReadWrite.Vector3int16.write(p1, p2.Min)
		t.ReadWrite.Vector3int16.write(p1, p2.Max)
	end,
	read = function(p1) --[[ read | Line: 134 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.Vector3int16.read(p1)

		return Region3int16.new(v1, (t.ReadWrite.Vector3int16.read(p1)))
	end
}
t.ReadWrite.UDim = {
	write = function(p1, p2) --[[ write | Line: 142 ]]
		p1:WriteFloat32(p2.Scale)
		p1:WriteInt32(p2.Offset)
	end,
	read = function(p1) --[[ read | Line: 147 ]]
		local v1 = p1:ReadFloat32()

		return UDim.new(v1, (p1:ReadInt32()))
	end
}
t.ReadWrite.UDim2 = {
	write = function(p1, p2) --[[ write | Line: 155 | Upvalues: t (copy) ]]
		t.ReadWrite.UDim.write(p1, p2.X)
		t.ReadWrite.UDim.write(p1, p2.Y)
	end,
	read = function(p1) --[[ read | Line: 160 | Upvalues: t (copy) ]]
		local v1 = t.ReadWrite.UDim.read(p1)

		return UDim2.new(v1, (t.ReadWrite.UDim.read(p1)))
	end
}
t.ReadWrite.Vector2 = {
	write = function(p1, p2) --[[ write | Line: 168 ]]
		p1:WriteFloat32(p2.X)
		p1:WriteFloat32(p2.Y)
	end,
	read = function(p1) --[[ read | Line: 173 ]]
		local v1 = p1:ReadFloat32()

		return Vector2.new(v1, (p1:ReadFloat32()))
	end
}
t.ReadWrite.Vector3 = {
	write = function(p1, p2) --[[ write | Line: 181 ]]
		p1:WriteFloat32(p2.X)
		p1:WriteFloat32(p2.Y)
		p1:WriteFloat32(p2.Z)
	end,
	read = function(p1) --[[ read | Line: 187 ]]
		local v1 = p1:ReadFloat32()
		local v2 = p1:ReadFloat32()

		return Vector3.new(v1, v2, (p1:ReadFloat32()))
	end
}
t.ReadWrite.Vector2int16 = {
	write = function(p1, p2) --[[ write | Line: 196 ]]
		p1:WriteInt16(p2.X)
		p1:WriteInt16(p2.Y)
	end,
	read = function(p1) --[[ read | Line: 201 ]]
		local v1 = p1:ReadInt16()

		return Vector2int16.new(v1, (p1:ReadInt16()))
	end
}
t.ReadWrite.Vector3int16 = {
	write = function(p1, p2) --[[ write | Line: 209 ]]
		p1:WriteInt16(p2.X)
		p1:WriteInt16(p2.Y)
		p1:WriteInt16(p2.Z)
	end,
	read = function(p1) --[[ read | Line: 215 ]]
		local v1 = p1:ReadInt16()
		local v2 = p1:ReadInt16()

		return Vector3int16.new(v1, v2, (p1:ReadInt16()))
	end
}

return t