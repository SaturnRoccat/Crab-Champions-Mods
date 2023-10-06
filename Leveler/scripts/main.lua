
---@param CRAB ACrabPC
---@param nim any
function ModifyItemLevel(CRAB, nim)
    print("Starting LoopChests");

    ExecuteWithDelay(3000, function()
        local CrabPS = FindAllOf("CrabPS");
        if not CrabPS then
            print("No CrabPS Found");
            return;
        else
            print("Found CrabPS with " .. #CrabPS .. " entries");
            print(string.format("user one has %s perk slots", CrabPS[1].NumPerkSlots));
            ---@param v ACrabPS
            for i, v in ipairs(CrabPS)  do
                print(string.format("player %s has %s weapon mods", i, v.WeaponMods:GetArrayNum()));


                ---@param wmod FCrabWeaponMod
                v.WeaponMods:ForEach(function(index, wmod)
                    ---@type FCrabWeaponMod
                    local mod = wmod:get();
                    mod.Level = math.random(0, 255);
                    mod.WeaponModDA.WeaponModType = math.random(1, 83);
                end)
                ---@param wmod FCrabGrenadeMod
                v.GrenadeMods:ForEach(function(index, wmod)
                    ---@type FCrabGrenadeMod
                    local mod = wmod:get();
                    mod.Level = math.random(0, 255);
                end)
                ---@param wmod FCrabPerk
                v.Perks:ForEach(function(index, wmod)
                    ---@type FCrabPerk
                    local mod = wmod:get();
                    mod.Level = math.random(0, 255);
                end)
            end
        end
    
    end)
end
RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEnteredPortal", ModifyItemLevel, CRAB, nim);