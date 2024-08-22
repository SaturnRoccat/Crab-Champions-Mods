
print("[itemiser] Loaded!")

---@type boolean
local foundWeaponMods = false;
---@type boolean
local foundPerks = false;
---@type boolean
local foundGrenadeMods = false;

---@return table<UCrabWeaponModDA>
function GetAllCWMDA()
    ---@type table<UCrabWeaponModDA>
    local CWMDA = FindAllOf("CrabWeaponModDA");
    print("[itemiser] found " .. #CWMDA .. " weapon mods");
    return CWMDA;
end

---@return table<UCrabPerkDA>
function GetAllCPDA()
    ---@type table<UCrabPerkDA>
    local CPDA = FindAllOf("CrabPerkDA");
    print("[itemiser] found " .. #CPDA .. " perks");
    return CPDA;
end

---@return table<UCrabGrenadeModDA>
function GetAllCGMDA()
    ---@type table<UCrabGrenadeModDA>
    local CGMDA = FindAllOf("CrabGrenadeModDA");
    print("[itemiser] found " .. #CGMDA .. " grenade mods");
    return CGMDA;
end

---@type table<UCrabWeaponModDA> 
CWMDA = {};
---@type table<UCrabPerkDA>
CPDA = {};
---@type table<UCrabGrenadeModDA>
CGMDA = {};

function GetAllModData()
    if not foundWeaponMods then
        CWMDA = GetAllCWMDA();
        foundWeaponMods = true;
    end
    if not foundPerks then
        CPDA = GetAllCPDA();
        foundPerks = true;
    end
    if not foundGrenadeMods then
        CGMDA = GetAllCGMDA();
        foundGrenadeMods = true;
    end
end

---@param Player ACrabPS
function RandomiseWMD(Player)
    print("[itemiser] randomising weapon mods for a player");
    ---@param PFmod FCrabWeaponMod
    Player.WeaponMods:ForEach(function(index, PFmod)
        ---@type FCrabWeaponMod
        local FMod = PFmod:get();
        FMod.WeaponModDA = CWMDA[math.random(1, #CWMDA)];
    end)

    print("[itemiser] randomising perks for a player");
    ---@param PFperk FCrabPerk
    Player.Perks:ForEach(function(index, PFperk)
        ---@type FCrabPerk
        local FPerk = PFperk:get();
        FPerk.PerkDA = CPDA[math.random(1, #CPDA)];
    end)

    print("[itemiser] randomising grenade mods for a player");
    ---@param PFmod FCrabGrenadeMod
    Player.GrenadeMods:ForEach(function(index, PFmod)
        ---@type FCrabGrenadeMod
        local FMod = PFmod:get();
        FMod.GrenadeModDA = CGMDA[math.random(1, #CGMDA)];
    end)
end

---@param CRAB ACrabPC
---@param nim any
function ModifyPlayerData(CRAB, nim)
    print("[itemiser] player went through portal!")

    GetAllModData();
    ---@type table<ACrabPS>
    local CrabPS = FindAllOf("CrabPS");
    ---@param c ACrabPS
    for i, c in ipairs(CrabPS) do
        print(string.format("[itemiser] randomising player %s", i));
        RandomiseWMD(c);
    end
end

Keybinds = {
    ["RandomizeMods"] = {["Key"] = Key.R, ["ModifierKeys"] = {ModifierKey.CONTROL}} -- Randomize inventory keybind set to Ctrl + R
}

local function RandomizeMods()
    print("[itemiser] Randomization key pressed!")
    GetAllModData()
    local CrabPS = FindAllOf("CrabPS")
    for i, c in ipairs(CrabPS) do
        print(string.format("[itemiser] randomising player %s", i))
        RandomiseWMD(c)
    end
end

local function RegisterKey(KeyBindName, Callable)
    if (Keybinds[KeyBindName] and not IsKeyBindRegistered(Keybinds[KeyBindName].Key, Keybinds[KeyBindName].ModifierKeys)) then
        RegisterKeyBindAsync(Keybinds[KeyBindName].Key, Keybinds[KeyBindName].ModifierKeys, Callable)
    end
end

RegisterKey("RandomizeMods", RandomizeMods) 

-- RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEnteredPortal", ModifyPlayerData, CRAB, nim);
