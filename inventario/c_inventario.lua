local dentro = false
local paredeC = nil
local tabelaC = nil
local ammoC = nil
local nomeC = nil
local COLETE_LIMITE = 50
local listaInventario = {}
local tela = {}
local arma = {
    ['M4'] = {nome = 'M4', ammo = 30, id = 356},
    ['AK-47'] = {nome = 'AK-47', ammo = 30, id = 355},
    ['COMBAT SHOTGUN'] = {nome = 'COMBAT SHOTGUN', ammo = 7, id = 351},
    ['SHOTGUN'] = {nome = 'SHOTGUN', ammo = 7, id = 349},
    ['DEAGLE'] = {nome = 'DEAGLE', ammo = 7, id = 348},
    ['SILENCED'] = {nome = 'SILENCED', ammo = 17, id = 347},
    ['RIFLE'] = {nome = 'RIFLE', ammo = 10, id = 357},
    ['SNIPER'] = {nome = 'SNIPER', ammo = 10, id = 358},
    ['FLAMETHROWER'] = {nome = 'FLAMETHROWER', ammo = 20, id = 361},
    ['GRENADE'] = {nome = 'GRENADE', ammo = 1, id = 342},
    ['MOLOTOV'] = {nome = 'MOLOTOV', ammo = 1, id = 344},
    ['MEDKIT'] = {nome = 'MEDKIT', ammo = 100, id = 1580 },
    ['COLETE'] = {nome = 'COLETE', ammo = 25, id = 1242},
    ['BANDAGE'] = {nome = 'BANDAGE', ammo = 30, id = 1575 }

}

local function getWindowPosition(width, height)
    local screenWidth, screenHeight = guiGetScreenSize()
    local x = (screenWidth / 2) - (width / 2)
    local y = (screenHeight / 2) - (height / 2)

    return x, y, width, height
end

function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end
    
    return next(a) == nil
end

function clone (t)           -- t is a table
    local new_t = {}           -- create a new table
    local i, v = next(t, nil)  -- i is an index of t, v = t[i]
    while i do
      new_t[i] = v
      i, v = next(t, i)        -- get next index
    end
    return new_t
end


function dentroTrue(item, parede, tabela, ammo, nome)

    dentro = true
    paredeC = parede
    tabelaC = tabela
    ammoC = ammo
    nomeC = nome

end
addEvent('entrou', true)
addEventHandler('entrou', localPlayer, dentroTrue)


local function isInside()
    if paredeC == nil then 
        return 
    end
    if dentro then
        triggerServerEvent('dar:arma', localPlayer, localPlayer, paredeC, tabelaC, ammoC)
        if table.empty( listaInventario ) then
            listaInventario[0] = nomeC
            paredeC = nil
            tabelaC = nil
            ammoC = nil
            nomeC = nil
            dentro = false
            return
        end
        listaInventario[#listaInventario + 1] = nomeC

        paredeC = nil
        tabelaC = nil
        ammoC = nil
        nomeC = nil
        dentro = false
    end
end
addCommandHandler('take', isInside)

local function verInventario()
    for a,b in pairs(listaInventario) do
        outputChatBox(listaInventario[a])
    end
end
addCommandHandler('itens',verInventario)

function dentroFalse(item)
    dentro = false
end
addEvent('saiu', true)
addEventHandler('saiu', localPlayer, dentroFalse)


--------------------------------------- DAQUI PRA CIMA É O CÓDIGO PRA PEGAR
--------------------------------------- COMEÇA A TELA DAQUI PRA BAIXO



function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end


function inventario()
    showCursor(true, false)
    
    local x, y, width, height = getWindowPosition(550, 550)
    tela['inventario'] = guiCreateWindow(x, y, width, height, 'Inventário', false)
    --guiSetInputEnabled(true)
    --centerWindow(tela['inventario'])
    guiSetInputMode('no_binds')
    guiSetVisible(tela['inventario'], true)
    guiWindowSetSizable(tela['inventario'], false)



    tela['lista'] = guiCreateGridList(50, 30, width - 100, height - 110, false, tela['inventario'])
    guiGridListAddColumn(tela['lista'], 'Itens',1)
    
    for i=0,10 do
      guiGridListAddRow(tela['lista'], listaInventario[i])
    end




    guiGridListSetScrollBars(tela['lista'], false, false)



    tela['usar'] = guiCreateButton(95, 470+10, 175, 30*2, 'Usar', false, tela['inventario'])
    tela['dropar'] = guiCreateButton(95 + 175+20, 470+10, 175, 30*2, 'Dropar', false, tela['inventario'])
    guiSetProperty(tela['usar'], 'Font', 'default-bold-small')
    guiSetProperty(tela['dropar'], 'Font', 'default-bold-small')
    guiSetProperty(tela['usar'], 'NormalTextColour', 'ff4aa832')
    guiSetProperty(tela['dropar'], 'NormalTextColour', 'ffed2626')
    guiSetProperty(tela['inventario'], 'Alpha', '90')
    guiWindowSetMovable(tela['inventario'], false)
    

    addEventHandler('onClientGUIClick', tela['usar'], function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return 
        end
        local x, y = guiGridListGetSelectedItem(tela['lista'])
        if x == -1 then 
            destroyElement(tela['inventario'])
            guiSetInputEnabled(false)
            showCursor(false, false)
            return
        end
        local item = guiGridListGetItemText(tela['lista'], x, y)

        
        destroyElement(tela['inventario'])
        guiSetInputEnabled(false)
        local municao
        if item == 'AK-47' or item == 'M4' then
            municao = 30
        end
        if item == 'SHOTGUN' or item == 'DEAGLE' or item == 'COMBAT SHOTGUN' then
            municao = 7
        end
        if item == 'SNIPER' or item == 'RIFLE' or item == 'FLAMETHROWER'then
            municao = 10
        end
        if item == 'GRENADE' or item == 'MOLOTOV'then
            municao = 1
        end
        if item == 'SILENCED' then
            municao = 14
        end
        if item == 'COLETE' then
            local controle = getPedArmor(localPlayer)
            if controle >= COLETE_LIMITE then 
                outputChatBox('nivel maximo de colete', 230, 30, 30)
                showCursor(false, false)
                return
            end
            setPedArmor(localPlayer, controle + 25)
            showCursor(false, false)
            listaInventario[x] = nil
            return
        end
        if item == 'MEDKIT' then
            local controle = getElementHealth(localPlayer)
            if controle == 100 then 
                outputChatBox('Vida Cheia', 30, 230, 30)
                showCursor(false, false)
                return
            end
            setElementHealth(localPlayer, 100)
            listaInventario[x] = nil
            showCursor(false, false)
            return
        end
        if item == 'BANDAGE' then 
            local controle = getElementHealth(localPlayer)
            if controle == 100 then 
                outputChatBox('Vida Cheia', 30, 230, 30)
                showCursor(false, false)
                return
            end
            setElementHealth(localPlayer, controle + 30)
            listaInventario[x] = nil
            showCursor(false, false)
            return
        end
        listaInventario[x] = nil
        showCursor(false, false)
        triggerServerEvent('dar:arma2',localPlayer, localPlayer, item, municao)


    end, false)

    addEventHandler('onClientGUIClick', tela['dropar'], function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return 
        end
        local a, b = guiGridListGetSelectedItem(tela['lista'])
        if a == -1 then 
            destroyElement(tela['inventario'])
            showCursor(false, false)
            guiSetInputEnabled(false)
            return
        end
        local item = guiGridListGetItemText(tela['lista'], a, b)
        local x, y, z = getElementPosition(localPlayer)
        if item ~= nil then 
            destroyElement(tela['inventario'])
            listaInventario[a]=nil
            triggerServerEvent('drop:item',localPlayer, arma[item], x, y, z)
            showCursor(false, false)
            guiSetInputEnabled(false)
            return
        end

    end, false)



end

addCommandHandler('inv',inventario)



