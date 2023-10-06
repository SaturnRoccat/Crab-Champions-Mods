print("Loaded The Crab Champions Modding Utils UE4SS Library")
require("hooks")



RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEnteredPortal", FireStartRunHooks, Player, NII);
RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEnteredPortal", FirePortalEntered, Player, NII);
RegisterHook("/Script/CrabChampions.CrabPC:ClientOnEnteredPortal", FireRoundEndClear, Player, NII);

NotifyOnNewObject("/Script/CrabChampions.CrabChest", FireChestSpawnedForRoundEnd, CreatedObject)