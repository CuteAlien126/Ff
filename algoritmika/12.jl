using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function kol_per!(r)
    W,S =kol_numsteps!(r, West), kol_numsteps!(r, Sud)
    if !isborder(r, Nord)
        move!(r, Nord)
    else
        return 0
    end
    s=snake!(r)
    kol_numsteps!(r,Nord,S)
    kol_numsteps!(r,Ost,W)
    return s
end

function kol_numsteps!(r, Side)::Int
    kol=0
    while !isborder(r, Side)
        move!(r, Side)
        kol+=1
    end
    return kol
end

function snake!(r)
    kol=0
    Side=Ost
    while !isborder(r,Nord)
        x=state_numsteps!(r,Side)
        move!(r, Nord)
        Side=inverse(Side)
        kol+=x
    end
    n+=state_numsteps!(r, Side)
    return kol
end

function state_numsteps!(r, Side)
    x=0
    z=0
    y=0
    w=0
    while !isborder(r, Side)
        w=z
        z=y
        if isborder(r, Sud)
            y=1
        else
            y=0
        end
        if  (y==0) & (z==0)
            x+=w  
        end
        move!(r, Side)
    end
    if (y==1) || (z==1)
        x+=1
    end
    println(x)
    return x
end


kol_per!(r)
