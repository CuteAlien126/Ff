using HorizonSideRobots
r=Robot("untitled.sit",animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
left(Side::HorizonSide)=HorizonSide(mod(Int(Side)+1,4))

function seek_spc!(r,obr_Side)
    kol=0
    Side=left(obr_Side)
    while isborder(r,obr_Side)
        kol+=1
        move_kol!(r,Side,kol)
        Side=inverse(Side)
    end
    move!(r,obr_Side)
    move_kol!(r,Side,div((kol+1),2))

end

function move_kol!(r,Side::HorizonSide,kol)
    for x in 1:kol
        move!(r,Side)
    end    
end

seek_spc!(r,Nord)