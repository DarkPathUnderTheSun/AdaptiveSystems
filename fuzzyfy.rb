=begin
            Welcome to my fuzzy logic ruby code!
            It's a just-for-fun little program intended to help me study 
            fuzzy logic, by the best method possible - by programming it!

            Do not expect genius stuff or amazing results. I just works
            for the exercices we see in class, and I hope it results auxiliar
            for some of the homework.

            How to use the program: 
            - Add a matrix object containing the vertexes of your funcion de pertenencia.

                    funcionDePertenenciaTriangular = [0,20,40]
                    funcionDePertenenciaTrapezoidal = [0,20,40,60]

            - Pick a umber to feed the program. The code will calculate just how much does
              the number belong to the fuzzy set.
                    
                    number = 15

            - Input these to one of the pertenence functions.

                    triangularPertenenceDegree(number,funcionDePertenenciaTriangular)

            Warning: be sure to use the corresponding functions. I.e.: don't input trapezoids
            to the trapezoidal function. The code WILL give you a wrong answer.


            Thanks for reading, have fun!
=end


#These functions are models of mathematical functions to calculate stuff.

def triangularPertenenceDeegree(x, triangle)
    x=x.to_f
    if x <= triangle[0]
        return 0
    elsif (triangle[0] < x)&&(x<=triangle[1])
        return ((x-triangle[0])/(triangle[1]-triangle[0]))
    elsif (triangle[1] < x)&&(x<triangle[2])
        return ((triangle[2]-x)/(triangle[2]-triangle[1]))
    elsif x >= triangle[2]
        return 0
    end
end

def trapezoidalPertenenceDeegree(x, trapezoid)
    x=x.to_f
    if (trapezoid[0]<=x)&&(x <= trapezoid[1]) 
        return ((x-trapezoid[0])/(trapezoid[1]-trapezoid[0]))
    elsif (trapezoid[1] <= x)&&(x<=trapezoid[2])
        return 1
    elsif (trapezoid[2] <= x)&&(x<=trapezoid[3])
        return ((trapezoid[3]-x)/(trapezoid[3]-trapezoid[2]))
    else
        return 0
    end
end

def 

#End of the math stuff.

#Here you can put your code. Don't forget to print the results!

#Example (which you should replace with your own code):


bigness = [20,50,60,90]
smallness = [0,10,20]
puts trapezoidalPertenenceDeegree(30, bigness)
puts triangularPertenenceDeegree(7, smallness)



#This should return 0.3333333333333333 and 0.7, which means that 
#30 has a grado de pertenencia of 0.3333... in the bigness set,
#and 7 has a grado de pertenencia of 0.7 in the smallness set.



#important for tars program!
=begin
var3 = 0
rule = [0,0,0,0,0,0,0,0,0]
for var1 in 0..2
    for var2 in 0..2
        rule[var3] = [fuzzyAngle[var1], fuzzyDistance[var2]].min
        puts "Fuerza de la regla #{var3+1}: #{rule[var3]}"
        var3 = var3 + 1
    end
end
=end