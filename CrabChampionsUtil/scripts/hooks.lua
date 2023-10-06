require("hookBools")



local startRunHookTable = {};
local PortalEnteredHookTable = {};
local RoundEndHookTable = {};

---@param Function function
function StartRunHook(Function)
    OnStartRunHook = true;
    table.insert(startRunHookTable, Function);
    print("[CrabChampionsUtil] Registered StartRunHook!");
end

---@param Function function
function RoundEndClearHook(Function)
    table.insert(RoundEndHookTable, Function);
    print("[CrabChampionsUtil] Registered RoundEndHook!");
end

---@param Function function
function PortalEnteredHook(Function)
    PortalEnteredHookBool = true;
    table.insert(PortalEnteredHookTable, Function);
    print("[CrabChampionsUtil] Registered PortalEnteredHook!");
end


--[[
    Awful way of doing this, but it works.
    I should be doing some sort of hook onto the sphere object that spawns around the teleporter.
    But I don't know how to do that. So this is what we're doing. Also this only runs on a teleporter activation. We have a few second buffer for the loading screen.
]]
---@param Player ACrabPS
---@param NII FCrabNextIslandInfo
function FireStartRunHooks(Player, NII)
    if OnStartRunHook then
        if not RunStarted then
            RunStarted = true;
            for _, Function in pairs(startRunHookTable) do
                Function(Player, NII);
            end
        end
    end
end

---@param Player ACrabPS
---@param NII FCrabNextIslandInfo
function FirePortalEntered(Player, NII)
    if PortalEnteredHookBool then
        for _, Function in pairs(PortalEnteredHookTable) do
            Function(Player, NII);
        end
    end
end

---@return table<ACrabPS> | nil
function GetAllPlayers()
    ---@type table<ACrabPS>
    local playerTable = FindAllOf("CrabPS");
    if playerTable then
        return playerTable;
    end
    return nil
end

---@param Player ACrabPS
---@param NII FCrabNextIslandInfo
function FireRoundEndClear(Player, NII)
    RoundReset = true;
end


--[[
    This asummes we know when the round ended and the chests are spawned.
    I need to hook the round end event and then run this function. :)
]]
---@return table<ACrabChest> | nil
function GetAllChests()
    ---@type table<ACrabChest>
    local chestTable = FindAllOf("CrabChest");
    if chestTable then
        return chestTable;
    end
    return nil
end

---@param CreatedObject ACrabChest
function FireChestSpawnedForRoundEnd(CreatedObject)
    if RoundReset then
        for _, Function in pairs(RoundEndHookTable) do
            Function(CreatedObject);
        end
        RoundReset = false;
    end
end