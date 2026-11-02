-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: oklab, time of decompilation: Sun May  3 10:10:48 2026 ]]
return {
	fromSRGB = function(vector3: Vector3) --[[ fromSRGB ]] -- line: 34
		local x = vector3.x
		local v6 = if not (x >= 0.04045) then x / 12.92 else ((x + 0.055) / 1.055) ^ 2.4
		local y = vector3.y
		local v8 = if not (y >= 0.04045) then y / 12.92 else ((y + 0.055) / 1.055) ^ 2.4
		local z = vector3.z
		local v10 = vector.create(v6, v8, if not (z >= 0.04045) then z / 12.92 else ((z + 0.055) / 1.055) ^ 2.4)
		local v11 = vector.dot(Vector3.new(0.4122214615345001, 0.5363325476646423, 0.05144599452614784), v10)
		local v12 = if not (v11 >= 0) then -(-v11) ^ 0.3333333333333333 else v11 ^ 0.3333333333333333
		local v13 = vector.dot(Vector3.new(0.21190349757671356, 0.6806995272636414, 0.10739696025848389), v10)
		local v14 = if not (v13 >= 0) then -(-v13) ^ 0.3333333333333333 else v13 ^ 0.3333333333333333
		local v15 = vector.dot(Vector3.new(0.08830246329307556, 0.2817188501358032, 0.6299787163734436), v10)
		local v16 = vector.create(v12, v14, if not (v15 >= 0) then -(-v15) ^ 0.3333333333333333 else v15 ^ 0.3333333333333333)

		return (vector.create(vector.dot(Vector3.new(0.21045425534248352, 0.7936177849769592, -0.004072046838700771), v16), vector.dot(Vector3.new(1.9779984951019287, -2.4285922050476074, 0.4505937099456787), v16), (vector.dot(Vector3.new(0.025904037058353424, 0.7827717661857605, -0.8086757659912109), v16))))
	end,
	toSRGB = function(vector3: Vector3) --[[ toSRGB ]] -- line: 51
		local v18 = vector.create(vector.dot(Vector3.new(1, 0.3963377773761749, 0.21580375730991364), vector3), vector.dot(Vector3.new(1, -0.10556134581565857, -0.0638541728258133), vector3), (vector.dot(Vector3.new(1, -0.08948417752981186, -1.2914855480194092), vector3)))
		local v19 = v18 * v18 * v18
		local v20 = vector.create(vector.dot(Vector3.new(4.076741695404053, -3.307711601257324, 0.23096993565559387), v19), vector.dot(Vector3.new(-1.2684379816055298, 2.609757423400879, -0.34131938219070435), v19), (vector.dot(Vector3.new(-0.004196086432784796, -0.7034186124801636, 1.7076146602630615), v19)))
		local x = v20.x
		local v22 = if not (x >= 0.0031308) then x * 12.92 else x ^ 0.4166666666666667 * 1.055 - 0.055
		local y = v20.y
		local v24 = if not (y >= 0.0031308) then y * 12.92 else y ^ 0.4166666666666667 * 1.055 - 0.055
		local z = v20.z

		return (vector.create(v22, v24, if not (z >= 0.0031308) then z * 12.92 else z ^ 0.4166666666666667 * 1.055 - 0.055))
	end
}
