using HorizonSideRobots
r=Robot(animate=true)
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

function walls_count(r)
    west_steps=num_steps_along!(r, West)
    sud_steps=num_steps_along!(r, Sud)

    walls=0
    flag=0
    side=West
    while !isborder(r, Nord)
        flag=0
        side=inverse(side)
        while !isborder(r, side)
            if isborder(r, Nord) && flag == 0
                walls+=1
                flag=1
            end
            if !isborder(r, Nord)
                flag=0
            end
            move!(r, side)
        end
        move!(r, Nord)
    end

    num_steps_along!(r, West)
    num_steps_along!(r, Sud)
    along!(r, Nord, sud_steps)
    along!(r, Ost, west_steps)

    return(walls)
end

function num_steps_along!(r, side)::Int
    num_steps = 0
    while !isborder(r, side)
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function along!(r, side, num_steps)::Nothing
    for x in 1:num_steps
        move!(r, side)
    end
end

print(walls_count(r))
