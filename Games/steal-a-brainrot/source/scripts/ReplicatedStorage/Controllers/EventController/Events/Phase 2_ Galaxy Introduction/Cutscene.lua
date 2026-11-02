local v1 = ""
for v2 = 1, 5 do
    local v3 = script[("Chunk_%*"):format((tostring(v2)))]
    v1 = v1 .. v3.Value
    v3.Value = ""
end
return v1