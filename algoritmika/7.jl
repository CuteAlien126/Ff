using HorizonSideRobots
r=Robot("pr.sit",animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
left(Side::HorizonSide)=HorizonSide(mod(Int(Side)+1,4))

function chelnok!(r,dr_Side)
    kol=0
    Side=left(dr_Side)
    while isborder(r,dr_Side)
        kol+=1
        move_kol!(r,Side,kol)
        Side=inverse(Side)
    end
end

function move_kol!(r,Side,kol)
    for x in 1:kol
        move!(r,Side)
    end    
end

chelnok!(r,Nord)