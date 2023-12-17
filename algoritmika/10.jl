using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function proiz_chess(r,N)
    num_Sud=num_steps_along!(r,Sud)
    num_West=num_steps_along!(r,West)

    kol=0
    state_1=1
    state_2=1
    state_3=0
    while true
        for x in 1:N
            kol=0
            state_1=state_2
            while !isborder(r,Ost)
                if kol<N && state_1==1
                    putmarker!(r)
                end
                move!(r, Ost)

                kol+=1

                if kol==N
                    if state_1==1
                        state_1=0
                    else
                        state_1=1
                    end
                    kol=0
                end
            end
            if isborder(r,Ost) && state_1==1
                putmarker!(r)
            end
            num_steps_along!(r,West)

            if isborder(r, Nord)
                state_3=1
                break
            end

            move!(r, Nord)
        end
        if flag_end == 1
            break
        end
        if state_2==1
            state_2=0
        else
            state_2=1
        end
    end

    num_steps_along!(r, Sud)
    num_steps_along!(r, West)
    return!(r,Nord,num_Sud)
    return!(r,Ost,num_West)
end

function num_steps_along!(r,Side)::Int
    num_steps=0
    while !isborder(r,Side)
        move!(r,Side)
        num_steps+=1
    end
    return num_steps
end

function return!(r,Side,num_steps)
    for x in 1:num_steps
        move!(r,Side)
    end
end

proiz_chess(r,2)