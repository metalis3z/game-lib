-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMeBlBhcmVudAVNb2RlbANJc0EHRWZmZWN0cw5GaW5kRmlyc3RDaGlsZBhnZXRFZmZlY3RzRm9sZGVyRnJvbVNlYXQFcHJpbnRJW0RFQlVHIFZFSElDTEVfU0VBVElOR10gaGFuZGxlT2NjdXBhbnRDaGFuZ2UgdHJpZ2dlcmVkLiBDdXJyZW50IE9jY3VwYW50OghPY2N1cGFudAROYW1lA25pbBZHZXRQbGF5ZXJGcm9tQ2hhcmFjdGVyMVtERUJVRyBWRUhJQ0xFX1NFQVRJTkddIEZpcmluZyBlbnRlckNhbGxiYWNrIGZvcjorW0RFQlVHIFZFSElDTEVfU0VBVElOR10gRmlyaW5nIGV4aXRDYWxsYmFjaxRoYW5kbGVPY2N1cGFudENoYW5nZQRnYW1lDklzRGVzY2VuZGFudE9mCkRpc2Nvbm5lY3QrW0RFQlVHIFZFSElDTEVfU0VBVElOR10gQWRkU2VhdCBjYWxsZWQgZm9yOg1PcGVuQ2xvc2VEb29yBUNsb25lGEdldFByb3BlcnR5Q2hhbmdlZFNpZ25hbAdDb25uZWN0W1tERUJVRyBWRUhJQ0xFX1NFQVRJTkddIFNlYXQgYWxyZWFkeSBoYXMgYW4gb2NjdXBhbnQgdXBvbiBpbml0aWFsaXphdGlvbi4gRm9yY2luZyBjYWxsYmFjay4PQW5jZXN0cnlDaGFuZ2VkB0FkZFNlYXQQU2V0UmVtb3Rlc0ZvbGRlchdTZXRCaW5kYWJsZUV2ZW50c0ZvbGRlcgdQbGF5ZXJzCkdldFNlcnZpY2UABwUBAQAAABVNAQAkAAAAAG8EAQC8AgH+AgAAAJ8CAwIOAgwAbwQDALwCAQMEAAAAnwIDAg4CAwBNAgGXAwAAAIICAgD7AgAAUgMBAJ8CAgCCAgAAxgIAAIICAgAFAwEDAgMDAwQDBQAEBgEYAAABAAAAAAEAAAAAAAAAAAAAAAIABQAAAAAEAAUAAAA9pAABAAAAAEBvAQIA+wMAAE0DA5YDAAAADgMGAPsCAABNAgKWAwAAAE0CAroEAAAAKwIBAG8CBQCfAAMB+wAAAE0AAJYDAAAADgAdAPsAAQAOACcA+wAAAE0AAJYDAAAA3gACAPsAAwD7AgIATQICJAYAAAC8AACJBwAAAJ8AAwJSAQAAKwEBAPsBAgDeAQIApAEBAAAAAEBvAggA+wMCAE0DA7oEAAAAnwEDAfsBAQD7AgIA+wMAAJ8BAwGCAAEA+wAEAA4ACgCkAAEAAAAAQG8BCQCfAAIB+wAEAPsBAgD7AgAAnwADAcYAAADeAAIAggABAAoDBwQAAABAAwgDCQMKAwsDAQMMAw0DDgAWDwEYAAAAAAAAAAAAAAAAAAAAAQAAAAEAAQAAAAEAAAAAAAABAAAAAQAAAAAAAAEAAAAAAgABAAAAAQAAAAEAAhcAAAAAAwACAAAADPsAAACkAgEAAAAAQLwAAK0CAAAAnwADAisABAD7AAEAvAAAGgMAAACfAAIBggABAAQDEAQAAABAAxEDEgAuAAEYAAAAAAAAAAEAAAACLwAAAAAKAwIAAABIpAMBAAAAAEBvBAIATQUAugMAAACfAwMBTQQAJAQAAABvBwUAvAUE/gYAAACfBQMCDgUNAG8HBwC8BQQDCAAAAJ8FAwIOBQMATQMElwcAAABlAAYA+wUAAFIGBACfBQICUgMFAGUAAQDGAwAADgMKAG8GCQC8BAMDCAAAAJ8EAwIOBAUAvAUEOgoAAACfBQICMAAFJAQAAADGBAAA2QUAABIAAAASAAEAEgEE/xICAQASAAIAbwgLALwGAJQMAAAAnwYDAlIIBQC8BgbHDQAAAJ8GAwJNBwCWCwAAAA4HBgCkBwEAAAAAQG8IDgCfBwIBUgcFAJ8HAQFNBwCLDwAAANkJAQASAAAAEgAGALwHB8cNAAAAnwcDAcEEAACCAAEAEAMHBAAAAEADEwMKAwEDAgMDAwQDBQMUAxUDCQMWAxcDGAMZAgECDBoBGAgAAAAAAPgAAQAAAAABAAAAAAAAAAAAAAAAAgYBAAAAAQAAAAAAAwIAAAAAABEAAAAAAAAAAgAAAQAAAAEAAwAAAAAAAAAFAAUAAAAAAAAAAAAAAYIAAQAAADUbARgANQAAAAAAAAAAAAABggABAAAANhwBGAA2AAAAAAQAAAECABejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMC/wEDAAAAAADAAgQAEgACAMADBQASAAIAEgAAADADAfMGAAAAwAMHADADAeQIAAAAwAMJADADAa8KAAAAggECAAsDEAQAAABAAx0DHgYABgMDGgYEAxsGBQMcBAADBAUBAAEYAAAAAAAAAAEAAgAIAAAAACkAAAEAAAIBAAAAAAZFuDCp1OVreNwRE0N8lQdnNaAn3Xd8Wqg=

-- decompilation:
local l_Players_0 = game:GetService("Players");
local v1 = {};
local function v2(v3) --[[ Line: 4 ]] --[[ Name: getEffectsFolderFromSeat ]]
    -- upvalues: v2 (copy)
    local l_Parent_0 = v3.Parent;
    if l_Parent_0:IsA("Model") then
        if l_Parent_0:FindFirstChild("Effects") then
            return l_Parent_0.Effects;
        else
            return v2(l_Parent_0);
        end;
    else
        return nil;
    end;
end;
v1.AddSeat = function(v5, v6, v7) --[[ Line: 12 ]] --[[ Name: AddSeat ]]
    -- upvalues: v2 (copy), l_Players_0 (copy)
    print("[DEBUG VEHICLE_SEATING] AddSeat called for:", v5.Name);
    local l_Parent_1 = v5.Parent;
    local v9 = if l_Parent_1:IsA("Model") then if l_Parent_1:FindFirstChild("Effects") then l_Parent_1.Effects else v2(l_Parent_1) else nil;
    if v9 then
        l_Parent_1 = v9:FindFirstChild("OpenCloseDoor");
        if l_Parent_1 then
            l_Parent_1:Clone().Parent = v5;
        end;
    end;
    l_Parent_1 = nil;
    local function v10() --[[ Line: 22 ]] --[[ Name: handleOccupantChange ]]
        -- upvalues: v5 (copy), v6 (copy), l_Parent_1 (ref), l_Players_0 (ref), v7 (copy)
        print("[DEBUG VEHICLE_SEATING] handleOccupantChange triggered. Current Occupant:", v5.Occupant and v5.Occupant.Name or "nil");
        if v5.Occupant then
            if v6 then
                l_Parent_1 = v5.Occupant;
                l_Parent_1 = l_Players_0:GetPlayerFromCharacter(l_Parent_1.Parent) or l_Parent_1;
                print("[DEBUG VEHICLE_SEATING] Firing enterCallback for:", l_Parent_1.Name);
                v6(l_Parent_1, v5);
                return;
            end;
        elseif v7 then
            print("[DEBUG VEHICLE_SEATING] Firing exitCallback");
            v7(l_Parent_1, v5);
            l_Parent_1 = nil;
        end;
    end;
    local v11 = v5:GetPropertyChangedSignal("Occupant"):Connect(v10);
    if v5.Occupant then
        print("[DEBUG VEHICLE_SEATING] Seat already has an occupant upon initialization. Forcing callback.");
        v10();
    end;
    v5.AncestryChanged:Connect(function() --[[ Line: 46 ]]
        -- upvalues: v5 (copy), v11 (copy)
        if not v5:IsDescendantOf(game) then
            v11:Disconnect();
        end;
    end);
end;
v1.SetRemotesFolder = function() --[[ Line: 53 ]] --[[ Name: SetRemotesFolder ]]

end;
v1.SetBindableEventsFolder = function() --[[ Line: 54 ]] --[[ Name: SetBindableEventsFolder ]]

end;
return v1;
