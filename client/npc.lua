-- funtions
function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0x3CC4A718C258BDD0 , iParam0 );
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- load NPCs
Citizen.CreateThread(function()
    for z, x in pairs(Config.TobaccoNpc) do
    while not HasModelLoaded( GetHashKey(Config.TobaccoNpc[z]["Model"]) ) do
        Wait(500)
        modelrequest( GetHashKey(Config.TobaccoNpc[z]["Model"]) )
    end
    local npc = CreatePed(GetHashKey(Config.TobaccoNpc[z]["Model"]), Config.TobaccoNpc[z]["Pos"].x, Config.TobaccoNpc[z]["Pos"].y, Config.TobaccoNpc[z]["Pos"].z, Config.TobaccoNpc[z]["Heading"], false, false, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    FreezeEntityPosition(npc, false)
    SetEntityInvincible(npc, true)
    TaskStandStill(npc, -1)
    Wait(100)
    SET_PED_RELATIONSHIP_GROUP_HASH(npc, GetHashKey(Config.TobaccoNpc[z]["Model"]))
    SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
    SetEntityAsMissionEntity(npc, true, true)
    SetModelAsNoLongerNeeded(GetHashKey(Config.TobaccoNpc[z]["Model"]))
    end
end)