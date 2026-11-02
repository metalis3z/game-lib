-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function() --[[ Line: 1 ]]
    local v0 = require(script.Parent.Streamable);
    local v1 = require(script.Parent.StreamableUtil);
    local v2 = nil;
    local function _(v3) --[[ Line: 7 ]] --[[ Name: CreateInstance ]]
        -- upvalues: v2 (ref)
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = v3;
        l_Folder_0.Archivable = false;
        l_Folder_0.Parent = v2;
        return l_Folder_0;
    end;
    beforeAll(function() --[[ Line: 15 ]]
        -- upvalues: v2 (ref)
        v2 = Instance.new("Folder");
        v2.Name = "KnitTest";
        v2.Archivable = false;
        v2.Parent = workspace;
    end);
    afterEach(function() --[[ Line: 22 ]]
        -- upvalues: v2 (ref)
        v2:ClearAllChildren();
    end);
    afterAll(function() --[[ Line: 26 ]]
        -- upvalues: v2 (ref)
        v2:Destroy();
    end);
    describe("Compound", function() --[[ Line: 30 ]]
        -- upvalues: v0 (copy), v2 (ref), v1 (copy)
        it("should capture multiple streams", function() --[[ Line: 31 ]]
            -- upvalues: v0 (ref), v2 (ref), v1 (ref)
            local v6 = v0.new(v2, "ABC");
            local v7 = v0.new(v2, "XYZ");
            local v8 = 0;
            local v9 = 0;
            v1.Compound({
                S1 = v6, 
                S2 = v7
            }, function(_, v11) --[[ Line: 36 ]]
                -- upvalues: v8 (ref), v9 (ref)
                v8 = v8 + 1;
                v11:Add(function() --[[ Line: 38 ]]
                    -- upvalues: v9 (ref)
                    v9 = v9 + 1;
                end);
            end);
            local l_Folder_1 = Instance.new("Folder");
            l_Folder_1.Name = "ABC";
            l_Folder_1.Archivable = false;
            l_Folder_1.Parent = v2;
            local l_l_Folder_1_0 = l_Folder_1;
            local l_Folder_2 = Instance.new("Folder");
            l_Folder_2.Name = "XYZ";
            l_Folder_2.Archivable = false;
            l_Folder_2.Parent = v2;
            l_Folder_1 = l_Folder_2;
            task.wait();
            l_l_Folder_1_0.Parent = nil;
            task.wait();
            l_l_Folder_1_0.Parent = v2;
            task.wait();
            l_l_Folder_1_0.Parent = nil;
            l_Folder_1.Parent = nil;
            task.wait();
            l_Folder_1.Parent = v2;
            task.wait();
            expect(v8).to.equal(2);
            expect(v9).to.equal(2);
            v6:Destroy();
            v7:Destroy();
        end);
    end);
end;