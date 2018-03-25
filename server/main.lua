ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(Config.Price)
    TriggerClientEvent('esx:showNotification', _source, _U('you_paid') .. '$' .. Config.Price)

end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)



        local itemSkin = {}
        local item1 = string.lower(accessory) .. '_1'
        local item2 = string.lower(accessory) .. '_2'
        itemSkin[item1] = skin[item1]
        itemSkin[item2] = skin[item2]
        store.set(accessory, itemSkin)

    end)

end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)


        local skin = (store.get(accessory)  or {})
        if skin ~={} then
          hasAccessory = true
        else
          hasAccessory = false
        end
        cb(hasAccessory, skin)

    end)

end)

--===================================================================
--===================================================================

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.get('money') >= Config.Price then
        cb(true)
    else
        cb(false)
    end

end)
