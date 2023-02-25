bait = {}
evento = {}
blip = {}

function eventoCarro(Player, comando, carro, visibilidade)

    if not carro then
        outputChatBox('#00DCFFUse #EAD909/bait idCarro 0 #00DCFF para deixar invisivel ou #EAD909/bait idCarro #00DCFFpara deixar visivel', Player, 231, 217, 176, true)
        return
    end

    local x,y,z = getElementPosition(Player)
    local rx,ry,rz = getElementRotation(Player)
    setElementPosition(Player, x, y, z + 3)
    bait[#bait + 1] = createVehicle(carro, x,y,z, rx, ry, rz, Placa)
    if visibilidade then 
        setElementAlpha(bait[#bait], visibilidade)
    end
    evento[#bait] = createColRectangle(x-70, y-70, 150, 150)
    local lista = getElementsByType('player')
    addEventHandler('onColShapeHit', evento[#bait], function(source)
        if getElementType(source) == 'vehicle' then
            return
        end
        local lista = getElementsByType('player')
        for i,j in ipairs(lista) do 
            local conta = getAccountName(getPlayerAccount(j))
            if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
                outputChatBox('\n\n\n #EAD909' ..getPlayerName(source) .. '#00DCFF Está próximo do carro do evento', j, 255,255,255, true)
            end
        end
    
    end)

    addEventHandler('onPlayerVehicleEnter', root, function (carro, seat, jacked)
        for i,j in pairs(bait) do 
            if carro == j then
                destroyElement(evento[i])
                local lista = getElementsByType('player')
                for i,j in ipairs(lista) do 
                    local conta = getAccountName(getPlayerAccount(j))
                    if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
                        outputChatBox('\n\n\n#EAD909' ..getPlayerName(source) .. '#00DCFF Pegou o carro', j, 255,255,255, true)
                    end
                end
                bait[i] = nil
            end
        end
    end)
    

end




addCommandHandler('bait',eventoCarro, false, false)
